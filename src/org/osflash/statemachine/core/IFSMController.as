package org.osflash.statemachine.core {

	/**
	 * The outward-facing contract between the StateMachine and the framework actors.
	 */
	public interface IFSMController {
		/**
		 * The name of the current state.
		 */
		function get currentStateName():String;

		/**
		 * The name of the referring action.
		 */
		function get referringAction():String;

		/**
		 * Indicates whether the StateMachine is undergoing a transition cycle.
		 */
		function get isTransitioning():Boolean;

		/**
		 * The current phase of the transition cycle
		 * @see TransitionPhases
		 */
		function get transitionPhase():String;

		/**
		 * Sends an action to the StateMachine, precipitating a state transition.
		 * @param transitionName the name of the action.
		 * @param payload the data to be sent with the action.
		 */
		function changeState( transitionName:String, payload:Object = null ):void;

		/**
		 * Cancels the current transition.
		 *
		 * NB: A transitions can only be cancelled during the <strong>enteringGuard</strong> or <strong>exitingGuard</strong>
		 * phases of a transition.
		 * @param reason information regarding the reason for the cancellation
		 * @param payload the data to be sent to the <strong>cancelled </strong> phase.
		 */
		function cancelStateTransition( reason:String, payload:Object = null ):void;


	}
}