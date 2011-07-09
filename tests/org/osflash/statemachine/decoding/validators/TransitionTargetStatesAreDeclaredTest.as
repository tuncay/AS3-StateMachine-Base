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

public class TransitionTargetStatesAreDeclaredTest {

    private var _dataValidator:IDataValidator;
    private var _wellFormedData:XML;
    private var _badlyFormedData:XML;

    [Before]
    public function before():void {
        _wellFormedData =
        <fsm initial="state/initial">
            <state name="state/starting" >
                <transition name="transition/end" target="state/ending"/>
            </state>
            <state name="state/ending" >
                <transition name="transition/start" target="state/starting"/>
            </state>
        </fsm>;

        _badlyFormedData =
        <fsm initial="state/initial">
            <state name="state/starting" >
                <transition name="transition/end" target="state/ending"/>
                <transition name="transition/start" target="state/starting"/>
            </state>
            <state name="state/ending" >
                <transition name="transition/start" target="state/starting"/>
                <transition name="transition/middle" target="state/middling"/>
            </state>
        </fsm>;


        _dataValidator = new TransitionTargetStatesAreDeclared();
    }

    [After]
    public function after():void {
        _wellFormedData = null;
        _dataValidator = null;
    }

    [Test]
    public function if_data_is_badly_formed__throws_StateDecodingError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.TRANSITION_TARGET_NOT_DECLARED );
        expectedMessage = injectThis( expectedMessage ).withThis( "transition", "transition/middle" ).finallyWith( "state", "state/ending" );
        assertThat( setBadDataAndCallValidateOnTestSubject, throws( allOf( instanceOf( StateDecodingError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
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
        _dataValidator.data = _badlyFormedData;
        _dataValidator.validate();
    }

}
}
