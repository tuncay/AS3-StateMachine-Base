/**
 * User: revisual.co.uk
 * Date: 29/06/11
 * Time: 15:13
 */
package org.osflash.statemachine.uids {
import org.osflash.statemachine.uids.IUID;

public function getUIDFromIdentifier( id:String):IUID {
        return BaseUID.getUIDFromIdentifier( id );
    }

}
