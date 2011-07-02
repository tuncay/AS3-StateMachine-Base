/**
 * User: revisual.co.uk
 * Date: 02/07/11
 * Time: 22:28
 */
package org.osflash.statemachine.base.supporting {
import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.StateTransitionModel;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.uids.getNullUID;

public class MockStateTransitionModel implements StateTransitionModel {

    private var _register:ITransitionRegister;

    public function MockStateTransitionModel( register:ITransitionRegister ) {
        _register = register;
    }

    public function get hasTransitionBeenCancelled():Boolean {
        return false;
    }

    public function get currentState():IState {
        return null;
    }

    public function get targetState():IState {
        return null;
    }

    public function get payload():IPayload {
        return null;
    }

    public function set transitionPhase( value:UID ):void {
    }

    public function setTargetStateAsCurrent():void {
    }

    public function cancelTransition( reason:UID, payload:Object ):void {
        _register.setReason( reason );
        _register.setPayload( payload);
    }

    public function get transitionPhase():UID {
        return getNullUID();
    }
}
}
