package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.StateModelError;
import org.osflash.statemachine.errors.getErrorMessage;
import org.osflash.statemachine.supporting.injectThis;

public class StateModelTest {

    private var stateModel:StateModel;
    private var starting:IState;
    private var loading:IState;
    private var saving:IState;


    private var startTransition:String;
    private var loadTranstion:String;
    private var saveTransition:String;


    [Before]
    public function before():void {
        initProps();
        initTestSubject();
        initStates();
    }

    [After]
    public function after():void {
        disposeProps();

    }


    [Test]
    public function when_no_states_have_been_registered__hasState_returns_false():void {
        assertThat( stateModel.hasState( loading.name ), isFalse() );
    }

    [Test]
    public function when_no_states_have_been_registered__retrieving_initialState_throws_StateModelError():void {
        const expectedMessage:String = getErrorMessage( ErrorCodes.NO_INITIAL_STATE_DECLARED );
        const throwFunction:Function = function ():void { stateModel.initialState; };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function when_no_states_have_been_registered__removeState_returns_false():void {
        assertThat( stateModel.removeState( loading.name ), isFalse() );
    }

    [Test ]
    public function when_no_states_have_been_registered__getTargetState_throws_StateModelError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.TARGET_DECLARATION_MISMATCH );
        expectedMessage = injectThis( expectedMessage )
                          .withThis( "state", saving.name )
                          .withThis( "transition", startTransition )
                          .finallyWith( "target", starting );

        const throwFunction:Function = function ():void { stateModel.getTargetState( startTransition, saving ); };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function if_transition_is_not_defined_in_source_state__getTargetState_throws_StateModelError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.TRANSITION_NOT_DECLARED_IN_STATE );
        expectedMessage = injectThis( expectedMessage )
                          .withThis( "state", saving.name )
                          .finallyWith( "transition", saveTransition );

        const throwFunction:Function = function ():void { stateModel.getTargetState( saveTransition, saving ); };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function when_no_states_have_been_registered__getState_throws_StateModelError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.STATE_REQUESTED_IS_NOT_REGISTERED );
        expectedMessage = injectThis( expectedMessage )
                          .finallyWith( "state", saving.name );

        const throwFunction:Function = function ():void { stateModel.getState( saving.name ); };
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
        assertThat( stateModel.initialState, strictlyEqualTo( starting ) );
    }

    [Test]
    public function when_a_state_is_registered__hasState_returns_true_for_that_state_uid():void {
        const expected:String = "true,true,true";
        registerAllStates();
        const got:String = callHasStateForAllRegisteredStates();
        assertThat( got, strictlyEqualTo( expected ) );
    }

    [Test]
    public function when_a_state_is_registered__getState_returns_the_IState_with_that_state_name():void {
        const expected:String = starting + "," + loading + "," + saving;
        registerAllStates();
        const got:String = callGetStateOnAllRegisteredStates();
        assertThat( got, strictlyEqualTo( expected ) );
    }

    [Test]
    public function calling_getTargetState_returns_the_target_IState_for_the_source_states_transition_name():void {
        const expected:String = loading + "," + saving + "," + saving + "," + starting + "," + loading;
        registerAllStates();
        const got:String = callGetTargetStateOnAllTransitions();
        assertThat( got, expected );
    }

    [Test]
    public function calling_removeState_on_a_registered_state_returns_true():void {
        const expected:String = "true,true,true";
        registerAllStates();
        const got:String = callingRemoveStateOnAllRegisteredStates();
        assertThat( got, equalTo( expected ) );
    }

    [Test]
    public function after_calling_removeState_on_a_registered_state_hasState_returns_false():void {
        const expected:String = "false,false,false";
        registerAllStates();
        removeAllStates();
        const got:String = callHasStateForAllRegisteredStates();
        assertThat( got, equalTo( expected ) );
    }


    private function initProps():void {

        startTransition = "transition/start";
        loadTranstion = "transition/load";
        saveTransition = "transition/save";
    }

    private function initTestSubject():void {
        stateModel = new StateModel();
    }

    private function initStates():void {
        starting = new BaseState( "state/starting", 1 );
        starting.defineTransition( loadTranstion, "state/loading" );
        starting.defineTransition( saveTransition, "state/saving" );

        loading = new BaseState( "state/loading", 2 );
        loading.defineTransition( saveTransition, "state/saving" );

        saving = new BaseState( "state/saving", 4 );
        saving.defineTransition( startTransition, "state/starting" );
        saving.defineTransition( loadTranstion, "state/loading" );
    }

    private function registerAllStates():void {
        stateModel.registerState( starting );
        stateModel.registerState( loading );
        stateModel.registerState( saving );
    }

    private function removeAllStates():void {
        stateModel.removeState( starting.name );
        stateModel.removeState( loading.name );
        stateModel.removeState( saving.name );
    }

    private function callHasStateForAllRegisteredStates():String {
        var got:Array = [];
        got.push( stateModel.hasState( starting.name ) );
        got.push( stateModel.hasState( loading.name ) );
        got.push( stateModel.hasState( saving.name ) );
        return got.join( "," );
    }

    private function callGetStateOnAllRegisteredStates():String {
        var got:Array = [];
        got.push( stateModel.getState( starting.name ) );
        got.push( stateModel.getState( loading.name ) );
        got.push( stateModel.getState( saving.name ) );
        return got.join( "," );
    }

    private function callGetTargetStateOnAllTransitions():String {
        var got:Array = [];
        got.push( stateModel.getTargetState( loadTranstion, starting ) );
        got.push( stateModel.getTargetState( saveTransition, starting ) );
        got.push( stateModel.getTargetState( saveTransition, loading ) );
        got.push( stateModel.getTargetState( startTransition, saving ) );
        got.push( stateModel.getTargetState( loadTranstion, saving ) );
        return got.join( "," );
    }

    private function callingRemoveStateOnAllRegisteredStates():String {
        const got:Array = [ ];
        got.push( stateModel.removeState( loading.name ) );
        got.push( stateModel.removeState( saving.name ) );
        got.push( stateModel.removeState( starting.name ) );
        return got.join( "," );
    }

    private function disposeProps():void {
        stateModel = null;
        starting = null;
        loading = null;
        saving = null;

        starting = null;
        loading = null;
        saving = null;

        startTransition = null;
        loadTranstion = null;
        saveTransition = null;
    }


}
}
