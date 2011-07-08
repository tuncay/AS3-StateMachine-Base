package org.osflash.statemachine.decoding.validators {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.StateDecodingError;
import org.osflash.statemachine.errors.getErrorMessage;

public class DataHasInitialStateAttributeTest {

    private var _dataValidator:IDataValidator;
    private var _wellFormedData:XML;
    private var _badlyFormedData:XML;

    [Before]
    public function before():void {
        _wellFormedData = <fsm initial="state/initial"/>;
        _badlyFormedData = <fsm />;
        _dataValidator = new DataHasInitialStateAttribute();
    }

    [After]
    public function after():void {
        _wellFormedData = null;
        _dataValidator = null;
    }

    [Test]
    public function if_data_is_badly_formed__throws_StateDecodingError():void {
        const expectedMessage:String = getErrorMessage( ErrorCodes.INITIAL_STATE_ATTRIBUTE_NOT_DECLARED );
        assertThat( setBadDataAndCallValidateOnTestSubject, throws( allOf( instanceOf( StateDecodingError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function if_data_is_well_formed__validate_returns_data():void {
        assertThat( setWellDataAndCallValidateOnTestSubject(), strictlyEqualTo( _wellFormedData ));
    }

    private function setWellDataAndCallValidateOnTestSubject():Object {
        _dataValidator.data = _wellFormedData;
        return _dataValidator.validate();
    }

     private function setBadDataAndCallValidateOnTestSubject():void {
        _dataValidator.data = _badlyFormedData;
        _dataValidator.validate();
    }
}
}
