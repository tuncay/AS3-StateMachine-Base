package org.osflash.statemachine.errors {

public class ErrorMap {
    private static const _errorBindings:ErrorBindingsList = new ErrorBindingsList();

    public function getError( code:int ):BaseStateError {
        return _errorBindings.getErrorBinding( code ).getError();
    }

    public function getErrorMessage( code:int ):String {
        return _errorBindings.getErrorBinding( code ).getMessage();
    }

}
}
