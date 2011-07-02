package org.osflash.statemachine.base {

import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.TransitionController;
import org.osflash.statemachine.core.TransitionValidator;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.model.TransitionModel;

public class StateMachine implements IFSMController {

    private var _transitionModel:TransitionModel;
    private var _transitionController:TransitionController;

    private var _transitionValidator:TransitionValidator;
    private var _cancellationValidator:TransitionValidator;

    public function StateMachine( model:TransitionModel, controller:TransitionController ) {
        _transitionModel = model;
        _transitionController = controller;
    }

    protected final function setValidators( transition:TransitionValidator, cancellation:TransitionValidator):void{
        _transitionValidator = transition;
        _cancellationValidator = cancellation;
    }


    public final function transition( transition:UID, payload:Object = null ):void {
        if ( isTransitionFromValidPhase ) {
            _transitionController.transition(transition, payload);
        }
        else {
            throw new StateTransitionError( StateTransitionError.ILLEGAL_TRANSITION_ERROR  );
        }
    }

    public final function cancelStateTransition( reason:UID, payload:Object = null ):void {
        if ( isCancellationFromValidPhase ) {
            _transitionModel.cancelTransition( reason, payload );
        } else {
            throw new StateTransitionError( StateTransitionError.ILLEGAL_CANCEL_ERROR );
        }
    }

    public function transitionToInitialState():void {
        _transitionController.transitionToInitialState();
    }

    public function dispose():void {
        _transitionModel = null;
        _transitionController = null;
    }

    private final function get isTransitionFromValidPhase():Boolean {
        return (_transitionValidator == null) ? false : _transitionValidator.validate( _transitionModel );
    }

    private final function get isCancellationFromValidPhase():Boolean {
        return (_cancellationValidator == null) ? false : _cancellationValidator.validate( _transitionModel );
    }

}
}