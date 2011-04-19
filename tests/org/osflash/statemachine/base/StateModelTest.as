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

    [Before]
    public function before():void {
        stateModelOwner = new StateModel();
        stateModel = stateModelOwner as IStateModel;
    }

    [After]
    public function after():void {
        stateModelOwner = null;
        stateModel = null;
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
        var state:IState = new BaseState( LOADING );
        state.defineTrans( SAVE, SAVING );
        Assert.assertNull( stateModelOwner.getTargetState( SAVE, state ) );
    }

    [Test]
    public function when_no_states_have_been_registered_getState_returns_null():void {
        Assert.assertNull( stateModel.getState( LOADING ) );
    }

    [Test]
    public function when_a_state_is_registered_as_initial_the_initialState_property_is_set_as_that_state():void {
        var state:IState = new BaseState( LOADING );
        stateModelOwner.registerState( state, true );
        Assert.assertStrictlyEquals(state, stateModelOwner.initialState );
    }

    [Test]
    public function when_a_state_is_not_registered_as_initial_the_initialState_property_is_not_as_that_state():void {
        var state:IState = new BaseState( LOADING );
        stateModelOwner.registerState( state, false );
        Assert.assertNull( stateModelOwner.initialState );
    }

    [Test]
    public function when_a_state_is_registered_hasState_returns_true_for_that_state_name():void {
        var state:IState = new BaseState( LOADING );
        stateModelOwner.registerState( state );
        Assert.assertTrue( stateModelOwner.hasState( LOADING ) );
    }

    /*[Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
     public function when_null_value_is_passed_setData_throws_error():void {


     }*/


    private const STARTING:String = "starting";
    private const LOADING:String = "loading";
    private const SAVING:String = "saving";
    private const LOAD:String = "load";
    private const SAVE:String = "save";
    private const START:String = "start";


    private const THREE_CORRECTLY_DECLARED_STATES:XML =
                  <fsm initial={LOADING}>

                      <state name={STARTING}>
                          <transition name={LOAD} target={LOADING}/>
                          <transition name={SAVE} target={SAVING}/>
                      </state>

                      <state name={LOADING}>
                          <transition name={SAVE} target={SAVING}/>
                      </state>

                      <state name={SAVING}>
                          <transition name={START} target={STARTING}/>
                          <transition name={LOAD} target={LOADING}/>
                      </state>
                  </fsm>
    ;
}
}
