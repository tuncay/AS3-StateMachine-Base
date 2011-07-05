package org.osflash.statemachine.model {

import org.osflash.statemachine.core.*;
import org.osflash.statemachine.uids.IUID;

public interface ITransitionProperties {
    function get currentTransitionPhase():IUID;
    function set currentTransitionPhase( value:IUID ):void;
    function get currentState():IState
    function set currentState( state:IState ):void
    function get hasTransitionBeenCancelled():Boolean
    function get currentPayload():IPayload
    function get referringTransition():IUID
    function get cancellationReason():IUID
    function set cancellationReason( reason:IUID ):void
    function set currentTransitionBinding( binding:TransitionBinding ):void
    function reset():void
}
}
