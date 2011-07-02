package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.base.StateTransition;
import org.osflash.statemachine.base.TransitionModel;
import org.osflash.statemachine.core.TransitionController;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.logging.log;

public class BaseTransitionController implements TransitionController {

    private var _model:TransitionModel;
    private var _transition:StateTransition;

    public function BaseTransitionController( model:TransitionModel, transition:StateTransition ) {
        _model = model;
        _transition = transition;
    }

    public function transitionToInitialState():void {
        _model.setInitialStateAsCurrent();
        transitionToState( );
    }

    public final function transition( transition:UID, payload:Object = null ):void {
        _model.pushTransition( transition, payload );
        if ( _model.isCurrentlyTransitioning ) {
            log( " currently transitioning, the request is queued" );
        }
        else {
            prepareAndExecuteNextTransition();
        }
    }

    private final function prepareAndExecuteNextTransition():void {
        if ( _model.hasNextTransitions  ) {
            if ( _model.discardUndefinedTransition ) {
                transitionToState( );
            }
            else {
                log( "[" + _model.referringTransition + "]" + " is not defined in state: " + "[" +_model.currentState + "]" );
                prepareAndExecuteNextTransition();
            }
        }
    }

    protected final function transitionToState( ):void {
        _model.markTransitionAsStarted();
        _transition.dispatchPhases( _model );
        _model.markTransitionAsEnded();
        _model.reset();
        prepareAndExecuteNextTransition();
    }

    public function destroy():void {
        _model = null;
        _transition = null;
    }

}
}