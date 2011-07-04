package org.osflash.statemachine.core {

import org.osflash.statemachine.uids.IUID;

/**
 * Contract with FSMInjector and framework for managing States
 */
public interface IStateModel {

    function getState( stateID:IUID ):IState;
}
}