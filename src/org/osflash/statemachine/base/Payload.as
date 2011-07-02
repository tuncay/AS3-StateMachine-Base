
package org.osflash.statemachine.base {

import org.osflash.statemachine.core.IPayload;

public class Payload implements IPayload {

    private var _body:Object;

    public function Payload( body:Object ) {
       setBodyFromObject( body );
    }

    public function get body():Object {
        return _body;
    }

    public function get isNull():Boolean {
        return ( _body == null  );
    }

    public function setBody( body:Object ):void{
        setBodyFromObject( body );
    }

    public function equals( value:Object ):Boolean {
        if ( value is IPayload )
            return ( value === this ) ? true : (IPayload( value ).body === _body);
        else
            return ( value === _body );
    }

    private function setBodyFromObject( body:Object ):void{
          _body = ( body is IPayload) ? IPayload( body ).body : body;
    }
}
}
