package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.model.IPhaseModel;

public interface ITransitionPhase {
    function set model( value:IPhaseModel ):void;

    function set logCode( value:int ):void;

    function dispatch():Boolean;
}
}
