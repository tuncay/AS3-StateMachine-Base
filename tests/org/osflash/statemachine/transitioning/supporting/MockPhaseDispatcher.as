/**
 * User: revisual.co.uk
 * Date: 04/07/11
 * Time: 14:21
 */
package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.transitioning.IPhaseDispatcher;

public class MockPhaseDispatcher implements IPhaseDispatcher {

    private var _registry:IResultsRegistry;

    public function MockPhaseDispatcher( registry:IResultsRegistry ) {
        _registry = registry
    }

    public function dispatchPhases(  ):void {

        _registry.pushResult( "IPhaseDispatcher.dispatchPhases()" );

    }
}
}
