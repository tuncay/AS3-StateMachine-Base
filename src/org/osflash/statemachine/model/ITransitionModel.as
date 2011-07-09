package org.osflash.statemachine.model {

import org.osflash.statemachine.core.*;

public interface ITransitionModel extends IFSMProperties {

    function get hasTransition():Boolean;

    function set cancellationReason( reason:String ):void;

    function setInitialStateAsCurrent():void;

    function addTransition( transition:String, payload:Object = null ):void;

    function dequeueTransition():void

    function reset():void;
}
}
