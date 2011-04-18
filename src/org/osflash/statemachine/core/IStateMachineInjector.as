package org.osflash.statemachine.core {
import org.osflash.statemachine.base.BaseStateMachine;

public interface IStateMachineInjector {
    /**
     * Registers all the decoded states with the IStateMachine, then calls the onRegister method.
     * @param stateModel the IStateMachine to inject
     */
    function inject(stateModel:IStateModelOwner, stateMachine:BaseStateMachine):void

    /**
     * The destroy method for GC
     */
    function destroy():void;
}
}