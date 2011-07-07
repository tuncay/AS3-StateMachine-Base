package org.osflash.statemachine.transitioning {

import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.object.equalTo;
import org.osflash.statemachine.model.ITransitionModel;
import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.transitioning.supporting.MockPhaseDispatcher;
import org.osflash.statemachine.transitioning.supporting.MockStateTransitionModel;
import org.osflash.statemachine.uids.CancellationReasonUID;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionUID;
import org.osflash.statemachine.uids.flushUIDs;

public class StateTransitionControllerTest implements IResultsRegistry {

    private var stateTransitionController:StateTransitionController;

    private var got:Array;


    public function setUp( transitions:Array = null ):void {
        const transitionModel:ITransitionModel = new MockStateTransitionModel( this, transitions );
        stateTransitionController = new StateTransitionController( transitionModel, new MockPhaseDispatcher( this ) );
        got = [];

    }

    public function setUpPrequeuedTransitions():void {
        const prequeuedTransitions:Array = [
            {transition:new StateTransitionUID( "prequeued_one" ), payload:"payload_one"},
            {transition:new StateTransitionUID( "prequeued_two" ), payload:"payload_two"}
        ];
        setUp( prequeuedTransitions );
    }

    [After]
    public function tearDown():void {
        stateTransitionController = null;
        got = null;
        flushUIDs();
    }

    [Test]
    public function transitionToInitialState_calls_expected_methods_in_correct_order():void {
        setUp();
        stateTransitionController.transitionToInitialState();
        assertThatTransitionToInitialStateExecutesCorrectly();
    }

    [Test]
    public function cancelStateTransition_calls_addReasonForCancellation_on_model_and_passes_params():void {
        const reason:IUID = new CancellationReasonUID( "testing_one" );
        const payload:Object = "payload_one";
        setUp();
        stateTransitionController.cancelStateTransition( reason );
        assertThatCancelStateTransitionExecutesCorrectly();
    }

    [Test]
    public function transition_calls_expected_methods_in_correct_order_and_passes_params():void {
        const transition:IUID = new StateTransitionUID( "testing_one" );
        const payload:Object = "payload_one";
        setUp();
        stateTransitionController.transition( transition, payload );
        assertThatTransitionExecutesCorrectly();
    }

    [Test]
    public function prequeued_transition_calls_expected_methods_in_correct_order_and_passes_params():void {
        const transition:IUID = new StateTransitionUID( "testing_three" );
        const payload:Object = "payload_three";
        setUpPrequeuedTransitions();
        stateTransitionController.transition( transition, payload );
        assertThatPrequeuedTransitionExecutesCorrectly();
    }

    private function assertThatTransitionToInitialStateExecutesCorrectly():void {
        assertThat( got, array(
        equalTo( "IStateTransitionModel.setInitialStateAsCurrent()" ),
        equalTo( "IPhaseDispatcher.dispatchPhases()" ),
        equalTo( "IStateTransitionModel.reset()" ),
        equalTo( "IStateTransitionModel.hasNextTransition()" ) ) );
    }

    private function assertThatCancelStateTransitionExecutesCorrectly():void {
        assertThat( got, array(
        equalTo( "IStateTransitionModel.addReasonForCancellation(reason/testing_one)" ) ) );
    }

    private function assertThatTransitionExecutesCorrectly():void {
        assertThat( got, array(
        equalTo( "IStateTransitionModel.enqueueTransition(transition/testing_one,payload_one)" ),
        equalTo( "IStateTransitionModel.hasNextTransition()" ),
        equalTo( "IStateTransitionModel.dequeueNextTransition()::transition/testing_one,payload_one" ),
        equalTo( "IPhaseDispatcher.dispatchPhases()" ),
        equalTo( "IStateTransitionModel.reset()" ),
        equalTo( "IStateTransitionModel.hasNextTransition()" ) ) );
    }

    private function assertThatPrequeuedTransitionExecutesCorrectly():void {
        assertThat( got, array(
        equalTo( "IStateTransitionModel.enqueueTransition(transition/testing_three,payload_three)" ),
        equalTo( "IStateTransitionModel.hasNextTransition()" ),
        equalTo( "IStateTransitionModel.dequeueNextTransition()::transition/prequeued_one,payload_one" ),
        equalTo( "IPhaseDispatcher.dispatchPhases()" ),
        equalTo( "IStateTransitionModel.reset()" ),
        equalTo( "IStateTransitionModel.hasNextTransition()" ),
        equalTo( "IStateTransitionModel.dequeueNextTransition()::transition/prequeued_two,payload_two" ),
        equalTo( "IPhaseDispatcher.dispatchPhases()" ),
        equalTo( "IStateTransitionModel.reset()" ),
        equalTo( "IStateTransitionModel.hasNextTransition()" ),
        equalTo( "IStateTransitionModel.dequeueNextTransition()::transition/testing_three,payload_three" ),
        equalTo( "IPhaseDispatcher.dispatchPhases()" ),
        equalTo( "IStateTransitionModel.reset()" ),
        equalTo( "IStateTransitionModel.hasNextTransition()" ) ) );
    }


    public function pushResult( value:Object ):void {
        got.push( value );
    }
}
}
