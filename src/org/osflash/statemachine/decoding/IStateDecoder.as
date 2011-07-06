package org.osflash.statemachine.decoding {

import org.osflash.statemachine.core.*;
import org.osflash.statemachine.uids.IUID;

public interface IStateDecoder {

    function setData( value:IDataValidator ):void;

    function decodeState( stateDef:Object ):IState;

    function isInitial( stateName:IUID ):Boolean;

    function getStates():Vector.<IState>;



}
}