/**
 * User: revisual.co.uk
 * Date: 24/06/11
 * Time: 09:55
 */
package org.osflash.statemachine.uids {

public final class StateProcessUID extends BaseUID {

    public static const TYPE:String = "process";

    public function StateProcessUID( name:String, index:int = -1 ) {
        super( name, TYPE, index );
    }

}
}
