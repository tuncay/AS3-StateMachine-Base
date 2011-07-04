/**
 * User: revisual.co.uk
 * Date: 24/06/11
 * Time: 09:53
 */
package org.osflash.statemachine.uids {
public interface IUID {

    function get identifier():String;
    function get index():int;
    function get type():String;
    function get isNull():Boolean;
    function toString():String;
    function equals( value:Object ):Boolean;

}
}
