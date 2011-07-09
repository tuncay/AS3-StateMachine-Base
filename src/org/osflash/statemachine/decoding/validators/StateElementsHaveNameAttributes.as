package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

public class StateElementsHaveNameAttributes implements IDataValidator {

    private var _data:XML;

    public function validate():Object {
        const states:XMLList = _data.state.(!hasOwnProperty( "@name" ) );
        if ( states.length() == 0 )  return _data;
        throw getError( ErrorCodes.STATE_NAME_ATTRIBUTE_NOT_DECLARED ).injectMsgWith( states.length().toString(), "quantity" );
    }

    public function set data( value:Object ):void {
        _data = XML( value );
    }
}
}
