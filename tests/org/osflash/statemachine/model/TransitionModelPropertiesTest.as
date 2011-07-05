package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.StateTransitionCancellationError;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.supporting.injectToken;
import org.osflash.statemachine.uids.CancellationReasonUID;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionPhaseUID;
import org.osflash.statemachine.uids.StateTransitionUID;
import org.osflash.statemachine.uids.StateUID;
import org.osflash.statemachine.uids.flushUIDs;
import org.osflash.statemachine.uids.getNullUID;

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
    public function default_currentTransitionPhase_value_is_NONE():void {
        assertThat( _properties.currentTransitionPhase, strictlyEqualTo( StateTransitionPhaseUID.NONE ) );
    }

    [Test]
    public function default_cancellationReason_value_is_NULL():void {
        assertThat( _properties.cancellationReason, strictlyEqualTo( getNullUID() ) );
    }

    [Test]
    public function default_hasTransitionBeenCancelled_value_is_false():void {
        assertThat( _properties.hasTransitionBeenCancelled, isFalse() );
    }

    [Test]
    public function default_cancellationReason_is_NULL():void {
        assertThat( _properties.cancellationReason, strictlyEqualTo( getNullUID() ) );
    }

    [Test]
    public function cancellationReason_getter_setter_works_correctly():void {
        const reason:IUID = new CancellationReasonUID( "testing" );
        _properties.cancellationReason = reason;
        assertThat( _properties.cancellationReason, strictlyEqualTo( reason ) );
    }

    [Test]
    public function cancellationReason_sets_hasTransitionBeenCancelled_value_to_true():void {
        const reason:IUID = new CancellationReasonUID( "testing" );
        _properties.cancellationReason = reason;
        assertThat( _properties.hasTransitionBeenCancelled, isTrue() );
    }

    [Test]
    public function cancellationReason_throws_StateTransitionCancellationError_if_NULL_passed():void {
        const reason:IUID = getNullUID();
        var expectedMessage:String = setUpForTestingCancellationReasonErrorThrowing();
        assertThatCancellationReasonThrowsStateTransitionCancellationError( reason, expectedMessage );
    }

    [Test]
    public function cancellationReason_throws_StateTransitionCancellationError_if_null_passed():void {
        const reason:IUID = null;
        var expectedMessage:String = setUpForTestingCancellationReasonErrorThrowing();
        assertThatCancellationReasonThrowsStateTransitionCancellationError( reason, expectedMessage );
    }

    private function setUpForTestingCancellationReasonErrorThrowing():String {

        const state:IState = new BaseState( new StateUID( "one" ) );
        const transition:IUID = new StateTransitionUID( "one" );
        state.defineTransition( transition, state.uid );
        _properties.setCurrentState( state );
        _properties.setCurrentTransition( new TransitionBinding( transition, {} ) );

        var expectedMessage:String = StateTransitionCancellationError.NULL_CANCELLATION_REASON;
        expectedMessage = injectToken( expectedMessage, "state", state.uid.toString() );
        expectedMessage = injectToken( expectedMessage, "transition", transition.toString() );

         return expectedMessage;

    }

    private function assertThatCancellationReasonThrowsStateTransitionCancellationError( reason:IUID, expectedMessage:String ):void {


        const throwFunction:Function = function ():void {
            _properties.cancellationReason = reason;
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionCancellationError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );


    }



[Test]
public function setCancellationReason_sets_hasTransitionBeenCancelled_value_to_true():void {
    const reason:IUID = new CancellationReasonUID( "testing" );
    _properties.cancellationReason = reason;
    assertThat( _properties.hasTransitionBeenCancelled, isTrue() );
}


[Test]
public function default_currentState_value_is_NULL():void {
    assertThat( _properties.currentState, nullValue() );
}

[Test]
public function calling_setCurrentState_for_the_first_time__with_isInitial_true__sets_currentState_correctly():void {
    const state:IState = new BaseState( new StateUID( "state_one" ) );
    _properties.setCurrentState( state, true );

    assertThat( _properties.currentState, strictlyEqualTo( state ) );
}

[Test]
public function calling_setCurrentState_subsequently__with_isInitial_true__throws_StateTransitionError():void {
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
