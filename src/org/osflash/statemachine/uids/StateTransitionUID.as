
package org.osflash.statemachine.uids {

public final class StateTransitionUID extends BaseUID {

    public static const TYPE:String = "transition";

    public function StateTransitionUID( name:String, index:int = -1 ) {
        super( name, TYPE, index );
    }
}
}
