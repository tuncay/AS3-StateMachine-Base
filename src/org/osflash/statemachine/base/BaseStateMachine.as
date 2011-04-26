package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.core.IStateModelOwner;
import org.osflash.statemachine.core.ITransitionPhase;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.transitioning.TransitionPhase;

/**
 * Abstract class for managing state transitions. This class manages over all process, subclass
 * specifies Event model and the management of the transition
 */
public class BaseStateMachine implements IFSMController, IStateLogger {

    /**
     * @private
     */
    private const ILLEGAL_TRANSITION_ERROR:String = "A transition can not be invoked from this phase: ";

    /**
     * @private
     */
    private const ILLEGAL_CANCEL_ERROR:String = "A transition can not be cancelled from this phase: ";

    /**
     * @private
     */
    private const INVOKE_TRANSITION_LATER_ALREADY_SCHEDULED:String = "A transition has already been scheduled for later";

    /**
     * The current state
     */
    protected var currentState:IState;

    /**
     * The current transition phase
     */
    protected var currentTransitionPhase:ITransitionPhase;

    /**
     * @private
     */
    private var _cachedInfo:String;

    /**
     * @private
     */
    private var _cachedPayload:IPayload;

    /**
     * @private
     */
    private var _canceled:Boolean;

    /**
     * @private
     */
    private var _isTransitioning:Boolean;

    /**
     * @private
     */
    private var _logger:IStateLogger;

    /**
     * @private
     */
    private var _model:IStateModelOwner;

    /**
     * @private
     */
    private var _invokeLaterScheduled:Boolean;

    /**
     *
     * @param model The state model
     * @param logger for logging
     */
    public function BaseStateMachine( model:IStateModelOwner, logger:IStateLogger = null ) {
        _model = model;
        _logger = logger;
        currentTransitionPhase = TransitionPhase.NONE;
    }

    /**
     * @inheritDoc
     */
    public final function get currentStateName():String {
        return (currentState == null) ? null : currentState.name;
    }

    /**
     * @inheritDoc
     */
    public final function get isTransitioning():Boolean {
        return _isTransitioning;
    }

    /**
     * @inheritDoc
     */
    public final function get referringTransitionName():String {
        return (currentState == null) ? null : currentState.referringTransitionName;
    }

    /**
     * @inheritDoc
     */
    public final function get transitionPhase():ITransitionPhase {
        return currentTransitionPhase;
    }

    /**
     * Determines whether the transition has been marked for cancellation.
     */
    protected final function get isCanceled():Boolean {
        return _canceled;
    }

    /**
     * Either the name of the current transition or the reason for cancellation.
     */
    protected final function get cachedInfo():String {
        return _cachedInfo;
    }

    /**
     * The cached transit payload.
     */
    protected final function get cachedPayload():IPayload {
        return _cachedPayload;
    }

    /**
     * Subclasses determine whether a transition can be invoked in the current phase
     */
    protected function get isTransitionLegal():Boolean {
        return false;
    }

    /**
     * Subclasses determine whether a transition can be cancelled in the current phase
     */
    protected function get isCancellationLegal():Boolean {
        return false;
    }


    /**
     * @inheritDoc
     */
    public final function transition( transitionName:String, payload:Object = null ):void {

        _cachedInfo = transitionName;
        _cachedPayload = wrapPayload( payload );

        if ( !isTransitionLegal )
            throw new StateTransitionError( ILLEGAL_TRANSITION_ERROR + ( transitionPhase == null ) ? "[undefined]" : transitionPhase.name );

        else if ( isTransitioning && _invokeLaterScheduled )
            throw new StateTransitionError( INVOKE_TRANSITION_LATER_ALREADY_SCHEDULED );

        else if ( isTransitioning ) {
            _invokeLaterScheduled = true;
            listenForStateChangeOnce( invokeTransitionLater );
        }

        else
            invokeTransition( _cachedInfo, _cachedPayload );
    }

