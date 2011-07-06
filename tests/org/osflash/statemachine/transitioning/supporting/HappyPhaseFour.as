/**
 * User: revisual.co.uk
 * Date: 03/07/11
 * Time: 07:28
 */
package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.model.IPhaseModel;
import org.osflash.statemachine.transitioning.ITransitionPhase;

public class HappyPhaseFour implements ITransitionPhase {

  private var _register:IPhaseRegister;

    public function HappyPhaseFour( register:IPhaseRegister ) {
        _register = register;
    }

    public function dispatch( model:IPhaseModel ):Boolean {
        _register.setPhase( this );
        return true;
    }
}
}
