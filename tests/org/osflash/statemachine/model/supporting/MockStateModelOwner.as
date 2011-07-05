package org.osflash.statemachine.model.supporting {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.IStateModelOwner;
import org.osflash.statemachine.uids.IUID;

public class MockStateModelOwner implements IStateModelOwner {

    private var _initialState:IState;

    public function MockStateModelOwner( initialState:IState ) {
        _initialState = initialState;
    }

    public function get initialState():IState {
        return _initialState;
    }

    public function registerState( state:IState, initial:Boolean = false ):Boolean {
        return false;
    }

    public function removeState( stateUID:IUID ):Boolean {
        return false;
    }

    public function hasState( stateUID:IUID ):Boolean {
        return false;
    }

    public function getTargetState( transitionUID:IUID, state:IState ):IState {
        return null;
    }

    public function dispose():void {
    }
}
}