    /**
     * @inheritDoc
     */
    public final function cancelStateTransition( reason:String, payloadBody:Object = null ):void {
        if ( isCancellationLegal ) {
            _canceled = true;
            _cachedInfo = reason;
            _cachedPayload = wrapPayload( payloadBody );
        } else
            throw new StateTransitionError( ILLEGAL_CANCEL_ERROR + ( transitionPhase == null ) ? "[undefined]" : transitionPhase.name );

    }

    /**
     * @inheritDoc
     */
    public function transitionToInitialState():void {
        if ( _model.initialState ) {
            transitionToState( _model.initialState, null );
        }
    }

    /**
     * @inheritDoc
     */
    public final function log( msg:String ):void {
        if ( _logger != null )
            _logger.log( msg );
    }

    /**
     * @inheritDoc
     */
    public final function logPhase( phase:ITransitionPhase, state:IState ):void {
        if ( _logger != null )
            _logger.logPhase( phase, state );
    }

    /**
     * @inheritDoc
     */
    public function destroy():void {
        resetProperties();
        currentState = null;
        currentTransitionPhase = null;
        _logger = null;
        _model = null;
    }

    /**
     * Retrieves the target state from the model, then passes it to transitionToState method
     */
    protected final function invokeTransition( transitionName:String, payload:IPayload ):void {
        const targetState:IState = _model.getTargetState( transitionName, currentState );
        if ( targetState == null )
            log( "Transition: " + transitionName + " is not defined in state: " + currentStateName );
        else transitionToState( targetState, payload );
    }

    /**
     * The listener method for invoking a transition later
     */
    protected final function invokeTransitionLater( stateName:String ):void {
        invokeTransition( _cachedInfo, _cachedPayload );
        _cachedInfo = null;
        _cachedPayload = null;
        _invokeLaterScheduled = false;
    }

    /**
     * Controls the process of the actual transition
     * @param target  the target state of the current transition
     * @param payload  the payload in transit
     */
    protected final function transitionToState( target:IState, payload:IPayload ):void {
        _isTransitioning = true;
        onTransition( target, payload );
        _isTransitioning = false;
        if ( isCanceled )
            handleCancelledTransition();
        else
            handleGeneralStateChange();
        currentTransitionPhase = TransitionPhase.NONE;
        resetProperties();
    }

    /**
     * Called if the transition is cancelled, then delegates action to sub-class.
     */
    protected final function handleCancelledTransition():void {
        _canceled = false;
        log( "the current transition has been cancelled" );
        currentTransitionPhase = TransitionPhase.CANCELLED;
        dispatchTransitionCancelled();
    }

    /**
     *  Called if the transition is successful, then delegates action to sub-class.
     */
    protected final function handleGeneralStateChange():void {
        currentTransitionPhase = TransitionPhase.GLOBAL_CHANGED;
        dispatchGeneralStateChanged();
    }

    /**
     * Resets any properties needed after each transition.
     * This can be extended, but does not need to be called from a sub-class.
     */
    protected function resetProperties():void {
        _cachedInfo = null;
        _cachedPayload = null;
    }

    /**
     * Do not call this in sub-classes for testing purposes only
     * @param value
     */
    protected final function setIsTransitioning( value:Boolean ):void {
        _isTransitioning = value;
    }

    /**
     * Wraps the underlying Event model, so the framework can listen for the global state changed
     * transition phase
     * @param listener
     * @return
     */
    public function listenForStateChange( listener:Function ):* {
        return null;
    }

    public function listenForStateChangeOnce( listener:Function ):* {
        return null;
    }

    public function stopListeningForStateChange( listener:Function ):* {
        return null;
    }

    /**
     * Override to define the state transition.
     * @param target the IState which to transition to.
     * @param payload the data payload from the action notification.
     */
    protected function onTransition( target:IState, payload:Object ):void {
    }

    /**
     * Override to notify interested framework actors that the
     * state has changed.
     */
    protected function dispatchGeneralStateChanged():void {
    }

    /**
     * Override to notify interested framework actors that the
     * state transition has been cancelled.
     */
    protected function dispatchTransitionCancelled():void {
    }

    protected function wrapPayload( body:Object ):IPayload {
        return ( body is IPayload) ? IPayload( body ) : new Payload( body );
    }
}
}