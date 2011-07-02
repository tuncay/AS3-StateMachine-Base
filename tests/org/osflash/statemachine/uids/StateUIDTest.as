package org.osflash.statemachine.uids {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.osflash.statemachine.uids.BaseUID;

public class StateUIDTest extends IUIDBaseTests {


     public override function setUp( id:String, type:String = null, index:int = -2 ):void {

        if ( index == -2 ) {
            subject = new StateUID( id );
        }
        else {
            subject = new StateUID( id, index );
        }

    }


    [Test]
    public function type_property_is_set_to_TYPE_static_constant():void {
        const expectedIdentifier:String =  StateUID.TYPE + BaseUID.delimiter + id;
        setUp( id );
        assertThat( subject.identifier, equalTo( expectedIdentifier ) );
    }
}
}
