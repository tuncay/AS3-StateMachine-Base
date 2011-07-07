package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.core.allOf;
import org.hamcrest.core.not;
import org.hamcrest.core.throws;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.StateModelError;
import org.osflash.statemachine.errors.getErrorMessage;
import org.osflash.statemachine.supporting.injectThis;
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
        initUIDs();
        initTestSubject();
        initStates();
    }

    [After]
    public function after():void {
        disposeProps();
        flushUIDs();
    }


    [Test]
    public function when_no_states_have_been_registered__hasState_returns_false():void {
        assertThat( stateModel.hasState( loadingUID ), isFalse() );
    }

    [Test]
    public function when_no_states_have_been_registered__retrieving_initialState_throws_StateModelError():void {
        const expectedMessage:String = getErrorMessage( ErrorCodes.NO_INITIAL_STATE_DECLARED );
        const throwFunction:Function = function ():void { stateModel.initialState; };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function when_no_states_have_been_registered__removeState_returns_false():void {
        assertThat( stateModel.removeState( loadingUID ), isFalse() );
    }

    [Test ]
    public function when_no_states_have_been_registered__getTargetState_throws_StateModelError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.TARGET_DECLARATION_MISMATCH );
        expectedMessage = injectThis( expectedMessage )
                          .withThis( "state", saving.uid )
                          .withThis( "transition", startUID )
                          .finallyWith( "target", starting );

        const throwFunction:Function = function ():void { stateModel.getTargetState( startUID, saving ); };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function if_transition_is_not_defined_in_source_state__getTargetState_throws_StateModelError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.TRANSITION_NOT_DECLARED_IN_STATE );
        expectedMessage = injectThis( expectedMessage )
                          .withThis( "state", saving.uid )
                          .finallyWith( "transition", saveUID );

        const throwFunction:Function = function ():void { stateModel.getTargetState( saveUID, saving ); };
        assertThat( throwFunction, throws( allOf( instanceOf( StateModelError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function when_no_states_have_been_registered__getState_throws_StateModelError():void {
        var expectedMessage:String = getErrorMessage( ErrorCodes.STATE_REQUESTED_IS_NOT_REGISTERED );
        expectedMessage = injectThis( expectedMessage )
                          .finallyWith( "state", saving.uid );

        const throwFunction:Function = function ():void { stateModel.getState( saving.uid ); };
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


    private function initUIDs():void {
        startingUID = new StateUID( "starting" );
        loadingUID = new StateUID( "loading" );
        savingUID = new StateUID( "saving" );

        startUID = new StateTransitionUID( "start" );
        loadUID = new StateTransitionUID( "load" );
        saveUID = new StateTransitionUID( "save" );
    }

    private function initTestSubject():void {
        stateModel = new StateModel();
    }

    private function initStates():void {
        starting = new BaseState( startingUID );
        starting.defineTransition( loadUID, loadingUID );
        starting.defineTransition( saveUID, savingUID );

        loading = new BaseState( loadingUID );
        loading.defineTransition( saveUID, savingUID );

        saving = new BaseState( savingUID );
        saving.defineTransition( startUID, startingUID );
        saving.defineTransition( loadUID, loadingUID );
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

    private function callHasStateForAllRegisteredStates():String {
        var got:Array = [];
        got.push( stateModel.hasState( startingUID ) );
        got.push( stateModel.hasState( loadingUID ) );
        got.push( stateModel.hasState( savingUID ) );
        return got.join( "," );
    }

    private function callGetStateOnAllRegisteredStates():String {
        var got:Array = [];
        got.push( stateModel.getState( startingUID ) );
        got.push( stateModel.getState( loadingUID ) );
        got.push( stateModel.getState( savingUID ) );
        return got.join( "," );
    }

    private function callGetTargetStateOnAllTransitions():String {
        var got:Array = [];
        got.push( stateModel.getTargetState( loadUID, starting ) );
        got.push( stateModel.getTargetState( saveUID, starting ) );
        got.push( stateModel.getTargetState( saveUID, loading ) );
        got.push( stateModel.getTargetState( startUID, saving ) );
        got.push( stateModel.getTargetState( loadUID, saving ) );
        return got.join( "," );
    }

    private function callingRemoveStateOnAllRegisteredStates():String {
        const got:Array = [ ];
        got.push( stateModel.removeState( loadingUID ) );
        got.push( stateModel.removeState( savingUID ) );
        got.push( stateModel.removeState( startingUID ) );
        return got.join( "," );
    }

    private function disposeProps():void {
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
    }


}
}
