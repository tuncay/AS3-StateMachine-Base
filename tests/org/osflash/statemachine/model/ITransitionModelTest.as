package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.supporting.MockStateModelOwner;
import org.osflash.statemachine.model.supporting.MockTransitionProperties;
import org.osflash.statemachine.uids.CancellationReasonUID;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionUID;
import org.osflash.statemachine.uids.StateUID;
import org.osflash.statemachine.uids.flushUIDs;
import org.osflash.statemachine.uids.getNullUID;

public class ITransitionModelTest {

    private var transitionModel:ITransitionModel;
    private var properties:ITransitionProperties;
    private var stateModel:IStateModelOwner;
    private var initialState:IState;

    [Before]
    public function before():void {
        initialState = new BaseState( new StateUID( "initial" ) );
        stateModel = new MockStateModelOwner( initialState );
        properties = new MockTransitionProperties();
        transitionModel = new TransitionModel( stateModel, properties );
    }

    [After]
    public function after():void {
        transitionModel = null;
        initialState = null;
        properties = null;
        flushUIDs();
    }

    [Test]
    public function default_hasNextTransition_is_false():void {
        assertThat( transitionModel.hasTransition, isFalse() );
    }

    [Test]
    public function addTransition_sets_hasNextTransition_true():void {
        addTransition();
        assertThat( transitionModel.hasTransition, isTrue() );
    }

    [Test]
    public function dequeueTransition_sets_hasNextTransition_false():void {
        addTransition();
        dequeueTransition();
        assertThat( transitionModel.hasTransition, isFalse() );
    }

    [Test]
    public function dequeueTransition_sets_referringTransition_on_properties():void {
        addTransition();
        dequeueTransition();
        assertThat( properties.referringTransition.identifier, equalTo( "transition/one" ) );
    }

    [Test]
    public function dequeueTransition_sets_currentPayload_on_properties():void {
        addTransition();
        dequeueTransition();
        assertThat( properties.currentPayload.body, equalTo( "payload_one" ) );
    }

    [Test]
    public function setInitialStateAsCurrent_sets_currentState_on_properties_to_predefined_initialState():void {
        transitionModel.setInitialStateAsCurrent();
        assertThat( properties.currentState, strictlyEqualTo( initialState ) );
    }

    [Test]
    public function cancellationReason_sets_cancellationReason_on_properties():void {
        addCancellationReason();
        assertThat( properties.cancellationReason.identifier, strictlyEqualTo( "reason/one" ) );
    }

    [Test]
    public function reset_calls_reset_method_on_properties():void {
        addCancellationReason();
        reset();
        assertThat( properties.cancellationReason, strictlyEqualTo( getNullUID() ) );
    }


    private function addTransition():void {
        transitionModel.addTransition( new StateTransitionUID( "one" ), "payload_one" );
    }

    private function dequeueTransition():void {
        transitionModel.dequeueTransition();
    }

    private function addCancellationReason():void {
        transitionModel.cancellationReason = new CancellationReasonUID( "one" );
    }

    private function reset():void {
        transitionModel.reset();
    }


}
}
