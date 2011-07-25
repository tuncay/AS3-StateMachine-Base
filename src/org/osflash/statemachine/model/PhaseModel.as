package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.uids.IUID;

public class PhaseModel implements IPhaseModel {

    private var _stateModel:IStateModel;
    private var _properties:ITransitionProperties;

    public final function PhaseModel( stateModel:IStateModel, properties:ITransitionProperties ) {
        _stateModel = stateModel;
        _properties = properties;
    }

    public function set transitionPhase( value:IUID ):void {
        _properties.currentTransitionPhase = value;
    }

    public function get payload():IPayload {
        return _properties.currentPayload;
    }

    public function get currentState():IState {
        return _properties.currentState;
    }

    public function get targetState():IState {
        if( currentState.isNull() ) return _stateModel.initialState;
        return _stateModel.getTargetState( _properties.referringTransition, _properties.currentState );
    }

    public function get hasTransitionBeenCancelled():Boolean {
        return _properties.hasTransitionBeenCancelled;
    }

    public function setTargetStateAsCurrent():void {
        _properties.currentState = targetState;
    }

    public function get referringTransition():String {
        return _properties.referringTransition;
    }

    public function get cancellationReason():String {
        return _properties.cancellationReason;
    }
}
}
