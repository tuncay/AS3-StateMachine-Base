/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import flexunit.framework.Assert;

public class BaseStateTest {


    private var state:BaseState;
    private const STATE_NAME:String = "testStateName";
    private const TARGET_NAME:String = "testTargetName";
    private const TRANSITION_NAME:String = "testTranstion";

    [Before]
    public function before():void {

        state = new BaseState(STATE_NAME);
    }

    [After]
    public function after():void {

        state = null;
    }

    [Test]
    public function name_valueIsPassedAsConstructorArgument_shouldBeAsPassedInConstructor():void {
        Assert.assertEquals(STATE_NAME, state.name);
    }

    [Test]
    public function referringTransition_defaultValue_shouldBeNull():void {
        Assert.assertNull(state.referringTransitionName);
    }

    [Test]
    public function defineTrans_defineTransition_shouldReturnTrue():void {
        Assert.assertTrue(state.defineTrans(TRANSITION_NAME, TARGET_NAME));
    }

    [Test]
    public function defineTrans_defineSameTransitionTwice_shouldReturnFalse():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        Assert.assertFalse(state.defineTrans(TRANSITION_NAME, TARGET_NAME));
    }



    [Test]
    public function hasTrans_defineTransitionThenTestForIt_shouldReturnTrue():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        Assert.assertTrue(state.hasTrans(TRANSITION_NAME));
    }

    [Test]
    public function hasTrans_testForUndefinedTransition_shouldReturnFalse():void {
        Assert.assertFalse(state.hasTrans(TRANSITION_NAME));
    }

    [Test]
    public function getTarget_defineTransitionThenRetrieveTarget_shouldReturnTheTargetDefined():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        Assert.assertEquals(TARGET_NAME, state.getTarget(TRANSITION_NAME));
    }

    [Test]
    public function getTarget_retrieveTargetFromUndefinedTransition_shouldReturnNull():void {
        Assert.assertNull( state.getTarget(TRANSITION_NAME));
    }

    [Test]
    public function removeTrans_defineThenRemoveTransition_shouldReturnTrue():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        Assert.assertTrue(state.removeTrans(TRANSITION_NAME));
    }

    [Test]
    public function removeTrans_removeUndefinedTransition_shouldReturnFalse():void {
        Assert.assertFalse(state.removeTrans(TRANSITION_NAME));
    }

    [Test]
    public function length_defaultValue_shouldBeZero():void {
        Assert.assertEquals(0, state.length);
    }

    [Test]
    public function length_defineTransitionThenTestLength_lengthShouldBeOne():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        Assert.assertEquals(1, state.length);
    }

    [Test]
    public function length_defineThreeTransitionThenTestLength_lengthShouldBeThree():void {
        state.defineTrans(TRANSITION_NAME + "1", TARGET_NAME);
         state.defineTrans(TRANSITION_NAME + "2", TARGET_NAME);
         state.defineTrans(TRANSITION_NAME + "3", TARGET_NAME);
        Assert.assertEquals(3, state.length);
    }

    [Test]
    public function length_defineThenRemoveTransitionThenTestLength_shouldReturnZero():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        state.removeTrans(TRANSITION_NAME);
        Assert.assertEquals(0, state.length);
    }

     [Test]
    public function length_defineTransitionThenDestroy_shouldReturnZero():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        state.destroy();
        Assert.assertEquals(0, state.length);
    }

       [Test]
    public function referringTransitionName_testDefaultValue_shouldReturnNull():void {
        Assert.assertNull( state.referringTransitionName );
    }

    [Test]
    public function referringTransitionName_defineTransitionThenRetrieveTarget_shouldReturnTheTransitionName():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        state.getTarget(TRANSITION_NAME);
        Assert.assertEquals( TRANSITION_NAME, state.referringTransitionName);
    }

    [Test]
    public function destroy_defineTransitionThenDestroyAndTest_shouldReturnFalse():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        state.destroy();
        Assert.assertFalse(  state.hasTrans(TRANSITION_NAME));
    }
}
}
