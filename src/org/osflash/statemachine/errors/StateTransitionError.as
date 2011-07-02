package org.osflash.statemachine.errors {
/**
 * Thrown when an attempt has been made to start a transition when the
 * StateMachione is already transitioning
 *
 * @see org.osflash.statemachine.model.StateModel#transitionTo()
 */
public class StateTransitionError extends BaseStateError {

    public static const ILLEGAL_TRANSITION_ERROR:String = "A transition can not be invoked from this phase: ";

    public static const ILLEGAL_CANCEL_ERROR:String = "A transition can not be cancelled from this phase: ";

    public static const INVOKE_TRANSITION_LATER_ALREADY_SCHEDULED:String = "A transition has already been scheduled for later";

    public function StateTransitionError(msg:String) {
        super(msg);
    }
}
}