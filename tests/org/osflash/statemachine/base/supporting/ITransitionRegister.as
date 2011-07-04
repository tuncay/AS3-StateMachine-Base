package org.osflash.statemachine.base.supporting {

import org.osflash.statemachine.uids.IUID;

public interface ITransitionRegister {

    function setTransition( transition:IUID ):void

    function setPayload( payload:Object ):void

    function setReason( reason:IUID ):void;
}
}
