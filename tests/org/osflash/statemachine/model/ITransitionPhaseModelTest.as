package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.supporting.MockStateModel;
import org.osflash.statemachine.model.supporting.MockTransitionProperties;
import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.uids.CancellationReasonUID;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionUID;
import org.osflash.statemachine.uids.StateUID;
import org.osflash.statemachine.uids.TransitionPhaseUID;
import org.osflash.statemachine.uids.flushUIDs;

public class ITransitionPhaseModelTest implements IResultsRegistry {

    private var _transitionPhaseModel:IPhaseModel;
    private var _properties:ITransitionProperties;
    private var _stateModel:IStateModel;
    private var _initialState:IState;
    private var _currentState:IState;
    private var _targetState:IState;
    private var _results:Array;
    private var _transition:IUID;
    private var _payload:String;
    private var _phase:IUID;

    [Before]
    public function before():void {
        initProps();
        initTestSubject();
    }

    [After]
    public function after():void {
        disposeProps();
        flushUIDs();
    }

    [Test]
    public function currentState_returns_value_from_properties():void {
        setCurrentStateOnProperties();
        assertThat( _transitionPhaseModel.currentState, strictlyEqualTo( _currentState ) );
    }

    [Test]
    public function targetState_retrieves_referringTransition_and_currentState_from_properties__then_calls_getTargetState_on_model():void {
        const expected:String = "transition/one:state/current,state/target";
        setCurrentStateOnProperties();
        setTransitionOnProperties();
        callTargetStateGetterOnTestSubject();
        assertThat( got, equalTo( expected ) );
    }

    [Test]
    public function hasTransitionBeenCancelled_returns_value_from_properties():void {
        setCancellationReasonOnProperties();
        assertThat( _transitionPhaseModel.hasTransitionBeenCancelled, equalTo( _properties.hasTransitionBeenCancelled ) );
    }

    [Test]
    public function transitionPhase_setter_sets_value_on_properties():void {
        setTransitionPhaseOnTestSubject();
        assertThat( _properties.currentTransitionPhase, equalTo( _phase ) );
    }

   [Test]
    public function payload_returns_value_from_properties():void {
        setTransitionOnProperties();
        assertThat( _transitionPhaseModel.payload.body, equalTo( _payload ) );
    }

    [Test]
    public function setTargetStateAsCurrent_retrieves_targetState_from_model_then_sets_currentState_on_properties():void {
        setTransitionOnProperties();
        callSetTargetStateAsCurrentOnTestSubject();
        assertThat( _properties.currentState, equalTo( _targetState ) );
    }

    private function callSetTargetStateAsCurrentOnTestSubject():void {
        _transitionPhaseModel.setTargetStateAsCurrent();
    }

    private function setTransitionPhaseOnTestSubject():void {
        _transitionPhaseModel.transitionPhase = _phase;
    }

    private function setCurrentStateOnProperties():void {
        _properties.currentState = _currentState;
    }

    private function setTransitionOnProperties():void {
        _properties.currentTransitionBinding = new TransitionBinding( _transition , _payload );
    }


    private function callTargetStateGetterOnTestSubject():void {
        pushResult( _transitionPhaseModel.targetState ) ;
    }

    private function setCancellationReasonOnProperties():void {
        _properties.cancellationReason = new CancellationReasonUID( "one" );
    }

    private function initProps():void {
        _results = [];
        _initialState = new BaseState( new StateUID( "initial" ) );
        _currentState = new BaseState( new StateUID( "current" ) );
        _targetState = new BaseState( new StateUID( "target" ) );
        _stateModel = new MockStateModel( _initialState, _targetState, this );
        _properties = new MockTransitionProperties();
        _transition = new StateTransitionUID("one");
        _phase = new TransitionPhaseUID("one");
        _payload = "payload/one";
    }

    private function initTestSubject():void {
        _transitionPhaseModel = new PhaseModel( _stateModel, _properties );
    }

    private function disposeProps():void {
        _results = [];
        _transitionPhaseModel = null;
        _stateModel = null;
        _properties = null;
        _initialState = null;
        _currentState = null;
        _targetState = null;
        _transition = null;
        _phase = null;
        _payload = null;
    }

    public function get got():String {
        return _results.join( "," );
    }

    public function pushResult( value:Object ):void {
        _results.push( value );
    }
}
}
