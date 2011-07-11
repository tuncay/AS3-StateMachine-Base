package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.ErrorMap;

public class DataHasInitialStateDeclared implements IDataValidator {

    private var _data:XML;

    public function validate():Object {
        const statenames:XMLList = _data..state.(hasOwnProperty( "@name" ) && @name == _data.@initial );
        if ( statenames.length() == 1 ) return _data;
        throw new ErrorMap().getError( ErrorCodes.INITIAL_STATE_NOT_DECLARED );
    }

    public function set data( value:Object ):void {
        _data = XML( value );
    }
}
}
