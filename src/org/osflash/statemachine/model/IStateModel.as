package org.osflash.statemachine.model {

import org.osflash.statemachine.core.*;
import org.osflash.statemachine.uids.IUID;

public interface IStateModel {

    function get initialState():IState;

    function registerState( state:IState, initial:Boolean = false ):Boolean;

    function removeState( stateUID:IUID ):Boolean;

    function hasState( stateUID:IUID ):Boolean;

    function getTargetState( transitionUID:IUID, state:IState ):IState ;

    function dispose():void;
}
}