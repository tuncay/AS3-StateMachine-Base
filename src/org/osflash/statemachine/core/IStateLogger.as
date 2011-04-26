package org.osflash.statemachine.core {
public interface IStateLogger {
    /**
     * Allows wrapping of logging functionality within the StateMachine framework
     * @param msg The message to log
     */
    function log(msg:String):void;


    /**
     * Allows the logging of each phase as triggered in the BaseStateMachine's onTransition method
     * @param phase
     * @param state
     */
    function logPhase(phase:ITransitionPhase, state:IState):void;

}
}