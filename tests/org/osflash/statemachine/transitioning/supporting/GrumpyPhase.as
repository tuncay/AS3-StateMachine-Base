package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.model.IPhaseModel;
import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.transitioning.ITransitionPhase;

public class GrumpyPhase implements ITransitionPhase {

    private var _registry:IResultsRegistry;
    private var _model:IPhaseModel;
    private var _logger:IStateLogger;
    private var _count:int;

    public function GrumpyPhase( registry:IResultsRegistry, count:int ) {
        _registry = registry;
        _count = count;
    }

    public function dispatch():Boolean {
        var results:String = "[" + _count + "]GP:";
        if ( _model != null ) {
            results += "M:";
        }
        if ( _logger != null ) {
            results += "L"
        }
        _registry.pushResult( results );
        return false;
    }

    public function set model( value:IPhaseModel ):void {
        _model = value;
    }

    public function set logger( value:IStateLogger ):void {
        _logger = value;
    }
}
}
