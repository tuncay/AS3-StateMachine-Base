/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.uids {
import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.sameInstance;
import org.osflash.statemachine.core.UID;

public class UIDStaticTests {

    private var uid:UID;
    private const id:String = "id";
    private const type:String = "type";

    public function setUp( id:String, type:String ):void {
        uid = new BaseUID( id, type );
    }

    [After]
    public function after():void {

        BaseUID.flushUIDs();

    }

    [Test]
    public function UID_static_const_NULL_has_isNull_returning_true():void {
        assertThat( BaseUID.NULL_UID.isNull, equalTo( true ) );
    }

    [Test]
    public function getIUIDFromIdentifier_returns_corresponding_IUID():void {
        setUp( id,  type);
        assertThat( BaseUID.getUIDFromIdentifier( uid.identifier ), sameInstance( uid ) );
    }

    [Test]
    public function getIBIDFromIdentifier_returns_NULL_IUID_if_none_registered():void {
        assertThat( BaseUID.getUIDFromIdentifier( "none/registered" ), sameInstance( BaseUID.NULL_UID ) );
    }


}
}
