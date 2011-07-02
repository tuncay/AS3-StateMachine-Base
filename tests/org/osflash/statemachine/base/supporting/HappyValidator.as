/**
 * User: revisual.co.uk
 * Date: 02/07/11
 * Time: 22:48
 */
package org.osflash.statemachine.base.supporting {
import org.osflash.statemachine.core.TransitionValidator;

public class HappyValidator implements TransitionValidator {

    public function validate( model:Object ):Boolean {
        return true;
    }
}
}
