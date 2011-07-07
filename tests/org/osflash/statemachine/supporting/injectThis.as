/**
 * User: revisual.co.uk
 * Date: 30/06/11
 * Time: 09:31
 */
package org.osflash.statemachine.supporting {

    public function injectThis( value:String):ITokenInjector {
        return new InjectTokenIntoString( value );
    }

}
