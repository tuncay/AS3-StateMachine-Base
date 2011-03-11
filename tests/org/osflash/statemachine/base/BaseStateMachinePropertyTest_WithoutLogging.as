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
import org.osflash.statemachine.core.ITransitionPhase;
import org.osflash.statemachine.supporting.MockFSMController;
import org.osflash.statemachine.supporting.MockStateMachine;
import org.osflash.statemachine.supporting.TestTransitionPhases;

public class BaseStateMachinePropertyTest_WithoutLogging {

     private const STATE_NAME:String = "testStateName";
    private const TARGET_NAME:String = "testTargetName";
    private const TRANSITION_NAME:String = "testTranstion";

    private var stateMachine:MockStateMachine;

    [Before]
    public function before():void {
        stateMachine = new MockStateMachine( null );
    }

    [After]
    public function after():void {
        stateMachine = null;

    }


    [Test]
    public function currentStateName_testDefaultValue_shouldReturnNull():void {
           Assert.assertNull(  stateMachine.currentStateName );
    }

    [Test]
    public function currentStateName_setCurrentState_shouldReturnSameNameAsState():void {
        var state:IState = new BaseState( STATE_NAME );
        stateMachine.setCurrentStateForTesting( state );
        Assert.assertEquals( state.name, stateMachine.currentStateName );
    }

    [Test]
    public function isTransitioning_testDefaultValue_shouldReturnFalse():void {
        Assert.assertFalse(  stateMachine.isTransitioning );
    }
    
    [Test]
    public function referringTransitionName_testDefaultValue_shouldReturnNull():void {
          Assert.assertNull(  stateMachine.referringTransitionName );
    }

    [Test]
    public function referringTransitionName_setCurrentState_shouldReturnReferringTransitionNameFromState():void {
        var state:IState = new BaseState(STATE_NAME);
        state.defineTrans( TRANSITION_NAME, TARGET_NAME );
        state.getTarget( TRANSITION_NAME );
        stateMachine.setCurrentStateForTesting( state );
        Assert.assertEquals( state.referringTransitionName, stateMachine.referringTransitionName );
    }

    [Test]
    public function transitionPhase_testDefaultValue_shouldReturnNull():void {
          Assert.assertNull(  stateMachine.transitionPhase );
    }

        [Test]
    public function transitionPhase_setCurrentValue_shouldReturnSameInstance():void {
          stateMachine.setTransitionPhaseForTesting( TestTransitionPhases.NONE );
          Assert.assertStrictlyEquals( TestTransitionPhases.NONE, stateMachine.transitionPhase );
    }




}
}
