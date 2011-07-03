package org.osflash.statemachine.model {
import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IUID;
import org.osflash.statemachine.transitioning.Payload;

public class TransitionBinding {

    private var _transition:IUID;
    private var _payload:IPayload;


    public function TransitionBinding( transition:IUID, body:Object ) {
        _transition = transition;
        if ( body is IPayload ) {
            _payload = IPayload( body );
        } else {
            _payload = new Payload( body );
        }
    }

    public function get transition():IUID {
        return _transition;
    }

    public function get payload():IPayload {
        return _payload;
    }
}
}