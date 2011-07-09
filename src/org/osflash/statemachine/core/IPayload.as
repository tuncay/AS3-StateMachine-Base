package org.osflash.statemachine.core {

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
