package org.osflash.statemachine.core {
/**
 * Contract with FSMInjector and framework for managing States
 */
public interface IStateModelOwner {

    /**
     * retrieves the initial state
     */
    function get initialState():IState;

    /**
     * Registers a IState with the FSM.
     * @param state the IState to be registered.
     * @param initial whether the IState is the initial state.
     * @return the success of the operation.
     */
    function registerState(state:IState, initial:Boolean = false):Boolean;

    /**
     * Removes a IState from the FSM.
     * @param stateName the IState to be removed.
     * @return the success of the opperation.
     */
    function removeState(stateName:String):Boolean;

    /**
     * Interrogates the FSM for the presence of the named IState.
     * @param stateName the name of the IState.
     * @return
     */
    function hasState(stateName:String):Boolean;

    /**
     * Retrieves the target IState from the named transition
     * @param transitionName the name of the transition that defines the target
     * @param state the state that defines the transition
     * @return
     */
    function getTargetState(transitionName:String, state:IState):IState

    /**
     * The destroy method for GC.
     */
    function destroy():void;
}
}