package org.osflash.statemachine.core {
public interface IFSMProperties {

    function get currentStateUID():UID;

    function get referringTransition():UID;

    function get isCurrentlyTransitioning():Boolean;

    function get transitionPhase( ):UID


}
}