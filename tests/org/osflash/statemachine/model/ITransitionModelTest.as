package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.supporting.MockStateModel;
import org.osflash.statemachine.model.supporting.MockTransitionProperties;

public class ITransitionModelTest {

    private var _transitionModel:ITransitionModel;
    private var _properties:ITransitionProperties;
    private var _stateModel:IStateModel;
    private var _initialState:IState;
    private var _transition:String;
    private var _reason:String
    private var _payload:Object;

    [Before]
    public function before():void {
        _transition = "trasnition/one";
        _reason = "reason/one";
        _payload = "payload/one";
        initTestSubject();
    }

    private function initTestSubject():void {
        _initialState = new BaseState( "initial", 1 );
        _stateModel = new MockStateModel( _initialState );
        _properties = new MockTransitionProperties();
        _transitionModel = new TransitionModel( _stateModel, _properties );
    }

    [After]
    public function after():void {
        disposeProps();
    }

    [Test]
    public function default_hasNextTransition_is_false():void {
        assertThat( _transitionModel.hasTransition, isFalse() );
    }

    [Test]
    public function addTransition_sets_hasNextTransition_true():void {
        addTransition();
        assertThat( _transitionModel.hasTransition, isTrue() );
    }

    [Test]
    public function dequeueTransition_sets_hasNextTransition_false():void {
        addTransition();
        dequeueTransition();
        assertThat( _transitionModel.hasTransition, isFalse() );
    }

    [Test]
    public function dequeueTransition_sets_referringTransition_on_properties():void {
        addTransition();
        dequeueTransition();
        assertThat( _properties.referringTransition, strictlyEqualTo( _transition ) );
    }

    [Test]
    public function dequeueTransition_sets_currentPayload_on_properties():void {
        addTransition();
        dequeueTransition();
        assertThat( _properties.currentPayload.body, strictlyEqualTo( _payload ) );
    }

   /* [Test]
    public function setInitialStateAsCurrent_sets_currentState_on_properties_to_predefined_initialState():void {
        _transitionModel.setInitialStateAsTarget();
        assertThat( _properties.currentState, strictlyEqualTo( _initialState ) );
    }*/

    [Test]
    public function cancellationReason_sets_cancellationReason_on_properties():void {
        addCancellationReason();
        assertThat( _properties.cancellationReason, strictlyEqualTo( _reason ) );
    }

    [Test]
    public function cancellationReason_flushes_queue_so_hasTransition_is_false():void {
        addTransition();
        addCancellationReason();
        assertThat( _transitionModel.hasTransition, isFalse() );
    }

    [Test]
    public function reset_calls_reset_method_on_properties():void {
        addCancellationReason();
        reset();
        assertThat( _properties.cancellationReason, nullValue() );
    }

    private function addTransition():void {
        _transitionModel.addTransition( _transition, _payload );
    }

    private function dequeueTransition():void {
        _transitionModel.dequeueTransition();
    }

    private function addCancellationReason():void {
        _transitionModel.cancellationReason = _reason;
    }

    private function reset():void {
        _transitionModel.reset();
    }

    private function disposeProps():void {
        _transitionModel = null;
        _stateModel = null;
        _properties = null;
        _initialState = null;
    }

}
}
