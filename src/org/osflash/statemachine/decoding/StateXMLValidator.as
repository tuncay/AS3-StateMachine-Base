package org.osflash.statemachine.decoding {

import org.osflash.statemachine.decoding.validators.DataHasInitialStateAttribute;
import org.osflash.statemachine.decoding.validators.DataHasInitialStateDeclared;
import org.osflash.statemachine.decoding.validators.DataIsNotNull;
import org.osflash.statemachine.decoding.validators.StateElementsHaveNameAttributes;
import org.osflash.statemachine.decoding.validators.StateNamesAreUnique;
import org.osflash.statemachine.decoding.validators.TransitionElementsHaveRequiredAttributes;
import org.osflash.statemachine.decoding.validators.TransitionNamesInEachStateAreUnique;

public class StateXMLValidator extends MacroDataValidator {

    private var _data:XML;

    public function StateXMLValidator( data:XML ) {
        super( data );
    }

    protected override function initiateValidator():void {
        addValidatorClass( DataIsNotNull );
        addValidatorClass( DataHasInitialStateAttribute );
        addValidatorClass( DataHasInitialStateDeclared );
        addValidatorClass( StateElementsHaveNameAttributes );
        addValidatorClass( TransitionElementsHaveRequiredAttributes );
        addValidatorClass( StateNamesAreUnique );
        addValidatorClass( TransitionNamesInEachStateAreUnique );
    }
}
}