package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.nullValue;

public class TransitionQueueTest {

    private var _transitionQueue:TransitionQueue;
    private var _transitionOne:String;
    private var _transitionTwo:String;
    private var _transitionThree:String;
    private var _payloadOne:String;
    private var _payloadTwo:String;
    private var _payloadThree:String;


    [Before]
    public function before():void {
        _transitionOne = "transition/one";
        _transitionTwo = "transition/two";
        _transitionThree = "transition/three";
        _payloadOne = "payload/one";
        _payloadTwo = "payload/two";
        _payloadThree = "payload/three";
        _transitionQueue = new TransitionQueue();
    }

    [After]
    public function after():void {
        _transitionQueue = null;
    }


    [Test]
    public function calling_hasNext_when_empty_returns_false():void {
        assertThat( _transitionQueue.hasNext, isFalse() );
    }

    [Test]
    public function calling_hasNext_when_enqueued_returns_true():void {
        enqueueSingleItem();
        assertThat( _transitionQueue.hasNext, isTrue() );
    }

    [Test]
    public function dequeueTransition_when_empty_returns_null():void {
        assertThat( _transitionQueue.dequeueTransition(), nullValue() );
    }

    [Test]
    public function dequeuing_returns_TransitionBinding_with_enqueued_transitionUID_and_IPayload():void {
        enqueueSingleItem();
        const expected:String = "transition/one:payload/one";
        const got:String = dequeueAndToString();
        assertThat( got, equalTo( expected ) );
    }

    [Test]
    public function queue_is_last_on_last_off():void {
        enqueueThreeItems();
        dequeueTwice();
        const expected:String = "transition/three:payload/three";
        const got:String = dequeueAndToString();
        assertThat( got, equalTo( expected ) );
    }

    private function dequeueAndToString():String {
        return _transitionQueue.dequeueTransition().toString();
    }

    private function enqueueSingleItem():void {
        _transitionQueue.enqueueTransition( _transitionOne, _payloadOne );
    }

    private function enqueueThreeItems():void {
        _transitionQueue.enqueueTransition( _transitionOne, _payloadOne );
        _transitionQueue.enqueueTransition( _transitionTwo, _payloadTwo );
        _transitionQueue.enqueueTransition( _transitionThree, _payloadThree );
    }

    private function dequeueTwice():void {
        _transitionQueue.dequeueTransition();
        _transitionQueue.dequeueTransition();
    }


}
}
