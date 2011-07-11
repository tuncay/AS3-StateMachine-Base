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

    internal static var errorsBindings:Vector.<ErrorBinding>;

    public static function getError( code:int ):BaseStateError {
        if ( errorsBindings == null )createBindings();
        return errorsBindings[code].getError();
    }

    public static function getErrorMessage( code:int ):String {
        if ( errorsBindings == null )createBindings();
        return errorsBindings[code].getMessage();
    }

    private static function createBindings():void {
            errorsBindings = new <ErrorBinding>[];
            errorsBindings.push( new ErrorBinding( StateDecodingError, "No FSM data has been defined, or the value passed is  null" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "Duplicate state(s) with the name(s) [${state}] have been found" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "Duplicate transitions fount in [${state}]" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "The initial state attribute has not been declared" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "The initial state attribute refers to a state that is not declared" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "The name attribute for ${quantity} state element(s) have not been declared" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "The name attribute for ${quantity} transition element(s) have not been declared" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "The target attribute for ${quantity} transition element(s) have not been declared" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "The target for [${transition}] in [${state}] has not been declared" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "The IStateDecoder member has not been declared for IStateModelDecoder" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "The IStateModel param passed in IStateModelDecoder.inject() method was null" ));
            errorsBindings.push( new ErrorBinding( StateDecodingError, "[${state}] has not incoming transitions" ));

            errorsBindings.push( new ErrorBinding( StateModelError, "No initial state declared" ));
            errorsBindings.push( new ErrorBinding( StateModelError, "the target state [${target}] does not exist for [${transition}] in state [${state}]" ));
            errorsBindings.push( new ErrorBinding( StateModelError, "the transition [${transition}] is not declared in state [${state}]" ));
            errorsBindings.push( new ErrorBinding( StateModelError, "the state [${state}] is not registered" ));

            errorsBindings.push( new ErrorBinding( StateTransitionError, "A transition can not be invoked from the [${phase}] phase" ));
            errorsBindings.push( new ErrorBinding( StateTransitionError, "A transition can not be cancelled from the [${phase}] phase" ));
            errorsBindings.push( new ErrorBinding( StateTransitionError, "No ITransitionPhase have been pushed to the TransitionPhaseDispatcher" ));
            errorsBindings.push( new ErrorBinding( StateTransitionError, "The transition[${transition}] is not defined in the current state [${state}]" ));
    }
}
}