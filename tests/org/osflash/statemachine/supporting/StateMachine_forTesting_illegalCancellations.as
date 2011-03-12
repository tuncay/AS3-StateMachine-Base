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

public class StateMachine_forTesting_illegalCancellations extends BaseStateMachine {

    public const REASON:String = "forTestingPurposes";

    public function StateMachine_forTesting_illegalCancellations( model:IStateModel ) {
        super( model );
    }


    override protected function onTransition(target:IState, payload:Object):void {
       cancelStateTransition(REASON);
    }

    override protected function get isTransitionLegal():Boolean {
        return true;
    }

    override protected function get isCancellationLegal():Boolean {
        return false;
    }
}
}
