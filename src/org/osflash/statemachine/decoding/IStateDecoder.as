package org.osflash.statemachine.decoding {
import org.osflash.statemachine.core.*;
import org.osflash.statemachine.uids.IUID;

public interface IStateDecoder {

    function setData(value:Object):void;

    function decodeState(stateDef:Object):IState;

    function isInitial(stateName:IUID):Boolean;

    function getStateList():Array;

    function destroy():void;

}
}