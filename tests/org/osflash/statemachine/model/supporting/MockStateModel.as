package org.osflash.statemachine.model.supporting {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.IStateModel;
import org.osflash.statemachine.model.TransitionBinding;
import org.osflash.statemachine.supporting.IResultsRegistry;

public class MockStateModel implements IStateModel {

    private var _initialState:IState;
    private var _targetState:IState;
    private var _registry:IResultsRegistry;

    public function MockStateModel( initialState:IState, targetState:IState = null, registry:IResultsRegistry = null ) {
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

    public function removeState( stateUID:String ):Boolean {
        return false;
    }

    public function hasState( stateUID:String ):Boolean {
        return false;
    }

    public function getTargetState( transitionName:String, state:IState ):IState {
        _registry.pushResult( new TransitionBinding( transitionName, state ) );
        return _targetState;
    }

    public function dispose():void {
    }
}
}
