/**
 * User: revisual.co.uk
 * Date: 04/07/11
 * Time: 14:18
 */
package org.osflash.statemachine.transitioning.supporting {

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.ITransitionModel;
import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.uids.IUID;

public class MockStateTransitionModel implements ITransitionModel {

    public var currentState:IState;

    private var _registry:IResultsRegistry;
    private var _transitions:Array = [];

    public function MockStateTransitionModel( registry:IResultsRegistry, transitions:Array ) {
        _registry = registry;
        if ( transitions != null ) {
            _transitions = transitions;
        }
    }

    public function get hasTransition():Boolean {
        _registry.pushResult( "ISTM.hNT" );
        return (_transitions.length != 0);
    }

    public function setInitialStateAsTarget():void {
        _registry.pushResult( "ISTM.sISAC" );
    }

    public function addTransition( transition:String, payload:Object = null ):void {
        _transitions.push( {transition:transition, payload:payload} );
        _registry.pushResult( "ISTM.eT:" + transition.toString() + ":" + payload.toString() );
    }

    public function set cancellationReason( reason:String ):void {
        _registry.pushResult( "ISTM.aRFC:" + reason.toString() );
    }

    public function dequeueTransition():void {
        const o:Object = _transitions.shift();
        _registry.pushResult( "ISTM.dNT:" + o.transition.toString() + ":" + o.payload.toString() );

    }

    public function reset():void {
        _registry.pushResult( "ISTM.r" );
    }

    public function get currentStateName():String {
        return null;
    }

    public function get referringTransition():String {
        return null;
    }

    public function get transitionPhase():IUID {
        return null;
    }

    public function flushQueuedTransitions():void {
    }
}
}
