package org.osflash.statemachine.core {

/**
	 * The inward-facing interface between the FSMController and the
	 * SignalTransitionController
	 */
	public interface IFSMControllerOwner {

		function get hasChangedListener(  ):Boolean;

		/**
		 * Allows the SignalTransitionController to listen to framework action requests.
		 * @param listener the method to handle the action request
		 * @return the listener Function passed as the parameter
		 */
		function listenForIncomingCalls( listener:Function ):Function;

		/**
		 * Dispatches the general <strong>changed</strong> phase to all framework
		 * listeners.
		 * @param state the current state.
		 */
		function dispatchStateChange( stateName:String ):void;


		/**
		 * Sets the current state when the transition has been successful
		 * @param state the state that is to be the current state
		 */
		function setCurrentState( state:IState ):void;

		/**
		 * Sets whether the StateMachine is undergoing a transition cycle
		 */
		function setIsTransition( value:Boolean ):void;

		/**
		 * Sets the current phase of the transition cycle
		 * @see TransitionPhases
		 */
		function setTransitionPhase( value:ITransitionPhase ):void;

		/**
		 * Sets the referring action of the transition cycle
		 * @see TransitionPhases
		 */
		function setReferringTransition( value:String ):void;

		/**
		 * The destroy method for GC
		 */
		function destroy():void;
	}
}