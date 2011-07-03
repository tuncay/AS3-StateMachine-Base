/**
 * User: revisual.co.uk
 * Date: 02/07/11
 * Time: 18:21
 */
package org.osflash.statemachine.transitioning {
import org.osflash.statemachine.core.TransitionPhase;
import org.osflash.statemachine.errors.StateTransitionError;

public class StateTransition {

    private var _transitionPhases:Array;

    public function StateTransition() {
        initialise();
    }

    protected function initialise():void {
    }

    public final function pushTransitionPhase( phase:TransitionPhase ):void {
        if ( _transitionPhases == null )_transitionPhases = [];
        _transitionPhases.push( phase );
    }

    public function dispatchPhases( model:Object ):void {
        if ( _transitionPhases == null || _transitionPhases.length == 0 ) {
            throw new StateTransitionError( StateTransitionError.NO_PHASES_HAVE_BEEN_PUSHED_TO_STATE_TRANSITION );
        }
        var n:int = 0;
        while ( n < _transitionPhases.length ) {
            const phase:TransitionPhase = TransitionPhase( _transitionPhases[n++] );
            const proceedWithTransition:Boolean = phase.process( model );
            if ( !proceedWithTransition ) break;
        }
    }
}
}
