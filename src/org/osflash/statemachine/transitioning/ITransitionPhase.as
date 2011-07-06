package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.model.IPhaseModel;

public interface ITransitionPhase {
    function dispatch( model:IPhaseModel ):Boolean;
}
}
