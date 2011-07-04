/**
 * User: revisual.co.uk
 * Date: 02/07/11
 * Time: 22:28
 */
package org.osflash.statemachine.base.supporting {

import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.getNullUID;

public class MockStateTransitionModel implements IFSMProperties {

    private var _register:ITransitionRegister;

    public function MockStateTransitionModel( register:ITransitionRegister ) {
        _register = register;
    }

    public function get transitionPhase():IUID {
        return getNullUID();
    }


    public function get currentStateUID():IUID {
        return null;
    }

    public function get referringTransition():IUID {
        return null;
    }
}
}
