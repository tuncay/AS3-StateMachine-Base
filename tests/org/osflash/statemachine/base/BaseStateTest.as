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
    public function name_value_passed_in_constructor_is_attributed_to_state_name_property():void {
        Assert.assertEquals(STATE_NAME, state.name);
    }

    [Test]
    public function defining_transition_once_returns_true():void {
        Assert.assertTrue(state.defineTrans(TRANSITION_NAME, TARGET_NAME));
    }

    [Test]
    public function defining_existing_transition_returns_false():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        Assert.assertFalse(state.defineTrans(TRANSITION_NAME, TARGET_NAME));
    }

    [Test]
    public function calling_hasTans_on_existing_transition_returns_true():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        Assert.assertTrue(state.hasTrans(TRANSITION_NAME));
    }

    [Test]
    public function calling_hasTans_on_undefined_transition_returns_false():void {
        Assert.assertFalse(state.hasTrans(TRANSITION_NAME));
    }

    [Test]
    public function calling_getTarget_on_existing_transition_returns_target_state_name():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        Assert.assertEquals(TARGET_NAME, state.getTarget(TRANSITION_NAME));
    }

    [Test]
    public function calling_getTarget_on_undefined_transition_returns_null():void {
        Assert.assertNull( state.getTarget(TRANSITION_NAME));
    }

    [Test]
    public function removing_existing_transition_returns_true():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        Assert.assertTrue(state.removeTrans(TRANSITION_NAME));
    }

    [Test]
    public function removing_undefined_transition_returns_false():void {
        Assert.assertFalse(state.removeTrans(TRANSITION_NAME));
    }

     [Test]
    public function default_value_for_referringTransitionName_is_null ():void {
        Assert.assertNull(state.referringTransitionName);
    }

    [Test]
    public function calling_getTarget_sets_the_referringTransitionName():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        state.getTarget(TRANSITION_NAME);
        Assert.assertEquals( TRANSITION_NAME, state.referringTransitionName);
    }

    [Test]
    public function calling_destroy_sets_referringTransitionName_to_null():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        state.getTarget(TRANSITION_NAME);
        state.destroy();
        Assert.assertNull( state.referringTransitionName);
    }

    [Test]
    public function after_defining_a_transition_then_destroying_calling_hasTrans_returns_false():void {
        state.defineTrans(TRANSITION_NAME, TARGET_NAME);
        state.destroy();
        Assert.assertFalse(  state.hasTrans(TRANSITION_NAME) );
    }


}
}
