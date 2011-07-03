
package org.osflash.statemachine.transitioning.supporting {
import org.osflash.statemachine.core.TransitionPhase;

public class GrumpyPhase implements TransitionPhase {

    public function process( model:Object ):Boolean {
       IPhaseRegister( model ).setPhase( this );
        return false;
    }
}
}
