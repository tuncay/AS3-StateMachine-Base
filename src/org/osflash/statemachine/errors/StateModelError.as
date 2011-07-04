package org.osflash.statemachine.errors {

/**

 */
public class StateModelError extends BaseStateError {

    public static const NO_INITIAL_STATE_DECLARED:String = "No initial state declared ";
    public static const TARGET_DECLARATION_MISMATCH:String = "the target state [${target}] does not exist for [${transition}] in state [${state}]";
    public static const TRANSITION_NOT_DECLARED_IN_STATE:String = "the transition [${transition}] is not declared in state [${state}]";
    public static const STATE_REQUESTED_IS_NOT_REGISTERED:String = "the state [${state}] is not registered";

    public function StateModelError( msg:String ) {
        super( msg );
    }
}
}