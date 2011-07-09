package org.osflash.statemachine.base.supporting {

import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.uids.IUID;

public class MockStateTransitionModel implements IFSMProperties {

    private var _currentState:String;
    private var _transition:String;
    private var _phase:IUID;


    public function set transitionPhase( phase:IUID ):void {
        _phase = phase;
    }

    public function get transitionPhase():IUID {
        return _phase;
    }

    public function get currentStateName():String {
        return _currentState;
    }

    public function set currentStateUID( value:String ):void {
        _currentState = value;
    }

    public function get referringTransition():String {
        return _transition;
    }

    public function set referringTransition( value:String ):void {
        _transition = value;
    }
}
}
