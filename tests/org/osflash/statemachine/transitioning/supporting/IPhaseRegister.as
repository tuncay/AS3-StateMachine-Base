package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.transitioning.ITransitionPhase;

public interface IPhaseRegister {
    function setPhase( phase:ITransitionPhase ):void;
}
}
