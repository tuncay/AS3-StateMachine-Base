/*
 ADAPTED FOR A STAND ALONE UTILITY FROM:
 PureMVC AS3 Utility - StateMachine
 Copyright (c) 2008 Neil Manuell, Cliff Hall
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.osflash.statemachine.base {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.decoding.IStateDecoder;
import org.osflash.statemachine.decoding.IStateModelInjector;
import org.osflash.statemachine.errors.StateDecodingError;
import org.osflash.statemachine.model.IStateModelOwner;
import org.osflash.statemachine.uids.IUID;

public class StateModelInjector implements IStateModelInjector {

    private static const STATE_DECODER_MUST_NOT_BE_NULL:String = "IStateDecoder has not been declared";

    protected var _stateDecoder:IStateDecoder;

    public function StateModelInjector( stateDecoder:IStateDecoder ) {
        _stateDecoder = stateDecoder;
    }

    public function inject( stateModel:IStateModelOwner ):void {

        if ( _stateDecoder == null )
            throw new StateDecodingError( STATE_DECODER_MUST_NOT_BE_NULL );

        const states:Array = _stateDecoder.getStateList();
        for each ( var state:IState in states ) {
            stateModel.registerState( state, isInitial( state.uid ) );
        }
    }

    public function destroy():void {
        _stateDecoder.destroy();
        _stateDecoder = null;
    }

    protected function isInitial( stateName:IUID ):Boolean {
        return _stateDecoder.isInitial( stateName );
    }


}
}