package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.object.isTrue;
import org.osflash.statemachine.uids.flushUIDs;

public class TransitionQueueTest {

    private var transitionQueue:TransitionQueue;

    [Before]
    public function before():void {

        transitionQueue = new TransitionQueue();
    }

    [After]
    public function after():void {
        transitionQueue = null;
        flushUIDs();
    }


    [Test]
    public function calling_hasNext_when_empty_returns_false():void {
        assertThat( transitionQueue.hasNext, isTrue() );
    }


}
}
