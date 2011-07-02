/**
 * User: revisual.co.uk
 * Date: 30/06/11
 * Time: 09:31
 */
package org.osflash.statemachine.supporting {

public function injectToken( value:String,  keyword:String, replace:String ):String {
        const regexp:RegExp = new RegExp( "\\$\\{(" + keyword + ")\\}", "g" );
        return  value.replace( regexp, replace );
    }

}
