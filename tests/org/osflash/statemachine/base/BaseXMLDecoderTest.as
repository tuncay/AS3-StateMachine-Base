/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 18/04/11
 * Time: 17:11
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import org.flexunit.Assert;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateDecoder;

public class BaseXMLDecoderTest {

    private var decoder:IStateDecoder;

    public function setUp( fsm:XML ):void {
        decoder = new BaseXMLStateDecoder( fsm );
    }

    [After]
    public function after():void {
        decoder = null;
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function when_null_value_is_passed_setData_throws_error():void {
        setUp( null );
        decoder.setData( null );
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function when_null_data_is_passed_to_constructor_getStateList_throws_error():void {
        setUp( null );
        decoder.getStateList();
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function if_no_initial_state_is_declared_in_data_setData_throws_error():void {
        setUp( NO_INITIAL_STATE_DECLARED );
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function if_initial_state_cannot_be_found_in_data_setData_throws_error():void {
        setUp( INITIAL_STATE_NOT_FOUND );
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function if_a_state_name_attribute_is_not_declared_getStateList_throws_error():void {
        setUp( STATE_NAME_NOT_DECLARED );
        decoder.getStateList()
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function if_a_states_attribute_name_is_not_unique_getStateList_throws_error():void {
        setUp( DUPLICATE_STATE_DECLARED );
        decoder.getStateList()
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function if_a_transition_name_attribute_is_not_declared_getStateList_throws_error():void {
        setUp( TRANSITION_NAME_NOT_DECLARED );
        decoder.getStateList()
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function if_a_transition_target_attribute_is_not_declared_getStateList_throws_error():void {
        setUp( TRANSITION_TARGET_NOT_DECLARED );
        decoder.getStateList()
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function if_a_transitions_attribute_name_is_not_unique_getStateList_throws_error():void {
        setUp( DUPLICATE_TRANSITION_DECLARED );
        decoder.getStateList()
    }

    [Test]
    public function getStateList_returns_list_of_length_three():void {
        setUp( THREE_CORRECTLY_DECLARED_STATES );
        var states:Array = decoder.getStateList();
        Assert.assertEquals( states.length, 3 );
    }

    [Test]
    public function getStateList_returns_list_of_IStates():void {
        setUp( THREE_CORRECTLY_DECLARED_STATES );
        var states:Array = decoder.getStateList();
        for ( var i:int = 0; i < states.length; i++ ) {
            var state:IState = states[i] as IState;
            Assert.assertNotNull( state );
        }
    }

    [Test]
    public function getStateList_returns_list_of_IStates_with_expected_names():void {
        setUp( THREE_CORRECTLY_DECLARED_STATES );
        var states:Array = decoder.getStateList();
        var expectedStateNames:Array = [ STARTING, LOADING, SAVING ];
        for ( var i:int = 0; i < states.length; i++ ) {
            var state:IState = states[i] as IState;
            Assert.assertEquals( expectedStateNames[i], state.name );
        }
    }


    [Test]
    public function getStateList_returns_list_of_IStates_with_expected_named_transitions():void {
        setUp( THREE_CORRECTLY_DECLARED_STATES );
        var states:Array = decoder.getStateList();
        var starting:IState = IState( states[0] );
        var loading:IState = IState( states[1] );
        var saving:IState = IState( states[2] );

        Assert.assertTrue(
                         starting.hasTrans( LOAD ) && starting.hasTrans( SAVE ) &&
                         loading.hasTrans( SAVE ) && saving.hasTrans( START ) && saving.hasTrans( LOAD )
                         );
    }

    [Test]
    public function getStateList_returns_list_of_IStates_with_transitions_having_expected_targets():void {
        setUp( THREE_CORRECTLY_DECLARED_STATES );
        var states:Array = decoder.getStateList();
        var starting:IState = IState( states[0] );
        var loading:IState = IState( states[1] );
        var saving:IState = IState( states[2] );
        Assert.assertTrue(
                         starting.getTarget( LOAD ) == LOADING && starting.getTarget( SAVE ) == SAVING &&
                         loading.getTarget( SAVE ) == SAVING && saving.getTarget( START ) == STARTING &&
                         saving.getTarget( LOAD ) == LOADING
                         );
    }

    [Test]
    public function for_expected_initial_state_isInitial_returns_true():void {
        setUp( THREE_CORRECTLY_DECLARED_STATES );
        Assert.assertTrue(  decoder.isInitial( LOADING )  );
    }

    [Test]
    public function for_expected_non_initial_state_isInitial_returns_false():void {
        setUp( THREE_CORRECTLY_DECLARED_STATES );
        Assert.assertFalse(  decoder.isInitial( STARTING )  );
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function calling_destroy_method_nulls_data_property_so_getStateList_throws_error():void {
        setUp( THREE_CORRECTLY_DECLARED_STATES );
        decoder.destroy();
        decoder.getStateList();
    }


    private const STARTING:String = "starting";
    private const LOADING:String = "loading";
    private const SAVING:String = "saving";
    private const NEXT:String = "next";
    private const LOAD:String = "load";
    private const SAVE:String = "save";
    private const START:String = "start";

    private const NO_INITIAL_STATE_DECLARED:XML =
                  <fsm>
                      <state name={STARTING}/>
                  </fsm>;

    private const INITIAL_STATE_NOT_FOUND:XML =
                  <fsm initial={LOADING}>
                      <state name={STARTING}/>
                  </fsm>;

    private const STATE_NAME_NOT_DECLARED:XML =
                  <fsm initial={STARTING}>
                      <state/>
                  </fsm>;

    private const DUPLICATE_STATE_DECLARED:XML =
                  <fsm initial={STARTING}>
                      <state name={STARTING}/>
                      <state name={STARTING}/>
                  </fsm>
    ;

    private const TRANSITION_NAME_NOT_DECLARED:XML =
                  <fsm initial={STARTING}>
                      <state name={STARTING}>
                          <transition target={LOADING}/>
                      </state>
                  </fsm>
    ;

    private const TRANSITION_TARGET_NOT_DECLARED:XML =
                  <fsm initial={STARTING}>
                      <state name={STARTING}>
                          <transition name={NEXT}/>
                      </state>
                  </fsm>
    ;

    private const DUPLICATE_TRANSITION_DECLARED:XML =
                  <fsm initial={STARTING}>
                      <state name={STARTING}>
                          <transition name={LOAD} target={LOADING}/>
                          <transition name={LOAD} target={SAVING}/>
                      </state>
                  </fsm>
    ;

    private const THREE_CORRECTLY_DECLARED_STATES:XML =
                  <fsm initial={LOADING}>

                      <state name={STARTING}>
                          <transition name={LOAD} target={LOADING}/>
                          <transition name={SAVE} target={SAVING}/>
                      </state>

                      <state name={LOADING}>
                          <transition name={SAVE} target={SAVING}/>
                      </state>

                      <state name={SAVING}>
                          <transition name={START} target={STARTING}/>
                          <transition name={LOAD} target={LOADING}/>
                      </state>
                  </fsm>
    ;
}
}
