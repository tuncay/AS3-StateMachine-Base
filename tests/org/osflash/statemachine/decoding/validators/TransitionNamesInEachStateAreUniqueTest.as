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

public class TransitionNamesInEachStateAreUniqueTest {

    private var _dataValidator:IDataValidator;
    private var _wellFormedData:XML;
    private var _badlyFormedData:XML;

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

        _badlyFormedData =
        <fsm initial="state/initial">
            <state name="state/starting" >
                <transition name="transition/start" target="state/starting"/>
                <transition name="transition/end" target="state/endinging"/>
                <transition name="transition/start" target="state/starting"/>
            </state>
        </fsm>;


        _dataValidator = new TransitionNamesInEachStateAreUnique();
    }

    [After]
    public function after():void {
        _wellFormedData = null;
        _dataValidator = null;
    }

    [Test]
    public function if_data_is_badly_formed__throws_StateDecodingError():void {
        var expectedMessage:String = new ErrorMap().getErrorMessage( ErrorCodes.DUPLICATE_TRANSITION_DECLARED );
        expectedMessage = injectThis( expectedMessage ).finallyWith( "state", "state/starting" );
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
