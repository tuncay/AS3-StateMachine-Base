package org.osflash.statemachine.core {
/**
 * The contract between concrete states and the StateMachine framework.
 */
public interface IState {
    /**
     * The name of the state
     */
    function get name():String;

    /**
     * the name of the transition the last getTarget method was passed
     */
    function get referringTransitionName():String;

    /**
     * Defines a transition.
     * A transition requires a name by which it will be invoked, and the name of the state to which the FSM will move
     * towards.
     * @param transitionName the name of the transition.
     * @param target the name of the target state to transition to.
     * @return the success of the operation.
     */
    function defineTrans(transitionName:String, target:String):Boolean;

    /**
     * Remove a previously defined transition.
     * @param transitionName the name of the transition.
     * @return the success of the operation.
     */
    function removeTrans(transitionName:String):Boolean;

    /**
     * Ascertains whether there is a transition defined for the specified name
     * @param transitionName the name of the transition.
     * @return
     */
    function hasTrans(transitionName:String):Boolean;

    /**
     * Get the target state name for a given action.
     * @param transitionName the name of the transition.
     * @return the target state's name.
     */
    function getTarget(transitionName:String):String;


    /**
     * Destroy method.
     */
    function destroy():void;

}
}