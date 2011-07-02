/**
 * User: revisual.co.uk
 * Date: 01/07/11
 * Time: 15:07
 */
package org.osflash.statemachine.core {
import org.osflash.statemachine.base.TransitionModel;

public interface TransitionPhase {
    function set model( value:TransitionModel):void;
      function process( model:Object ):Boolean;
}
}
