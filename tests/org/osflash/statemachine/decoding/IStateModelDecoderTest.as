package org.osflash.statemachine.decoding {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.decoding.supporting.MockIStateDecoder;
import org.osflash.statemachine.decoding.supporting.MockIStateModel;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.StateDecodingError;
import org.osflash.statemachine.errors.getErrorMessage;
import org.osflash.statemachine.model.IStateModel;
import org.osflash.statemachine.supporting.IResultsRegistry;

public class IStateModelDecoderTest implements IResultsRegistry {

    private var _stateDecoder:IStateDecoder;
    private var _stateModel:IStateModel;
    private var _stateModelDecoder:IStateModelDecoder;
    private var _results:Array;
    private var _states:Vector.<IState>;

    [Before]
    public function before():void {
        initProps();
    }

    [After]
    public function after():void {
        disposeProps();
    }

    [Test]
    public function calling_inject_with_null_IStateDecoder_throws_StateDecodingError():void {
        const expectedMessage:String = getErrorMessage( ErrorCodes.STATE_DECODER_MUST_NOT_BE_NULL );
        initTestSubject( null );
        assertThat( injectIStateModel, throws( allOf( instanceOf( StateDecodingError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function calling_inject_with_null_IStateModel_throws_StateDecodingError():void {
        const expectedMessage:String = getErrorMessage( ErrorCodes.STATE_MODEL_MUST_NOT_BE_NULL );
        initTestSubject( _stateDecoder );
        assertThat( injectNullIStateModel, throws( allOf( instanceOf( StateDecodingError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function injecting_calls_isInitial_on_IStateDecoder_then_registerState_onIStateModel():void {
        const expected:String = "MISD.iI:state/one,MISM.rS:state/one:false," +
                                "MISD.iI:state/two,MISM.rS:state/two:false," +
                                "MISD.iI:state/three,MISM.rS:state/three:false";
        initTestSubject( _stateDecoder );
        injectIStateModel();
        assertThat( got, equalTo( expected ) );
    }

    private function injectIStateModel():void {
        _stateModelDecoder.inject( _stateModel );
    }

    private function injectNullIStateModel():void {
        _stateModelDecoder.inject( null );
    }

    private function initProps():void {
        _results = [];
        _states = new <IState> [
            new BaseState( "state/one", 1 ),
            new BaseState( "state/two", 2 ),
            new BaseState( "state/three", 4 )
        ];
        _stateDecoder = new MockIStateDecoder( _states, this );
        _stateModel = new MockIStateModel( this );
    }

    private function initTestSubject( decoder:IStateDecoder ):void {
        _stateModelDecoder = new StateModelDecoder( decoder );
    }

    private function disposeProps():void {
        _results = null;
        _states = null;
        _stateDecoder = null;
        _stateModelDecoder = null;
    }

    public function get got():String {
        return _results.join( "," );
    }

    public function pushResult( value:Object ):void {
        _results.push( value );
    }


}
}
