package org.osflash.statemachine.decoding.validators {

import flashx.textLayout.debug.assert;

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;

import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.StateDecodingError;
import org.osflash.statemachine.errors.getErrorMessage;

public class DataIsNotNullTest {

    private var _dataValidator:IDataValidator;
    private var _data:Object;

    [Before]
    public function before():void {
        _data = "testing";
        _dataValidator = new DataIsNotNull();
    }

    [After]
    public function after():void {
        _data = null;
        _dataValidator = null;
    }

    [Test]
    public function if_data_is_null__throws_StateDecodingError():void {
        const expectedMessage:String = getErrorMessage( ErrorCodes.NULL_FSM_DATA_ERROR );
        assertThat( setNullDataAndCallValidateOnTestSubject, throws( allOf( instanceOf( StateDecodingError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function if_data_is_not_null__validate_returns_data():void {

        assertThat( setDataAndCallValidateOnTestSubject(), strictlyEqualTo( _data ));
    }

    private function setDataAndCallValidateOnTestSubject():Object {
        _dataValidator.data = _data;
        return _dataValidator.validate();
    }

     private function setNullDataAndCallValidateOnTestSubject():void {
        _dataValidator.data = null;
        _dataValidator.validate();
    }
}
}
