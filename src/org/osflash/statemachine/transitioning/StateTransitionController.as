package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.core.IPhaseDispatcher;
import org.osflash.statemachine.core.IStateTransitionController;
import org.osflash.statemachine.core.IStateTransitionModel;
import org.osflash.statemachine.core.IUID;
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
        transitionToState( );
    }

    public final function transition( transition:IUID, payload:Object = null ):void {
        _model.enqueueTransition( transition, payload );
        if ( _isCurrentlyTransitioning ) {
            log( " currently transitioning, the request is queued" );
        }
        else {
            prepareAndExecuteNextTransition();
        }
    }

   public function cancelStateTransition( reason:IUID, payload:Object = null ):void{
       _model.cancelTransition( reason, payload );
   }

    private final function prepareAndExecuteNextTransition():void {
        if ( _model.hasNextTransition  ) {
            if ( _model.discardUndefinedTransition() ) {
                transitionToState( );
            }
            else {
                log( "[" + _model.referringTransition + "]" + " is not defined in state: " + "[" +_model.currentStateUID + "]" );
                prepareAndExecuteNextTransition();
            }
        }
    }

    protected final function transitionToState( ):void {
       _isCurrentlyTransitioning = true;
        _model.shiftNextTransition();
        _transition.dispatchPhases( _model );
         _isCurrentlyTransitioning = false;
        _model.reset();
        prepareAndExecuteNextTransition();
    }

    public function destroy():void {
        _model = null;
        _transition = null;
    }

}
}