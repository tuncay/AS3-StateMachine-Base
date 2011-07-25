package org.osflash.statemachine.core {

import org.osflash.statemachine.uids.IUID;

public interface IStateLogger {

    function log( msg:String ):void;

    function logPhase( phase:IUID, transition:String, state:IState ):void;

    function logStateChange( currentState:IState, targetState:IState ):void;

    function logCancellation( reason:String, transition:String, state:IState ):void;

}
}