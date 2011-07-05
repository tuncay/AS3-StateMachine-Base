package org.osflash.statemachine.model {

import org.osflash.statemachine.core.*;
import org.osflash.statemachine.uids.IUID;

public interface ITransitionModel extends IFSMProperties {

    function get hasTransition():Boolean;

    function set cancellationReason( reason:IUID ):void;

    function setInitialStateAsCurrent():void;

    function addTransition( transition:IUID, payload:Object = null ):void;

    function dequeueTransition():void

    function reset():void;
}
}
