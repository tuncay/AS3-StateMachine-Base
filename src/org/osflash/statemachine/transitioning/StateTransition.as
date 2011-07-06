package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.model.IPhaseDispatcher;
import org.osflash.statemachine.model.IPhaseModel;

public class StateTransition implements IPhaseDispatcher {

    private var _transitionPhases:Vector.<ITransitionPhase>;
    private var _model:IPhaseModel;

    public function StateTransition( model:IPhaseModel) {
        _model = model;
        initialiseStateTransition();
    }

    protected function initialiseStateTransition():void {
    }

    public final function pushTransitionPhase( phase:ITransitionPhase ):void {
        if ( _transitionPhases == null )_transitionPhases = new Vector.<ITransitionPhase>;
        _transitionPhases.push( phase );
    }

    public function dispatchPhases(  ):void {
        if ( _transitionPhases == null || _transitionPhases.length == 0 ) {
            throw new StateTransitionError( StateTransitionError.NO_PHASES_HAVE_BEEN_PUSHED_TO_STATE_TRANSITION );
        }
        var n:int = 0;
        while ( n < _transitionPhases.length ) {
            const phase:ITransitionPhase = ITransitionPhase( _transitionPhases[n++] );
            const proceedWithTransition:Boolean = phase.dispatch( _model );
            if ( !proceedWithTransition ) return;
        }
    }
}
}
