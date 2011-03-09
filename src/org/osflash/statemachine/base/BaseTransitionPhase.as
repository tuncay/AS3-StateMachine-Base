package org.osflash.statemachine.base {
import org.osflash.statemachine.core.ITransitionPhase;

/**
 * A Base Class for the enumeration of TransitionPhases
 */
public class BaseTransitionPhase implements ITransitionPhase {

    /**
     * Creates a new instance
     * @param name  the name of the transition phase
     * @param index  a unique binary-placeholder
     */
    public function BaseTransitionPhase(name:String, index:int) {
        _name = name;
        _index = index;
    }

    /**
     *  @private
     */
    private var _name:String;

    /**
     * The name of the TransitionPhase
     */
    public function get name():String {
        return _name;
    }

    /**
     * @private
     */
    private var _index:int;

    /**
     * unique index for TransitionPhase
     * must be binary place-holder, as used for bit masking
     */
    public function get index():int {
        return _index;
    }

    /**
     *  Tests to see whether the passed value is considered equal to
     *  the TransitionPhase instance.
     * @param value  either a ITransitionPhase, an int or a String
     * @return
     */
    public function equals(value:Object):Boolean {
        if (value is ITransitionPhase)
            return ( value === this );
        else if (value is int)
            return ( value == _index );
        else if (value is String)
            return ( value == _name );

        return false;
    }

}


}