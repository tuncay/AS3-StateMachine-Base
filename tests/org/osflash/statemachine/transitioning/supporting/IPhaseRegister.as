package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.core.ITransitionPhase;

public interface IPhaseRegister {
    function setPhase( phase:ITransitionPhase ):void;
}
}
