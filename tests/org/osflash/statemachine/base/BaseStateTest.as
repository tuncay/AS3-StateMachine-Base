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
    private var _transitionNameTwo:String;
    private var _index:uint;
    private var _targetStateNameTwo:String;

    [Before]
    public function before():void {
        initProps();
        initTestSubject();
    }

    [After]
    public function after():void {
        disposeProps();
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

    [Test]
    public function transitionsToString_returns_expected_encoded_value():void {
        const expected:String = _transitionNameTwo + ":" + _targetStateNameTwo + "," + _transitionName + ":" + _targetStateName;
        addTwoTransitionsToTestSubject();
        assertThat( _state.getTarget( _transitionName ), equalTo( _targetStateName ) );
        assertThat( _state.getTarget( _transitionNameTwo ), equalTo( _targetStateNameTwo ) );
    }

    private function addTwoTransitionsToTestSubject():void {
        _state.defineTransition( _transitionName, _targetStateName );
        _state.defineTransition( _transitionNameTwo, _targetStateNameTwo );
    }

    private function initTestSubject():void {
        _state = new BaseState( _stateName, _index );
    }

    private function initProps():void {
        _index = 16;
        _stateName = "testState";
        _targetStateName = "testTarget";
        _targetStateNameTwo = "testTargetTwo";
        _transitionName = "testTranstionOne";
        _transitionNameTwo = "testTranstionTwo";
    }

    private function disposeProps():void {
        _index = 0;
        _state = null;
        _stateName = null;
        _targetStateName = null;
        _transitionName = null;
    }


}
}
