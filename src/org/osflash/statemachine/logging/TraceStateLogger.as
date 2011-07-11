package org.osflash.statemachine.logging {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.uids.IUID;

public class TraceStateLogger implements IStateLogger {

    public var prefix:String;

    public var active:Boolean;

    public var stateflags:int;

    public var phaseflags:int;


    public function TraceStateLogger( prefix:String = "", active:Boolean = true ) {
        this.prefix = prefix;
        this.active = active;
        this.stateflags = 0;
        this.phaseflags = 0;
    }

    public function logPhase( phase:IUID, transition:String, state:IState ):void {
        if ( active &&
             phaseflags == 0 || ( phaseflags & phase.index ) &&
                                stateflags == 0 || ( stateflags & state.index) ) {
            log( ( prefix || "" ) + "executed phase[" + phase.identifier + "] durring transition [" + transition + "] from state[" + state.name + "]" );
        }
    }

    public function log( msg:String ):void {
        if ( msg != null )
            trace( msg );
    }

    public function logStateChange( currentState:IState, targetState:IState ):void {

        if ( active &&
             stateflags == 0 || ( stateflags & currentState.index) ) {
            log( ( prefix || "" ) + "state has changed from [" + currentState.name + "] to [" + targetState.name + "]" );
        }
    }

    public function logCancellation( reason:IUID, transition:String, state:IState ):void {
        if ( active &&
             stateflags == 0 || ( stateflags & state.index) ) {
            log( ( prefix || "" ) + "transition[" + transition + "] from state [" + state.name + "] has been cancelled because {" + reason + "]" );
        }
    }
}
}
