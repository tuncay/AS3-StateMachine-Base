package org.osflash.statemachine.core {


/**
 * Contract with FSMInjector and framework for managing States
 */
public interface IStateProvider {

    function getState( stateName:String ):IState;
}
}