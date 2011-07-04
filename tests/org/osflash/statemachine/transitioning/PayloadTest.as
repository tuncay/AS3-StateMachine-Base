/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.transitioning {

import org.hamcrest.assertThat;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.core.IPayload;

public class PayloadTest {


    private const STATE_NAME:String = "testStateName";
    private const TARGET_NAME:String = "testTargetName";
    private const TRANSITION_NAME:String = "testTranstion";
    private var payload:IPayload;

    public function setUp( body:Object ):void {

        payload = new Payload( body );
    }

    [After]
    public function tearDown():void {

        payload = null;
    }

    [Test]
    public function body_passed_in_constructor_is_assigned_to_body_property():void {
        const body:Object = {};
        setUp( body );
        assertThat( payload.body, strictlyEqualTo( body ) );
    }

    [Test]
    public function body_of_IPayload_passed_in_constructor_is_assigned_to_body_property():void {
        const body:Object = {};
        setUp( new Payload( body ) );
        assertThat( payload.body, strictlyEqualTo( body ) );
    }

    [Test]
    public function if_body_is_null_isNull_returns_true():void {
        setUp( null );
        assertThat( payload.isNull, isTrue() );
    }

    [Test]
    public function if_body_is_set_isNull_returns_false():void {
        const body:Object = {};
        setUp( body );
        assertThat( payload.isNull, isFalse() );
    }

    [Test]
    public function test_equal_against_strictlyEqual_body_instance__returns_true():void {
        const body:Object = {};
        setUp( body );
        assertThat( payload.equals( body ), isTrue() );
    }

    [Test]
    public function test_equal_against_self__returns_true():void {
        const body:Object = {};
        setUp( body );
        assertThat( payload.equals( payload ), isTrue() );
    }

    [Test]
    public function test_equal_against_Payload_with_strictlyEqual_body_instance__returns_true():void {
        const body:Object = {};
        const payload2:IPayload = new Payload( body );
        setUp( body );
        assertThat( payload.equals( payload2 ), isTrue() );
    }

    [Test]
    public function test_equal_against_Payload_with_non_equal_body_instance__returns_false():void {
        const body1:Object = {};
        const body2:Object = {};
        const payload2:IPayload = new Payload( body2 );
        setUp( body1 );
        assertThat( payload.equals( payload2 ), isFalse() );
    }

    [Test]
    public function test_equal_against_non_equal_body_instance__returns_false():void {
        const body1:Object = {};
        const body2:Object = {};
        setUp( body1 );
        assertThat( payload.equals( body2 ), isFalse() );
    }


}
}
