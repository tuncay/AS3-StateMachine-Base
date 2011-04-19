/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 18/04/11
 * Time: 17:11
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import org.flexunit.Assert;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModel;
import org.osflash.statemachine.core.IStateModelOwner;

public class StateModelTest {

    private var stateModelOwner:IStateModelOwner;
    private var stateModel:IStateModel;
    private var starting:IState;
    private var loading:IState;
    private var saving:IState;

    [Before]
    public function before():void {

        stateModelOwner = new StateModel();
        stateModel = stateModelOwner as IStateModel;

        starting = new BaseState( STARTING );
        starting.defineTrans( LOAD, LOADING );
        starting.defineTrans( SAVE, SAVING );

        loading = new BaseState( LOADING );
        loading.defineTrans( SAVE, SAVING );

        saving = new BaseState( SAVING );
        saving.defineTrans( START, STARTING );
        saving.defineTrans( LOAD, LOADING );
    }

    [After]
    public function after():void {
        stateModelOwner = null;
        stateModel = null;
        starting = null;
        loading = null;
        saving = null;
    }

    [Test]
    public function when_no_states_have_been_registered_hasState_returns_false():void {
        Assert.assertFalse( stateModelOwner.hasState( LOADING ) );
    }

    [Test]
    public function when_no_states_have_been_registered_initialState_returns_null():void {
        Assert.assertNull( stateModelOwner.initialState );
    }

    [Test]
    public function when_no_states_have_been_registered_removeState_returns_false():void {
        Assert.assertFalse( stateModelOwner.removeState( LOADING ) );
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function when_no_states_have_been_registered_getTargetState_throws_error():void {
        Assert.assertNull( stateModelOwner.getTargetState( START, saving ) );
    }

    [Test]
    public function if_transition_is_not_defined_in_source_state_returns_null():void {
        Assert.assertNull( stateModelOwner.getTargetState( SAVE, saving ) );
    }

    [Test]
    public function when_no_states_have_been_registered_getState_returns_null():void {
        Assert.assertNull( stateModel.getState( LOADING ) );
    }

    [Test]
    public function when_a_state_is_registered_as_initial_the_initialState_property_is_set_as_that_state():void {
        stateModelOwner.registerState( starting, true );
        Assert.assertStrictlyEquals( starting, stateModelOwner.initialState );
    }

    [Test]
    public function when_a_state_is_not_registered_as_initial_the_initialState_property_is_not_set_as_that_state():void {
        stateModelOwner.registerState( saving, false );
        Assert.assertNull( stateModelOwner.initialState );
    }

    [Test]
    public function when_a_state_is_registered_hasState_returns_true_for_that_state_name():void {
        stateModelOwner.registerState( starting );
        stateModelOwner.registerState( loading );
        stateModelOwner.registerState( saving );
        Assert.assertTrue(
                         stateModelOwner.hasState( STARTING ) &&
                         stateModelOwner.hasState( LOADING ) &&
                         stateModelOwner.hasState( SAVING )
                         )
    }

    [Test]
    public function when_a_state_is_registered_getState_returns_the_IState_with_that_state_name():void {
        stateModelOwner.registerState( starting );
        stateModelOwner.registerState( loading );
        stateModelOwner.registerState( saving );
        Assert.assertTrue(
                         stateModel.getState( STARTING ) == starting &&
                         stateModel.getState( LOADING ) == loading &&
                         stateModel.getState( SAVING ) == saving
                         )
    }

    [Test]
        public function calling_getTargetState_returns_the_target_IState_for_the_source_states_transition_name():void {
            stateModelOwner.registerState( starting );
            stateModelOwner.registerState( loading );
            stateModelOwner.registerState( saving );
            Assert.assertTrue(
                             stateModelOwner.getTargetState( LOAD, starting ) === loading &&
                             stateModelOwner.getTargetState( SAVE, starting ) === saving &&
                             stateModelOwner.getTargetState( SAVE, loading ) === saving &&
                             stateModelOwner.getTargetState( START, saving ) === starting &&
                             stateModelOwner.getTargetState( LOAD, saving ) === loading
                             )
        }


    [Test]
    public function calling_removeState_on_a_registered_state_returns_true():void {
        stateModelOwner.registerState( starting );
        stateModelOwner.registerState( loading );
        stateModelOwner.registerState( saving );
        Assert.assertTrue(
                         stateModelOwner.removeState( LOADING ) &&
                         stateModelOwner.removeState( SAVING ) &&
                         stateModelOwner.removeState( STARTING )
                         )
    }

    [Test]
    public function after_calling_removeState_on_a_registered_state_hasState_returns_false():void {
        stateModelOwner.registerState( starting );
        stateModelOwner.registerState( loading );
        stateModelOwner.registerState( saving );

        stateModelOwner.removeState( STARTING );
        stateModelOwner.removeState( LOADING );
        stateModelOwner.removeState( SAVING );

        Assert.assertFalse(
                         stateModelOwner.hasState( LOADING ) &&
                         stateModelOwner.hasState( SAVING ) &&
                         stateModelOwner.hasState( STARTING )
                         )
    }


    private const STARTING:String = "starting";
    private const LOADING:String = "loading";
    private const SAVING:String = "saving";
    private const LOAD:String = "load";
    private const SAVE:String = "save";
    private const START:String = "start";



}
}
