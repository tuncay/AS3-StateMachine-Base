/**
 * User: revisual.co.uk
 * Date: 01/07/11
 * Time: 15:07
 */
package org.osflash.statemachine.core {
import org.osflash.statemachine.model.TransitionModel;

public interface TransitionPhase {
      function process( model:Object ):Boolean;
}
}
