package org.osflash.statemachine.decoding {

import org.osflash.statemachine.core.IState;

public interface IStateDecoder {

    function setData( value:IDataValidator ):void;

    function decodeState( stateDef:Object, index:uint ):IState;

    function isInitial( stateName:String ):Boolean;

    function getStates():Vector.<IState>;

    function decodeTransitionForState( state:IState, stateDef:Object ):IState


}
}