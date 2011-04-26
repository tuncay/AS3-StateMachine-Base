package org.osflash.statemachine.transitioning {
import org.osflash.statemachine.core.ITransitionPhase;

/**
 * A Base Class for the enumeration of TransitionPhases
 */
public class TransitionPhase implements ITransitionPhase {

    /**
     * Represents a NULL transition phase, ie, no state transition is currently occuring
     */
    public static const NONE:TransitionPhase = new TransitionPhase( "none", 1 );

    public static const GLOBAL_CHANGED:ITransitionPhase = new TransitionPhase( "globalChanged", 2 );

    public static const CANCELLED:ITransitionPhase = new TransitionPhase( "cancelled", 4 );

    /**
     * Creates a new instance
     * @param name  the name of the transition phase
     * @param index  a unique binary-placeholder
     */
    public function TransitionPhase( name:String, index:int ) {
        _name = name;
        _index = index;
    }

    /**
     *  @private
     */
    private var _name:String;

    /**
     *  @inheritDoc
     */
    public function get name():String {
        return _name;
    }

    /**
     * @private
     */
    private var _index:int;

    /**
     *  @inheritDoc
     */
    public function get index():int {
        return _index;
    }

    /**
     *  @inheritDoc
     */
    public function equals( value:Object ):Boolean {
        if ( value is ITransitionPhase )
            return ( value === this ) ? true : (ITransitionPhase( value ).index == _index && ITransitionPhase( value ).name == _name);
        else if ( value is int )
            return ( value == _index );
        else if ( value is String )
            return ( value == _name );

        return false;
    }

}


}