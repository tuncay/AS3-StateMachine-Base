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
 * Optional Null Object wrapper if you don't want null values
 * to be thrown around the place
 */
public interface IPayload {

    /**
     * The transit object
     */
    function get body():Object;

    /**
     * Indicates whether the body is a null value.
     */
    function get isNull():Boolean;


}
}
