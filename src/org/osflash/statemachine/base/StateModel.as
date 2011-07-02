package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModel;
import org.osflash.statemachine.core.IStateModelOwner;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.errors.StateModelError;

public class StateModel implements IStateModel, IStateModelOwner {

    protected var _states:Object = new Object();
    protected var _initial:IState;

    public function get initialState():IState {
        if ( _initial == null ) {
            throw new StateModelError( StateModelError.NO_INITIAL_STATE_DECLARED );
        }
        return _initial;
    }

    public function hasState( stateID:UID ):Boolean {
        return ( _states[ stateID.identifier ] != null );
    }

    public function registerState( state:IState, initial:Boolean = false ):Boolean {
        if ( state == null || hasState( state.uid ) ) return false;
        _states[ state.uid.identifier ] = state;
        if ( initial ) this._initial = IState( state );
        return true;
    }

    public function getState( stateID:UID ):IState {
        if( !hasState( stateID ) ){
            throwStateNotRegisteredError( stateID );
        }
        return  IState( _states[ stateID.identifier ] );
    }



    public function removeState( stateID:UID ):Boolean {
        if ( !hasState( stateID ) ) return false;
        delete _states[ stateID.identifier ];
        return true;
    }

    public function dispose():void {
        for each ( var state:IState in _states )
            state.dispose();
        _states = null;
        _initial = null;
    }

    public function getTargetState( transitionUID:UID, state:IState ):IState {
        if( !state.hasTrans( transitionUID )){
            throwTransitionNotDefinedInState(state.uid, transitionUID );
        }
        const targetStateUID:UID = state.getTarget( transitionUID );
        const targetState:IState = IState( _states[ targetStateUID.identifier ] );
        if ( targetState == null && targetStateUID != null ) {
            throwTargetMismatchError( state.uid, targetStateUID, transitionUID );
        }
        return targetState;
    }

    private function throwTransitionNotDefinedInState( state:UID, transition:UID ):void {
       const error:StateModelError = new StateModelError( StateModelError.TRANSITION_NOT_DECLARED_IN_STATE );
        error.injectMessageWithToken( "state", state.identifier );
        error.injectMessageWithToken( "transition", transition.identifier );
        throw error;
    }

    private function throwTargetMismatchError( state:UID, target:UID, transition:UID ):void {
        const error:StateModelError = new StateModelError( StateModelError.TARGET_DECLARATION_MISMATCH );
        error.injectMessageWithToken( "state", state.identifier );
        error.injectMessageWithToken( "target", target.identifier );
        error.injectMessageWithToken( "transition", transition.identifier );
        throw error;
    }

     private function throwStateNotRegisteredError( state:UID ):void {
         const error:StateModelError = new StateModelError( StateModelError.STATE_REQUESTED_IS_NOT_REGISTERED );
        error.injectMessageWithToken( "state", state.identifier );
        throw error;
    }


}
}