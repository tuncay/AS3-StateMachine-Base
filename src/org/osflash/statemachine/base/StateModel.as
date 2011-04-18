/*
 ADAPTED FOR A STAND ALONE UTILITY FROM:
 PureMVC AS3 Utility - StateMachine
 Copyright (c) 2008 Neil Manuell, Cliff Hall
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModel;
import org.osflash.statemachine.core.IStateModelOwner;
import org.osflash.statemachine.errors.StateTransitionError;

/**
 * A Finite State Machine implementation.
 * <P>
 * Handles registration and removal of state definitions.
 * Dependencies on any Observers (Events, Signals, Notifications)
 * are encapsulated within the <code>ITransitionController</code>
 * which controls the phases of the transition between states
 * </P>
 *
 * @ see ITransitionController
 * @ see BaseTransitionController
 */
public class StateModel implements IStateModel, IStateModelOwner {

    /**
     * Map of States objects by name.
     */
    protected var _states:Object = new Object();

    /**
     * The initial state of the FSM.
     */
    protected var _initial:IState;

    public function get initialState():IState{
        return _initial;
    }

    /**
     * @inheritDoc
     */
    public function hasState(stateName:String):Boolean {
        return ( _states[ stateName ] != null );
    }

    /**
     * @inheritDoc
     */
    public function registerState(state:IState, initial:Boolean = false):Boolean {
        if (state == null || hasState(state.name)) return false;
        _states[ state.name ] = state;
        if (initial) this._initial = IState(state);
        return true;
    }

    public function getState( stateName:String ):IState{
        return  IState( _states[ stateName ] );
    }

    /**
     * @inheritDoc
     */
    public function removeState(stateName:String):Boolean {
        if (!hasState(stateName)) return false;
        delete _states[ stateName ];
        return true;
    }

    /**
     * @inheritDoc
     */
    public function destroy():void {

        for each (var state:IState in _states) state.destroy();
        _states = null;
        _initial = null;
    }

    public function getTargetState(transitionName:String, state:IState):IState {
        var targetStateName:String = state.getTarget(transitionName);
        var targetState:IState = IState(_states[ targetStateName ]);
        if( targetState == null && targetStateName != null)
                throw new StateTransitionError(StateTransitionError.TARGET_DECLARATION_MISMATCH + targetStateName);
        return targetState;
    }


}
}