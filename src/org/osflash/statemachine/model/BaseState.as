package org.osflash.statemachine.model {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.uids.getNullUID;

public class BaseState implements IState {

    protected var _transitions:Object = new Object();

    private var _uid:UID;

    public function BaseState( id:UID ):void {
        _uid = id;
    }

    public function get uid():UID {
        return _uid;
    }

    public function defineTransition( transitionUID:UID, target:UID ):Boolean {
        if ( hasTrans( transitionUID ) ) return false;
        _transitions[ transitionUID.identifier ] = target;
        return true;
    }

    public function hasTrans( transitionUID:UID ):Boolean {
        if ( _transitions == null ) return false;
        return ( _transitions[ transitionUID.identifier ] != null );
    }

    public function removeTrans( transitionUID:UID ):Boolean {
        const targetUID:UID = getTarget( transitionUID );
        if ( targetUID.equals( getNullUID() ) ) return false;
        delete _transitions[ transitionUID.identifier ];
        return true;
    }

    public function getTarget( transitionUID:UID ):UID {
        const returnUID:UID = _transitions[ transitionUID.identifier ];
        return (returnUID == null ) ? getNullUID() : returnUID;
    }

    public function dispose():void {
        _transitions = null;
    }
}
}