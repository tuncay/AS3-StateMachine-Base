package org.osflash.statemachine.decoding {

import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.getUIDFromIdentifier;

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

        for ( var i:int; i < stateDefs.length(); i++ ) {
            const stateDef:XML = stateDefs[i];
            const state:IState = decodeState( stateDef );
            decodeTransitions( state, stateDef );
            states.push( state );
        }
        return states;
    }

    public function decodeState( stateDef:Object ):IState {
        const stateUID:IUID = getUIDFromIdentifier( stateDef.@name );
        return new BaseState( stateUID );
    }

    public function isInitial( stateUID:IUID ):Boolean {
        return ( stateUID.equals( data.@initial.toString() ) );
    }

    protected function decodeTransitions( state:IState, stateDef:Object ):void {
        var transitions:XMLList = stateDef..transition as XMLList;
        for ( var i:int; i < transitions.length(); i++ ) {
            var transDef:XML = transitions[i];
            defineTransition( state, transDef );
        }
    }

    private function defineTransition( state:IState, transDef:XML ):void {
        const transitionUID:IUID = getUIDFromIdentifier( transDef.@name );
        const targetUID:IUID = getUIDFromIdentifier( transDef.@target );
        state.defineTransition( transitionUID, targetUID );
    }
}
}