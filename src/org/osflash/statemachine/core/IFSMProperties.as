package org.osflash.statemachine.core {
public interface IFSMProperties {

    function get currentStateUID():IUID;

    function get referringTransition():IUID;

    function get transitionPhase( ):IUID


}
}