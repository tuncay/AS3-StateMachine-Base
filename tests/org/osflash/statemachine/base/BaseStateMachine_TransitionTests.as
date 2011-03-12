/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import flexunit.framework.Assert;

import org.osflash.statemachine.core.IStateModel;
import org.osflash.statemachine.supporting.StateMachine_forTesting_cancellationArguments;
import org.osflash.statemachine.supporting.StateMachine_forTesting_relevantMethodsAreCalled_duringCancelledTransition;
import org.osflash.statemachine.supporting.StateMachine_forTesting_releventMethodsAreCalled_duringTransition;
import org.osflash.statemachine.supporting.StateMachine_forTesting_illegalCancellations;
import org.osflash.statemachine.supporting.StateMachine_forTesting_illegalTransitions;
import org.osflash.statemachine.supporting.StateMachine_forTesting_modelReturningNullTargetState;
import org.osflash.statemachine.supporting.StateMachine_forTesting_releventMethodsAreCalled_duringTransitionLater;
import org.osflash.statemachine.supporting.StateMachine_forTesting_successfulTransitionArguments;
import org.osflash.statemachine.supporting.Stub_StateModel_withNullStates;
import org.osflash.statemachine.supporting.Stub_StateModel_withStates;

public class BaseStateMachine_TransitionTests {

    private const TRANSITION_NAME:String = "testTransition";

    [Test(expects="org.osflash.statemachine.errors.StateTransitionError")]
    public function transition_illegalTransition_shouldThrowError():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forTesting_illegalTransitions = new StateMachine_forTesting_illegalTransitions(stateModel);
        stateMachine.transition(TRANSITION_NAME);
    }

    [Test(expects="org.osflash.statemachine.errors.StateTransitionError")]
    public function transition_illegalCancellation_shouldThrowError():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forTesting_illegalCancellations = new StateMachine_forTesting_illegalCancellations(stateModel);
        stateMachine.transition(TRANSITION_NAME);
    }

    [Test]
    public function transition_modelReturnsNullTargetState_transitionToStateMethodShouldNotBeCalled():void {
        var stateModel:IStateModel = new Stub_StateModel_withNullStates();
        var stateMachine:StateMachine_forTesting_modelReturningNullTargetState = new StateMachine_forTesting_modelReturningNullTargetState(stateModel);
        stateMachine.transition(TRANSITION_NAME);
        Assert.assertFalse(stateMachine.wasTransitionToStateMethodCalled)
    }

    [Test]
    public function transition_straightTransition_allRelevantProtectedMethodsShouldBeCalled():void {
        var stateModel:Stub_StateModel_withStates = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forTesting_releventMethodsAreCalled_duringTransition = new StateMachine_forTesting_releventMethodsAreCalled_duringTransition(stateModel);
        stateMachine.transition(TRANSITION_NAME);
        Assert.assertTrue(stateMachine.wereRelevantMethodsCalled);
    }

    [Test]
    public function transition_cancelledTransition_allRelevantProtectedMethodsShouldBeCalled():void {
        var stateModel:Stub_StateModel_withStates = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forTesting_relevantMethodsAreCalled_duringCancelledTransition = new StateMachine_forTesting_relevantMethodsAreCalled_duringCancelledTransition(stateModel);
        stateMachine.transition(TRANSITION_NAME);
        Assert.assertTrue(stateMachine.wereRelevantMethodsCalled);
    }

    [Test]
    public function transition_transitionLater_allRelevantProtectedMethodsShouldBeCalled():void {
        var stateModel:Stub_StateModel_withStates = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forTesting_releventMethodsAreCalled_duringTransitionLater = new StateMachine_forTesting_releventMethodsAreCalled_duringTransitionLater(stateModel);
        stateMachine.setIsTransitioningForTesting(true);
        stateMachine.transition(TRANSITION_NAME);
        Assert.assertTrue(stateMachine.wereRelevantMethodsCalled);
    }

    [Test]
    public function transition_transitionLater_transitionNameAndPayloadShouldBeCached():void {
        var stateModel:Stub_StateModel_withStates = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forTesting_releventMethodsAreCalled_duringTransitionLater = new StateMachine_forTesting_releventMethodsAreCalled_duringTransitionLater(stateModel);
         var payload:Object = {};
        stateMachine.setIsTransitioningForTesting(true);
        stateMachine.transition(TRANSITION_NAME, payload);
        Assert.assertTrue(stateMachine.wereArgumentsCached(TRANSITION_NAME, payload));
    }

    [Test]
    public function transition_onTransitionMethodArgumentsPassed_argumentsShouldBePassedCorrectlyToOnTransitionMethod():void {
        var stateModel:Stub_StateModel_withStates = new Stub_StateModel_withStates();
        var payload:Object = {};
        var stateMachine:StateMachine_forTesting_successfulTransitionArguments = new StateMachine_forTesting_successfulTransitionArguments(stateModel);
        stateMachine.transition(TRANSITION_NAME, payload);
        Assert.assertTrue(stateMachine.wereArgumentsPassedCorrectlyTo_onTransitionMethod(stateModel.TARGET_STATE, payload));
    }

    [Test]
    public function transition_cancellationArgumentsAreCorrect_returnsTrue():void {
        var stateModel:Stub_StateModel_withStates = new Stub_StateModel_withStates();
        var payload:Object = {};
        var reason:String = "cancelledForTesting";
        var cancellationPayload:Object = {};
        var stateMachine:StateMachine_forTesting_cancellationArguments = new StateMachine_forTesting_cancellationArguments(stateModel);
        stateMachine.setCancellationArguments( reason, cancellationPayload );
        stateMachine.transition(TRANSITION_NAME, payload);
        Assert.assertTrue(stateMachine.wereArgumentsCached);
    }


}
}
