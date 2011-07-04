package org.osflash.statemachine.transitioning {
import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.core.allOf;
import org.hamcrest.core.isA;
import org.hamcrest.core.throws;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.osflash.statemachine.transitioning.ITransitionPhase;
import org.osflash.statemachine.errors.StateTransitionError;
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
        stateTransition = new StateTransition();
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
        stateTransition.dispatchPhases( this );

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
        stateTransition.dispatchPhases( this );

        assertThat( phasesGot, array(
        isA( HappyPhaseOne ),
        isA( HappyPhaseTwo ),
        isA( GrumpyPhase ) ) );

    }

    [Test]
    public function when_no_phases_pushed_throws_StateTransitionError():void {

        var expectedMessage:String = StateTransitionError.NO_PHASES_HAVE_BEEN_PUSHED_TO_STATE_TRANSITION;

        const throwFunction:Function = function ():void {
            stateTransition.dispatchPhases( this );
        };
        assertThat( throwFunction, throws( allOf( instanceOf( StateTransitionError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );

    }

    public function setHappyPhases():void {
        stateTransition.pushTransitionPhase( new HappyPhaseOne() );
        stateTransition.pushTransitionPhase( new HappyPhaseTwo() );
        stateTransition.pushTransitionPhase( new HappyPhaseThree() );
        stateTransition.pushTransitionPhase( new HappyPhaseFour() );
        stateTransition.pushTransitionPhase( new HappyPhaseFive() );
    }

    public function setHappyPhasesPlusOneGrumpyPhase():void {
        stateTransition.pushTransitionPhase( new HappyPhaseOne() );
        stateTransition.pushTransitionPhase( new HappyPhaseTwo() );
        stateTransition.pushTransitionPhase( new GrumpyPhase() );
        stateTransition.pushTransitionPhase( new HappyPhaseThree() );
        stateTransition.pushTransitionPhase( new HappyPhaseFour() );
        stateTransition.pushTransitionPhase( new HappyPhaseFive() );
    }


    public function setPhase( phase:ITransitionPhase ):void {
        phasesGot.push( phase );
    }
}
}
