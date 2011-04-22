/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import flexunit.framework.Assert;

import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModelOwner;
import org.osflash.statemachine.supporting.MockFSMControllerForTestingBaseStateMachine;
import org.osflash.statemachine.supporting.StubIStateModelOwnerForTestingFSMController;

public class IFSMControllerTest {


    private var fsmController:IFSMController;
    private var mock:MockFSMControllerForTestingBaseStateMachine;


    private const INITIAL_STATE_NAME:String = "initial";
    private const TARGET_STATE_NAME:String = "target";
    private const TRANSITION_NAME:String = "next";
    private const REASON:String = "cancellationReason";
    private const PAYLOAD:Object = {};
    private const CANCELLATION_PAYLOAD:Object = {};
    private const initialState:IState = new BaseState( INITIAL_STATE_NAME );
    private const targetState:IState = new BaseState( TARGET_STATE_NAME );

    public function setUp( initial:IState, target:IState ):void {
        mock = new MockFSMControllerForTestingBaseStateMachine( initial, target );
        fsmController = mock;
    }

    [After]
    public function tearDown():void {
        mock = null;
        fsmController = null;
    }

    [Test]
    public function currentStateName_default_value_should_be_null():void {
        setUp( initialState, targetState );
        Assert.assertNull( fsmController.currentStateName );
    }

    [Test]
    public function isTransitioning_default_value_should_be_null():void {
        setUp( initialState, targetState );
        Assert.assertFalse( fsmController.isTransitioning );
    }

    [Test]
    public function referringTransitionName_default_value_should_be_null():void {
        setUp( initialState, targetState );
        Assert.assertNull( fsmController.referringTransitionName );
    }

    [Test]
    public function transitionPhase_default_value_should_be_null():void {
        setUp( initialState, targetState );
        Assert.assertNull( fsmController.transitionPhase );
    }

    [Test]
     public function calling_transitionToInitialState_sets_currentState_name():void {
     setUp( initialState, targetState );
     mock.setIsTransitionLegalProperty( true );
     mock.transitionToInitialState(  );

        Assert.assertTrue( mock.getFullTransitionResults( initialState ) );
        Assert.assertFalse( mock.getTransitionCancelledResults( initialState ) );
        Assert.assertFalse( mock.getTransitionLaterResults() );
     }

    [Test(expected="org.osflash.statemachine.errors.StateTransitionError")]
    public function calling_transition_in_illegal_phase_throws_Error():void {
        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( false );
        fsmController.transition( TRANSITION_NAME );
    }

    [Test]
    public function calling_transition_when_isTransition_is_true_caches_transition_name():void {
        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( true );
        fsmController.transition( TRANSITION_NAME );
        Assert.assertTrue( mock.cachedInfoEquals( TRANSITION_NAME ) );
    }

    [Test]
    public function calling_transition_when_isTransition_is_false_caches_transition_name():void {
        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( false );
        fsmController.transition( TRANSITION_NAME );
        Assert.assertTrue( mock.cachedInfoEquals( TRANSITION_NAME ) );
    }

    [Test]
    public function calling_transition_when_isTransition_is_true_caches_payload():void {
        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( true );
        fsmController.transition( TRANSITION_NAME, PAYLOAD );
        Assert.assertTrue( mock.cachedPayloadEquals( PAYLOAD ) );
    }

    [Test]
    public function calling_transition_when_isTransition_is_false_caches_payload():void {
        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( false );
        fsmController.transition( TRANSITION_NAME, PAYLOAD );
        Assert.assertTrue( mock.cachedPayloadEquals( PAYLOAD ) );
    }

    [Test]
    public function calling_transition_when_isTransition_is_true_invokes_transition_later():void {
        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( true );
        fsmController.transition( TRANSITION_NAME );
        Assert.assertTrue( mock.getTransitionLaterResults() );
        Assert.assertFalse( mock.getTransitionCancelledResults( targetState ) );
        Assert.assertFalse( mock.getFullTransitionResults( targetState ) );
    }

    [Test(expected="org.osflash.statemachine.errors.StateTransitionError")]
    public function scheduling_a_transition_later_more_than_once_throws_Error():void {
        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( true );
        fsmController.transition( TRANSITION_NAME );
        fsmController.transition( TRANSITION_NAME );
    }

    [Test]
    public function calling_transition_when_target_state_is_null_fails_silently():void {
        setUp( initialState, null );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( false );
        fsmController.transition( TRANSITION_NAME );

        Assert.assertFalse( mock.getFullTransitionResults( targetState ) );
        Assert.assertFalse( mock.getTransitionCancelledResults( targetState ) );
        Assert.assertFalse( mock.getTransitionLaterResults() );
    }

    [Test]
    public function calling_transition_when_target_state_is_defined_results_in_full_transition():void {
        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( false );
        fsmController.transition( TRANSITION_NAME );

        Assert.assertTrue( mock.getFullTransitionResults( targetState ) );
        Assert.assertFalse( mock.getTransitionCancelledResults( targetState ) );
        Assert.assertFalse( mock.getTransitionLaterResults() );


    }

    [Test(expected="org.osflash.statemachine.errors.StateTransitionError")]
    public function cancelling_transition_when_isCancellationLegal_is_false_throws_Error():void {

        const cancelTransitionCallback:Function = function():void {
            fsmController.cancelStateTransition( REASON, CANCELLATION_PAYLOAD )
        };

        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( false );
        mock.setIsCancellationLegalProperty( false );
        mock.setCancelTransitionCallback( cancelTransitionCallback );
        fsmController.transition( TRANSITION_NAME );


    }

    [Test]
    public function cancelling_transition_when_isCancellationLegal_is_true_results_in_correct_cancellation_procedures():void {

        const cancelTransitionCallback:Function = function():void {
            fsmController.cancelStateTransition( REASON, CANCELLATION_PAYLOAD )
        };

        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( false );
        mock.setIsCancellationLegalProperty( true );
        mock.setCancelTransitionCallback( cancelTransitionCallback );
        fsmController.transition( TRANSITION_NAME );

        Assert.assertTrue( mock.getTransitionCancelledResults( targetState ) );
        Assert.assertFalse( mock.getFullTransitionResults( targetState ) );
        Assert.assertFalse( mock.getTransitionLaterResults() );
    }

    [Test]
    public function when_cancelling_transition_the_reason_is_cached():void {

        const cancelTransitionCallback:Function = function():void {
            fsmController.cancelStateTransition( REASON, CANCELLATION_PAYLOAD )
        };

        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( false );
        mock.setIsCancellationLegalProperty( true );
        mock.setCancelTransitionCallback( cancelTransitionCallback );
        fsmController.transition( TRANSITION_NAME );

        Assert.assertTrue( mock.cachedInfoEquals( REASON ) );

    }

    [Test]
    public function when_cancelling_transition_the_cancellation_payload_is_cached():void {

        const cancelTransitionCallback:Function = function():void {
            fsmController.cancelStateTransition( REASON, CANCELLATION_PAYLOAD );
        };

        setUp( initialState, targetState );
        mock.setIsTransitionLegalProperty( true );
        mock.setIsTransitioningProperty( false );
        mock.setIsCancellationLegalProperty( true );
        mock.setCancelTransitionCallback( cancelTransitionCallback );
        fsmController.transition( TRANSITION_NAME );

        Assert.assertTrue( mock.cachedPayloadEquals( CANCELLATION_PAYLOAD ) );
    }


}
}
