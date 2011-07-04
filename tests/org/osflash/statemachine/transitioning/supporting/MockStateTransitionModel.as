/**
 * User: revisual.co.uk
 * Date: 04/07/11
 * Time: 14:18
 */
package org.osflash.statemachine.transitioning.supporting {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.model.IStateTransitionModel;
import org.osflash.statemachine.uids.IUID;

public class MockStateTransitionModel implements IStateTransitionModel {

    public var currentState:IState;

    private var _registry:IResultsRegistry;
    private var _transitions:Array = [];

    public function MockStateTransitionModel( registry:IResultsRegistry, transitions:Array ) {
        _registry = registry;
        if ( transitions != null ) {
           _transitions = transitions;
        }
    }

    public function get hasNextTransition():Boolean {
        _registry.pushResult( "IStateTransitionModel.hasNextTransition()" );
        return (_transitions.length != 0);
    }

    public function setInitialStateAsCurrent():void {
        _registry.pushResult( "IStateTransitionModel.setInitialStateAsCurrent()" );
    }

    public function addTransition( transition:IUID, payload:Object = null ):void {
        _transitions.push( {transition:transition, payload:payload} );
        _registry.pushResult( "IStateTransitionModel.enqueueTransition(" + transition.toString() + "," + payload.toString() + ")" );
    }

    public function addReasonForCancellation( reason:IUID, payload:Object = null ):void {
        _registry.pushResult( "IStateTransitionModel.addReasonForCancellation(" + reason.toString() + "," + payload.toString() + ")" );
    }

    public function dequeueNextTransition():void {
        const o:Object =  _transitions.shift();
        _registry.pushResult( "IStateTransitionModel.dequeueNextTransition()::" + o.transition.toString() + "," + o.payload.toString() );

    }

    public function reset():void {
        _registry.pushResult( "IStateTransitionModel.reset()" );
    }

    public function get currentStateUID():IUID {
        return null;
    }

    public function get referringTransition():IUID {
        return null;
    }

    public function get transitionPhase():IUID {
        return null;
    }
}
}
