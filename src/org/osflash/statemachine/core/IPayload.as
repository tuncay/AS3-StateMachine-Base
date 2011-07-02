/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 17/03/11
 * Time: 21:05
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.core {

/**
 * Contract for transition payload object.
 * All payloads sent via a transition will be wrapped by an IPayload internally.
 * This stops null values being thrown around the place
 */
public interface IPayload {

    /**
     * The transit object
     */
    function get body():Object;

    function setBody( body:Object ):void;

    /**
     * Indicates whether the body is a null value.
     */
    function get isNull():Boolean;

    /**
     * Performs a test to see whether the object passed is equal to its body.
     * If an IPayload is passed as the value, then first it tests strict equality
     * with itself, then if that fails, it tests if both IPayload bodys asre strictly equal
     * @param value The Object to be tested
     * @return whether the object is equal to the IPyload object, or its body
     */
    function equals( value:Object ):Boolean;


}
}
