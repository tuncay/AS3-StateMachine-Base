package org.osflash.statemachine.errors {
/**

 */
public class StateDecodingError extends Error {
    public static const STATE_WITH_SAME_NAME_ALREADY_REGISTERD:String = "A state with that name has already been registered: ";
    public static const TRANSITION_WITH_SAME_NAME_ALREADY_REGISTERED:String = "A transition with that name has already been registered: ";

    public function StateDecodingError( msg:String )
    {
        super( msg );
    }
}
}