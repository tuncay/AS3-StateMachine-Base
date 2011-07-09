package org.osflash.statemachine.model {

import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.transitioning.Payload;

public class TransitionBinding {

    private var _transition:String;
    private var _payload:IPayload;


    public function TransitionBinding( transition:String, body:Object ) {
        _transition = transition;
        setBody( body );
    }

    private function setBody( body:Object ):void {
        if ( body is IPayload ) {
            _payload = IPayload( body );
        } else {
            _payload = new Payload( body );
        }
    }

    public function get transition():String {
        return _transition;
    }

    public function get payload():IPayload {
        return _payload;
    }

    public function toString():String {
        return transition + ":" + _payload.body.toString();
    }
}


}