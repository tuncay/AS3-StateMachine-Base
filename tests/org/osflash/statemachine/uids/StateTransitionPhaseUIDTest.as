package org.osflash.statemachine.uids {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class StateTransitionPhaseUIDTest extends IUIDBaseTests {


    public override function setUp( id:String, type:String = null, index:int = -2 ):void {

        if ( index == -2 ) {
            subject = new StateTransitionPhaseUID( id );
        }
        else {
            subject = new StateTransitionPhaseUID( id, index );
        }

    }


    [Test]
    public function type_property_is_set_to_TYPE_static_constant():void {
        const expectedIdentifier:String = StateTransitionPhaseUID.TYPE + BaseUID.delimiter + id;
        setUp( id );
        assertThat( subject.identifier, equalTo( expectedIdentifier ) );
    }
}
}
