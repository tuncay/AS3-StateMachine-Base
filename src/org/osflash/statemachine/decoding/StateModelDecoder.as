
package org.osflash.statemachine.decoding {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.decoding.IStateDecoder;
import org.osflash.statemachine.decoding.IStateModelDecoder;
import org.osflash.statemachine.errors.StateDecodingError;
import org.osflash.statemachine.model.IStateModel;
import org.osflash.statemachine.uids.IUID;

public class StateModelDecoder implements IStateModelDecoder {

    private static const STATE_DECODER_MUST_NOT_BE_NULL:String = "IStateDecoder has not been declared";

    protected var _stateDecoder:IStateDecoder;

    public function StateModelDecoder( stateDecoder:IStateDecoder ) {
        _stateDecoder = stateDecoder;
    }

    public function inject( stateModel:IStateModel ):void {

        if ( _stateDecoder == null )
            throw new StateDecodingError( STATE_DECODER_MUST_NOT_BE_NULL );

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