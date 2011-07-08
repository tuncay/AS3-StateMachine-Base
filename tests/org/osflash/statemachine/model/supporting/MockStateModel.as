package org.osflash.statemachine.model.supporting {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.IStateModel;
import org.osflash.statemachine.model.TransitionBinding;
import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.uids.IUID;

public class MockStateModel implements IStateModel {

    private var _initialState:IState;
    private var _targetState:IState;
    private var _registry:IResultsRegistry;

    public function MockStateModel( initialState:IState, targetState:IState = null,  registry:IResultsRegistry = null) {
        _initialState = initialState;
        _targetState = targetState;
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
         _registry.pushResult( new TransitionBinding(transitionUID, state) );
        return _targetState;
    }

    public function dispose():void {
    }
}
}
