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

    public function TraceStateLogger(prefix:String = "", active:Boolean = true, flags:int = 127) {
        this.prefix = prefix;
        this.active = active;
        this.flags = flags;
    }

    public function log(msg:String):void {
        if (active)
            trace(prefix + msg);
    }

    public function logPhase(phase:ITransitionPhase, state:IState):void {
        if (active && ( flags & phase.index ))
            trace(prefix + " PHASE: " + phase.name + " from STATE: " + state.name + " executed.");
    }
}
}
