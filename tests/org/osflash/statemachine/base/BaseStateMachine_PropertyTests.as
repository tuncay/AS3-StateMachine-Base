/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import flexunit.framework.Assert;

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModel;
import org.osflash.statemachine.supporting.StateMachine_forSetting_simpleProperties;
import org.osflash.statemachine.supporting.StateMachine_forTesting_isTransitionValue_duringCancelledTransition;
import org.osflash.statemachine.supporting.StateMachine_forTesting_isTransitionValue_duringTransition;
import org.osflash.statemachine.supporting.Stub_StateModel_withStates;
import org.osflash.statemachine.supporting.TestTransitionPhases;

public class BaseStateMachine_PropertyTests {

    private const STATE_NAME:String = "testStateName";
    private const TARGET_NAME:String = "testTargetName";
    private const TRANSITION_NAME:String = "testTranstion";


    [Test]
    public function currentStateName_testDefaultValue_shouldReturnNull():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forSetting_simpleProperties = new StateMachine_forSetting_simpleProperties( stateModel );
        Assert.assertNull(stateMachine.currentStateName);
    }

    [Test]
    public function currentStateName_setCurrentState_shouldReturnSameNameAsState():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forSetting_simpleProperties = new StateMachine_forSetting_simpleProperties(stateModel);
        var state:IState = new BaseState(STATE_NAME);
        stateMachine.setCurrentStateForTesting(state);
        Assert.assertEquals(state.name, stateMachine.currentStateName);
    }

    [Test]
    public function isTransitioning_testDefaultValue_shouldReturnFalse():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forSetting_simpleProperties = new StateMachine_forSetting_simpleProperties(stateModel);
        Assert.assertFalse(stateMachine.isTransitioning);
    }

    [Test]
    public function isTransitioning_callTransitionToStateMethod_shouldReturnTrue():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forTesting_isTransitionValue_duringTransition = new StateMachine_forTesting_isTransitionValue_duringTransition(stateModel);
        stateMachine.transitionToStateForTesting(new BaseState(STATE_NAME));
        Assert.assertTrue(stateMachine.expectedResultsFor_isTransitioning_duringTransition(true, false));
    }

    [Test]
    public function isTransitioning_callTransitionToStateMethodThenCancelTransition_shouldReturnTrue():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forTesting_isTransitionValue_duringCancelledTransition = new StateMachine_forTesting_isTransitionValue_duringCancelledTransition(stateModel);
        stateMachine.transitionToStateForTesting(new BaseState(STATE_NAME));
        Assert.assertTrue(stateMachine.expectedResultsFor_isTransitioning_duringTransition(true, false));
    }

    [Test]
    public function referringTransitionName_testDefaultValue_shouldReturnNull():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forSetting_simpleProperties = new StateMachine_forSetting_simpleProperties(stateModel);
        Assert.assertNull(stateMachine.referringTransitionName);
    }

    [Test]
    public function referringTransitionName_setCurrentState_shouldReturnReferringTransitionNameFromState():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forSetting_simpleProperties = new StateMachine_forSetting_simpleProperties(stateModel);
        var state:IState = new BaseState(STATE_NAME);
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        state.getTarget(TRANSITION_NAME);
        stateMachine.setCurrentStateForTesting(state);
        Assert.assertEquals(state.referringTransitionName, stateMachine.referringTransitionName);
    }

    [Test]
    public function transitionPhase_testDefaultValue_shouldReturnNull():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forSetting_simpleProperties = new StateMachine_forSetting_simpleProperties(stateModel);
        Assert.assertNull(stateMachine.transitionPhase);
    }

    [Test]
    public function transitionPhase_setCurrentValue_shouldReturnSameInstance():void {
        var stateModel:IStateModel = new Stub_StateModel_withStates();
        var stateMachine:StateMachine_forSetting_simpleProperties = new StateMachine_forSetting_simpleProperties(stateModel);
        stateMachine.setTransitionPhaseForTesting(TestTransitionPhases.NONE);
        Assert.assertStrictlyEquals(TestTransitionPhases.NONE, stateMachine.transitionPhase);
    }


}
}
