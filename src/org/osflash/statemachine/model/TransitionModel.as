package org.osflash.statemachine.model {

import org.osflash.statemachine.uids.IUID;

public class TransitionModel implements ITransitionModel {

    private var _stateModel:IStateModel;
    private var _queue:TransitionQueue;
    private var _properties:ITransitionProperties;

    public final function TransitionModel( stateModel:IStateModel, properties:ITransitionProperties ) {
        _stateModel = stateModel;
        _properties = properties;
        _queue = new TransitionQueue();
    }

    public function get currentStateName():String {
        return _properties.currentState.name;
    }

    public function get referringTransition():String {
        return _properties.referringTransition;
    }

    public function get transitionPhase():IUID {
        return _properties.currentTransitionPhase;
    }

    public function get hasTransition():Boolean {
        return _queue.hasNext;
    }

    public function setInitialStateAsCurrent():void {
        _properties.currentState = _stateModel.initialState;
    }

    public function addTransition( transition:String, payload:Object = null ):void {
        _queue.enqueueTransition( transition, payload );
    }

    public function set cancellationReason( reason:String ):void {
        _properties.cancellationReason = reason;
    }

    public function dequeueTransition():void {
        _properties.currentTransitionBinding = _queue.dequeueTransition();
    }

    public function reset():void {
        _properties.reset();
    }
}
}
