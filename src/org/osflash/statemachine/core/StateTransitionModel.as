/**
 * User: revisual.co.uk
 * Date: 02/07/11
 * Time: 19:53
 */
package org.osflash.statemachine.core {


public interface StateTransitionModel {

    function get hasTransitionBeenCancelled():Boolean;
    function get currentState():IState;
    function get targetState():IState;
    function get payload():IPayload;
    function set transitionPhase( value:UID ):void;
    function setTargetStateAsCurrent():void;
}
}
