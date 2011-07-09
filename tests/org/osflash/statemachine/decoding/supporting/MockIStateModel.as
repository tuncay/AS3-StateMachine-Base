package org.osflash.statemachine.decoding.supporting {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.IStateModel;
import org.osflash.statemachine.supporting.IResultsRegistry;

public class MockIStateModel implements IStateModel {

    private var _registry:IResultsRegistry;

    public function MockIStateModel( registry:IResultsRegistry ) {
        _registry = registry;
    }

    public function get initialState():IState {
        return null;
    }

    public function registerState( state:IState, initial:Boolean = false ):Boolean {
        _registry.pushResult( "MISM.rS:" + state + ":" + initial.toString() );
        return false;
    }

    public function removeState( stateName:String ):Boolean {
        return false;
    }

    public function hasState( stateName:String ):Boolean {
        return false;
    }

    public function getTargetState( transitionName:String, state:IState ):IState {
        return null;
    }

}
}
