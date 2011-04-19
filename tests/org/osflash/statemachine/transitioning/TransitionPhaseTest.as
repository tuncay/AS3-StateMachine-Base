/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.transitioning {
import flexunit.framework.Assert;

import mx.states.Transition;

import org.osflash.statemachine.core.ITransitionPhase;
import org.osflash.statemachine.transitioning.TransitionPhase;

public class TransitionPhaseTest {

    private var phase:TransitionPhase;


    [Before]
    public function before():void {

        phase = new TransitionPhase( PHASE_NAME, PHASE_INDEX );
    }

    [After]
    public function after():void {
        phase = null;
    }

    [Test]
    public function name_is_passed_as_constructor_argument():void {
        Assert.assertEquals( PHASE_NAME, phase.name );
    }

    [Test]
    public function index_is_passed_as_constructor_argument():void {
        Assert.assertEquals( PHASE_INDEX, phase.index );
    }

    [Test]
    public function calling_equals_against_equivalent_name_string_returns_true():void {
        Assert.assertTrue( phase.equals( PHASE_NAME ) );
    }

    [Test]
    public function calling_equals_against_equivalent_index_int_returns_true():void {
        Assert.assertTrue( phase.equals( PHASE_INDEX ) );
    }

    [Test]
    public function calling_equals_against_self_returns_true():void {
        Assert.assertTrue( phase.equals( phase ) );
    }

    [Test]
    public function calling_equals_against_unequivalent_name_string_returns_false():void {
        Assert.assertFalse( phase.equals( PHASE_NAME_UNEQUAL ) );
    }

    [Test]
    public function calling_equals_against_unequivalent_index_int_returns_false():void {
        Assert.assertFalse( phase.equals( PHASE_INDEX_UNEQUAL ) );
    }

    [Test]
    public function calling_equals_against_unequivalent_TransitionPhase_returns_false():void {
        var unequalPhase:ITransitionPhase = new TransitionPhase( PHASE_NAME_UNEQUAL, PHASE_INDEX_UNEQUAL );
        Assert.assertFalse( phase.equals( unequalPhase ) );
    }

    private const PHASE_NAME:String = "testPhaseName";
    private const PHASE_INDEX:int = 0;

    private const PHASE_NAME_UNEQUAL:String = "testPhaseNameUnequal";
    private const PHASE_INDEX_UNEQUAL:int = 4;

}
}
