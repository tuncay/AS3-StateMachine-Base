package org.osflash.statemachine.core {


public interface IFSMController {

    function transition( transition:String, payload:Object = null ):void;

    function cancelStateTransition( reason:String ):void;


}
}