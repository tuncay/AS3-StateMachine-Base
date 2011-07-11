package org.osflash.statemachine.errors{

internal class ErrorBinding {

    private var _msg:String;
    private var _errorClass:Class;

    public function ErrorBinding( errorClass:Class, msg:String ) {
        _errorClass = errorClass;
        _msg = msg;
    }

    public function getMessage():String {
        return _msg;
    }

    public function getError():BaseStateError {
        return new _errorClass( _msg );
    }
}
}