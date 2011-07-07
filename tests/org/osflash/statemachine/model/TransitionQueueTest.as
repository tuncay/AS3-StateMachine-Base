package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.hasPropertyChain;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;
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
    public function calling_hasNext_when_enqueued_returns_true():void {
        enqueueSingleItem();
        assertThat( transitionQueue.hasNext, isTrue() );
    }

    [Test]
    public function dequeueTransition_when_empty_returns_null():void {
        assertThat( transitionQueue.dequeueTransition(), nullValue() );
    }

    [Test]
    public function dequeuing_returns_TransitionBinding_with_enqueued_transitionUID_and_IPayload():void {
        enqueueSingleItem();
        const expected:String = "transition/testing_one:body_one";
        const got:String = dequeueAndToString();
        assertThat( got, equalTo( expected ) );
    }

    [Test]
    public function queue_is_last_on_last_off():void {
        enqueueThreeItems();
        dequeueTwice();
        const expected:String = "transition/testing_three:body_three";
        const got:String = dequeueAndToString();
        assertThat( got, equalTo( expected ) );
    }

    private function dequeueAndToString():String {
        return transitionQueue.dequeueTransition().toString();
    }

    private function enqueueSingleItem():void {
        transitionQueue.enqueueTransition( new StateTransitionUID( "testing_one" ), "body_one" );
    }

    private function enqueueThreeItems():void {
        transitionQueue.enqueueTransition( new StateTransitionUID( "testing_one" ), "body_one" );
        transitionQueue.enqueueTransition( new StateTransitionUID( "testing_two" ), "body_two" );
        transitionQueue.enqueueTransition( new StateTransitionUID( "testing_three" ), "body_three" );
    }

    private function dequeueTwice():void {
        transitionQueue.dequeueTransition();
        transitionQueue.dequeueTransition();
    }


}
}
