package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

public class StateNamesAreUnique implements IDataValidator {

    private var _data:XML;

    public function validate():Object {
        const states:XMLList = retrieveAllStateNameAttributes();
        var errors:Vector.<String> = new <String>[];
        for each ( var name:XML in states ) {
            const duplicateList:int = retrieveNumberOfStateElementsWithName( name );
            if ( duplicateList != 1 ) errors.push( name.toString() );
        }
        if ( errors.length == 0 )return _data;
        throw getError( ErrorCodes.DUPLICATE_STATES_DECLARED ).injectMsgWith( errors.join( "," ), "state" );
    }

    private function retrieveAllStateNameAttributes():XMLList {
        return _data.state.(hasOwnProperty( "@name" ) ).@name;
    }

    private function retrieveNumberOfStateElementsWithName( id:String ):int {
        return _data.state.( hasOwnProperty( "@name" ) && @name == id).length();
    }

    public function set data( value:Object ):void {
        _data = XML( value );
    }
}
}
