/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.model {
import flexunit.framework.Assert;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.model.BaseState;
import org.osflash.statemachine.uids.StateTransitionUID;
import org.osflash.statemachine.uids.StateUID;
import org.osflash.statemachine.uids.flushUIDs;
import org.osflash.statemachine.uids.getNullUID;

public class BaseStateTest {

    private var _state:BaseState;
    private var _stateUID:StateUID;
    private var _targetStateUID:StateUID;
    private var _transitionUID:StateTransitionUID;

    [Before]
    public function before():void {
        _stateUID = new StateUID( "testStateUID" );
        _targetStateUID = new StateUID( "testTargetUID" );
        _transitionUID = new StateTransitionUID( "testTranstionUID" );
        _state = new BaseState( _stateUID );
    }

    [After]
    public function after():void {
        _state = null;
        _stateUID = null;
        _targetStateUID = null;
        _transitionUID = null;

        flushUIDs();
    }

    [Test]
    public function uid_passed_in_constructor_is_attributed_to_uid_property():void {
        assertThat( _state.uid, equalTo( _stateUID ) )
    }

    [Test]
    public function defining_transition_returns_true():void {
        assertThat( _state.defineTransition( _transitionUID, _stateUID ), equalTo( true ) );
    }

    [Test]
    public function defining_existing_transition_returns_false():void {
        _state.defineTransition( _transitionUID, _targetStateUID );
        assertThat( _state.defineTransition( _transitionUID, _targetStateUID ), equalTo( false ) );
    }

    [Test]
    public function calling_hasTans_on_existing_transition_returns_true():void {
        _state.defineTransition( _transitionUID, _targetStateUID );
        assertThat( _state.hasTrans( _transitionUID ), equalTo( true ) );
    }

    [Test]
    public function calling_hasTans_on_undefined_transition_returns_false():void {
        assertThat( _state.hasTrans( _transitionUID ), equalTo( false ) );
    }

    [Test]
    public function calling_getTarget_on_existing_transition_returns_target_state_UID():void {
        _state.defineTransition( _transitionUID, _targetStateUID );
        assertThat( _state.getTarget( _transitionUID ), strictlyEqualTo( _targetStateUID ) );
    }

    [Test]
    public function calling_getTarget_on_undefined_transition_returns_null():void {
        const NULL_UID:UID = getNullUID();
        assertThat( _state.getTarget( _transitionUID ), strictlyEqualTo( NULL_UID ) );
    }

    [Test]
    public function removing_existing_transition_returns_true():void {
        _state.defineTransition( _transitionUID, _targetStateUID );
        assertThat( _state.removeTrans( _transitionUID ), equalTo( true ) );
    }

    [Test]
    public function removing_undefined_transition_returns_false():void {
        assertThat( _state.removeTrans( _transitionUID ), equalTo( false ) );
    }

    [Test]
    public function disposing_state_removes_all_transitions():void {
        _state.defineTransition( _transitionUID, _targetStateUID );
        _state.dispose();
        Assert.assertFalse( _state.hasTrans( _transitionUID ) );
    }


}
}
