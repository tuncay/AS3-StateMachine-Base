/**
 * User: revisual.co.uk
 * Date: 02/07/11
 * Time: 22:30
 */
package org.osflash.statemachine.base.supporting {
import org.osflash.statemachine.core.StateTransitionController;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.model.BaseState;
import org.osflash.statemachine.uids.getNullUID;

public class MockStateTransitionController implements StateTransitionController {

    private var _register:ITransitionRegister;

    public function MockStateTransitionController( register:ITransitionRegister ) {
        _register = register;
    }

    public function transition( transition:UID, payload:Object = null ):void {
        _register.setTransition( transition );
        _register.setPayload( payload );
    }

    public function transitionToInitialState():void {
         _register.setPayload( new BaseState( getNullUID()) )
    }
}
}
