package org.osflash.statemachine.errors {

/**

 */
public class BaseStateError extends Error {

    public function BaseStateError( msg:String ) {
        super( msg );
    }

    public function injectMessageWithToken( keyword:String, replace:String ):void {
        const regexp:RegExp = new RegExp( "\\$\\{(" + keyword + ")\\}", "g" );
        message = message.replace( regexp, replace );
    }
}
}