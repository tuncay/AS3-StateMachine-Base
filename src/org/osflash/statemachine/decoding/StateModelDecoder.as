package org.osflash.statemachine.decoding {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;
import org.osflash.statemachine.model.IStateModel;
import org.osflash.statemachine.uids.IUID;

public class StateModelDecoder implements IStateModelDecoder {

    protected var _stateDecoder:IStateDecoder;

    public function StateModelDecoder( stateDecoder:IStateDecoder ) {
        _stateDecoder = stateDecoder;
    }

    public function inject( stateModel:IStateModel ):void {
        if ( _stateDecoder == null ) {
            throw getError( ErrorCodes.STATE_DECODER_MUST_NOT_BE_NULL );
        }
        if ( stateModel == null ) {
            throw getError( ErrorCodes.STATE_MODEL_MUST_NOT_BE_NULL );
        }
        decodeStatesAndAddToIStateModel( stateModel );
    }

    private function decodeStatesAndAddToIStateModel( stateModel:IStateModel ):void {
        const states:Vector.<IState> = _stateDecoder.getStates();
        for each ( var state:IState in states ) {
            stateModel.registerState( state, isInitial( state.uid ) );
        }
    }

    protected function isInitial( stateName:IUID ):Boolean {
        return _stateDecoder.isInitial( stateName );
    }
}
}