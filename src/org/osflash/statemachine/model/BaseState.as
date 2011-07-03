package org.osflash.statemachine.model {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IUID;
import org.osflash.statemachine.uids.getNullUID;

public class BaseState implements IState {

    protected var _transitions:Object = new Object();

    private var _uid:IUID;

    public function BaseState( id:IUID ):void {
        _uid = id;
    }

    public function get uid():IUID {
        return _uid;
    }

    public function defineTransition( transitionUID:IUID, target:IUID ):Boolean {
        if ( hasTrans( transitionUID ) ) return false;
        _transitions[ transitionUID.identifier ] = target;
        return true;
    }

    public function hasTrans( transitionUID:IUID ):Boolean {
        if ( _transitions == null ) return false;
        return ( _transitions[ transitionUID.identifier ] != null );
    }

    public function removeTrans( transitionUID:IUID ):Boolean {
        const targetUID:IUID = getTarget( transitionUID );
        if ( targetUID.equals( getNullUID() ) ) return false;
        delete _transitions[ transitionUID.identifier ];
        return true;
    }

    public function getTarget( transitionUID:IUID ):IUID {
        const returnUID:IUID = _transitions[ transitionUID.identifier ];
        return (returnUID == null ) ? getNullUID() : returnUID;
    }

    public function dispose():void {
        _transitions = null;
    }
}
}