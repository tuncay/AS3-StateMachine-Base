package org.osflash.statemachine.base {

import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.StateTransitionModel;
import org.osflash.statemachine.core.StateTransitionController;
import org.osflash.statemachine.core.TransitionValidator;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.errors.StateTransitionError;

public class StateMachine implements IFSMController {

    private var _transitionModel:StateTransitionModel;
    private var _transitionController:StateTransitionController;
    private var _transitionValidator:TransitionValidator;
    private var _cancellationValidator:TransitionValidator;

    public function StateMachine( model:StateTransitionModel, controller:StateTransitionController ) {
        _transitionModel = model;
        _transitionController = controller;
    }

    public final function transitionToInitialState():void {
        _transitionController.transitionToInitialState();
    }

    public final function setValidators( transition:TransitionValidator, cancellation:TransitionValidator ):void {
        _transitionValidator = transition;
        _cancellationValidator = cancellation;
    }

    public final function transition( transition:UID, payload:Object = null ):void {
        if ( isTransitionFromValidPhase ) {
            _transitionController.transition( transition, payload );
        } else {
            throwStateTransitionError( StateTransitionError.INVALID_TRANSITION_ERROR );
        }
    }

    public final function cancelStateTransition( reason:UID, payload:Object = null ):void {
        if ( isCancellationFromValidPhase ) {
            _transitionModel.cancelTransition( reason, payload );
        } else {
            throwStateTransitionError( StateTransitionError.INVALID_CANCEL_ERROR );
        }
    }

    private function throwStateTransitionError( msg:String ):void {
        const error:StateTransitionError = new StateTransitionError( msg );
        error.injectMessageWithToken( "phase", _transitionModel.transitionPhase.toString() );
        throw error;
    }

    private final function get isTransitionFromValidPhase():Boolean {
        return (_transitionValidator == null) ? false : _transitionValidator.validate( _transitionModel );
    }

    private final function get isCancellationFromValidPhase():Boolean {
        return (_cancellationValidator == null) ? false : _cancellationValidator.validate( _transitionModel );
    }
}
}