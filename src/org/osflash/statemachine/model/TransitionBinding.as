package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.transitioning.Payload;
import org.osflash.statemachine.uids.IUID;

public class TransitionBinding {

    private var _uid:IUID;
    private var _payload:IPayload;


    public function TransitionBinding( transition:IUID, body:Object ) {
        _uid = transition;
        if ( body is IPayload ) {
            _payload = IPayload( body );
        } else {
            _payload = new Payload( body );
        }
    }

    public function get uid():IUID {
        return _uid;
    }

    public function get payload():IPayload {
        return _payload;
    }
}
}