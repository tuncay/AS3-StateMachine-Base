package org.osflash.statemachine.uids {

internal class BaseUID implements IUID {

    public static var delimiter:String = "/";

    private var _id:String;
    private var _type:String;
    private var _index:int;
    private var _identifier:String;

    public function BaseUID( id:String, type:String, index:int = -1 ) {
        _id = id;
        _type = type;
        _index = index;
    }


    public function get identifier():String {
        return _identifier || ( _identifier = _type + delimiter + _id );
    }

    public function get type():String {
        return _type;
    }

    public function get index():int {
        return _index;
    }

    public function toString():String {
        return identifier;
    }

    public function get isNull():Boolean {
        return ( _id == null );
    }

    public function equals( value:Object ):Boolean {
        if ( value is IUID ) {
            return ( IUID( value ).identifier == this.identifier );
        }
        if ( value is String ) {
            return ( String( value ) == this.identifier );
        }
        return false;
    }
}
}
