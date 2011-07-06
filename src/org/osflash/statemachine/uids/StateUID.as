
package org.osflash.statemachine.uids {

public final class StateUID extends BaseUID {

    public static const TYPE:String = "state";

    public function StateUID( id:String, index:int = -1 ) {
        super( id, TYPE, index );
    }
}
}
