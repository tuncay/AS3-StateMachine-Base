package org.osflash.statemachine.core {
import org.osflash.statemachine.uids.IUID;

public interface IFSMProperties {

    function get currentStateUID():IUID;

    function get referringTransition():IUID;

    function get transitionPhase( ):IUID


}
}