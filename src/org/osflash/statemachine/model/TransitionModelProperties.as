package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionPhaseUID;
import org.osflash.statemachine.uids.getNullUID;

internal class TransitionModelProperties {

    private var _currentState:IState;
    private var _cancellationBinding:TransitionBinding;
    private var _currentBinding:TransitionBinding;

    internal var currentTransitionPhase:IUID;

    internal function get currentState():IState {
        return _currentState;
    }

    internal function get hasTransitionBeenCancelled():Boolean {
        return ( _cancellationBinding != null );
    }

    internal function setCurrentTransition( binding:TransitionBinding ):void {
        const result:Boolean = _currentState.hasTrans( binding.transition );
        if ( result ) {
            _currentBinding = binding;
        } else {
            throwUndefinedTransitionError( binding.transition );
        }
    }

    private function throwUndefinedTransitionError( transition:IUID ):void {
        const error:StateTransitionError = new StateTransitionError( StateTransitionError.TRANSITION_UNDEFINED_IN_CURRENT_STATE );
        error.injectMessageWithToken( "state", _currentState.toString() );
        error.injectMessageWithToken( "transition", transition.toString() );
        throw error;
    }

    internal function reset():void {
        currentTransitionPhase = StateTransitionPhaseUID.NONE;
        _cancellationBinding = null;
    }

    internal function get referringTransition():IUID {
        return (_currentBinding == null ) ? getNullUID() : _currentBinding.transition;
    }

    internal function get currentPayload():IPayload {
        if ( hasTransitionBeenCancelled ) {
            return _cancellationBinding.payload;
        }
        return _currentBinding.payload;
    }

    internal function setCancellationReason( reason:IUID, payload:Object ):void {
        _cancellationBinding = new TransitionBinding( reason, payload );
    }

    internal function setCurrentState( state:IState, isInitial:Boolean = false ):void {
        if ( isInitial && _currentState == null || !isInitial ) {
            _currentState = state;
        } else {
            throw new StateTransitionError( StateTransitionError.INITIAL_STATE_CAN_ONLY_BE_SET_ONCE );
        }
    }
}
}
