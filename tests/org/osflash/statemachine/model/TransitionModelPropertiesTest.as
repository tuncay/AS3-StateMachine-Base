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
import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.errors.getErrorMessage;
import org.osflash.statemachine.supporting.injectThis;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.TransitionPhaseUID;

public class TransitionModelPropertiesTest {

    private var _properties:ITransitionProperties;
    private var _state:IState;
    private var _transition:String;
    private var _transitionTwo:String;
    private var _phase:IUID;
    private var _reason:String;
    private var _payload:String;
    private var _payloadTwo:String;

    [Before]
    public function before():void {
        _transition = "transition/one";
        _transitionTwo = "transition/two";
        _phase = new TransitionPhaseUID( "one" );
        _reason = "reason/one";
        _payload = "payload/one";
        _payloadTwo = "payload/two";

        _properties = new TransitionProperties();
    }

    [After]
    public function after():void {
        _properties = null;
        _state = null;

        _transition = null;
        _transitionTwo = null;
        _phase = null;
        _reason = null;
        _payload = null;
        _payloadTwo = null;
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
    public function default_referringTransition_is_null():void {
        assertThat( _properties.referringTransition, nullValue() );
    }

    [Test]
    public function default_currentTransitionPhase_value_is_NONE():void {
        assertThat( _properties.currentTransitionPhase, strictlyEqualTo( TransitionPhaseUID.NONE ) );
    }

    [Test]
    public function default_hasTransitionBeenCancelled_value_is_false():void {
        assertThat( _properties.hasTransitionBeenCancelled, isFalse() );
    }

    [Test]
    public function default_cancellationReason_is_null():void {
        assertThat( _properties.cancellationReason, nullValue() );
    }

    [Test]
    public function cancellationReason_getter_setter_works_correctly():void {
        setUpTransitionModelProperties();
        assertThat( _properties.cancellationReason, strictlyEqualTo( _reason ) );
    }

    [Test]
    public function cancellationReason_sets_hasTransitionBeenCancelled_value_to_true():void {
        setUpTransitionModelProperties();
        assertThat( _properties.hasTransitionBeenCancelled, isTrue() );
    }

    [Test]
    public function reset_sets_cancellationReason_to_null():void {
        setUpTransitionModelProperties();
        _properties.reset();
        assertThat( _properties.cancellationReason, nullValue() );
    }

    [Test]
    public function reset_sets_currentTransitionPhase_to_NONE():void {
        setUpTransitionModelProperties();
        _properties.reset();
        assertThat( _properties.currentTransitionPhase, strictlyEqualTo( TransitionPhaseUID.NONE ) );
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
        assertThat( _properties.referringTransition, strictlyEqualTo( _transition ) );
    }

    [Test]
    public function setTransition_sets_currentPayload_property():void {
        setUpTransitionModelProperties();
        assertThat( _properties.currentPayload.body, equalTo( _payload ) );
    }

    [Test]
    public function setTransition_throws_StateTransitionError_if_transition_not_defined_in_currentState():void {
        setUpTransitionModelProperties();
        assertThatUndefinedTransitionInCurrentStateThrowsStateTransitionError();
    }

    private function setUpTransitionModelProperties():void {
        _state = new BaseState( "state/one", 1 );
        _state.defineTransition( _transition, _state.name );
        _properties.currentState = _state;
        _properties.currentTransitionPhase = _phase;
        _properties.cancellationReason = _reason;
        _properties.currentTransitionBinding = new TransitionBinding( _transition, _payload );
    }

    private function assertThatUndefinedTransitionInCurrentStateThrowsStateTransitionError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.TRANSITION_UNDEFINED_IN_CURRENT_STATE );
        expectedMessage = injectThis( expectedMessage )
                          .withThis( "state", _properties.currentState.name )
                          .finallyWith( "transition", _transitionTwo );
        assertThat( setUndefinedTransitionOnTestSubject, throws( allOf( instanceOf( StateTransitionError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    private function setUndefinedTransitionOnTestSubject():void {
        _properties.currentTransitionBinding = new TransitionBinding( _transitionTwo, _payloadTwo );
    }
}
}
