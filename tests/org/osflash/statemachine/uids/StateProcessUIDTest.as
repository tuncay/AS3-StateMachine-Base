package org.osflash.statemachine.uids {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class StateProcessUIDTest extends IUIDBaseTests {


    public override function setUp( id:String, type:String = null, index:int = -2 ):void {

        if ( index == -2 ) {
            subject = new StateProcessUID( id );
        }
        else {
            subject = new StateProcessUID( id, index );
        }

    }


    [Test]
    public function type_property_is_set_to_TYPE_static_constant():void {
        const expectedIdentifier:String = StateProcessUID.TYPE + BaseUID.delimiter + id;
        setUp( id );
        assertThat( subject.identifier, equalTo( expectedIdentifier ) );
    }
}
}
