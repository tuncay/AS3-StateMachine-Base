package org.osflash.statemachine.model {
import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.transitioning.Payload;

public class TransitionBinding {

    private var _transition:UID;
    private var _payload:IPayload;


    public function TransitionBinding( transition:UID, body:Object ) {
        _transition = transition;
        if ( body is IPayload ) {
            _payload = IPayload( body );
        } else {
            _payload = new Payload( body );
        }
    }

    public function get transition():UID {
        return _transition;
    }

    public function get payload():IPayload {
        return _payload;
    }
}
}