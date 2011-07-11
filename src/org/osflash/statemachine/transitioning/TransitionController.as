package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.model.ITransitionModel;

public class TransitionController implements ITransitionController {

    private var _model:ITransitionModel;
    private var _transition:IPhaseDispatcher;
    private var _isCurrentlyTransitioning:Boolean;

    public function TransitionController( model:ITransitionModel, transition:IPhaseDispatcher ) {
        _model = model;
        _transition = transition;
    }

    public function transitionToInitialState():void {
        _model.setInitialStateAsCurrent();
        executeTransition();
    }

    public final function transition( transition:String, payload:Object = null ):void {
        _model.addTransition( transition, payload );
        if ( !_isCurrentlyTransitioning ) {
            prepareAndExecuteNextTransition();
        }
    }

    public function cancelStateTransition( reason:String ):void {
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
        _transition.dispatchPhases();
        _isCurrentlyTransitioning = false;
        _model.reset();
        prepareAndExecuteNextTransition();
    }
}
}