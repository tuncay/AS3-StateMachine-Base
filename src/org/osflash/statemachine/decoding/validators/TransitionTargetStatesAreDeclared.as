package org.osflash.statemachine.decoding.validators {

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

public class TransitionTargetStatesAreDeclared implements IDataValidator {

    private var _data:XML;

    public function validate():Object {
        const transitions:XMLList = _data..transition;
        for each ( var transition:XML in transitions ) {
            const duplicateList:int = retrieveNumberOfStateElementsWithName( transition.@target );
            if ( duplicateList == 0 )
                throw getError( ErrorCodes.TRANSITION_TARGET_NOT_DECLARED ).injectMsgWith( transition.parent().@name, "state" ).injectMsgWith( transition.@name, "transition" );
        }
        return _data;
    }

    private function retrieveNumberOfStateElementsWithName( id:String ):int {
        return _data.state.( hasOwnProperty( "@name" ) && @name == id ).length();
    }

    public function set data( value:Object ):void {
        _data = XML( value );
    }
}
}
