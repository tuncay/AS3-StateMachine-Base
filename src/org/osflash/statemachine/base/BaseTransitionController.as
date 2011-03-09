package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IFSMControllerOwner;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.core.ITransitionController;
import org.osflash.statemachine.core.ITransitionPhase;

/**
 * Abstract class for creating custom state transitions
 */
public class BaseTransitionController implements ITransitionController, IStateLogger {
    /**
     * @private
     */
    private var _cancellationReason:String;

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
    private var _currentState:IState;

    /**
     * @private
     */
    private var _isTransitioning:Boolean;

    /**
     * @private
     */
    private var _transitionCallback:Function;
    private var _logger:IStateLogger;
    private var _controller:IFSMControllerOwner;

    public function BaseTransitionController(controller:IFSMControllerOwner, logger:IStateLogger = null) {
        _controller = controller;
        _logger = logger;
    }

    /**
     * @inheritDoc
     */
    public function get currentState():IState {
        return _currentState;
    }

    /**
     * @inheritDoc
     */
    public function set invokeTransitionCallback(value:Function):void {
        _transitionCallback = value;
    }

    /**
     * @inheritDoc
     */
    public function get isTransitioning():Boolean {
        return _isTransitioning;
    }

    /**
     * Determines whether the transition has been marked for cancellation.
     */
    protected function get isCanceled():Boolean {
        return _canceled;
    }

    /**
     * The reason given for cancelling the transition.
     */
    protected function get cancellationReason():String {
        return _cancellationReason;
    }

    /**
     * The data payload from the cancel notification.
     */
    protected function get cachedPayload():Object {
        return _cachedPayload;
    }

    /**
     * @inheritDoc
     */
    public final function transition(target:IState, payload:Object = null):void {
        setIsTransitioning(true);
        onTransition(target, payload);
        setIsTransitioning(false); // to allow transitioning from the Cancelled and Changed phases
        if (isCanceled)cancelStateTransition();
        else dispatchGeneralStateChanged();
        reset();
    }


    /**
     * @inheritDoc
     */
    public function destroy():void {
        reset();
        _currentState = null;
        _transitionCallback = null;
        _controller.destroy();
    }

    /**
     * @inheritDoc
     */
    public function log(msg:String):void {
        if (_logger != null)
            _logger.log(msg);
    }

    public function logPhase(phase:ITransitionPhase, state:IState):void {
        if (_logger != null)
            _logger.logPhase(phase, state);
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
     * Sets the current state of the FSM.
     * @param state
     */
    protected function setCurrentState(state:IState):void {
        _currentState = state;
        _controller.setCurrentState(state);
    }

    /**
     * Sets the current transitional status of the StateMachine.
     * NB subclasses should not call it, but can override to add functionality
     * @param value
     */
    protected function setIsTransitioning(value:Boolean):void {
        _isTransitioning = value;
        _controller.setIsTransition(value);
    }

    /**
     * @private
     */
    protected final function cancelStateTransition():void {
        _canceled = false;
        log("the current transition has been cancelled");
        dispatchTransitionCancelled();
    }


    protected function setReferringTransition():void {
        if (currentState == null)return;
        _controller.setReferringTransition(currentState.referringTransitionName);
    }

    protected function setTransitionPhase(phase:ITransitionPhase, state:IState):void {
        _controller.setTransitionPhase(phase);
        logPhase(phase, state);
    }

    /**
     * Starts a new transition
     * @param transitionName the name of the action
     * @param payload the data payload from the action notification.
     * @return whether the action has been called successfully
     */
    protected function handleStateTransition(transitionName:String, payload:Object):Boolean {
        if (_transitionCallback == null) return false;
        _transitionCallback(transitionName, payload);
        return true;
    }

    /**
     * Marks the transition to be cancelled.
     * @param reason the reason for cancellation.
     * @param payload the data payload from the cancel notification.
     */
    protected function handleCancelStateTransition(reason:String = null, payload:Object = null):void {
        _canceled = true;
        _cancellationReason = reason;
        _cachedPayload = payload;
    }

    /**
     * Resets any properties needed after each transition.
     * This can be extended, but does not need to be called from a sub-class.
     */
    protected function reset():void {
        _cancellationReason = null;
        _cachedPayload = null;
    }


}
}