/**
 * User: revisual.co.uk
 * Date: 02/07/11
 * Time: 22:57
 */
package org.osflash.statemachine.base.supporting {
import org.osflash.statemachine.core.TransitionValidator;

public class GrumpyValidator implements TransitionValidator {

    public function validate( model:Object ):Boolean {
        return false;
    }
}
}
