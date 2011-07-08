package org.osflash.statemachine.decoding.supporting {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.decoding.IStateDecoder;
import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.uids.IUID;

public class MockIStateDecoder implements IStateDecoder {

    private var _registry:IResultsRegistry;
    private var _states:Vector.<IState>;

    public function MockIStateDecoder( states:Vector.<IState>, regisitry:IResultsRegistry ) {
        _states = states;
        _registry = regisitry;
    }

    public function setData( value:IDataValidator ):void {
    }

    public function decodeState( stateDef:Object ):IState {
        return null;
    }

    public function isInitial( stateName:IUID ):Boolean {
        _registry.pushResult( "MISD.iI:" + stateName.toString() );
        return false;
    }

    public function getStates():Vector.<IState> {
        return _states;
    }

    public function decodeTransitionForState( state:IState, stateDef:Object ):IState {
        return null;
    }
}
}
