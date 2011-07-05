package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.StateTransitionCancellationError;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.transitioning.Payload;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionPhaseUID;
import org.osflash.statemachine.uids.getNullUID;

internal class TransitionProperties implements ITransitionProperties {

    private var _currentState:IState;
    private var _currentBinding:TransitionBinding;
    private var _cancellationReason:IUID;
    private var _currentTransitionPhase:IUID;

    public function TransitionProperties() {
        reset();
    }

    public function get currentState():IState {
        return _currentState;
    }

    public function set currentState( state:IState ):void {
        _currentState = state;
    }

      public function get currentTransitionPhase():IUID {
        return _currentTransitionPhase;
    }

    public function set currentTransitionPhase( phase:IUID ):void {
        _currentTransitionPhase = phase;
    }

    public function get hasTransitionBeenCancelled():Boolean {
        return ( !_cancellationReason.isNull );
    }

    public function get currentPayload():IPayload {
        return ( _currentBinding == null ) ? new Payload( null ) : _currentBinding.payload;
    }

    public function get referringTransition():IUID {
        return (_currentBinding == null ) ? getNullUID() : _currentBinding.transition;
    }

    public function get cancellationReason():IUID {
        return (_cancellationReason == null ) ? getNullUID() : _cancellationReason;
    }

    public function set cancellationReason( reason:IUID ):void {
        if ( reason != null && !reason.isNull ) {
            _cancellationReason = reason;
        } else {
            const error:StateTransitionCancellationError = new StateTransitionCancellationError( StateTransitionCancellationError.NULL_CANCELLATION_REASON );
            error.injectMessageWithToken( "transition", referringTransition.toString() );
            error.injectMessageWithToken( "state", currentState.uid.toString() );
            throw error;
        }
    }

    public function set currentTransitionBinding( binding:TransitionBinding ):void {
        const result:Boolean = _currentState.hasTrans( binding.transition );
        if ( result ) {
            _currentBinding = binding;
        } else {
            const error:StateTransitionError = new StateTransitionError( StateTransitionError.TRANSITION_UNDEFINED_IN_CURRENT_STATE );
            error.injectMessageWithToken( "state", _currentState.uid.toString() );
            error.injectMessageWithToken( "transition", binding.transition.toString() );
            throw error;
        }
    }

    public function reset():void {
        currentTransitionPhase = StateTransitionPhaseUID.NONE;
        _cancellationReason = getNullUID();
    }

}
}
