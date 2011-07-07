package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.model.IPhaseModel;
import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.transitioning.ITransitionPhase;

public class GrumpyPhase implements ITransitionPhase {

    private var _registry:IResultsRegistry;
    private var _model:IPhaseModel;
    private var _logCode:int;
     private var _count:int = 1;

    public function GrumpyPhase( registry:IResultsRegistry ) {
        _registry = registry;
        _logCode = -1;
    }

    public function dispatch():Boolean {
        var results:String = "[" + _count++ + "]GP:";
        if ( _model != null ) {
            results += "M:";
        }
        if ( _logCode != -1 ) {
            results += "LC(" + _logCode.toString() + ")"
        }
        _registry.pushResult( results );
        return false;
    }

    public function set model( value:IPhaseModel ):void {
        _model = value;
    }

    public function set logCode( value:int ):void {
        _logCode = value;
    }
}
}
