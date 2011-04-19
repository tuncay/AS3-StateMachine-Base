package org.osflash.statemachine.core {
public interface IStateModelInjector {
    /**
     * Registers all the decoded states with the IStateMachine, then calls the onRegister method.
     * @param stateModel the IStateMachine to inject
     */
    function inject(stateModel:IStateModelOwner):void

    /**
     * The destroy method for GC
     */
    function destroy():void;
}
}