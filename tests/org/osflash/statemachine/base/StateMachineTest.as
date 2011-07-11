package org.osflash.statemachine.base {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.base.supporting.GrumpyValidator;
import org.osflash.statemachine.base.supporting.HappyValidator;
import org.osflash.statemachine.base.supporting.MockStateTransitionController;
import org.osflash.statemachine.base.supporting.MockStateTransitionModel;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.ErrorMap;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.supporting.injectThis;
import org.osflash.statemachine.transitioning.ITransitionController;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.TransitionPhaseUID;

public class StateMachineTest implements IResultsRegistry {

    private var _stateMachine:StateMachine;
    private var _results:Array;
    private var _transitionName:String;
    private var _reason:String;
    private var _payload:Object;
    private var _currentStateName:String;
    private var _phaseUID:IUID;


    [Before]
    public function before():void {
        initProps();
        initTestSubject();
    }

    [After]
    public function after():void {
        disposeProps();
    }


    [Test]
    public function valid_transition_passes_transitionUID_and_payload_to_transitionController():void {
        var expectedResults:String = injectThis( "TC:T(${transition}):PL(${payload})" ).withThis( "transition", _transitionName ).finallyWith( "payload", _payload );
        setHappyValidators();
        executeTransition();
        assertThat( got, equalTo( expectedResults ) );
    }

    [Test]
    public function valid_cancellation_passes_reasonUID_to_transitionController():void {
        var expectedResults:String = injectThis( "TC:R(${reason})" ).finallyWith( "reason", _reason );
        setHappyValidators();
        cancelTransition();
        assertThat( got, equalTo( expectedResults ) );
    }

    [Test]
    public function invalid_cancellation_throws_StateTransitionError_and_injects_phase_from_model_in_error_message():void {
        setGrumpyValidators();
        assertThatInvalidCancellationThrowsStateTransitionError();
    }

    [Test]
    public function invalid_transition_throws_StateTransitionError_and_injects_phase_from_model_in_error_message():void {
        setGrumpyValidators();
        assertThatInvalidTransitionThrowsStateTransitionError();
    }

    [Test]
    public function transitionToInitialState_calls_transitionToInitialState_on_transitionController():void {
        var expectedResults:String = "TC:T2IS";
        _stateMachine.transitionToInitialState();
        assertThat( got, equalTo( expectedResults ) );
    }

    [Test]
    public function currentStateUID_wraps_currentStateUID_getter_on_model():void {
        assertThat( _stateMachine.currentStateName, equalTo( _currentStateName ) );
    }

    [Test]
    public function referringTransition_wraps_referringTransition_getter_on_model():void {
        assertThat( _stateMachine.referringTransition, strictlyEqualTo( _transitionName ) );
    }

    [Test]
    public function transitionPhase_wraps_transitionPhase_getter_on_model():void {
        assertThat( _stateMachine.transitionPhase, strictlyEqualTo( _phaseUID ) );
    }

    private function initProps():void {
        _transitionName = "transition/one";
        _reason = "reason/one";
        _currentStateName = "state/current";
        _phaseUID = new TransitionPhaseUID( "one" );
        _payload = "payload_one";

        _results = [];
    }

    private function initTestSubject():void {
        const controller:ITransitionController = new MockStateTransitionController( this );
        const model:MockStateTransitionModel = new MockStateTransitionModel();
        model.transitionPhase = _phaseUID;
        model.currentStateUID = _currentStateName;
        model.referringTransition = _transitionName;

        _stateMachine = new StateMachine( model, controller );
    }

    private function disposeProps():void {
        _stateMachine = null;
        _results = null;
        _transitionName = null;
        _payload = null;
        _reason = null;
    }

    private function setHappyValidators():void {
        _stateMachine.setValidators( new HappyValidator(), new HappyValidator() );
    }

    private function setGrumpyValidators():void {
        _stateMachine.setValidators( new GrumpyValidator(), new GrumpyValidator() );
    }

    private function executeTransition():void {
        _stateMachine.transition( _transitionName, _payload );
    }

    private function cancelTransition():void {
        _stateMachine.cancelStateTransition( _reason );
    }

    private function assertThatInvalidTransitionThrowsStateTransitionError():void {
        var expectedMessage:String = new ErrorMap().getErrorMessage( ErrorCodes.INVALID_TRANSITION );
        expectedMessage = injectThis( expectedMessage ).finallyWith( "phase", _phaseUID );
        const throwFunction:Function = function ():void { _stateMachine.transition( _transitionName, _payload ); };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    private function assertThatInvalidCancellationThrowsStateTransitionError():void {
        var expectedMessage:String = new ErrorMap().getErrorMessage( ErrorCodes.INVALID_CANCEL );
        expectedMessage = injectThis( expectedMessage ).finallyWith( "phase", _phaseUID );
        const throwFunction:Function = function ():void { _stateMachine.cancelStateTransition( _transitionName ); };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    public function pushResult( value:Object ):void {
        _results.push( value );
    }

    public function get got():String {
        return _results.join( "," );
    }
}
}
