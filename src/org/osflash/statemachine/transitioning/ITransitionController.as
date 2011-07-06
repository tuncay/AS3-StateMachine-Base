package org.osflash.statemachine.transitioning {

import org.osflash.statemachine.core.*;

public interface ITransitionController extends IFSMController {

    function transitionToInitialState():void;

}
}