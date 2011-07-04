package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.model.IPhaseDispatcher;
import org.osflash.statemachine.transitioning.IStateTransitionController;
import org.osflash.statemachine.model.IStateTransitionModel;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.logging.log;

public class StateTransitionController implements IStateTransitionController {

    private var _model:IStateTransitionModel;
    private var _transition:IPhaseDispatcher;
    private var _isCurrentlyTransitioning:Boolean;

    public function StateTransitionController( model:IStateTransitionModel, transition:IPhaseDispatcher ) {
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

    public function cancelStateTransition( reason:IUID, payload:Object = null ):void {
        _model.addReasonForCancellation( reason, payload );
    }

    private final function prepareAndExecuteNextTransition():void {
        if ( _model.hasNextTransition ) {
            _model.dequeueNextTransition();
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