package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateProvider;
import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.ErrorMap;

public class StateModel implements IStateProvider, IStateModel {

    protected var _states:Object = new Object();
    protected var _initial:IState;
    private var _errorMap:ErrorMap;

    public function get initialState():IState {
        if ( _initial == null ) {
            throw errorMap.getError( ErrorCodes.NO_INITIAL_STATE_DECLARED );
        }
        return _initial;
    }

    public function hasState( stateName:String ):Boolean {
        return ( _states[ stateName ] != null );
    }

    public function registerState( state:IState, initial:Boolean = false ):Boolean {
        if ( state == null || hasState( state.name ) ) return false;
        _states[ state.name ] = state;
        if ( initial ) this._initial = IState( state );
        return true;
    }

    public function getState( stateName:String ):IState {
        if ( !hasState( stateName ) ) {
            throw errorMap.getError( ErrorCodes.STATE_REQUESTED_IS_NOT_REGISTERED ).injectMsgWith( stateName, "state" );
        }
        return  IState( _states[ stateName ] );
    }

    public function removeState( stateName:String ):Boolean {
        if ( !hasState( stateName ) ) return false;
        delete _states[ stateName ];
        return true;
    }

    public function getTargetState( transitionName:String, state:IState ):IState {
        if ( !state.hasTrans( transitionName ) ) {
            throw errorMap.getError( ErrorCodes.TRANSITION_NOT_DECLARED_IN_STATE )
                  .injectMsgWith( state.name, "state" )
                  .injectMsgWith( transitionName, "transition" );
        }
        const targetStateName:String = state.getTarget( transitionName );
        const targetState:IState = IState( _states[ targetStateName ] );
        if ( targetState == null && targetStateName != null ) {
            throw errorMap.getError( ErrorCodes.TARGET_DECLARATION_MISMATCH ).injectMsgWith( state.name, "state" )
                  .injectMsgWith( targetStateName, "target" )
                  .injectMsgWith( transitionName, "transition" );
        }
        return targetState;
    }

    private function get errorMap():ErrorMap {
        return _errorMap || (_errorMap = new ErrorMap());
    }
}
}