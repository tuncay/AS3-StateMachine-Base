package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.equalTo;
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
import org.osflash.statemachine.uids.getUIDFromIdentifier;

public class TransitionModelPropertiesTest {

    private var _properties:TransitionModelProperties;
    private var _state:IState;

    [Before]
    public function before():void {
        _properties = new TransitionModelProperties();
    }

    [After]
    public function after():void {
        _properties = null;
        _state = null;
        flushUIDs();
    }

    [Test]
    public function default_currentState_value_is_NULL():void {
        assertThat( _properties.currentState, nullValue() );
    }

    [Test]
    public function currentState_getter_setter_work_correctly():void {
        setUpTransitionModelProperties();
        assertThat( _properties.currentState, strictlyEqualTo( _state ) );
    }

    [Test]
    public function default_currentPayload_is_NULL():void {
        assertThat( _properties.currentPayload, hasPropertyWithValue( "isNull", isTrue() ) );
    }

    [Test]
    public function default_referringTransition_is_NULL():void {
        assertThat( _properties.referringTransition, strictlyEqualTo( getNullUID() ) );
    }

    [Test]
    public function default_currentTransitionPhase_value_is_NONE():void {
        assertThat( _properties.currentTransitionPhase, strictlyEqualTo( StateTransitionPhaseUID.NONE ) );
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
        setUpTransitionModelProperties();
        assertThat( _properties.cancellationReason, strictlyEqualTo( getUIDFromIdentifier( "reason/one" ) ) );
    }

    [Test]
    public function cancellationReason_sets_hasTransitionBeenCancelled_value_to_true():void {
        setUpTransitionModelProperties();
        assertThat( _properties.hasTransitionBeenCancelled, isTrue() );
    }

    [Test]
    public function cancellationReason_throws_StateTransitionCancellationError_if_NULL_passed():void {
        setUpTransitionModelProperties();
        assertThatCancellationReasonThrowsStateTransitionCancellationError( getNullUID() );
    }

    [Test]
    public function cancellationReason_throws_StateTransitionCancellationError_if_null_passed():void {
        setUpTransitionModelProperties();
        assertThatCancellationReasonThrowsStateTransitionCancellationError( null );
    }

    [Test]
    public function reset_sets_cancellationReason_to_NULL():void {
        setUpTransitionModelProperties();
        _properties.reset();
        assertThat( _properties.cancellationReason, strictlyEqualTo( getNullUID() ) );
    }

    [Test]
    public function reset_sets_currentTransitionPhase_to_NONE():void {
        setUpTransitionModelProperties();
        _properties.reset();
        assertThat( _properties.currentTransitionPhase, strictlyEqualTo( StateTransitionPhaseUID.NONE ) );
    }

    [Test]
    public function reset_sets_hasTransitionBeenCancelled_to_false():void {
        setUpTransitionModelProperties();
        _properties.reset();
        assertThat( _properties.hasTransitionBeenCancelled, isFalse() );
    }

    [Test]
    public function setTransition_sets_referringTransition_property():void {
        setUpTransitionModelProperties();
        assertThat( _properties.referringTransition, strictlyEqualTo( getUIDFromIdentifier( "transition/one" ) ) );
    }

    [Test]
    public function setTransition_sets_currentPayload_property():void {
        setUpTransitionModelProperties();
        assertThat( _properties.currentPayload.body, equalTo( "payload_one" ) );
    }

     [Test]
    public function setTransition_throws_StateTransitionError_if_transition_not_defined_in_currentState():void {
        setUpTransitionModelProperties();
        assertThatUndefinedTransitionInCurrentStateThrowsStateTransitionError();
    }

    private function setUpTransitionModelProperties():void {
        _state = new BaseState( new StateUID( "one" ) );
        const transition:IUID = new StateTransitionUID( "one" );
        _state.defineTransition( transition, _state.uid );
        _properties.currentState = _state;
        _properties.currentTransitionPhase = new StateTransitionPhaseUID( "one" );
        _properties.cancellationReason = new CancellationReasonUID( "one" );
        _properties.setCurrentTransition( new TransitionBinding( transition, "payload_one" ) );
    }

    private function assertThatCancellationReasonThrowsStateTransitionCancellationError( reason:IUID ):void {
        var expectedMessage:String = StateTransitionCancellationError.NULL_CANCELLATION_REASON;
        expectedMessage = injectToken( expectedMessage, "state", _properties.currentState.uid.toString() );
        expectedMessage = injectToken( expectedMessage, "transition", _properties.referringTransition.toString() );

        const throwFunction:Function = function ():void {
            _properties.cancellationReason = reason;
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionCancellationError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    private function assertThatUndefinedTransitionInCurrentStateThrowsStateTransitionError():void {
        const transition:IUID = new StateTransitionUID( "two");
        var expectedMessage:String = StateTransitionError.TRANSITION_UNDEFINED_IN_CURRENT_STATE;
        expectedMessage = injectToken( expectedMessage, "state", _properties.currentState.uid.toString() );
        expectedMessage = injectToken( expectedMessage, "transition", transition.toString() );

        const throwFunction:Function = function ():void {
           _properties.setCurrentTransition( new TransitionBinding( transition, "payload_two" ) );
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }
}
}
