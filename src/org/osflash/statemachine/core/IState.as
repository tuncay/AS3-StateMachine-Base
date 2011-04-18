package org.osflash.statemachine.core {
/**
 * The contract between concrete states and the StateMachine framework.
 */
public interface IState {
    /**
     * The name of the state
     */
    function get name():String;

    function get referringTransitionName():String;

    /**
     * The number of transitions defined in this state
     */
    function get length():int;

    /**
     * Defines a transition.
     * A transition requires the name of the triggering action, and the name of the state to which the FSM will move towards.
     * @param transitionName the name of the action.
     * @param target the name of the target state to transition to.
     * @return the success of the operation.
     */
    function defineTrans(transitionName:String, target:String):Boolean;

    /**
     * Remove a previously defined transition.
     * @param transitionName the name of the action.
     * @return the success of the opperation.
     */
    function removeTrans(transitionName:String):Boolean;

    /**
     * Ascertains whether there is a transition defined for the specified action
     * @param transitionName the name of the action.
     * @return
     */
    function hasTrans(transitionName:String):Boolean;

    /**
     * Get the target state name for a given action.
     * @param transitionName the name of the StateMachine.ACTION event type.
     * @return the target state's name.
     */
    function getTarget(transitionName:String):String;


    /**
     * Destroy method.
     */
    function destroy():void;

}
}