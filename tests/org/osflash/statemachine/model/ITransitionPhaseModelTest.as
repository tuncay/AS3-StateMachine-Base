package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.hasPropertyChain;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.supporting.IBindingRegistry;
import org.osflash.statemachine.model.supporting.MockStateModelOwner;
import org.osflash.statemachine.model.supporting.MockTransitionProperties;
import org.osflash.statemachine.uids.CancellationReasonUID;
import org.osflash.statemachine.uids.StateTransitionUID;
import org.osflash.statemachine.uids.StateUID;
import org.osflash.statemachine.uids.flushUIDs;

public class ITransitionPhaseModelTest implements IBindingRegistry {

    private var transitionPhaseModel:IPhaseModel;
    private var properties:ITransitionProperties;
    private var stateModel:IStateModel;
    private var initialState:IState;
    private var currentState:IState;
    private var bindingGot:TransitionBinding;

    [Before]
    public function before():void {
        initialState = new BaseState( new StateUID( "initial" ) );
        currentState = new BaseState( new StateUID( "current" ) );
        stateModel = new MockStateModelOwner( initialState, this );
        properties = new MockTransitionProperties();
        transitionPhaseModel = new PhaseModel  ( stateModel, properties );
    }

    [After]
    public function after():void {
        transitionPhaseModel = null;
        stateModel = null;
        properties = null;
        initialState = null;
        currentState = null;
        flushUIDs();
    }

    [Test]
    public function currentState_returns_currentState_from_properties():void {
        addCurrentStateToProperties();
        assertThat( transitionPhaseModel.currentState, strictlyEqualTo( currentState ) );
    }

    [Test]
    public function targetState_calls_getTargetState_onIStateModelOwner():void {
        addCurrentStateToProperties();
        addTransitionToProperties();
        callTargetStateGetter();

        assertThat( bindingGot, allOf(
            hasPropertyChain("transition.identifier", equalTo("transition/one") ),
            hasPropertyChain("payload.body", strictlyEqualTo(currentState) )
        ));

    }





    private function addCurrentStateToProperties():void {
        properties.currentState = currentState;
    }

    private function addTransitionToProperties():void {
        properties.currentTransitionBinding = new TransitionBinding( new StateTransitionUID( "one" ), "payload_one" );
    }

    private function callTargetStateGetter():void {
        var nullValue:IState = transitionPhaseModel.targetState;
    }

    private function addCancellationReasonToProperties():void {
        properties.cancellationReason = new CancellationReasonUID( "one" );
    }

    private function reset():void {
        // transitionPhaseModel.reset();
    }


    public function setBinding( transitionBinding:TransitionBinding ):void {
        bindingGot = transitionBinding;
    }
}
}
