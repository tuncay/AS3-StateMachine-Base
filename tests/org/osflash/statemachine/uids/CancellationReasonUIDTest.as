package org.osflash.statemachine.uids {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class CancellationReasonUIDTest extends IUIDBaseTests {


    public override function setUp( id:String, type:String = null, index:int = -2 ):void {

        if ( index == -2 ) {
            subject = new CancellationReasonUID( id );
        }
        else {
            subject = new CancellationReasonUID( id, index );
        }

    }


    [Test]
    public function type_property_is_set_to_TYPE_static_constant():void {
        const expectedIdentifier:String = CancellationReasonUID.TYPE + BaseUID.delimiter + id;
        setUp( id );
        assertThat( subject.identifier, equalTo( expectedIdentifier ) );
    }
}
}
