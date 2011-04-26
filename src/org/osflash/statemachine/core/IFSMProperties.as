package org.osflash.statemachine.core {

/**
 * The outward-facing contract between the StateMachine and the framework actors,
 * allowing read only access to the FSM properties
 */
public interface IFSMProperties {
    /**
     *
     * The name of the current state.
     */
    function get currentStateName():String;

    /**
     * The name of the transition whicj referred the FSM to its current State.
     */
    function get referringTransitionName():String;

    /**
     * Indicates whether the StateMachine is undergoing a transition cycle.
     */
    function get isTransitioning():Boolean;

    /**
     * The current phase of the transition cycle
     * @see TransitionPhases
     */
    function get transitionPhase():ITransitionPhase;


}
}