package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.logging.logPhase;
import org.osflash.statemachine.model.IPhaseModel;
import org.osflash.statemachine.uids.IUID;

public class BaseTransitionPhase implements ITransitionPhase {

    private var _logCode:int;
    private var _continueTransition:Boolean;
    private var _model:IPhaseModel;

    public function BaseTransitionPhase() {
        _continueTransition = true;
    }

    public function set model( value:IPhaseModel ):void {
        _model = value;
    }

    public function set logger( value:int ):void {
        _logCode = value;
    }

    public function dispatch():Boolean {
        executePhase( _model );
        return _continueTransition;
    }

    private function setCurrentPhase( phase:IUID ):void {
        const state:IUID = _model.currentState.name;
        logPhase( _logCode, state, phase );
    }

    protected function executePhase( model:IPhaseModel ):void { }

    protected function cancelTransition():void {
        _continueTransition = false;
    }


}
}
