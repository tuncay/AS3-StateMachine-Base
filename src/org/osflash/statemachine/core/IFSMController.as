package org.osflash.statemachine.core {
public interface IFSMController {

    function transition( transition:UID, payload:Object = null ):void;

    function cancelStateTransition( reason:UID, payload:Object = null ):void;


}
}