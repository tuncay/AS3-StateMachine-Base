package org.osflash.statemachine.core {

public interface TransitionController {

    function transition( transition:UID, payload:Object = null ):void

    function transitionToInitialState():void
}
}