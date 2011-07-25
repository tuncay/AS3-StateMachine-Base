package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.ErrorMap;
import org.osflash.statemachine.model.IPhaseModel;
import org.osflash.statemachine.transitioning.ITransitionPhase;

public class TransitionPhaseDispatcher implements IPhaseDispatcher {

    private var _phases:Vector.<ITransitionPhase>;
    private var _model:IPhaseModel;
    private var _logger:IStateLogger;
    private var _fixedLength:int;
    private var _numPhases:int;

    public function TransitionPhaseDispatcher( model:IPhaseModel, length:int, logger:IStateLogger = null ) {
        _model = model;
        _fixedLength = length;
        _logger = logger;
        _phases = new Vector.<ITransitionPhase>( _fixedLength, true );
        initialiseStateTransition();

    }

    protected function initialiseStateTransition():void {
    }

    public function pushTransitionPhase( value:ITransitionPhase ):void {
        value.model = _model;
        value.logger = _logger;
        _phases[_numPhases++] = value;
    }


    public function dispatchPhases():void {
         if ( _numPhases != _fixedLength )
            throw new ErrorMap().getError( ErrorCodes.NUMBER_OF_PHASES_PUSHED_TO_STATE_TRANSITION )
                  .injectMsgWith( "got", _numPhases.toString() )
                  .injectMsgWith( "expected", _fixedLength.toString() );


        for each ( var phase:ITransitionPhase in _phases ) {
            const  proceedWithTransition:Boolean = phase.dispatch();
            if ( !proceedWithTransition ) return;
        }
    }
}
}
