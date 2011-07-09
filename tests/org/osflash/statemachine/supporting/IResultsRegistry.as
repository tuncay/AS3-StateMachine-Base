package org.osflash.statemachine.supporting {

public interface IResultsRegistry {
    function get got():String;

    function pushResult( value:Object ):void;
}
}
