/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 31/01/11
 * Time: 16:06
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.logging {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.core.ITransitionPhase;

public class TraceStateLogger implements IStateLogger {

    public var prefix:String;

    public var active:Boolean;

    public var flags:int;

    private var _lastMessage:String;

    public function TraceStateLogger( prefix:String = "", active:Boolean = true, flags:int = 511 ) {
        this.prefix = prefix;
        this.active = active;
        this.flags = flags;
    }

    public function get lastMessage():String {
        return _lastMessage;
    }


    public function log( msg:String ):void {
        if ( active )
            writeLog( (prefix || "" ) + msg );
        else
            writeLog( null );
    }

    public function logPhase( phase:ITransitionPhase, state:IState ):void {
        if ( active && ( flags & phase.index ) )
            writeLog( (prefix || "" ) + " phase[" + phase.name + "] from state[" + state.id + "] executed." );
        else
            writeLog( null );
    }

    private function writeLog( msg:String ):void {
        _lastMessage = msg;
        if ( msg != null )
            trace( msg );
    }


}
}
