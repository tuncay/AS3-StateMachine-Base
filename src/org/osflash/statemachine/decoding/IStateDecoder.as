package org.osflash.statemachine.decoding {

import org.osflash.statemachine.core.IState;

public interface IStateDecoder {

    function setData( value:IDataValidator ):void;
    function isInitial( stateName:String ):Boolean;
    function getStates():Vector.<IState>;


}
}