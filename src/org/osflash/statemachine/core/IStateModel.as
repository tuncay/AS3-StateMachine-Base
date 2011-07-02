package org.osflash.statemachine.core {
/**
 * Contract with FSMInjector and framework for managing States
 */
public interface IStateModel {

    function getState(stateID:UID):IState;
}
}