package org.osflash.statemachine.core {
/**
 * Contract with FSMInjector to encapsulate creation of concrete IState instances for a given data source.
 */
public interface IStateDecoder {

    /**
     * sets the FSM declaration
     * @param value the FSM declaration
     */
    function setData(value:Object):void;

    /**
     * This the factory method for decoding each state definition into a concrete IState.
     * @param stateDef the data defining the IState to be created.
     * @return the decoded state.
     */
    function decodeState(stateDef:Object):IState;

    /**
     * Ascertains whether a state is the initial state.
     * @param stateName the name of the state.
     * @return
     */
    function isInitial(stateName:String):Boolean;

    /**
     * Iterates through the FSM definition, and returns an array of decoded states.
     * @return the decoded IStates
     */
    function getStateList():Array;

    /**
     * The destroy method for GC
     */
    function destroy():void;

}
}