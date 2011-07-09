package org.osflash.statemachine.decoding {


public interface IDataValidator {

    function set data( value:Object ):void;

    function validate():Object;

}
}