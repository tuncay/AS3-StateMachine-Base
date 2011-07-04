
package org.osflash.statemachine.uids {

import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.errors.UIDError;

internal class BaseUID implements IUID {

    internal static const NULL_UID:IUID = new BaseUID( null, null );

    private static var _registry:Array;
    public static var delimiter:String = "/";

    private var _id:String;
    private var _type:String;

    private var _index:int;

    public function BaseUID( id:String, type:String, index:int = -1 ) {
        _id = id;
        _type = type;
        _index = index;
        registerIUID( this );
    }
    internal static function flushUIDs(  ):void {
       _registry = [];
    }

    internal static function getUIDFromIdentifier( name:String ):IUID {
        if( hasUID( name ) )
            return IUID(  _registry[ name ] );
        return NULL_UID;
    }
    private function registerIUID( iuid:IUID):void{
        if( _registry == null )
            flushUIDs();
        if( hasUID( iuid.identifier ) )
            throw new UIDError( UIDError.NON_UNIQUE_IDENTIFIER + iuid.identifier );
        else
            _registry[ iuid.identifier ] = iuid;

    }

    private static function hasUID( name:String ):Boolean {
    return (_registry[ name ] != null );
}

    public function get identifier():String {
        return _type + delimiter + _id;
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
        if( value is String ){
            return ( String( value ) == this.identifier );
        }
        return false;
    }
}
}
