package org.osflash.statemachine.core {
/**
 * Contract with FSMInjector and framework for managing States
 */
public interface IStateModel {

    /**
     * Retrieves the State with the given name
     * @param stateName
     * @return   the IState retrieved
     */
    function getState(stateName:String):IState;
}
}