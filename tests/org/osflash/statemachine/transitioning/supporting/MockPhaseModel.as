/**
 * User: revisual.co.uk
 * Date: 04/07/11
 * Time: 11:30
 */
package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.IPhaseModel;
import org.osflash.statemachine.uids.IUID;

public class MockPhaseModel implements IPhaseModel {
    public function MockPhaseModel() {
    }

    public function get currentState():IState {
        return null;
    }

    public function get targetState():IState {
        return null;
    }

    public function get hasTransitionBeenCancelled():Boolean {
        return false;
    }

    public function set transitionPhase( phase:IUID ):void {
    }

    public function get payload():IPayload {
        return null;
    }

    public function setTargetStateAsCurrent():void {
    }

    public function get referringTransition():String {
        return "";
    }

    public function get cancellationReason():String {
        return "";
    }
}
}
