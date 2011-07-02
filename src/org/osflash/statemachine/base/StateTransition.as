/**
 * User: revisual.co.uk
 * Date: 02/07/11
 * Time: 18:21
 */
package org.osflash.statemachine.base {
import org.osflash.statemachine.core.TransitionPhase;

public class StateTransition {

    private var _transitionPhases:Array;

    public function StateTransition() {
        initialise();
    }

    protected  function initialise( ) :void{  }

    protected final function pushTransitionPhase( phase:TransitionPhase ):void{
        _transitionPhases.push( phase );
    }

    public function dispatchPhases( model:Object ):void {
        var n:int = 0;
        while ( n < _transitionPhases.length ) {
            const phase:TransitionPhase = TransitionPhase( _transitionPhases[n++] );
            const proceedWithTransition:Boolean = phase.process( model );
            if( !proceedWithTransition ) return;
        }
    }
}
}
