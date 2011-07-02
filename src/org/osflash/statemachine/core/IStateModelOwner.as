package org.osflash.statemachine.core {
public interface IStateModelOwner {

    function get initialState():IState;

    function registerState(state:IState, initial:Boolean = false):Boolean;

    function removeState(stateUID:UID):Boolean;

    function hasState(stateUID:UID):Boolean;

    function getTargetState(transitionUID:UID, state:IState):IState ;

    function dispose():void;
}
}