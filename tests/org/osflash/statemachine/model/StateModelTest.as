/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 18/04/11
 * Time: 17:11
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.core.allOf;
import org.hamcrest.core.not;
import org.hamcrest.core.throws;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.StateModelError;
import org.osflash.statemachine.supporting.injectToken;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionUID;
import org.osflash.statemachine.uids.StateUID;
import org.osflash.statemachine.uids.flushUIDs;

public class StateModelTest {

    private var stateModel:StateModel;
    private var starting:IState;
    private var loading:IState;
    private var saving:IState;

    private var startingUID:IUID;
    private var loadingUID:IUID;
    private var savingUID:IUID;

    private var startUID:IUID;
    private var loadUID:IUID;
    private var saveUID:IUID;

    [Before]
    public function before():void {

        startingUID = new StateUID( "starting" );
        loadingUID = new StateUID( "loading" );
        savingUID = new StateUID( "saving" );

        startUID = new StateTransitionUID( "start" );
        loadUID = new StateTransitionUID( "load" );
        saveUID = new StateTransitionUID( "save" );


        stateModel = new StateModel();

        starting = new BaseState( startingUID );
        starting.defineTransition( loadUID, loadingUID );
        starting.defineTransition( saveUID, savingUID );

        loading = new BaseState( loadingUID );
        loading.defineTransition( saveUID, savingUID );

        saving = new BaseState( savingUID );
        saving.defineTransition( startUID, startingUID );
        saving.defineTransition( loadUID, loadingUID );
    }

    [After]
    public function after():void {
        stateModel = null;
        starting = null;
        loading = null;
        saving = null;

        startingUID = null;
        loadingUID = null;
        savingUID = null;

        startUID = null;
        loadUID = null;
        saveUID = null;

        flushUIDs();
    }

    private function registerAllStates():void {
        stateModel.registerState( starting );
        stateModel.registerState( loading );
        stateModel.registerState( saving );
    }

    private function removeAllStates():void {
        stateModel.removeState( startingUID );
        stateModel.removeState( loadingUID );
        stateModel.removeState( savingUID );
    }

    [Test]
    public function when_no_states_have_been_registered_hasState_returns_false():void {
        assertThat( stateModel.hasState( loadingUID ), isFalse() );
    }

    [Test]
    public function when_no_states_have_been_registered_initialState_throws_StateModelError():void {
        const expectedMessage:String = StateModelError.NO_INITIAL_STATE_DECLARED;
        const throwFunction:Function = function ():void {
            stateModel.initialState;
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function when_no_states_have_been_registered_removeState_returns_false():void {
        assertThat( stateModel.removeState( loadingUID ), isFalse() );
    }

    [Test ]
    public function when_no_states_have_been_registered_getTargetState_throws_StateModelError():void {
        var expectedMessage:String = StateModelError.TARGET_DECLARATION_MISMATCH;
        expectedMessage = injectToken( expectedMessage, "state", saving.uid.toString() );
        expectedMessage = injectToken( expectedMessage, "transition", startUID.toString() );
        expectedMessage = injectToken( expectedMessage, "target", starting.uid.toString() );

        const throwFunction:Function = function ():void {
            stateModel.getTargetState( startUID, saving );
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }


    [Test]
    public function if_transition_is_not_defined_in_source_state_throws_StateModelError():void {

        var expectedMessage:String = StateModelError.TRANSITION_NOT_DECLARED_IN_STATE;
        expectedMessage = injectToken( expectedMessage, "state", saving.uid.toString() );
        expectedMessage = injectToken( expectedMessage, "transition", saveUID.toString() );

        const throwFunction:Function = function ():void {
            stateModel.getTargetState( saveUID, saving );
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function when_no_states_have_been_registered_getState_throws_StateModelError():void {

        var expectedMessage:String = StateModelError.STATE_REQUESTED_IS_NOT_REGISTERED;
        expectedMessage = injectToken( expectedMessage, "state", saving.uid.toString() );

        const throwFunction:Function = function ():void {
            stateModel.getState( saving.uid );
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function when_a_state_is_registered_as_initial__the_initialState_property_is_set_as_that_state():void {
        stateModel.registerState( starting, true );
        assertThat( stateModel.initialState, strictlyEqualTo( starting ) )
    }

    [Test]
    public function when_a_state_is_not_registered_as_initial_the_initialState_property_is_not_set_as_that_state():void {
        stateModel.registerState( starting, true );
        stateModel.registerState( saving, false );
        assertThat( stateModel.initialState, allOf( strictlyEqualTo( starting ), not( saving ) ) );
    }


    [Test]
    public function when_a_state_is_registered_hasState_returns_true_for_that_state_name():void {

        registerAllStates();
        const got:Array = [
            stateModel.hasState( startingUID ),
            stateModel.hasState( loadingUID ),
            stateModel.hasState( savingUID )
        ];
        assertThat( got, array(
        isTrue(),
        isTrue(),
        isTrue() ) );
    }

    [Test]
    public function when_a_state_is_registered_getState_returns_the_IState_with_that_state_name():void {

        registerAllStates();

        var gotStates:Array = [
            stateModel.getState( startingUID ),
            stateModel.getState( loadingUID ),
            stateModel.getState( savingUID )
        ];

        assertThat( gotStates, array(
        strictlyEqualTo( starting ),
        strictlyEqualTo( loading ),
        strictlyEqualTo( saving ) ) );
    }

    [Test]
    public function calling_getTargetState_returns_the_target_IState_for_the_source_states_transition_name():void {
        registerAllStates();

        var gotStates:Array = [
            stateModel.getTargetState( loadUID, starting ),
            stateModel.getTargetState( saveUID, starting ),
            stateModel.getTargetState( saveUID, loading ),
            stateModel.getTargetState( startUID, saving ),
            stateModel.getTargetState( loadUID, saving )
        ];

        assertThat( gotStates, array(
        strictlyEqualTo( loading ),
        strictlyEqualTo( saving ),
        strictlyEqualTo( saving ),
        strictlyEqualTo( starting ),
        strictlyEqualTo( loading ) ) );
    }


    [Test]
    public function calling_removeState_on_a_registered_state_returns_true():void {
        registerAllStates();

        const got:Array = [
            stateModel.removeState( loadingUID ),
            stateModel.removeState( savingUID ),
            stateModel.removeState( startingUID )
        ];

        assertThat( got, array(
        isTrue(),
        isTrue(),
        isTrue() ) );
    }

    [Test]
    public function after_calling_removeState_on_a_registered_state_hasState_returns_false():void {

        registerAllStates();
        removeAllStates();

        const got:Array = [
            stateModel.hasState( startingUID ),
            stateModel.hasState( loadingUID ),
            stateModel.hasState( savingUID )
        ];

        assertThat( got, array(
        isFalse(),
        isFalse(),
        isFalse() ) );
    }


}
}
