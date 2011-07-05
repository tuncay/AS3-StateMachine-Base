package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.uids.IUID;

public class TransitionModel implements IStateTransitionModel, ITransitionPhaseModel {

    private var _stateModel:IStateModelOwner;
    private var _queue:TransitionQueue;
    private var _properties:TransitionModelProperties;

    public final function TransitionModel( stateModel:IStateModelOwner ) {
        _stateModel = stateModel;
        _queue = new TransitionQueue();
    }

    public function get currentStateUID():IUID {
        return _properties.currentState.uid;
    }

    public function get referringTransition():IUID {
        return _properties.referringTransition;
    }

    public function get transitionPhase():IUID {
        return _properties.currentTransitionPhase;
    }

    public function set transitionPhase( value:IUID ):void {
        _properties.currentTransitionPhase = value;
    }

    public function get hasNextTransition():Boolean {
        return _queue.hasNext;
    }

    public function get payload():IPayload {
        return _properties.currentPayload;
    }

    public function get currentState():IState {
        return _properties.currentState;
    }

    public function get targetState():IState {
        return _stateModel.getTargetState( referringTransition, _properties.currentState );
    }

    public function get hasTransitionBeenCancelled():Boolean {
        return _properties.hasTransitionBeenCancelled;
    }

    public function setInitialStateAsCurrent():void {
        _properties.setCurrentState( _stateModel.initialState );
    }

    public function setTargetStateAsCurrent():void {
        _properties.setCurrentState( targetState );
    }

    public function addTransition( transition:IUID, payload:Object = null ):void {
        _queue.enqueueTransition( transition, payload );
    }

    public function addReasonForCancellation( reason:IUID ):void {
        _properties.cancellationReason = reason, payload;
    }

    public function dequeueNextTransition():void {
        const nextTransition:TransitionBinding = _queue.dequeueTransition();
        _properties.setCurrentTransition( nextTransition );
    }

    public function reset():void {
        _properties.reset();
    }


}
}
