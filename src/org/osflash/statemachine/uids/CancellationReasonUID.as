/**
 * User: revisual.co.uk
 * Date: 24/06/11
 * Time: 09:55
 */
package org.osflash.statemachine.uids {
import org.osflash.statemachine.uids.BaseUID;

public class CancellationReasonUID extends BaseUID {

    public static const TYPE:String = "reason";

    public function CancellationReasonUID( name:String, index:int = -1 ) {
       super( name, TYPE, index );
    }

}
}
