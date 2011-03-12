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

public class StateMachine_forTesting_modelReturningNullTargetState extends BaseStateMachine {

    private var _was_transitionToStateMethod_Called:Boolean = false;

    public function StateMachine_forTesting_modelReturningNullTargetState( model:IStateModel ) {
        super( model );
    }

    public function get wasTransitionToStateMethodCalled():Boolean {
        return _was_transitionToStateMethod_Called;
    }

    override protected function get isTransitionLegal():Boolean {
        return true;
    }

    override protected function transitionToState(target:IState, payload:Object = null):void {
       _was_transitionToStateMethod_Called = true;
    }
}
}
