/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 31/01/11
 * Time: 16:13
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.core {

/**
 * Contract for enumbs that describe a transition phase
 */
public interface ITransitionPhase {

    /**
     * The name of the phase
     */
    function get name():String;

    /**
     * The index of the phase, this must be a binary placeholder, as this value
     * is used for bit masking
     */
    function get index():int;

    /**
     * Performs a test to see if the object equals the value passed.
     * <li>if the value is a String it is tested against the name property</li>
     * <li>if the value is an int it is tested against the index property</li>
     * <li>if the value is an ITransitionPhase it is tested strictly against this</li>
     * @param value either a ITransitionPhase, an int or a String
     * @return
     */
    function equals(value:Object):Boolean;
}
}