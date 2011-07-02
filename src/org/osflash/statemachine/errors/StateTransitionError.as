package org.osflash.statemachine.errors {
/**
 * Thrown when an attempt has been made to start a transition when the
 * StateMachione is already transitioning
 *
 * @see org.osflash.statemachine.model.StateModel#transitionTo()
 */
public class StateTransitionError extends BaseStateError {

    public static const INVALID_TRANSITION_ERROR:String = "A transition can not be invoked from the [${phase}] phase";

    public static const INVALID_CANCEL_ERROR:String = "A transition can not be cancelled from the [${phase}] phase";


    public function StateTransitionError(msg:String) {
        super(msg);
    }
}
}