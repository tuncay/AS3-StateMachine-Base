package org.osflash.statemachine.errors {

public class ErrorBindingsList {

     internal static var errorBindings:Vector.<ErrorBinding>;

    public function ErrorBindingsList() {
        createBindings();
    }

    private static function createBindings():void {
        errorBindings = new <ErrorBinding>[];
        errorBindings.push( new ErrorBinding( StateDecodingError, "No FSM data has been defined, or the value passed is  null" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "Duplicate state(s) with the name(s) [${state}] have been found" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "Duplicate transitions fount in [${state}]" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "The initial state attribute has not been declared" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "The initial state attribute refers to a state that is not declared" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "The name attribute for ${quantity} state element(s) have not been declared" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "The name attribute for ${quantity} transition element(s) have not been declared" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "The target attribute for ${quantity} transition element(s) have not been declared" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "The target for [${transition}] in [${state}] has not been declared" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "The IStateDecoder member has not been declared for IStateModelDecoder" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "The IStateModel param passed in IStateModelDecoder.inject() method was null" ) );
        errorBindings.push( new ErrorBinding( StateDecodingError, "[${state}] has not incoming transitions" ) );

        errorBindings.push( new ErrorBinding( StateModelError, "No initial state declared" ) );
        errorBindings.push( new ErrorBinding( StateModelError, "the target state [${target}] does not exist for [${transition}] in state [${state}]" ) );
        errorBindings.push( new ErrorBinding( StateModelError, "the transition [${transition}] is not declared in state [${state}]" ) );
        errorBindings.push( new ErrorBinding( StateModelError, "the state [${state}] is not registered" ) );

        errorBindings.push( new ErrorBinding( StateTransitionError, "A transition can not be invoked from the [${phase}] phase" ) );
        errorBindings.push( new ErrorBinding( StateTransitionError, "A transition can not be cancelled from the [${phase}] phase" ) );
        errorBindings.push( new ErrorBinding( StateTransitionError, "No ITransitionPhase have been pushed to the TransitionPhaseDispatcher" ) );
        errorBindings.push( new ErrorBinding( StateTransitionError, "The transition[${transition}] is not defined in the current state [${state}]" ) );
    }

    public function getErrorBinding( code:int ):ErrorBinding {
        return errorBindings[code];
    }
}
}
