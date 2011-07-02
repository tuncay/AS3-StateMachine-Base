package org.osflash.statemachine.base.supporting {
import org.osflash.statemachine.core.UID;

public interface ITransitionRegister {

    function setTransition( transition:UID ):void
    function setPayload( payload:Object ):void

    function setReason( reason:UID ):void;
}
}
