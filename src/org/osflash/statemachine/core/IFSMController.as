package org.osflash.statemachine.core {
public interface IFSMController {

    function transition( transition:IUID, payload:Object = null ):void;

    function cancelStateTransition( reason:IUID, payload:Object = null ):void;


}
}