package org.osflash.statemachine.core {

public interface ITransitionValidator {

    function validate( model:IFSMProperties ):Boolean
}
}