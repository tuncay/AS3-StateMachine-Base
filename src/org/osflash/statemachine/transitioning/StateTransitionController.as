package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.logging.log;
import org.osflash.statemachine.model.IPhaseDispatcher;
import org.osflash.statemachine.model.ITransitionModel;
import org.osflash.statemachine.uids.IUID;

public class StateTransitionController implements IStateTransitionController {

    private var _model:ITransitionModel;
    private var _transition:IPhaseDispatcher;
    private var _isCurrentlyTransitioning:Boolean;

    public function StateTransitionController( model:ITransitionModel, transition:IPhaseDispatcher ) {
        _model = model;
        _transition = transition;
    }

    public function transitionToInitialState():void {
        _model.setInitialStateAsCurrent();
        executeTransition();
    }

    public final function transition( transition:IUID, payload:Object = null ):void {
        _model.addTransition( transition, payload );
        if ( _isCurrentlyTransitioning ) {
            log( "fsm is currently transitioning, the request to transition has been queued" );
        }
        else {
            prepareAndExecuteNextTransition();
        }
    }

    public function cancelStateTransition( reason:IUID  ):void {
        _model.cancellationReason = reason;
    }

    private final function prepareAndExecuteNextTransition():void {
        if ( _model.hasTransition ) {
            _model.dequeueTransition();
            executeTransition();
        }
    }

    protected final function executeTransition():void {
        _isCurrentlyTransitioning = true;
        _transition.dispatchPhases( _model );
        _isCurrentlyTransitioning = false;
        _model.reset();
        prepareAndExecuteNextTransition();
    }
}
}