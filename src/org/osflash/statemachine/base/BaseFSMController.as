package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.IFSMControllerOwner;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.ITransitionPhase;
import org.osflash.statemachine.errors.StateTransitionError;

/**
 * SignalStateMachine FSMController composes the Signals that communicate between the StateMachine
 * and the framework actors.  It should be injected its IFSMController interface.
 */
public class BaseFSMController implements IFSMController, IFSMControllerOwner {

    /**
     * @private
     */
    private var _currentStateName:String;

    /**
     * @private
     */
    private var _referringTransition:String;

    /**
     * @private
     */
    private const ILLEGAL_TRANSITION_ERROR:String = "A transition can not be invoked from this phase: ";

    /**
     * @private
     */
    private const ILLEGAL_CANCEL_ERROR:String = "A transition can only be cancelled from an enteringGuard or exitingGuard phase";

    /**
     * @private
     */
    private var _isTransitioning:Boolean;

    /**
     * @private
     */
    private var _cacheActionName:String;

    /**
     * @private
     */
    private var _cachePayload:Object;

    /**
     * @private
     */
    private var _transitionPhase:ITransitionPhase;

    /**
     * Creates a new instance of FSMController
     */
    public function BaseFSMController() {

    }

    /**
     * @inheritDoc
     */
    public function get currentStateName():String {
        return _currentStateName;
    }

    /**
     * @inheritDoc
     */
    public function get referringTransition():String {
        return _referringTransition;
    }

    /**
     * @inheritDoc
     */
    public function get isTransitioning():Boolean {
        return _isTransitioning;
    }

    /**
     * @inheritDoc
     */
    public function get transitionPhase():ITransitionPhase {
        return _transitionPhase;
    }

    /**
     * Sends an action to the StateMachine, precipitating a state transition.
     *
     * If a transition is actioned during a permitted transition phase, then the action is scheduled to be sent
     * immediately the transition cycle is over.
     *
     * @param transitionName the name of the action.
     * @param payload the data to be sent with the action.
     *
     * @throws org.osflash.statemachine.errors.StateTransitionError Thrown if a transition is actioned from a
     * <strong>tearDown</strong>, <strong>enteringGuard</strong> or <strong>enteringGuard</strong> phase of a
     * transition cycle.
     */
    public function transition(transitionName:String, payload:Object = null):void {

        if (isTransitionLegal)
            instigateTransition(transitionName, payload);
        else
            throw new StateTransitionError(ILLEGAL_TRANSITION_ERROR + transitionPhase.name);

    }

    protected function isTransitionLegal():Boolean {
        return false;
    }

    /**
     * @private
     */
    private function instigateTransition(transitionName:String, payload:Object = null):void {
        if (isTransitioning) {
            _cacheActionName = transitionName;
            _cachePayload = payload;
            listenForStateChangeOnce(dispatchTransitionLater);
        }
        else dispatchTransition(transitionName, payload);
    }

    /**
     * @private
     */
    private function dispatchTransitionLater(stateName:String = null):void {
        dispatchTransition(_cacheActionName, _cachePayload);
        _cacheActionName = null;
        _cachePayload = null;
    }

    protected function dispatchTransition(transitionName:String, payload:Object):void {
    }

    /**
     * Cancels the current transition.
     *
     * NB: A transitions can only be cancelled during the <strong>enteringGuard</strong> or <strong>exitingGuard</strong>
     * phases of a transition.
     *
     * @param reason information regarding the reason for the cancellation
     * @param payload the data to be sent to the <strong>cancelled</strong> phase.
     * @throws org.osflash.statemachine.errors.StateTransitionError Thrown if a transition is cancelled from a transition phase
     * other than an enteringGuard or exitingGuard.
     */
    public function cancelStateTransition(reason:String, payload:Object = null):void {

        if (isCancellationLegal)
            dispatchCancellation(reason, payload);
        else
            throw new StateTransitionError(ILLEGAL_CANCEL_ERROR);

    }

    protected function isCancellationLegal():Boolean {
        return false;
    }

    protected function dispatchCancellation(reason:String, payload:Object):void {
    }

    /**
     * @inheritDoc
     */
    public function listenForStateChange(listener:Function):Function {
        return listener;
    }

    /**
     * @inheritDoc
     */
    public function listenForStateChangeOnce(listener:Function):Function {
        return listener;
    }


    /**
     * @inheritDoc
     */
    public function stopListeningForStateChange(listener:Function):Function {
        return listener;
    }

    /**
     * @inheritDoc
     */
    public function listenForIncomingCalls(listener:Function):Function {
        return listener;
    }

    /**
     * @inheritDoc
     */
    public function dispatchStateChange(stateName:String):void {

    }

    /**
     * @inheritDoc
     */
    public function destroy():void {
    }

    /**
     * @inheritDoc
     */
    public function setCurrentState(state:IState):void {
        _currentStateName = state.name;
    }


    /**
     * @inheritDoc
     */
    public function setReferringTransition(value:String):void {
        _referringTransition = value;
    }

    /**
     * @inheritDoc
     */
    public function setIsTransition(value:Boolean):void {
        _isTransitioning = value;
    }

    /**
     * @inheritDoc
     */
    public function setTransitionPhase(value:ITransitionPhase):void {
        _transitionPhase = value;
    }

    public function get hasChangedListener():Boolean {
        return false;
    }


}
}