package org.osflash.statemachine.transitioning.supporting {
import org.osflash.statemachine.transitioning.ITransitionPhase;

public class GrumpyPhase implements ITransitionPhase {

    public function process( model:Object ):Boolean {
        IPhaseRegister( model ).setPhase( this );
        return false;
    }
}
}
