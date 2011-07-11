package org.osflash.statemachine.decoding {

import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;

public class BaseXMLStateDecoder implements IStateDecoder {

    private var _fsm:XML;
    private var _dataValidator:IDataValidator;

    public function setData( value:IDataValidator ):void {
        _dataValidator = value;
    }

    protected function get data():XML {
        return _fsm || XML( _dataValidator.validate() );
    }

    public function getStates():Vector.<IState> {

        const states:Vector.<IState> = new Vector.<IState>;
        const stateDefs:XMLList = data..state;
        var index:uint = 1;
        for ( var i:int; i < stateDefs.length(); i++ ) {
            const stateDef:XML = stateDefs[i];
            const state:IState = decodeState( stateDef, index );
            decodeTransitionForState( state, stateDef );
            states.push( state );
            index = index << 1;
        }
        return states;
    }

    public function isInitial( stateName:String ):Boolean {
        return ( stateName == data.@initial.toString() );
    }

    protected function decodeState( stateDef:Object, index:uint ):IState {
        return new BaseState( stateDef.@name, index );
    }

    protected function decodeTransitionForState( state:IState, stateDef:Object ):IState {
        var transitions:XMLList = stateDef..transition as XMLList;
        for ( var i:int; i < transitions.length(); i++ ) {
            var transDef:XML = transitions[i];
            defineTransition( state, transDef );
        }
        return state;
    }

    private function defineTransition( state:IState, transDef:XML ):void {
        state.defineTransition( transDef.@name, transDef.@target );
    }
}
}