package org.osflash.statemachine.core {

public interface StateTransitionController {

    function transition( transition:UID, payload:Object = null ):void

    function transitionToInitialState():void
}
}