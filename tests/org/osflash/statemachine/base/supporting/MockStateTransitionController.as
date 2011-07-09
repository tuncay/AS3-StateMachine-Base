package org.osflash.statemachine.base.supporting {

import org.osflash.statemachine.supporting.IResultsRegistry;
import org.osflash.statemachine.transitioning.ITransitionController;

public class MockStateTransitionController implements ITransitionController {

    private var _register:IResultsRegistry;

    public function MockStateTransitionController( register:IResultsRegistry ) {
        _register = register;
    }

    public function transition( transition:String, payload:Object = null ):void {
        _register.pushResult( "TC:T(" + transition.toString() + "):PL(" + payload.toString() + ")" )
    }

    public function transitionToInitialState():void {
        _register.pushResult( "TC:T2IS" );
    }

    public function cancelStateTransition( reason:String ):void {
        _register.pushResult( "TC:R(" + reason.toString() + ")" );
    }

}
}
