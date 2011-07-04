package org.osflash.statemachine.model {

import org.osflash.statemachine.core.*;
import org.osflash.statemachine.uids.IUID;

public interface IStateTransitionModel extends IFSMProperties {

    function get hasNextTransition():Boolean;

    function setInitialStateAsCurrent():void;

    function addTransition( transition:IUID, payload:Object = null ):void;

    function addReasonForCancellation( reason:IUID, payload:Object = null ):void;

    function dequeueNextTransition():void

    function reset():void;
}
}
