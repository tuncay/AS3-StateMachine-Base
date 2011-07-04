/**
 * User: revisual.co.uk
 * Date: 01/07/11
 * Time: 15:07
 */
package org.osflash.statemachine.transitioning {

public interface ITransitionPhase {
    function process( model:Object ):Boolean;
}
}
