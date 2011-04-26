package org.osflash.statemachine.core {
public interface IStateModelInjector {

    /**
     * Registers all the decoded states with the IStateModelOwner.
     * @param stateModel the IStateModelOwner to inject
     */
    function inject(stateModel:IStateModelOwner):void

    /**
     * The destroy method for GC
     */
    function destroy():void;
}
}