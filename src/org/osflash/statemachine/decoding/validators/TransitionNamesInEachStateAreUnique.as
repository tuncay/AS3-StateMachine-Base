package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

public class TransitionNamesInEachStateAreUnique implements IDataValidator {

    private var _data:XML;

    public function TransitionNamesInEachStateAreUnique( data:XML ) {
        _data = data;
    }

    public function validate():Object {
        const states:XMLList = _data..state;
        for each ( var state:XML in states ) {
            validateState( state );
        }
        return _data;
    }

    private function validateState( state:XML ):void {
        const transitions:XMLList = retrieveAllTransitionNameAttributes( state );
        var errors:Vector.<String> = new <String>[];
        for each ( var name:XML in transitions ) {
            const duplicateList:int = retrieveNumberOfStateElementsWithName( name, state );
            if ( duplicateList != 1 ) errors.push( name.toString() );
        }
        if ( errors.length == 0 ) return;
        throw getError( ErrorCodes.DUPLICATE_STATES_DECLARED ).injectMsgWith( errors.join( "," ), "state" );
    }

    private function retrieveAllTransitionNameAttributes( state:XML ):XMLList {
        return state..transition.(hasOwnProperty( "@name" ) ).@name;
    }

    private function retrieveNumberOfStateElementsWithName( name:String, state:XML ):int {
        return state..transition.( hasOwnProperty( "@name" ) && @name == name).length();
    }


}
}
