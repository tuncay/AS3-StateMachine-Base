/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import flexunit.framework.Assert;

import org.osflash.statemachine.core.IPayload;

public class PayloadTest {


    private const STATE_NAME:String = "testStateName";
    private const TARGET_NAME:String = "testTargetName";
    private const TRANSITION_NAME:String = "testTranstion";
    private var payload:IPayload;

    public function setUp( body:Object ):void {

        payload = new Payload(body);
    }

    [After]
    public function tearDown():void {

        payload = null;
    }

    [Test]
    public function body_passed_in_constructor_assigned_to_body_property():void {
        const body:Object = {};
        setUp( body );
        Assert.assertEquals(body, payload.body);
    }

    [Test]
    public function body_of_IPayload_passed_in_constructor_is_assigned_to_body_property():void {
        const body:Object = {};
        setUp( new Payload( body ) );
        Assert.assertEquals(body, payload.body);
    }

    [Test]
    public function if_body_is_null_isNull_returns_true():void {
        setUp( null );
        Assert.assertTrue( payload.isNull);
    }

    [Test]
    public function if_body_is_set_isNull_returns_false():void {
        setUp( {} );
        Assert.assertFalse( payload.isNull);
    }

    [Test]
    public function payload_equals_returns_true_aginst_body_instance():void {
        const body:Object = {};
        setUp( body );
        Assert.assertTrue( payload.equals( body ));
    }

    [Test]
       public function payload_equals_returns_true_against_self():void {
           const body:Object = {};
           setUp( body );
           Assert.assertTrue( payload.equals( payload ));
       }


    [Test]
       public function payload_equals_returns_true_against_payload_with_same_body():void {
           const body:Object = {};
            const payload2:IPayload = new Payload( body );
           setUp( body );
           Assert.assertTrue( payload.equals( payload2 ));
       }




}
}
