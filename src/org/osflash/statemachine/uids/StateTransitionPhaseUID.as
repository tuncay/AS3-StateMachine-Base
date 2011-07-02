package org.osflash.statemachine.uids {
import org.osflash.statemachine.uids.BaseUID;

public class StateTransitionPhaseUID extends BaseUID {

    public static const NONE:StateTransitionPhaseUID = new StateTransitionPhaseUID( "none", 1 );

    public static const GLOBAL_CHANGED:StateTransitionPhaseUID = new StateTransitionPhaseUID( "globalChanged", 2 );

    public static const CANCELLED:StateTransitionPhaseUID = new StateTransitionPhaseUID( "cancelled", 4 );

    public static const TYPE:String = "transitionPhase";

    public function StateTransitionPhaseUID( name:String, index:int = -1) {
       super( name,  TYPE, index);

    }



    public override function equals( value:Object ):Boolean {

        if ( value is int )   {
            return ( value == index );
        }

        else {
            return super.equals( value );
        }

    }


}


}