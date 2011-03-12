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

public class StateMachine_forTesting_cancellationArguments extends BaseStateMachine {

    private var _reason:String;
    private var _cancellationPayload:Object;
    private var _wereArgumentsCached:Boolean;

    public function StateMachine_forTesting_cancellationArguments( model:IStateModel ) {
        super( model );
    }

    public function setCancellationArguments(reason:String, payload:Object):void {
        _reason = reason;
        _cancellationPayload = cachedPayload;
    }

    public function get wereArgumentsCached(  ):Boolean {
        return _wereArgumentsCached
    }

    override protected function get isTransitionLegal():Boolean {
        return true;
    }
    override protected function get isCancellationLegal():Boolean {
        return true;
    }

    override protected function dispatchTransitionCancelled():void {
         _wereArgumentsCached =  (_reason == cachedInfo) && ( _cancellationPayload === cachedPayload);
    }

    override protected function onTransition(target:IState, payload:Object):void {
       cancelStateTransition( _reason, _cancellationPayload)
    }
}
}
