/**
 * User: revisual.co.uk
 * Date: 03/07/11
 * Time: 07:28
 */
package org.osflash.statemachine.transitioning.supporting {
import org.osflash.statemachine.transitioning.ITransitionPhase;

public class HappyPhaseTwo implements ITransitionPhase {


    public function process( model:Object ):Boolean {
        IPhaseRegister( model ).setPhase( this );
        return true;
    }
}
}
