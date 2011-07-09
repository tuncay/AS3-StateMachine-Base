package org.osflash.statemachine.model {

import org.hamcrest.assertThat;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.transitioning.*;

public class StateTransitionBindingTest {

    private var _transitionBinding:TransitionBinding;

    private var _transition:String;
    private var _payload:Object;

    [Before]
    public function before():void {
        initProps();
    }

    private function initTestSubject( transition:String, body:Object ):void {
        _transitionBinding = new TransitionBinding( transition, body );
    }

    private function initProps():void {
        _transition = "transition/one";
        _payload = "payload_one";
    }

    [After]
    public function tearDown():void {
        disposeProps();
    }

    private function disposeProps():void {
        _transition = null;
        _payload = null;
        _transitionBinding = null;
    }

    [Test]
    public function transition_param_passed_in_constructor_attributed_to_transition_property():void {
        initTestSubject( _transition, _payload );
        assertThat( _transitionBinding.transition, strictlyEqualTo( _transition ) );
    }

    [Test]
    public function body_param_passed_in_constructor_set_as_payload_body():void {
        initTestSubject( _transition, _payload );
        assertThat( _transitionBinding.payload.body, strictlyEqualTo( _payload ) )
    }

    [Test]
    public function IPayload_passed_in_body_param_constructor_set_as_payload_property():void {
        const expectedPayload:IPayload = new Payload( _payload );
        initTestSubject( _transition, expectedPayload );
        assertThat( _transitionBinding.payload, strictlyEqualTo( expectedPayload ) )
    }
}
}
