
package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.model.IPhaseModel;
import org.osflash.statemachine.transitioning.ITransitionPhase;

public class HappyPhaseTwo implements ITransitionPhase {
    private var _register:IPhaseRegister;


    public function HappyPhaseTwo(register:IPhaseRegister) {
        _register = register;
    }

    public function dispatch( model:IPhaseModel ):Boolean {
        _register.setPhase( this );
        return true;
    }
}
}
