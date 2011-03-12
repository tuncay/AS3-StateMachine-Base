/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 16:39
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.base.BaseStateMachine;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModel;

public class StateMachine_forTesting_isTransitionValue_duringCancelledTransition extends BaseStateMachine {

    public const REASON:String = "forTestingPurposes";

    private var _isTransitioningValue_during_onTransition_Method:Boolean;
    private var _isTransitioningValue_during_dispatchGeneralStateCancelled_Method:Boolean;

    private var _was_onTransition_called:Boolean;
    private var _was_dispatchTransitionCancelled_called:Boolean;

    public function StateMachine_forTesting_isTransitionValue_duringCancelledTransition( model:IStateModel ) {
        super( model );
    }

    public function transitionToStateForTesting(target:IState):void {
        transitionToState(target);
    }

    public function expectedResultsFor_isTransitioning_duringTransition(during_onTransition:Boolean, during_dispatchGeneralStateCancelled:Boolean):Boolean {
        return  ( during_onTransition == _isTransitioningValue_during_onTransition_Method) &&
                ( during_dispatchGeneralStateCancelled == _isTransitioningValue_during_dispatchGeneralStateCancelled_Method)   &&
                _was_dispatchTransitionCancelled_called &&
                _was_onTransition_called;
    }

    override protected function onTransition(target:IState, payload:Object):void {
        _was_onTransition_called = true;
        _isTransitioningValue_during_onTransition_Method = isTransitioning;
        cancelStateTransition( REASON );
    }

    override protected function dispatchTransitionCancelled():void {
        _was_dispatchTransitionCancelled_called = true;
        _isTransitioningValue_during_dispatchGeneralStateCancelled_Method = isTransitioning;
    }

    override protected function get isCancellationLegal():Boolean {
        return true;
    }
}
}
