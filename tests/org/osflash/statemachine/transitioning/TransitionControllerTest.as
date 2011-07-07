package org.osflash.statemachine.transitioning {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.osflash.statemachine.model.ITransitionModel;
import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.transitioning.supporting.MockPhaseDispatcher;
import org.osflash.statemachine.transitioning.supporting.MockStateTransitionModel;
import org.osflash.statemachine.uids.CancellationReasonUID;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionUID;
import org.osflash.statemachine.uids.flushUIDs;

public class TransitionControllerTest implements IResultsRegistry {

    private var _stateTransitionController:TransitionController;

    private var _results:Array;
    private var _reason:IUID;
    private var _transition:IUID;
    private var _payload:Object;

    [Before]
    public function before():void {
        initProps();
    }

    [After]
    public function tearDown():void {
        disposeProps();
        flushUIDs();
    }

    [Test]
    public function transitionToInitialState_calls_expected_methods_on_members_in_correct_order():void {
        const expected:String = "ISTM.sISAC,IPD.dP,ISTM.r,ISTM.hNT";
        initTestSubject();
        _stateTransitionController.transitionToInitialState();
        assertThat( got, equalTo( expected ) );
    }

    [Test]
    public function cancelStateTransition_calls_addReasonForCancellation_on_model_and_passes_params():void {
        const expected:String = "ISTM.aRFC:reason/one";
        initTestSubject();
        _stateTransitionController.cancelStateTransition( _reason );
        assertThat( got, equalTo( expected ) );
    }

    [Test]
    public function transition_calls_expected_methods_on_menbers_in_correct_order_and_passes_params():void {
        const expected:String = "ISTM.eT:transition/one:payload/one,ISTM.hNT,ISTM.dNT:transition/one:payload/one," +
                                "IPD.dP,ISTM.r,ISTM.hNT";
        initTestSubject();
        _stateTransitionController.transition( _transition, _payload );
        assertThat( got, equalTo( expected ) );
    }

    [Test]
    public function prequeued_transition_calls_expected_methods_in_correct_order_and_passes_params():void {
        const expected:String = "ISTM.eT:transition/one:payload/one,ISTM.hNT,ISTM.dNT:transition/two:payload/two," +
                                "IPD.dP,ISTM.r,ISTM.hNT,ISTM.dNT:transition/three:payload/three,IPD.dP,ISTM.r," +
                                "ISTM.hNT,ISTM.dNT:transition/one:payload/one,IPD.dP,ISTM.r,ISTM.hNT";
        setUpPrequeuedTransitions();
        _stateTransitionController.transition( _transition, _payload );
        assertThat( got, equalTo( expected ) );
    }

    private function initProps():void {
        _reason = new CancellationReasonUID( "one" );
        _transition = new StateTransitionUID( "one" );
        _payload = "payload/one";
    }

    public function initTestSubject( transitions:Array = null ):void {
        const transitionModel:ITransitionModel = new MockStateTransitionModel( this, transitions );
        _stateTransitionController = new TransitionController( transitionModel, new MockPhaseDispatcher( this ) );
        _results = [];

    }

    public function setUpPrequeuedTransitions():void {
        const prequeuedTransitions:Array = [
            {transition:new StateTransitionUID( "two" ), payload:"payload/two"},
            {transition:new StateTransitionUID( "three" ), payload:"payload/three"}
        ];
        initTestSubject( prequeuedTransitions );
    }

    private function disposeProps():void {
        _stateTransitionController = null;
        _reason = null;
        _transition = null;
        _payload = null;
        _results = null;
    }


    public function pushResult( value:Object ):void {
        _results.push( value );
    }

    private function get got():String {
        return _results.join( "," );
    }
}
}
