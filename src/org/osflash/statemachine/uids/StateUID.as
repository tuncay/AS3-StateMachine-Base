/**
 * User: revisual.co.uk
 * Date: 24/06/11
 * Time: 09:55
 */
package org.osflash.statemachine.uids {
import org.osflash.statemachine.uids.BaseUID;

public class StateUID extends BaseUID {

    public static const TYPE:String = "state";

    public function StateUID( id:String, index:int = -1 ) {
       super( id, TYPE, index );
    }

}
}
