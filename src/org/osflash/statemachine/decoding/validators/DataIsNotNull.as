package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

public class DataIsNotNull implements IDataValidator {

    private var _data:Object;

    public function validate():Object {
        if ( _data != null )return _data;
        throw getError( ErrorCodes.NULL_FSM_DATA_ERROR );
    }

    public function set data( value:Object ):void {
        _data = value;
    }
}
}
