package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.uids.StateUID;
import org.osflash.statemachine.uids.flushUIDs;

public class TransitionModelPropertiesTest {

    private var _properties:TransitionModelProperties;

    [Before]
    public function before():void {
        _properties = new TransitionModelProperties();
    }

    [After]
    public function after():void {
        _properties = null;
        flushUIDs();
    }


    [Test]
    public function calling_setCurrentState_for_the_first_time__with_isInitial_true__sets_currentState_correctly():void {
        const state:IState = new BaseState( new StateUID( "state_one" ) );
        _properties.setCurrentState( state, true );

        assertThat( _properties.currentState, strictlyEqualTo( state ) );
    }

    [Test]
    public function calling_setCurrentState_subsequent__with_isInitial_true__throws_StateTransitionError():void {
        const expectedMessage:String = StateTransitionError.INITIAL_STATE_CAN_ONLY_BE_SET_ONCE;
        const stateOne:IState = new BaseState( new StateUID( "state_one" ) );
        const stateTwo:IState = new BaseState( new StateUID( "state_two" ) );
        _properties.setCurrentState( stateOne );

        const throwFunction:Function = function ():void {
            _properties.setCurrentState( stateTwo, true );
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );

    }


}
}
