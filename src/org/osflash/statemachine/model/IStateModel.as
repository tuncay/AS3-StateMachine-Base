package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IState;

public interface IStateModel {

    function get initialState():IState;

    function registerState( state:IState, initial:Boolean = false ):Boolean;

    function removeState( stateName:String ):Boolean;

    function hasState( stateName:String ):Boolean;

    function getTargetState( transitionName:String, state:IState ):IState ;

}
}