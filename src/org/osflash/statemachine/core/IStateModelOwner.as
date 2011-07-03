package org.osflash.statemachine.core {
public interface IStateModelOwner {

    function get initialState():IState;

    function registerState(state:IState, initial:Boolean = false):Boolean;

    function removeState(stateUID:IUID):Boolean;

    function hasState(stateUID:IUID):Boolean;

    function getTargetState(transitionUID:IUID, state:IState):IState ;

    function dispose():void;
}
}