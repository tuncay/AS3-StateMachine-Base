package org.osflash.statemachine.model {
import org.hamcrest.assertThat;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.transitioning.*;
import org.osflash.statemachine.uids.getNullUID;

public class TransitionBindingTest {

    private var transitionBinding:TransitionBinding;

    public function setUp( transition:UID, body:Object ):void {
        transitionBinding = new TransitionBinding( transition, body );
    }

    [After]
    public function tearDown():void {
        transitionBinding = null;
    }

    [Test]
    public function transition_param_passed_in_constructor_attributed_to_transition_property():void {
        setUp( getNullUID(), {} );
        assertThat( transitionBinding.transition, strictlyEqualTo( getNullUID() ) )
    }

    [Test]
    public function body_param_passed_in_constructor_set_as_payload_body():void {
        const expectedBody:Object = {};
        setUp( getNullUID(), expectedBody );
        assertThat( transitionBinding.payload.body, strictlyEqualTo( expectedBody ) )
    }

    [Test]
    public function IPayload_passed_in_body_param_constructor_set_as_payload_property():void {
        const expectedPayload:IPayload = new Payload({});
        setUp( getNullUID(), expectedPayload );
        assertThat( transitionBinding.payload, strictlyEqualTo( expectedPayload ) )
    }


}
}
