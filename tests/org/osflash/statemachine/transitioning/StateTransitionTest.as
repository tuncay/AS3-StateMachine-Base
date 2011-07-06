package org.osflash.statemachine.transitioning {

import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.core.allOf;
import org.hamcrest.core.isA;
import org.hamcrest.core.throws;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.model.IPhaseModel;
import org.osflash.statemachine.transitioning.supporting.GrumpyPhase;
import org.osflash.statemachine.transitioning.supporting.HappyPhaseFive;
import org.osflash.statemachine.transitioning.supporting.HappyPhaseFour;
import org.osflash.statemachine.transitioning.supporting.HappyPhaseOne;
import org.osflash.statemachine.transitioning.supporting.HappyPhaseThree;
import org.osflash.statemachine.transitioning.supporting.HappyPhaseTwo;
import org.osflash.statemachine.transitioning.supporting.IPhaseRegister;

public class StateTransitionTest implements IPhaseRegister {

    private var stateTransition:StateTransition;
    private var phasesGot:Array;

    [Before]
    public function before():void {
        stateTransition = new StateTransition(null);
        phasesGot = [];
    }

    [After]
    public function tearDown():void {
        stateTransition = null;
        phasesGot = null
    }

    [Test]
    public function successful_transition_processes_all_phases_in_correct_order():void {
        setHappyPhases();
        stateTransition.dispatchPhases(  );

        assertThat( phasesGot, array(
        isA( HappyPhaseOne ),
        isA( HappyPhaseTwo ),
        isA( HappyPhaseThree ),
        isA( HappyPhaseFour ),
        isA( HappyPhaseFive ) ) );

    }

    [Test]
    public function cancelled_transition_aborts_all_phases_after_cancellation():void {
        setHappyPhasesPlusOneGrumpyPhase();
        stateTransition.dispatchPhases(  );

        assertThat( phasesGot, array(
        isA( HappyPhaseOne ),
        isA( HappyPhaseTwo ),
        isA( GrumpyPhase ) ) );

    }

    [Test]
    public function when_no_phases_pushed_throws_StateTransitionError():void {

        var expectedMessage:String = StateTransitionError.NO_PHASES_HAVE_BEEN_PUSHED_TO_STATE_TRANSITION;

        const throwFunction:Function = function ():void {
            stateTransition.dispatchPhases(  );
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );

    }

    public function setHappyPhases():void {
        stateTransition.pushTransitionPhase( new HappyPhaseOne(this) );
        stateTransition.pushTransitionPhase( new HappyPhaseTwo(this) );
        stateTransition.pushTransitionPhase( new HappyPhaseThree(this) );
        stateTransition.pushTransitionPhase( new HappyPhaseFour(this) );
        stateTransition.pushTransitionPhase( new HappyPhaseFive(this) );
    }

    public function setHappyPhasesPlusOneGrumpyPhase():void {
        stateTransition.pushTransitionPhase( new HappyPhaseOne(this) );
        stateTransition.pushTransitionPhase( new HappyPhaseTwo(this) );
        stateTransition.pushTransitionPhase( new GrumpyPhase(this) );
        stateTransition.pushTransitionPhase( new HappyPhaseThree(this) );
        stateTransition.pushTransitionPhase( new HappyPhaseFour(this) );
        stateTransition.pushTransitionPhase( new HappyPhaseFive(this) );
    }


    public function setPhase( phase:ITransitionPhase ):void {
        phasesGot.push( phase );
    }
}
}
