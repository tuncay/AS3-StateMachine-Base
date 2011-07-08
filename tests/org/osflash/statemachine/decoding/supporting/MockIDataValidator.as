package org.osflash.statemachine.decoding.supporting {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.supporting.IResultsRegistry;

public class MockIDataValidator implements IDataValidator {

    private var _registry:IResultsRegistry;
    private var _data:Object;
    private var _count:int;

    public function MockIDataValidator(registry:IResultsRegistry) {
        _registry = registry;
        _count = 0;
    }

    public function set data( value:Object ):void {
         _registry.pushResult( "[" + _count++ + "]MIDV.d:" + value.toString() );
        _data = value;
    }

    public function validate():Object {
         _registry.pushResult( "[" + _count++ + "]MIDV.v" );
        return _data;
    }
}
}
