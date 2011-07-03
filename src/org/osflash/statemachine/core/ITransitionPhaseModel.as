
package org.osflash.statemachine.core {
public interface ITransitionPhaseModel {
   function get currentState():IState;
    function get targetState():IState;
    function get hasTransitionBeenCancelled():Boolean;
    function set transitionPhase( phase:IUID):void;
    function get payload():IPayload;
    function setTargetStateAsCurrent():void;

}
}
