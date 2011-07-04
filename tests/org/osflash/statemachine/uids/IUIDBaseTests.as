package org.osflash.statemachine.uids {

import org.hamcrest.assertThat;
import org.hamcrest.core.allOf;
import org.hamcrest.core.throws;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.hasPropertyWithValue;
import org.hamcrest.object.instanceOf;
import org.osflash.statemachine.uids.IUID;
import org.osflash.statemachine.errors.UIDError;

public class IUIDBaseTests {

    protected const id:String = "id";
    protected const type:String = "type";
    protected const index:int = 16;

    protected var subject:IUID;

    public function setUp( id:String, type:String = null, index:int = -2 ):void {

        if ( index == -2 ) {
            subject = new BaseUID( id, type );
        }
        else {
            subject = new BaseUID( id, type, index );
        }

    }

    [After]
    public function after():void {

        BaseUID.flushUIDs();

    }

    [Test]
    public function identifier_getter_returns__type_plus_delimiter_plus_id():void {
        setUp( id, type, index );
        const expectedIdentifier:String = subject.type + BaseUID.delimiter + id;

        assertThat( subject.identifier, equalTo( expectedIdentifier ) );
    }

    [Test]
    public function index_value_passed_in_constructor_is_attributed_to_index_property():void {
        setUp( id, type, index );
        assertThat( subject.index, equalTo( index ) );
    }


    [Test]
    public function default_index_property_is_minus_one():void {
        setUp( id, type );
        assertThat( subject.index, equalTo( -1 ) );
    }

    [Test]
    public function default_delimiter_property_is_forward_slash():void {
        setUp( id, type, index );
        const expectedIdentifier:String = subject.type + "/" + id;
        assertThat( subject.identifier, equalTo( expectedIdentifier ) );
    }

    [Test]
    public function calling_equals_against_self__returns_true():void {
        setUp( id, type, index );
        assertThat( subject.equals( subject ), equalTo( true ) );
    }

    [Test]
    public function calling_equals_against_non_self_IUID__returns_false():void {
        const uid_2:IUID = new BaseUID( "uid_1", "test" );
        setUp( id, type, index );
        assertThat( subject.equals( uid_2 ), equalTo( false ) );
    }

    [Test]
    public function calling_equals_against_matching_String__returns_true():void {
        setUp( id, type, index );
        assertThat( subject.equals( subject.identifier ), equalTo( true ) );
    }

    [Test]
    public function calling_equals_against_non_matching_String__returns_false():void {
        setUp( id, type, index );
        assertThat( subject.equals( "non/matching/string" ), equalTo( false ) );
    }

    [Test]
    public function calling_equals_against_non_IUID_implementer__returns_false():void {
        setUp( id, type, index );
        assertThat( subject.equals( {id:"non IUID implementer"} ), equalTo( false ) );
    }

    [Test]
    public function toString_returns_identifier_property():void {
        setUp( id, type, index );

        assertThat( subject.toString(), equalTo( subject.identifier ) );
    }

    [Test]
    public function creating_none_unique_IUID_throws_error():void {
        setUp( id, type, index );
        const expectedMessage:String = UIDError.NON_UNIQUE_IDENTIFIER + subject.identifier;
        const f:Function = function ():void {
            new BaseUID( id, subject.type );
        };

        assertThat( f, throws( allOf( instanceOf( UIDError ), hasPropertyWithValue( "message", expectedMessage ) ) ) );
    }

    [Test]
    public function if_id_is_not_null__isNull_returns_false():void {
        setUp( id, type, index );
        assertThat( subject.isNull, equalTo( false ) );
    }


}
}
