/**
 * User: revisual.co.uk
 * Date: 04/07/11
 * Time: 14:21
 */
package org.osflash.statemachine.transitioning.supporting {
import flash.utils.describeType;

import org.osflash.statemachine.model.IPhaseDispatcher;

public class MockPhaseDispatcher implements IPhaseDispatcher {

    private var _registry:IResultsRegistry;

    public function MockPhaseDispatcher( registry:IResultsRegistry ) {
        _registry = registry
    }

    public function dispatchPhases( model:Object ):void {
        const interfaceCheck:XMLList = describeType( model ).implementsInterface.( @type == "org.osflash.statemachine.model::IStateTransitionModel");
        var interfaceName:String;
        if ( interfaceCheck.length == 0 ) {
            interfaceName = "unexpectedType";
        } else {
            interfaceName = "IStateTransitionModel";
        }
        _registry.pushResult( "IPhaseDispatcher.dispatchPhases(" + interfaceName + ")" );

    }
}
}
