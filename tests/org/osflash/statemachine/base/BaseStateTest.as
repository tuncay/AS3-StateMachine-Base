package org.osflash.statemachine.base {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;

public class BaseStateTest {

    private var _state:BaseState;
    private var _stateName:String;
    private var _targetStateName:String;
    private var _transitionName:String;
    private var _index:uint;

    [Before]
    public function before():void {
        _index = 16;
        _stateName = "testStateUID";
        _targetStateName = "testTargetUID";
        _transitionName = "testTranstionUID";
        _state = new BaseState( _stateName, _index );
    }

    [After]
    public function after():void {
        _index = 0;
        _state = null;
        _stateName = null;
        _targetStateName = null;
        _transitionName = null;

    }

    [Test]
    public function name_passed_in_constructor_is_attributed_to_name_property():void {
        assertThat( _state.name, equalTo( _stateName ) )
    }

    [Test]
    public function index_passed_in_constructor_is_attributed_to_index_property():void {
        assertThat( _state.index, equalTo( _index ) )
    }

    [Test]
    public function defining_transition_returns_true():void {
        assertThat( _state.defineTransition( _transitionName, _stateName ), equalTo( true ) );
    }

    [Test]
    public function defining_existing_transition_returns_false():void {
        _state.defineTransition( _transitionName, _targetStateName );
        assertThat( _state.defineTransition( _transitionName, _targetStateName ), equalTo( false ) );
    }

    [Test]
    public function calling_hasTans_on_existing_transition_returns_true():void {
        _state.defineTransition( _transitionName, _targetStateName );
        assertThat( _state.hasTrans( _transitionName ), equalTo( true ) );
    }

    [Test]
    public function calling_hasTans_on_undefined_transition_returns_false():void {
        assertThat( _state.hasTrans( _transitionName ), equalTo( false ) );
    }

    [Test]
    public function calling_getTarget_on_existing_transition_returns_target_state_UID():void {
        _state.defineTransition( _transitionName, _targetStateName );
        assertThat( _state.getTarget( _transitionName ), strictlyEqualTo( _targetStateName ) );
    }

    [Test]
    public function calling_getTarget_on_undefined_transition_returns_null():void {
        assertThat( _state.getTarget( _transitionName ), nullValue() );
    }

    [Test]
    public function removing_existing_transition_returns_true():void {
        _state.defineTransition( _transitionName, _targetStateName );
        assertThat( _state.removeTrans( _transitionName ), equalTo( true ) );
    }

    [Test]
    public function removing_undefined_transition_returns_false():void {
        assertThat( _state.removeTrans( _transitionName ), equalTo( false ) );
    }


}
}
