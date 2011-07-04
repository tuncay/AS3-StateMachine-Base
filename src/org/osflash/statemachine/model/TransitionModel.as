package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.IStateModelOwner;
import org.osflash.statemachine.model.IStateTransitionModel;
import org.osflash.statemachine.model.ITransitionPhaseModel;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.errors.StateTransitionError;
import org.osflash.statemachine.uids.StateTransitionPhaseUID;
import org.osflash.statemachine.uids.getNullUID;

public class TransitionModel implements IStateTransitionModel, ITransitionPhaseModel {

    private var _stateModel:IStateModelOwner;
    private var _currentState:IState;
    private var _queue:Array;
    private var _currentTransitionPhase:IUID;
    private var _currentBinding:TransitionBinding;
    private var _cancellationBinding:TransitionBinding;

    public final function TransitionModel( stateModel:IStateModelOwner ) {
        _stateModel = stateModel;
        _queue = [];
        reset();
    }

    public function get currentStateUID():IUID {
        return _currentState.uid;
    }

    public function get referringTransition():IUID {
        return (_currentBinding == null ) ? getNullUID() : _currentBinding.transition;
    }

    public function get payload():IPayload {
        return _currentBinding.payload;
    }

    public function get transitionPhase():IUID {
        return _currentTransitionPhase;
    }

    public function set transitionPhase( value:IUID ):void {
        _currentTransitionPhase = value;
    }

    public function get targetState():IState {
        return _stateModel.getTargetState( referringTransition, _currentState );
    }

    public function get currentState():IState {
        return _currentState;
    }

    public function get hasTransitionBeenCancelled():Boolean {
        return ( _cancellationBinding != null );
    }

    public function get hasNextTransition():Boolean {
        return ( _queue.length != 0 );
    }

    public function setInitialStateAsCurrent():void {
        _currentState = _stateModel.initialState;
    }

    public function setTargetStateAsCurrent():void {
        _currentState = targetState;
    }

    public function enqueueTransition( transition:IUID, payload:Object = null ):void {
        _queue.push( new TransitionBinding( transition, payload ) );
    }

    public function cancelTransition( reason:IUID, payload:Object = null ):void {
        _cancellationBinding = new TransitionBinding( reason, payload );
    }

    public function reset():void {
        _currentTransitionPhase = StateTransitionPhaseUID.NONE;
        _cancellationBinding = null;
    }

    public function dequeueNextTransition():void {
        const discardedTransition:IUID = discardUndefinedTransition();
        if ( discardedTransition.equals( getNullUID() ) ) {
            _currentBinding = _queue.shift();
        } else {
            throwUndefinedTransitionError( discardedTransition );
        }
    }

    private function discardUndefinedTransition():IUID {
        if ( _currentState.hasTrans( TransitionBinding( _queue[0] ).transition ) ) {
            return getNullUID();
        } else {
            const transitionBinding:TransitionBinding = _queue.shift();
            return transitionBinding.transition;
        }
    }

    private function throwUndefinedTransitionError( transition:IUID ):void {
        const error:StateTransitionError = new StateTransitionError( StateTransitionError.TRANSITION_UNDEFINED_IN_CURRENT_STATE );
        error.injectMessageWithToken( "state", _currentState.toString() );
        error.injectMessageWithToken( "transition", transition.toString() );
        throw error;
    }

}
}
