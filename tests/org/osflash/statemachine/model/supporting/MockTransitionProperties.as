package org.osflash.statemachine.model.supporting {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.ITransitionProperties;
import org.osflash.statemachine.model.TransitionBinding;
import org.osflash.statemachine.uids.IUID;

public class MockTransitionProperties implements ITransitionProperties {

    private var _binding:TransitionBinding;
    private var _currentState:IState;
    private var _cancellationReason:String;
    private var _currentTransitionPhase:IUID;

    public function MockTransitionProperties() {
    }

    public function get currentTransitionPhase():IUID {
        return _currentTransitionPhase;
    }

    public function set currentTransitionPhase( value:IUID ):void {
        _currentTransitionPhase = value;
    }

    public function get currentState():IState {
        return _currentState;
    }

    public function set currentState( state:IState ):void {
        _currentState = state;
    }

    public function get hasTransitionBeenCancelled():Boolean {
        return false;
    }

    public function get currentPayload():IPayload {
        return _binding.payload;
    }

    public function get referringTransition():String {
        return _binding.transition;
    }

    public function get cancellationReason():String {
        return _cancellationReason;
    }

    public function set cancellationReason( reason:String ):void {
        _cancellationReason = reason;
    }

    public function set currentTransitionBinding( binding:TransitionBinding ):void {
        _binding = binding;
    }

    public function reset():void {
        _cancellationReason = null;
    }
}
}
