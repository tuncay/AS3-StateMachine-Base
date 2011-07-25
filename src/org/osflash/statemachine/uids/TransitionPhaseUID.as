package org.osflash.statemachine.uids {

public class TransitionPhaseUID extends BaseUID {

    public static const NONE:TransitionPhaseUID = new TransitionPhaseUID( "none", 1 );

    public static const CANCELLED:TransitionPhaseUID = new TransitionPhaseUID( "cancelled", 2 );

    public static const TYPE:String = "phase";

    public function TransitionPhaseUID( name:String, index:int = -1 ) {
        super( name, TYPE, index );
    }

    public override function equals( value:Object ):Boolean {

        if ( value is int ) {
            return ( value == index );
        } else {
            return super.equals( value );
        }
    }
}
}