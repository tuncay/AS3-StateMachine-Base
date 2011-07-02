package org.osflash.statemachine.core {
import org.osflash.statemachine.uids.StateUID;

public interface IState {

    function get uid():UID;

    function defineTransition( transitionID:UID, target:UID ):Boolean;

    function removeTrans(transitionName:UID):Boolean;

    function hasTrans(transitionName:UID):Boolean;

    function getTarget(transitionName:UID):UID;

    function dispose():void;

}
}