package org.osflash.statemachine.model {


public class TransitionQueue {

    private var _queue:Vector.<TransitionBinding>;

    public function TransitionQueue() {
        flush();
    }

    public function get hasNext():Boolean {
        return ( _queue.length != 0 );
    }

    public function enqueueTransition( transitionName:String, payload:Object ):void {
        _queue.push( new TransitionBinding( transitionName, payload ) );
    }

    public function dequeueTransition():TransitionBinding {
        return  _queue.shift();
    }

    public function flush():void {
        _queue = new Vector.<TransitionBinding>;
    }
}
}
