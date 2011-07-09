package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

public class TransitionNamesInEachStateAreUnique implements IDataValidator {

    private var _data:XML;

    public function validate():Object {
        const states:XMLList = _data.state;
        for each ( var state:XML in states ) {
            validateState( state );
        }
        return _data;
    }

    private function validateState( state:XML ):void {
        const transitions:XMLList = retrieveAllTransitionNameAttributes( state );
        for each ( var name:XML in transitions ) {
            const duplicateList:int = retrieveNumberOfStateElementsWithName( name, state );
            if ( duplicateList != 1 )
                throw getError( ErrorCodes.DUPLICATE_TRANSITION_DECLARED ).injectMsgWith( state.@name , "state" );
        }
    }

    private function retrieveAllTransitionNameAttributes( state:XML ):XMLList {
        return state.transition.(hasOwnProperty( "@name" ) ).@name;
    }

    private function retrieveNumberOfStateElementsWithName( id:String, state:XML ):int {
        return state.transition.( hasOwnProperty( "@name" ) && @name == id ).length();
    }


    public function set data( value:Object ):void {
        _data = XML( value );
    }
}
}
