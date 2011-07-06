package org.osflash.statemachine.model.supporting {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.IStateModel;
import org.osflash.statemachine.model.TransitionBinding;
import org.osflash.statemachine.uids.IUID;

public class MockStateModelOwner implements IStateModel {

    private var _initialState:IState;
    private var _registry:IBindingRegistry;

    public function MockStateModelOwner( initialState:IState, registry:IBindingRegistry = null) {
        _initialState = initialState;
        _registry = registry;
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
         _registry.setBinding( new TransitionBinding(transitionUID, state) );
        return null;
    }

    public function dispose():void {
    }
}
}
