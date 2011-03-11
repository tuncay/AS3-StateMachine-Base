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

public class MockStateMachine extends BaseStateMachine {


    public function MockStateMachine(model:IStateModel, logger:IStateLogger = null) {
        super(model, logger);
    }

    public function setCurrentStateForTesting(state:IState):void {
        currentState = state;
    }


    public function setTransitionPhaseForTesting(phase:ITransitionPhase):void {
        currentTransitionPhase = phase;
    }
}
}
