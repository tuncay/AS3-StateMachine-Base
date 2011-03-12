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
import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.core.IStateModel;
import org.osflash.statemachine.core.ITransitionPhase;

public class StateMachine_forTesting_isTransitionValue_duringTransition extends BaseStateMachine {

    private var _isTransitioningValue_during_onTransition_method:Boolean;
    private var _isTransitioningValue_during_dispatchGeneralStateChanged_method:Boolean;

    private var _was_onTransition_called:Boolean;
    private var _was_dispatchGeneralStateChanged_called:Boolean;

    public function StateMachine_forTesting_isTransitionValue_duringTransition( model:IStateModel ) {
        super( model );
    }

    public function transitionToStateForTesting(target:IState):void {
        transitionToState(target);
    }

    public function expectedResultsFor_isTransitioning_duringTransition(during_onTransition:Boolean, during_dispatchGeneralStateChanged:Boolean):Boolean {
        return  ( during_onTransition == _isTransitioningValue_during_onTransition_method) &&
                ( during_dispatchGeneralStateChanged == _isTransitioningValue_during_dispatchGeneralStateChanged_method)  &&
                _was_onTransition_called && _was_dispatchGeneralStateChanged_called;
    }

    override protected function onTransition(target:IState, payload:Object):void {
        _was_onTransition_called = true;
        _isTransitioningValue_during_onTransition_method = isTransitioning;
    }

    override protected function dispatchGeneralStateChanged():void {
        _was_dispatchGeneralStateChanged_called = true;
        _isTransitioningValue_during_dispatchGeneralStateChanged_method = isTransitioning;
    }
}
}
