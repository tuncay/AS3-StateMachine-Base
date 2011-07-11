package org.osflash.statemachine.transitioning.phases {

import org.osflash.statemachine.core.IStateLogger;
import org.osflash.statemachine.model.IPhaseModel;
import org.osflash.statemachine.uids.IUID;

public class BaseTransitionPhase implements ITransitionPhase {

    protected var _model:IPhaseModel;
    protected var _logger:IStateLogger;
    protected var _cancel:Boolean;

    public function BaseTransitionPhase() {
    }

    public function set model( value:IPhaseModel ):void {
        _model = value;
    }

    public function set logger( value:IStateLogger ):void {
        _logger = value;
    }

   protected function cancelTransition():void{
        _cancel = true;
   }

    public function dispatch():Boolean {

            return !_cancel;
    }
}
}
