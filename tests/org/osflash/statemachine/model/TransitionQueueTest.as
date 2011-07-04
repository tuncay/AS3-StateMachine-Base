package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.hasPropertyChain;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.uids.StateTransitionUID;
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
        assertThat( transitionQueue.hasNext, isFalse() );
    }

    [Test]
    public function calling_getNext_when_empty_returns_null():void {
        assertThat( transitionQueue.dequeueTransition(), nullValue() );
    }

    [Test]
    public function dequeuing_returns_TransitionBinding_with_enqueued_transitionUID_and_IPayload():void {
        enqueueSingleItem();
        assertThat( transitionQueue.dequeueTransition(),
        allOf(
        hasPropertyChain( "transition.identifier", strictlyEqualTo( "transition/testing_one" ) ),
        hasPropertyChain( "payload.body", strictlyEqualTo( "body_one" )
        ) ) );
    }

    [Test]
    public function queue_is_last_on_last_off():void {
        enqueueMultipleItems();
        transitionQueue.dequeueTransition();
        transitionQueue.dequeueTransition();
        assertThat( transitionQueue.dequeueTransition(),
        allOf(
        hasPropertyChain( "transition.identifier", equalTo( "transition/testing_three" ) ),
        hasPropertyChain( "payload.body", strictlyEqualTo( "body_three" )
        ) ) );
    }

    private function enqueueSingleItem():void {
        transitionQueue.enqueueTransition( new StateTransitionUID( "testing_one" ), "body_one" );
    }

    private function enqueueMultipleItems():void {
        transitionQueue.enqueueTransition( new StateTransitionUID( "testing_one" ), "body_one" );
        transitionQueue.enqueueTransition( new StateTransitionUID( "testing_two" ), "body_two" );
        transitionQueue.enqueueTransition( new StateTransitionUID( "testing_three" ), "body_three" );
    }


}
}
