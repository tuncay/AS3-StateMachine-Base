package org.osflash.statemachine.errors {

import org.osflash.statemachine.uids.IUID;

public class BaseStateError extends Error {

    public function BaseStateError( msg:String ) {
        super( msg );
    }


    public function injectMsgWith( value:*, keyword:String = null ):BaseStateError {
        if ( value is IUID ) {
            injectMsgWithIUID( IUID( value ), keyword );
        } else {
            injectMessageWithToken( keyword, value );
        }

        return this;
    }

    private function injectMsgWithIUID( value:IUID, keyword:String = null ):BaseStateError {
        injectMessageWithToken( keyword || value.type, value.toString() );
        return this;
    }

    public function injectMessageWithToken( keyword:String, replace:String ):void {
        const regexp:RegExp = new RegExp( "\\$\\{(" + keyword + ")\\}", "g" );
        message = message.replace( regexp, replace );
    }
}
}