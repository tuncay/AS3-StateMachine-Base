package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

public class DataHasInitialStateDeclared implements IDataValidator{

    private var _data:XML;

    public function DataHasInitialStateDeclared( data:XML) {
        _data = data;
    }

    public function validate():Object {
        const statenames:XMLList = _data..state.(hasOwnProperty( "@name" ) && @name == _fsm.@initial );
        if ( statenames.length() == 1 ) return _data;
        throw getError( ErrorCodes.INITIAL_STATE_NOT_DECLARED );
    }
}
}
