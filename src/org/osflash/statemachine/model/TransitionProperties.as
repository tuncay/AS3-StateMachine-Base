package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;
import org.osflash.statemachine.transitioning.Payload;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.TransitionPhaseUID;

internal class TransitionProperties implements ITransitionProperties {

    private var _currentState:IState;
    private var _currentBinding:TransitionBinding;
    private var _cancellationReason:String;
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
        return ( _cancellationReason != null );
    }

    public function get currentPayload():IPayload {
        return ( _currentBinding == null ) ? new Payload( null ) : _currentBinding.payload;
    }

    public function get referringTransition():String {
        return ( _currentBinding == null ) ? null : _currentBinding.transition;
    }

    public function get cancellationReason():String {
        return _cancellationReason;
    }

    public function set cancellationReason( reason:String ):void {
        _cancellationReason = reason;
    }

    public function set currentTransitionBinding( binding:TransitionBinding ):void {
        const result:Boolean = _currentState.hasTrans( binding.transition );
        if ( result ) {
            _currentBinding = binding;
        } else {
            throw getError( ErrorCodes.TRANSITION_UNDEFINED_IN_CURRENT_STATE ).injectMsgWith( currentState.name, "state" ).injectMsgWith( binding.transition, "transition" );
        }
    }

    public function reset():void {
        currentTransitionPhase = TransitionPhaseUID.NONE;
        _cancellationReason = null;
    }
}
}
