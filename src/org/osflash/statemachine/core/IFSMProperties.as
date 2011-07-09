package org.osflash.statemachine.core {

import org.osflash.statemachine.uids.IUID;

public interface IFSMProperties {

    function get currentStateName():String;

    function get referringTransition():String;

    function get transitionPhase():IUID


}
}