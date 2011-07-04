/**
 * User: revisual.co.uk
 * Date: 04/07/11
 * Time: 17:23
 */
package org.osflash.statemachine.model {
import org.osflash.statemachine.model.TransitionBinding;
import org.osflash.statemachine.uids.IUID;

public class TransitionQueue {

    private var _queue:Array;

    public function TransitionQueue() {
        _queue = [];
    }

    public function get hasNext():Boolean {
        return ( _queue.length != 0 );
    }

    public function enqueueTransition( transition:IUID, payload:Object ):void {
        _queue.push( new TransitionBinding( transition, payload ) );
    }

    public function getNext():TransitionBinding {
        return TransitionBinding( _queue.shift() );
    }
}
}
