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

public class StateMachine_forTesting_releventMethodsAreCalled_duringTransition extends BaseStateMachine {

    private var _was_dispatchGeneralStateChanged_called:Boolean;
    private var _was_onTransition_called:Boolean;
    private var _was_dispatchTransitionCancelled_called:Boolean;
    private var _was_listenForStateChangeOnce_called:Boolean;

    public function StateMachine_forTesting_releventMethodsAreCalled_duringTransition( model:IStateModel ) {
        super( model );
    }

    public function wereRelevantMethodsCalled():Boolean{
        return (_was_onTransition_called) &&
                (_was_dispatchGeneralStateChanged_called) &&
                (!_was_dispatchTransitionCancelled_called ) &&
                (!_was_listenForStateChangeOnce_called );

    }

    override protected function get isTransitionLegal():Boolean {
        return true;
    }

    override protected function onTransition(target:IState, payload:Object):void {
        _was_onTransition_called = true;
    }

    override protected function dispatchGeneralStateChanged():void {
        _was_dispatchGeneralStateChanged_called = true;
    }

    override protected function dispatchTransitionCancelled():void {
        _was_dispatchTransitionCancelled_called = true;
    }

    override public function listenForStateChangeOnce(listener:Function):Function {
       _was_listenForStateChangeOnce_called = true ;
        return null;
    }
}
}
