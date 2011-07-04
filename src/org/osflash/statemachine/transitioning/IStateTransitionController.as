package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.core.*;

public interface IStateTransitionController extends IFSMController {

    function transitionToInitialState():void;

}
}