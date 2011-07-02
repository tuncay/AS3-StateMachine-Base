package org.osflash.statemachine.base {
import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.notNullValue;
import org.osflash.statemachine.uids.CancellationReasonUID;
import org.osflash.statemachine.uids.flushUIDs;
import org.osflash.statemachine.uids.getNullUID;

public class StateMachinePropertiesTest {


    private var smProperties:TransitionModel;

    [Before]
    public function setUp():void {

        smProperties = new TransitionModel();
    }

    [After]
    public function tearDown():void {

        smProperties = null;
        flushUIDs();
    }

    [Test]
    public function default_cancellationReason_is_NULL_UID():void {
        assertThat( smProperties.cancellationReason.equals( getNullUID() ), isTrue() );
    }

    [Test]
    public function default_referringTransition_NULL_UID():void {
        assertThat( smProperties.referringTransition.equals( getNullUID() ), isTrue() );
    }

    [Test]
    public function default_currentTransitionPhase_is_NULL_UID():void {
        assertThat( smProperties.currentTransitionPhase.equals( getNullUID() ), isTrue() );
    }

    [Test]
    public function default_payload_isNull__returns_true():void {
        assertThat( smProperties.currentPayload, allOf( notNullValue(), hasPropertyWithValue( "isNull", isTrue() ) ) );
    }

    [Test]
    public function reset_restores_default_null_payload():void {
        smProperties.currentPayload = new Payload( {} );
        smProperties.reset();
        assertThat( smProperties.currentPayload, allOf( notNullValue(), hasPropertyWithValue( "isNull", isTrue() ) ) );
    }

    [Test]
    public function reset_restores_cancellationReason_to_NULL_UID():void {
        smProperties.cancellationReason = new CancellationReasonUID("test");
        smProperties.reset();
        assertThat( smProperties.currentTransitionPhase.equals( getNullUID() ), isTrue() );
    }


}
}
