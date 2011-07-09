package org.osflash.statemachine.decoding {

import org.osflash.statemachine.decoding.validators.DataHasInitialStateAttribute;
import org.osflash.statemachine.decoding.validators.DataHasInitialStateDeclared;
import org.osflash.statemachine.decoding.validators.DataIsNotNull;
import org.osflash.statemachine.decoding.validators.StateElementsHaveNameAttributes;
import org.osflash.statemachine.decoding.validators.StateHasNoIncomingTransitions;
import org.osflash.statemachine.decoding.validators.StateNamesAreUnique;
import org.osflash.statemachine.decoding.validators.TransitionElementsHaveRequiredAttributes;
import org.osflash.statemachine.decoding.validators.TransitionNamesInEachStateAreUnique;
import org.osflash.statemachine.decoding.validators.TransitionTargetStatesAreDeclared;

public class StateXMLValidator extends MacroDataValidator {

    private var _data:XML;

    public function StateXMLValidator( data:XML ) {
        super( data );
        addValidator( new DataIsNotNull );
        addValidator( new DataHasInitialStateAttribute );
        addValidator( new DataHasInitialStateDeclared );
        addValidator( new StateElementsHaveNameAttributes );
        addValidator( new TransitionElementsHaveRequiredAttributes );
        addValidator( new StateNamesAreUnique );
        addValidator( new TransitionNamesInEachStateAreUnique );
        addValidator( new TransitionTargetStatesAreDeclared );
        addValidator( new StateHasNoIncomingTransitions );
    }
}
}