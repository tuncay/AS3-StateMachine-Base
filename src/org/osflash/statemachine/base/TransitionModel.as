package org.osflash.statemachine.base {

import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModelOwner;
import org.osflash.statemachine.core.StateTransitionModel;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.transitioning.TransitionBinding;
import org.osflash.statemachine.uids.StateTransitionPhaseUID;
import org.osflash.statemachine.uids.getNullUID;

public class TransitionModel implements IFSMProperties, StateTransitionModel {

    private var _stateModel:IStateModelOwner;
    private var _currentState:IState;
    private var _queue:Array;
    private var _currentTransitionPhase:UID;
    private var _isCurrentlyTransitioning:Boolean;
    private var _currentBinding:TransitionBinding;
    private var _cancellationBinding:TransitionBinding;

    public final function TransitionModel( stateModel:IStateModelOwner ) {
        _stateModel = stateModel;
        _currentTransitionPhase = getNullUID();
        _queue = [];
        reset();
    }

    public function get currentStateUID():UID {
        return _currentState.uid;
    }

    public function get referringTransition():UID {
        return (_currentBinding == null ) ? getNullUID() : _currentBinding.transition;
    }

    public function get isCurrentlyTransitioning():Boolean {
        return _isCurrentlyTransitioning;
    }

    public function get hasNextTransitions():Boolean {
        return ( _queue.length != 0 );
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

    public function pushTransition( transition:UID, payload:Object ):void {
        _queue.push( new TransitionBinding( transition, payload ) );
    }

    public function cancelTransition( reason:UID, payload:Object ):void {
        _cancellationBinding = new TransitionBinding( reason, payload );
    }

    public function discardUndefinedTransition():Boolean {
        if ( _currentState.hasTrans( TransitionBinding( _queue[0] ).transition ) ) {
            return false
        } else {
            _queue.shift();
            return true;
        }
    }

    public function reset():void {
        _currentTransitionPhase = StateTransitionPhaseUID.NONE;
        _cancellationBinding = null;
    }

    public function markTransitionAsStarted():void {
        _isCurrentlyTransitioning = true;
        _currentBinding = _queue.shift();
    }

    public function markTransitionAsEnded():void {
        _isCurrentlyTransitioning = false;
    }

    public function get payload():IPayload {
        return _currentBinding.payload;
    }

    public function get transitionPhase( ):UID {
        return _currentTransitionPhase;
    }

     public function set transitionPhase( value:UID ):void {
        _currentTransitionPhase = value;
    }
}
}
