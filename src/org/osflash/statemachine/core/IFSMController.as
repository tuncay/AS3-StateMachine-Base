package org.osflash.statemachine.core {

/**
 * The outward-facing contract between the StateMachine and the framework actors,
 * allowing read/write access
 */
public interface IFSMController extends IFSMProperties {
    /**
     * Invokes a state transition.
     * @param transitionName the name of the action.
     * @param payload the data to be sent with the action, this will be wrapped with an IPayload
     */
    function transition(transitionName:String, payload:Object = null):void;

    /**
     * Cancels the current transition.
     *
     * NB: A transitions can only be cancelled during the <strong>enteringGuard</strong> or <strong>exitingGuard</strong>
     * phases of a transition.
     * @param reason information regarding the reason for the cancellation
     * @param payload the data to be sent to the <strong>cancelled </strong> phase.
     */
    function cancelStateTransition(reason:String, payload:Object = null):void;

    /**
     * Adds a listener to the general <strong>changed</strong> phase of the transition.
     * @param listener the method to handle the phase
     * @return depends of the Event model the FSM is using
     */
    function listenForStateChange(listener:Function):*;

    /**
     * Adds a listener to the general <strong>changed</strong> phase of the transition,
     * that is called once only, and then automagically removed.
     * @param listener the method to handle the phase
     * @return depends of the Event model the FSM is using
     */
    function listenForStateChangeOnce(listener:Function):*;

    /**
     * Removes the listener from the general <strong>changed</strong> phase of the transition.
     * @param listener the method to remove
     * @return depends of the Event model the FSM is using
     */
    function stopListeningForStateChange(listener:Function):*;


}
}