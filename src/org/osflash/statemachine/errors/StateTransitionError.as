package org.osflash.statemachine.errors {

public class StateTransitionError extends BaseStateError {

    public static const INVALID_TRANSITION_ERROR:String = "A transition can not be invoked from the [${phase}] phase";
    public static const INVALID_CANCEL_ERROR:String = "A transition can not be cancelled from the [${phase}] phase";
    public static const NO_PHASES_HAVE_BEEN_PUSHED_TO_STATE_TRANSITION:String = "No transition phases have been pushed to the StateTransition";
    public static const TRANSITION_UNDEFINED_IN_CURRENT_STATE:String = "The transition[${transition}] is not defined in the current state [${state}]";

    public function StateTransitionError( msg:String ) {
        super( msg );
    }
}
}