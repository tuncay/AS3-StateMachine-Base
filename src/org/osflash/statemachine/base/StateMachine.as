package org.osflash.statemachine.base {

import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.ErrorMap;
import org.osflash.statemachine.transitioning.ITransitionController;
import org.osflash.statemachine.transitioning.ITransitionValidator;
import org.osflash.statemachine.uids.IUID;

public class StateMachine implements IFSMController, IFSMProperties {

    private var _transitionModel:IFSMProperties;
    private var _transitionController:ITransitionController;
    private var _transitionValidator:ITransitionValidator;
    private var _cancellationValidator:ITransitionValidator;

    public function StateMachine( model:IFSMProperties, controller:ITransitionController ) {
        _transitionModel = model;
        _transitionController = controller;
    }

    public function get currentStateName():String {
        return _transitionModel.currentStateName;
    }

    public function get referringTransition():String {
        return _transitionModel.referringTransition;
    }

    public function get transitionPhase():IUID {
        return _transitionModel.transitionPhase;
    }

    public function transitionToInitialState():void {
        _transitionController.transitionToInitialState();
    }

    public function setValidators( transition:ITransitionValidator, cancellation:ITransitionValidator ):void {
        _transitionValidator = transition;
        _cancellationValidator = cancellation;
    }

    public function pushTransition( transition:String, payload:Object = null ):void {
        _transitionController.pushTransition( transition, payload );
    }

    public function transition():void {
        if ( isTransitionFromValidPhase ) {
            _transitionController.transition();
        } else {
            throw new ErrorMap().getError( ErrorCodes.INVALID_TRANSITION ).injectMsgWith( _transitionModel.transitionPhase );
        }
    }

    public function flushQueuedTransitions():void {
        _transitionController.flushQueuedTransitions();
    }

    public function cancelStateTransition( reason:String ):void {
        if ( isCancellationFromValidPhase ) {
            _transitionController.cancelStateTransition( reason );
        } else {
            throw new ErrorMap().getError( ErrorCodes.INVALID_CANCEL ).injectMsgWith( _transitionModel.transitionPhase );
        }
    }

    private function get isTransitionFromValidPhase():Boolean {
        return (_transitionValidator == null) ? false : _transitionValidator.validate( _transitionModel );
    }

    private function get isCancellationFromValidPhase():Boolean {
        return (_cancellationValidator == null) ? false : _cancellationValidator.validate( _transitionModel );
    }
}
}