package org.osflash.statemachine.core {

/**
 * The outward-facing contract between the StateMachine and the framework actors.
 */
public interface IFSMProperties {
    /**
     * The name of the current state.
     */
    function get currentStateName():String;

    /**
     * The name of the referring action.
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