package org.osflash.statemachine.core {


public interface IFSMController {

    function pushTransition( transition:String, payload:Object = null ):void;
     function transition(  ):void;
      function flushQueuedTransitions():void;
    function cancelStateTransition( reason:String ):void;


}
}