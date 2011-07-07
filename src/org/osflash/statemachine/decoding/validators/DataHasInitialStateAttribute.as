package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

public class DataHasInitialStateAttribute implements IDataValidator{

    private var _data:XML;

    public function DataHasInitialStateAttribute( data:XML) {
        _data = data;
    }

    public function validate():Object {
        if ( _data.@initial != undefined ) return _data;
        throw getError( ErrorCodes.INITIAL_STATE_ATTRIBUTE_NOT_DECLARED );
    }
}
}