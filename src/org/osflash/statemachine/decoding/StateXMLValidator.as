package org.osflash.statemachine.decoding {

import org.osflash.statemachine.errors.StateDecodingError;

public class StateXMLValidator implements IDataValidator {

    private var _data:XML;

    public function StateXMLValidator( data:XML ) {
        _data = data;
    }

    public function validate():Object {
        validateIsNotNull();
        validateHasInitialStateAttribute();
        validateInitialStateDeclared();
        validateStatesHaveNameAttributes();
        validateTransitionsHaveNameAttributes();
        validateTransitionsHaveTargetAttributes();
        validateStateNamesAreUnique();
        /*
         STATE_WITH_SAME_NAME_ALREADY_REGISTERED

         TRANSITION_WITH_SAME_NAME_ALREADY_REGISTERED*/
        return _data;
    }


    private function validateIsNotNull():void {
        if ( _data == null ) {
            throw new StateDecodingError( StateDecodingError.NULL_DATA_ERROR );
        }
    }

    private function validateHasInitialStateAttribute():void {
        if ( _data.@initial != undefined ) return;
        throw new StateDecodingError( StateDecodingError.INITIAL_STATE_ATTRIBUTE_NOT_DECLARED );
    }

    private function validateInitialStateDeclared():void {
        const statenames:XMLList = _data..state.(hasOwnProperty( "@name" ) && @name == _fsm.@initial );
        if ( statenames.length() == 1 ) return;
        throw new StateDecodingError( StateDecodingError.INITIAL_STATE_NOT_FOUND );
    }

    private function validateStatesHaveNameAttributes():void {
        const states:XMLList = _data..state.(!hasOwnProperty( "@name" ) );
        if ( states.length() == 0 )  return;
        const error:StateDecodingError = new StateDecodingError( StateDecodingError.STATE_NAME_ATTRIBUTE_NOT_DECLARED );
        throw  error.injectMsg( states.length.toString(), "quantity" );
    }

    private function validateTransitionsHaveNameAttributes():void {
        validateTransitionAttributes( "@name", StateDecodingError.TRANSITION_NAME_ATTRIBUTE_NOT_DECLARED );
    }

    private function validateTransitionsHaveTargetAttributes():void {
        validateTransitionAttributes( "@target", StateDecodingError.TRANSITION_TARGET_ATTRIBUTE_NOT_DECLARED );
        const transitions:XMLList = _data..transition.(!hasOwnProperty( "@target" ) );
    }

    private function validateTransitionAttributes( property:String, errorMsg:String ):void {
        const transitions:XMLList = _data..transition.(!hasOwnProperty( property ) );
        if ( transitions.length() == 0 )  return;
        const error:StateDecodingError = new StateDecodingError( errorMsg );
        throw  error.injectMsg( transitions.length.toString(), "quantity" );
    }

     private function validateStateNamesAreUnique():void {
    }


}
}