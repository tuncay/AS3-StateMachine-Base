package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.StateTransitionCancellationError;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionPhaseUID;
import org.osflash.statemachine.uids.getNullUID;

internal class TransitionModelProperties {

    private var _currentState:IState;
    private var _currentBinding:TransitionBinding;
    private var _cancellationReason:IUID;

    internal var currentTransitionPhase:IUID;


    public function TransitionModelProperties() {
        reset();
    }

    internal function get currentState():IState {
        return _currentState;
    }

    internal function get hasTransitionBeenCancelled():Boolean {
        return ( !_cancellationReason.isNull );
    }

    internal function setCurrentTransition( binding:TransitionBinding ):void {
        const result:Boolean = _currentState.hasTrans( binding.uid );
        if ( result ) {
            _currentBinding = binding;
        } else {
            throwUndefinedTransitionError( binding.uid );
        }
    }

    private function throwUndefinedTransitionError( transition:IUID ):void {
        const error:StateTransitionError = new StateTransitionError( StateTransitionError.TRANSITION_UNDEFINED_IN_CURRENT_STATE );
        error.injectMessageWithToken( "state", _currentState.uid.toString() );
        error.injectMessageWithToken( "transition", transition.toString() );
        throw error;
    }

    internal function reset():void {
        currentTransitionPhase = StateTransitionPhaseUID.NONE;
        _cancellationReason = getNullUID();
    }

    internal function get referringTransition():IUID {
        return (_currentBinding == null ) ? getNullUID() : _currentBinding.uid;
    }

    internal function get cancellationReason():IUID {
        return (_cancellationReason == null ) ? getNullUID() : _cancellationReason;
    }

    internal function set cancellationReason( reason:IUID ):void {
        if( reason == null || reason.isNull ){
            throwStateTransitionCancellationError();
        }
        _cancellationReason = reason;
    }

    private function throwStateTransitionCancellationError():void {
        const error:StateTransitionCancellationError =     new StateTransitionCancellationError(StateTransitionCancellationError.NULL_CANCELLATION_REASON);
        error.injectMessageWithToken("transition", referringTransition.toString() );
        error.injectMessageWithToken("state", currentState.uid.toString() );
        throw error;
    }

    internal function get currentPayload():IPayload {
        return _currentBinding.payload;
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
