package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.core.IStateModel;
import org.osflash.statemachine.core.ITransitionPhase;
import org.osflash.statemachine.errors.StateTransitionError;

/**
 * Abstract class for creating custom state transitions
 */
public class BaseStateMachine implements IFSMController, IStateLogger {

     /**
     * @private
     */
    protected var currentState:IState;

    /**
     * @private
     */
    protected var currentTransitionPhase:ITransitionPhase;

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
    private var _cachedInfo:String;

    /**
     * @private
     */
    private var _cachedPayload:Object;

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
    private var _model:IStateModel;

    public function BaseStateMachine(model:IStateModel, logger:IStateLogger = null) {
        _model = model;
        _logger = logger;
    }

    public final function get currentStateName():String {
        return (currentState == null) ? null : currentState.name;
    }

    /**
     * @inheritDoc
     */
    public final function get isTransitioning():Boolean {
        return _isTransitioning;
    }

    public final function get referringTransitionName():String {
        return (currentState == null) ? null : currentState.referringTransitionName;
    }

    public final function get transitionPhase():ITransitionPhase {
        return currentTransitionPhase;
    }

    public final function transition(transitionName:String, payload:Object = null):void {
        if (!isTransitionLegal)
           throw new StateTransitionError(ILLEGAL_TRANSITION_ERROR + ( transitionPhase == null ) ? "[undefined]" : transitionPhase.name);
        else if (isTransitioning) {
            _cachedInfo = transitionName;
            _cachedPayload = payload;
            listenForStateChangeOnce(invokeTransitionLater);
        }
        else invokeTransition(transitionName, payload);
    }

     public final function cancelStateTransition(reason:String, payload:Object = null):void {
        if (isCancellationLegal) {
            _canceled = true;
            _cachedInfo = reason;
            _cachedPayload = payload;
        } else
            throw new StateTransitionError(ILLEGAL_CANCEL_ERROR  + ( transitionPhase == null ) ? "[undefined]" : transitionPhase.name);

    }

     /**
     * @inheritDoc
     */
    public function onRegister():void {
        if (_model.initialState)
            transitionToState(_model.initialState, null);
    }

    /**
     * @private
     */
    private function invokeTransition(transitionName:String, payload:Object = null):void {
        var targetState:IState  = _model.getTargetState( transitionName, currentState );
        if( targetState == null) log("Transition: " + transitionName + " is not defined in state: " + currentStateName);
        else transitionToState( targetState, payload );
    }

    /**
     * @private
     */
    private function invokeTransitionLater(...args):void {
        invokeTransition(_cachedInfo, _cachedPayload);
        _cachedInfo = null;
        _cachedPayload = null;
    }

    /**
     * Determines whether the transition has been marked for cancellation.
     */
    protected final function get isCanceled():Boolean {
        return _canceled;
    }

    /**
     * The reason given for cancelling the transition.
     */
    protected final function get cachedInfo():String {
        return _cachedInfo;
    }

    /**
     * The data payload from the cancel notification.
     */
    protected final function get cachedPayload():Object {
        return _cachedPayload;
    }


    protected function transitionToState(target:IState, payload:Object = null):void {
        _isTransitioning = true;
        onTransition(target, payload);
        _isTransitioning = false;
        if (isCanceled)
            handleCancelledTransition();
        else
            dispatchGeneralStateChanged();
        reset();
    }

    private function handleCancelledTransition():void{
          _canceled = false;
            log("the current transition has been cancelled");
            dispatchTransitionCancelled();
    }

    /**
     * @inheritDoc
     */
    public final function log(msg:String):void {
        if (_logger != null)
            _logger.log(msg);
    }

    public final function logPhase(phase:ITransitionPhase, state:IState):void {
        if (_logger != null)
            _logger.logPhase(phase, state);
    }

    /**
     * @inheritDoc
     */
    public function destroy():void {
        reset();
        currentState = null;
    }

    /**
     * Do not call this in sub-classes for testing purposes only
     * @param value
     */
    protected final function setIsTransitioning( value:Boolean):void{
        _isTransitioning = value;
    }


    protected function get isTransitionLegal():Boolean {
        return false;
    }

    protected function get isCancellationLegal():Boolean {
        return false;
    }

    public function listenForStateChange(listener:Function):Function {
        return null;
    }

    public function listenForStateChangeOnce(listener:Function):Function {
        return null;
    }

    public function stopListeningForStateChange(listener:Function):Function {
        return null;
    }

    /**
     * Override to define the state transition.
     * @param target the IState which to transition to.
     * @param payload the data payload from the action notification.
     */
    protected function onTransition(target:IState, payload:Object):void {
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

    /**
     * Resets any properties needed after each transition.
     * This can be extended, but does not need to be called from a sub-class.
     */
    protected function reset():void {
        _cachedInfo = null;
        _cachedPayload = null;
    }
}
}