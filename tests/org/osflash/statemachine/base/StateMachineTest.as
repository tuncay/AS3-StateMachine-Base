package org.osflash.statemachine.base {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.isA;
import org.hamcrest.core.throws;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.base.supporting.GrumpyValidator;
import org.osflash.statemachine.base.supporting.HappyValidator;
import org.osflash.statemachine.base.supporting.ITransitionRegister;
import org.osflash.statemachine.base.supporting.MockStateTransitionController;
import org.osflash.statemachine.base.supporting.MockStateTransitionModel;
import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.errors.getErrorMessage;
import org.osflash.statemachine.supporting.injectToken;
import org.osflash.statemachine.transitioning.ITransitionController;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionPhaseUID;
import org.osflash.statemachine.uids.flushUIDs;
import org.osflash.statemachine.uids.getNullUID;

public class StateMachineTest implements ITransitionRegister {

    public var stateMachine:StateMachine;
    private var _transitionGot:IUID;
    private var _payloadGot:Object;
    private var _reasonGot:IUID;

    [Before]
    public function before():void {
        const model:IFSMProperties = new MockStateTransitionModel( this );
        const controller:ITransitionController = new MockStateTransitionController( this );
        stateMachine = new StateMachine( model, controller );
    }

    [After]
    public function after():void {
        stateMachine = null;
        flushUIDs();
    }

    [Test]
    public function valid_transition_passes_transitionUID_to_transitionController():void {
        setHappyValidators();
        stateMachine.transition( getNullUID(), {} );
        assertThat( _transitionGot, strictlyEqualTo( getNullUID() ) )
    }

    [Test]
    public function valid_transition_passes_payload_to_transitionController():void {
        const expected:Object = {};
        setHappyValidators();
        stateMachine.transition( getNullUID(), expected );
        assertThat( _payloadGot, strictlyEqualTo( expected ) );
    }

    [Test]
    public function invalid_transition_throws_StateTransitionError():void {

        var expectedMessage:String = getErrorMessage( ErrorCodes.INVALID_TRANSITION );
        expectedMessage = injectToken( expectedMessage, "phase", StateTransitionPhaseUID.NONE.toString() );
        setGrumpyValidators();

        const throwFunction:Function = function ():void {
            stateMachine.transition( getNullUID(), {} );
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );

    }

    [Test]
    public function valid_cancellation_passes_reasonUID_to_transitionController():void {
        setHappyValidators();
        stateMachine.cancelStateTransition( getNullUID() );
        assertThat( _reasonGot, strictlyEqualTo( getNullUID() ) );
    }

    [Test]
    public function invalid_cancellation_throws_StateTransitionError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.INVALID_CANCEL );
        expectedMessage = injectToken( expectedMessage, "phase", StateTransitionPhaseUID.NONE.toString() );
        setGrumpyValidators();

        const throwFunction:Function = function ():void {
            stateMachine.cancelStateTransition( getNullUID() );
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );

    }

    [Test]
    public function transitionToInitialState_calls_transitionToInitialState_on_transitionController():void {
        stateMachine.transitionToInitialState();
        assertThat( _payloadGot, isA( BaseState ) );
    }

    private function setHappyValidators():void {
        stateMachine.setValidators( new HappyValidator(), new HappyValidator() );
    }

    private function setGrumpyValidators():void {
        stateMachine.setValidators( new GrumpyValidator(), new GrumpyValidator() );
    }

    public function setTransition( transition:IUID ):void {
        _transitionGot = transition;
    }

    public function setPayload( payload:Object ):void {
        _payloadGot = payload;
    }

    public function setReason( reason:IUID ):void {
        _reasonGot = reason;
    }
}
}
