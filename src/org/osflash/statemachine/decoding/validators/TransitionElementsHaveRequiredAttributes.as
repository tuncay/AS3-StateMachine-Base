package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

public class TransitionElementsHaveRequiredAttributes implements IDataValidator {

    private var _data:XML;

    public function TransitionElementsHaveRequiredAttributes( data:XML ) {
        _data = data;
    }

    public function validate():Object {
        validateTransitionAttributes( "@name", ErrorCodes.TRANSITION_NAME_ATTRIBUTE_NOT_DECLARED );
        validateTransitionAttributes( "@target", ErrorCodes.TRANSITION_TARGET_ATTRIBUTE_NOT_DECLARED );
        return _data;
    }

    private function validateTransitionAttributes( property:String, errorCode:int ):void {
        const transitions:XMLList = _data..transition.(!hasOwnProperty( property ) );
        if ( transitions.length() == 0 )  return;
        throw getError( errorCode ).injectMsgWith( transitions.length.toString(), "quantity" );
    }
}
}
