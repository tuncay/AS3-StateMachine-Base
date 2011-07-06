package org.osflash.statemachine.base.supporting {

import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.transitioning.IStateTransitionController;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.getNullUID;

public class MockStateTransitionController implements IStateTransitionController {

    private var _register:ITransitionRegister;

    public function MockStateTransitionController( register:ITransitionRegister ) {
        _register = register;
    }

    public function transition( transition:IUID, payload:Object = null ):void {
        _register.setTransition( transition );
        _register.setPayload( payload );
    }

    public function transitionToInitialState():void {
        _register.setPayload( new BaseState( getNullUID() ) )
    }

    public function cancelStateTransition( reason:IUID  ):void {
        _register.setReason( reason );
    }

}
}
