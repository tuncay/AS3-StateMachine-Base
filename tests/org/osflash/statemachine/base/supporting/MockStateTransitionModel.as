package org.osflash.statemachine.base.supporting {

import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.uids.IUID;

public class MockStateTransitionModel implements IFSMProperties {

    private var _currentState:IUID;
    private var _transition:IUID;
    private var _phase:IUID;


    public function set transitionPhase( phase:IUID ):void {
        _phase = phase;
    }

    public function get transitionPhase():IUID {
        return _phase;
    }

    public function get currentStateUID():IUID {
        return _currentState;
    }

    public function set currentStateUID( value:IUID ):void {
        _currentState = value;
    }

    public function get referringTransition():IUID {
        return _transition;
    }

    public function set referringTransition( value:IUID ):void {
        _transition = value;
    }
}
}
