package org.osflash.statemachine.supporting {

public interface ITokenInjector {
    function withThis( keyword:String, replace:* ):ITokenInjector
    function finallyWith( keyword:String, replace:* ):String
    function toString():String;
}
}
