package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;
import org.osflash.statemachine.model.IPhaseModel;

public class TransitionPhaseDispatcher implements IPhaseDispatcher {

    private var _phases:Vector.<ITransitionPhase>;
    private var _model:IPhaseModel;
    private var _logCode:int;

    public function TransitionPhaseDispatcher( model:IPhaseModel, logCode:int = -1 ) {
        _model = model;
        _logCode = logCode;
        initialiseStateTransition();
    }

    protected function initialiseStateTransition():void {
    }

    public function pushTransitionPhase( value:ITransitionPhase ):void {
        value.model = _model;
        value.logCode = _logCode;
        phases.push( value );
    }

    private function get phases():Vector.<ITransitionPhase> {
        return _phases || ( _phases = new Vector.<ITransitionPhase> );
    }

    public function dispatchPhases():void {
        if ( _phases == null || _phases.length == 0 ) {
            throw getError( ErrorCodes.NO_PHASES_HAVE_BEEN_PUSHED_TO_STATE_TRANSITION );
        }
        var n:int = 0;
        while ( n < phases.length ) {
            const phase:ITransitionPhase = ITransitionPhase( phases[n++] );
            const proceedWithTransition:Boolean = phase.dispatch();
            if ( !proceedWithTransition ) return;
        }
    }
}
}
