package org.osflash.statemachine.core {

import org.osflash.statemachine.uids.IUID;

public interface IState {

    function get uid():IUID;

    function defineTransition( transitionID:IUID, target:IUID ):Boolean;

    function removeTrans( transitionName:IUID ):Boolean;

    function hasTrans( transitionName:IUID ):Boolean;

    function getTarget( transitionName:IUID ):IUID;

    function dispose():void;

}
}