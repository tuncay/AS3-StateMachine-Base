package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.uids.IUID;

public interface IPhaseModel {
    function get currentState():IState;

    function get targetState():IState;

    function get referringTransition():String;
    function get cancellationReason():String;

    function get hasTransitionBeenCancelled():Boolean;

    function set transitionPhase( phase:IUID ):void;

    function get payload():IPayload;

    function setTargetStateAsCurrent():void;

}
}
