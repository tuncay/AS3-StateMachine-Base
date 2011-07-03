/**
 * User: revisual.co.uk
 * Date: 02/07/11
 * Time: 22:57
 */
package org.osflash.statemachine.base.supporting {
import org.osflash.statemachine.core.IFSMProperties;
import org.osflash.statemachine.core.ITransitionValidator;

public class GrumpyValidator implements ITransitionValidator {

    public function validate( model:IFSMProperties ):Boolean {
        return false;
    }
}
}
