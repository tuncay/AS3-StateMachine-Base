package org.osflash.statemachine.core {
public interface IStateLogger {
    /**
     * Allows wrapping of logging functionality within the StateMachine framework
     * @param msg The message to log
     */
    function log(msg:String):void;

    function logPhase(phase:ITransitionPhase, state:IState):void;

}
}