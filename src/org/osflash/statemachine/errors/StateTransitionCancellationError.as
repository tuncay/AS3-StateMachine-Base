package org.osflash.statemachine.errors {

public class StateTransitionCancellationError extends BaseStateError {
    public static const NULL_CANCELLATION_REASON:String = "A null CancellationReasonUID was passed during [${transition}] in state[${state}] ";
    public function StateTransitionCancellationError( msg:String ) {
        super( msg );
    }
}
}
