package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.core.TransitionPhase;

public interface IPhaseRegister {
    function setPhase( phase:TransitionPhase ):void;
}
}
