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

public class MockStateMachineForTesting_isTransitionValue_duringTransition extends BaseStateMachine {

    private var _isTransitioningValue_during_onTransition_Method:Boolean;
    private var _isTransitioningValue_during_dispatchGeneralStateChanged_Method:Boolean;

    public function MockStateMachineForTesting_isTransitionValue_duringTransition(model:IStateModel, logger:IStateLogger = null) {
        super(model, logger);
    }

    public function transitionToStateForTesting(target:IState):void {
        transitionToState(target);
    }

    public function expectedResultsFor_isTransitioning_duringTransition(during_onTransition:Boolean, during_dispatchGeneralStateChanged:Boolean):Boolean {
        return  ( during_onTransition == _isTransitioningValue_during_onTransition_Method) &&
                ( during_dispatchGeneralStateChanged == _isTransitioningValue_during_dispatchGeneralStateChanged_Method)
    }

    override protected function onTransition(target:IState, payload:Object):void {
        _isTransitioningValue_during_onTransition_Method = isTransitioning;
    }

    override protected function dispatchGeneralStateChanged():void {
        _isTransitioningValue_during_dispatchGeneralStateChanged_Method = isTransitioning;
    }
}
}
