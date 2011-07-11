package org.osflash.statemachine.errors {

public class ErrorCodes {

    public static const NULL_FSM_DATA_ERROR:int = 0;
    public static const DUPLICATE_STATES_DECLARED:int = 1;
    public static const DUPLICATE_TRANSITION_DECLARED:int = 2;
    public static const INITIAL_STATE_ATTRIBUTE_NOT_DECLARED:int = 3;
    public static const INITIAL_STATE_NOT_DECLARED:int = 4;
    public static const STATE_NAME_ATTRIBUTE_NOT_DECLARED:int = 5;
    public static const TRANSITION_NAME_ATTRIBUTE_NOT_DECLARED:int = 6;
    public static const TRANSITION_TARGET_ATTRIBUTE_NOT_DECLARED:int = 7;
    public static const TRANSITION_TARGET_NOT_DECLARED:int = 8;
    public static const STATE_DECODER_MUST_NOT_BE_NULL:int = 9;
    public static const STATE_MODEL_MUST_NOT_BE_NULL:int = 10;
    public static const STATE_HAS_NO_INCOMING_TRANSITION:int = 11;

    public static const NO_INITIAL_STATE_DECLARED:int = 12;
    public static const TARGET_DECLARATION_MISMATCH:int = 13;
    public static const TRANSITION_NOT_DECLARED_IN_STATE:int = 14;
    public static const STATE_REQUESTED_IS_NOT_REGISTERED:int = 15;

    public static const INVALID_TRANSITION:int = 16;
    public static const INVALID_CANCEL:int = 17;
    public static const NO_PHASES_HAVE_BEEN_PUSHED_TO_STATE_TRANSITION:int = 18;
    public static const TRANSITION_UNDEFINED_IN_CURRENT_STATE:int = 19;


}
}