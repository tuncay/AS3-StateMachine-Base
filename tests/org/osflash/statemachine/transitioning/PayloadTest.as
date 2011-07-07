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

    private var _payload:IPayload;
    private var _body:Object;


    [Before]
    public function before():void {
        _body = "payload_one";
    }

    public function initTestSubject( body:Object ):void {
        _payload = new Payload( body );
    }

    [After]
    public function tearDown():void {
        _payload = null;
    }

    [Test]
    public function body_passed_in_constructor_is_assigned_to_body_property():void {
        initTestSubject( _body );
        assertThat( _payload.body, strictlyEqualTo( _body ) );
    }

    [Test]
    public function body_of_IPayload_passed_in_constructor_is_assigned_to_body_property():void {
        initTestSubject( new Payload( _body ) );
        assertThat( _payload.body, strictlyEqualTo( _body ) );
    }

    [Test]
    public function if_body_is_null_isNull_returns_true():void {
        initTestSubject( null );
        assertThat( _payload.isNull, isTrue() );
    }

    [Test]
    public function if_body_is_set_isNull_returns_false():void {
        initTestSubject( _body );
        assertThat( _payload.isNull, isFalse() );
    }

    [Test]
    public function test_equal_against_strictlyEqual_body_instance__returns_true():void {
        initTestSubject( _body );
        assertThat( _payload.equals( _body ), isTrue() );
    }

    [Test]
    public function test_equal_against_self__returns_true():void {
        initTestSubject( _body );
        assertThat( _payload.equals( _payload ), isTrue() );
    }

    [Test]
    public function test_equal_against_Payload_with_strictlyEqual_body_instance__returns_true():void {
        const payload2:IPayload = new Payload( _body );
        initTestSubject( _body );
        assertThat( _payload.equals( payload2 ), isTrue() );
    }

    [Test]
    public function test_equal_against_Payload_with_non_equal_body_instance__returns_false():void {
        const body2:Object = "payload_two";
        const payload2:IPayload = new Payload( body2 );
        initTestSubject( _body );
        assertThat( _payload.equals( payload2 ), isFalse() );
    }

    [Test]
    public function test_equal_against_non_equal_body_instance__returns_false():void {
        const body2:Object = "payload_two";
        initTestSubject( _body );
        assertThat( _payload.equals( body2 ), isFalse() );
    }


}
}
