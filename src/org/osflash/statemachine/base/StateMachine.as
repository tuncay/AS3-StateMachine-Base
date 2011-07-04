package org.osflash.statemachine.base {

import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.transitioning.IStateTransitionController;
import org.osflash.statemachine.transitioning.ITransitionValidator;
import org.osflash.statemachine.uids.IUID;

public class StateMachine implements IFSMController, IFSMProperties {

    private var _transitionModel:IFSMProperties;
    private var _transitionController:IStateTransitionController;
    private var _transitionValidator:ITransitionValidator;
    private var _cancellationValidator:ITransitionValidator;

    public function StateMachine( model:IFSMProperties, controller:IStateTransitionController ) {
        _transitionModel = model;
        _transitionController = controller;
    }

    public function get currentStateUID():IUID {
        return _transitionModel.currentStateUID;
    }

    public function get referringTransition():IUID {
        return _transitionModel.referringTransition;
    }

    public function get transitionPhase():IUID {
        return _transitionModel.transitionPhase;
    }

    public final function transitionToInitialState():void {
        _transitionController.transitionToInitialState();
    }

    public final function setValidators( transition:ITransitionValidator, cancellation:ITransitionValidator ):void {
        _transitionValidator = transition;
        _cancellationValidator = cancellation;
    }

    public final function transition( transition:IUID, payload:Object = null ):void {
        if ( isTransitionFromValidPhase ) {
            _transitionController.transition( transition, payload );
        } else {
            throwStateTransitionError( StateTransitionError.INVALID_TRANSITION_ERROR );
        }
    }

    public final function cancelStateTransition( reason:IUID, payload:Object = null ):void {
        if ( isCancellationFromValidPhase ) {
            _transitionController.cancelStateTransition( reason, payload );
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