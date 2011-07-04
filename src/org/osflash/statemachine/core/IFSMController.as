package org.osflash.statemachine.core {
import org.osflash.statemachine.uids.IUID;

public interface IFSMController {

    function transition( transition:IUID, payload:Object = null ):void;

    function cancelStateTransition( reason:IUID, payload:Object = null ):void;


}
}