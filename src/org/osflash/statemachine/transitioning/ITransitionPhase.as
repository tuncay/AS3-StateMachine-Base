package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.model.IPhaseModel;

public interface ITransitionPhase {
    function set model( value:IPhaseModel ):void;

    function set logger( value:IStateLogger ):void;

    function dispatch():Boolean;
}
}
