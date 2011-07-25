package org.osflash.statemachine.decoding.validators {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.decoding.IDataValidator;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.ErrorMap;
import org.osflash.statemachine.errors.StateDecodingError;
import org.osflash.statemachine.supporting.injectThis;

public class StateHasNoIncomingTransitionsTest {

    private var _dataValidator:IDataValidator;
    private var _wellFormedData:XML;
    private var _badlyFormedData:XML;
    private var _wellFormedDataIncomingInitialOnly:XML;

    [Before]
    public function before():void {
        _wellFormedData =
        <fsm initial="state/starting">
            <state name="state/starting" >
                <transition name="transition/end" target="state/ending"/>
            </state>
            <state name="state/ending" >
                <transition name="transition/start" target="state/starting"/>
            </state>
        </fsm>;

        _wellFormedDataIncomingInitialOnly =
        <fsm initial="state/starting">
            <state name="state/starting" >
                <transition name="transition/end" target="state/ending"/>
            </state>
            <state name="state/ending"/>
        </fsm>;

        _badlyFormedData =
        <fsm initial="state/starting">
            <state name="state/starting" >
                <transition name="transition/end" target="state/ending"/>
                <transition name="transition/start" target="state/starting"/>
            </state>
            <state name="state/ending" >
                <transition name="transition/start" target="state/starting"/>
            </state>
            <state name="state/middling" >
                <transition name="transition/start" target="state/starting"/>
            </state>
        </fsm>;


        _dataValidator = new StateHasNoIncomingTransitions();
    }

    [After]
    public function after():void {
        _wellFormedData = null;
        _dataValidator = null;
    }

    [Test]
    public function if_data_is_badly_formed__throws_StateDecodingError():void {
        var expectedMessage:String = new ErrorMap().getErrorMessage( ErrorCodes.STATE_HAS_NO_INCOMING_TRANSITION );
        expectedMessage = injectThis( expectedMessage ).finallyWith( "state", "state/middling" );
         _dataValidator.data = _badlyFormedData;
        assertThat( callValidateOnTestSubject, throws( allOf( instanceOf( StateDecodingError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function if_data_is_well_formed__validate_returns_data():void {
        assertThat( setDataAndCallValidateOnTestSubject(_wellFormedData), strictlyEqualTo( _wellFormedData ) );
    }

    [Test]
    public function if_data_is_well_formed_and_incoming_is_initial_only__validate_returns_data():void {
        assertThat( setDataAndCallValidateOnTestSubject( _wellFormedDataIncomingInitialOnly), strictlyEqualTo( _wellFormedDataIncomingInitialOnly ) );
    }

    private function setDataAndCallValidateOnTestSubject(xml:XML):Object {
        _dataValidator.data = xml;
        return _dataValidator.validate();
    }

     private function callValidateOnTestSubject():Object {
        return _dataValidator.validate();
    }
}
}
