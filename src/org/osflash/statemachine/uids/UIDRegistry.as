package org.osflash.statemachine.uids {

import org.osflash.statemachine.errors.ErrorCodes;
import org.osflash.statemachine.errors.getError;

internal class UIDRegistry {

    internal static var NULL_UID:IUID;
    private static var _registry:Object;

    internal static function flushUIDs():void {
        _registry = {};
        NULL_UID = new BaseUID( null, null );
    }

    internal static function registerIUID( iuid:IUID ):void {
        if ( _registry == null ) {
            flushUIDs();
        }

        if ( hasUID( iuid.identifier ) ) {
            throw getError( ErrorCodes.NON_UNIQUE_IDENTIFIER ).injectMsgWith( iuid, "identifier" );
        } else {
            _registry[ iuid.identifier ] = iuid;
        }
    }

    internal static function getUIDFromIdentifier( name:String ):IUID {
        if ( hasUID( name ) ) {
            return IUID( _registry[ name ] );
        }
        return NULL_UID;
    }

    private static function hasUID( name:String ):Boolean {
        return (_registry[ name ] != null );
    }
}
}
