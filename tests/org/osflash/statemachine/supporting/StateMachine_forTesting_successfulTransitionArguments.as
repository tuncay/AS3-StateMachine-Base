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

public class StateMachine_forTesting_successfulTransitionArguments extends BaseStateMachine {

    private var _payload:Object;
    private var _target:IState;

    public function StateMachine_forTesting_successfulTransitionArguments( model:IStateModel ) {
        super( model );
    }

    public function wereArgumentsPassedCorrectlyTo_onTransitionMethod( state:IState, payload:Object ):Boolean {
        return (state === _target) && ( payload === _payload);
    }

    override protected function get isTransitionLegal():Boolean {
        return true;
    }

    override protected function onTransition(target:IState, payload:Object):void {
       _target = target;
        _payload = payload;
    }
}
}
