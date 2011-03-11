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
    private const PHASE_NAME:String = "testPhaseName";
    private const PHASE_INDEX:int = 0;

    private const PHASE_NAME_UNEQUAL:String = "testPhaseNameUnequal";
    private const PHASE_INDEX_UNEQUAL:int = 4;

    [Before]
    public function before():void {

        phase = new TransitionPhase(PHASE_NAME, PHASE_INDEX);
    }

    [After]
    public function after():void {

        phase = null;
    }

    [Test]
    public function name_isPassedAsConstructorArgument_shouldBeAsPassedInConstructor():void {
        Assert.assertEquals(PHASE_NAME, phase.name);
    }

    [Test]
    public function index_isPassedAsConstructorArgument_shouldBeAsPassedInConstructor():void {
        Assert.assertEquals(PHASE_INDEX, phase.index);
    }

    [Test]
    public function equals_testAgainstNameConst_shouldReturnTrue():void {
        Assert.assertTrue( phase.equals( PHASE_NAME ));
    }

    [Test]
    public function equals_testAgainstIndexConst_shouldReturnTrue():void {
        Assert.assertTrue( phase.equals( PHASE_INDEX ));
    }

    [Test]
    public function equals_testAgainstItself_shouldReturnTrue():void {
        Assert.assertTrue( phase.equals( phase ));
    }

    [Test]
    public function equals_testAgainstUnequalNameConst_shouldReturnFalse():void {
        Assert.assertFalse( phase.equals( PHASE_NAME_UNEQUAL ));
    }

    [Test]
    public function equals_testAgainstUnequalIndexConst_shouldReturnFalse():void {
        Assert.assertFalse( phase.equals( PHASE_INDEX_UNEQUAL ));
    }

    [Test]
    public function equals_testAgainstUnequalTransitionPhase_shouldReturnFalse():void {
        var unequalPhase:ITransitionPhase = new TransitionPhase( PHASE_NAME_UNEQUAL, PHASE_INDEX_UNEQUAL);
        Assert.assertFalse( phase.equals( unequalPhase ));
    }

}
}
