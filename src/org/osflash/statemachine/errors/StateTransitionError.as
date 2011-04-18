package org.osflash.statemachine.errors {
/**
 * Thrown when an attempt has been made to start a transition when the
 * StateMachione is already transitioning
 *
 * @see org.osflash.statemachine.base.StateModel#transitionTo()
 */
public class StateTransitionError extends Error {


    public function StateTransitionError(msg:String) {
        super(msg);
    }
}
}