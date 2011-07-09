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
import org.osflash.statemachine.supporting.injectThis;

public class TransitionElementsHaveRequiredAttributesTest {

    private var _dataValidator:IDataValidator;
    private var _wellFormedData:XML;
    private var _badlyFormedDataOne:XML;
    private var _badlyFormedDataTwo:XML;

    [Before]
    public function before():void {
        _wellFormedData =
        <fsm initial="state/initial">
            <state name="state/starting" >
                <transition name="transition/start" target="state/starting"/>
                <transition name="transition/end" target="state/endinging"/>
            </state>

            <state name="state/ending" >
                <transition name="transition/start" target="state/starting"/>
                <transition name="transition/end" target="state/endinging"/>
            </state>
        </fsm>;

        _badlyFormedDataOne =
        <fsm initial="state/initial">
            <state name="state/starting" >
                <transition target="state/starting"/>
                <transition name="transition/end" target="state/endinging"/>
            </state>

            <state name="state/ending" >
                <transition name="transition/start" target="state/starting"/>
                <transition  target="state/endinging"/>
            </state>
        </fsm>;

        _badlyFormedDataTwo =
        <fsm initial="state/initial">
            <state name="state/starting" >
                <transition name="transition/start" target="state/starting"/>
                <transition name="transition/end"/>
            </state>

            <state name="state/ending" >
                <transition name="transition/start" target="state/starting"/>
                <transition name="transition/end"/>
            </state>
        </fsm>;
        _dataValidator = new TransitionElementsHaveRequiredAttributes();
    }

    [After]
    public function after():void {
        _wellFormedData = null;
        _dataValidator = null;
    }

    [Test]
    public function if_data_is_badly_formed__throws_StateDecodingError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.TRANSITION_NAME_ATTRIBUTE_NOT_DECLARED );
        expectedMessage = injectThis( expectedMessage ).finallyWith( "quantity", "2" );
        assertThat( setBadDataAndCallValidateOnTestSubject, throws( allOf( instanceOf( StateDecodingError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function if_data_is_badly_formed2__throws_StateDecodingError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.TRANSITION_TARGET_ATTRIBUTE_NOT_DECLARED );
        expectedMessage = injectThis( expectedMessage ).finallyWith( "quantity", "2" );
        assertThat( setBadData2AndCallValidateOnTestSubject, throws( allOf( instanceOf( StateDecodingError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }


    [Test]
    public function if_data_is_well_formed__validate_returns_data():void {
        assertThat( setWellDataAndCallValidateOnTestSubject(), strictlyEqualTo( _wellFormedData ) );
    }

    private function setWellDataAndCallValidateOnTestSubject():Object {
        _dataValidator.data = _wellFormedData;
        return _dataValidator.validate();
    }

    private function setBadDataAndCallValidateOnTestSubject():void {
        _dataValidator.data = _badlyFormedDataOne;
        _dataValidator.validate();
    }

    private function setBadData2AndCallValidateOnTestSubject():void {
        _dataValidator.data = _badlyFormedDataTwo;
        _dataValidator.validate();
    }
}
}
