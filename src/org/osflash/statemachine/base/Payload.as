/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 18/03/11
 * Time: 09:33
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IPayload;

public class Payload implements IPayload {

    private var _body:Object;

    public function Payload( body:Object ) {
        _body = ( body is IPayload) ? IPayload( body ).body : body;
    }

    public function get body():Object {
        return _body;
    }

    public function get isNull():Boolean {
        return ( _body == null  );
    }

    public function equals( value:Object ):Boolean {
        if ( value is IPayload )
            return ( value === this ) ? true : (IPayload( value ).body === _body);
        else
            return ( value === _body );
    }
}
}
