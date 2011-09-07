
package org.osflash.statemachine.core {

public interface IProcess {

    function set fsmController( value:IFSMController ):void

    function start( payload:Object = null ):void;
}
}
