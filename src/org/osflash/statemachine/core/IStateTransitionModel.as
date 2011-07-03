
package org.osflash.statemachine.core {

public interface IStateTransitionModel extends IFSMProperties {

    function get hasNextTransition ():Boolean;
    function setInitialStateAsCurrent():void;
    function enqueueTransition( transition:IUID, payload:Object = null ):void;
     function cancelTransition( reason:IUID, payload:Object = null ):void;
    function discardUndefinedTransition():Boolean;
    function shiftNextTransition():void
    function reset():void;
}
}
