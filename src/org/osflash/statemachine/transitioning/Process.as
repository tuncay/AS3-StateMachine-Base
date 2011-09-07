package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IProcess;
import org.osflash.statemachine.transitioning.Payload;

public class Process implements IProcess {

    private var _fsmController:IFSMController;
    private var _fsmProperties:IFSMProperties;

    private var _payload:IPayload;

    public function set fsmController( value:IFSMController ):void {
        _fsmController = value;
    }

    public function set fsmProperties( value:IFSMProperties ):void {
        _fsmProperties = value;
    }

    public function start( payload:Object = null ):void {
        _payload = new Payload( payload );
        _fsmController.flushQueuedTransitions();
        configureProcess( _fsmProperties );
        _fsmController.transition();
    }

    public function get currentStateName():String {
        return _fsmProperties.currentStateName;
    }

    public function get referringTransition():String {
        return _fsmProperties.referringTransition;
    }

    protected function configureProcess( fsmProperties:IFSMProperties ):void {
    }

    public final function pushTransition( transitionName:String ):void {
        _fsmController.pushTransition( transitionName, _payload );
    }

}
}
