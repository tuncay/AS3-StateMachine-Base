/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine {
import org.flexunit.Assert;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateDecoder;
import org.osflash.statemachine.core.IStateModel;
import org.osflash.statemachine.core.IStateModelInjector;
import org.osflash.statemachine.supporting.IDecodeReporter;
import org.osflash.statemachine.supporting.MockStateDecoder;

public class BaseStateModelTests implements IDecodeReporter {

    private var reportedStateDefintionsFromDecodeState:Array;
    private var reportedStateDefintionsFromDecodeTransition:Array;

    private var reportedStatesFromDecodeState:Array;
    private var reportedStatesFromDecodeTransition:Array;
    private var stateModel:IStateModel;

    [After]
    public function after():void {
        reportedStateDefintionsFromDecodeState = null;
        reportedStateDefintionsFromDecodeTransition = null;
        reportedStatesFromDecodeState = null;
        reportedStatesFromDecodeTransition = null;
        stateModel = null;
    }

    public function setup(fsm:XML):void {

        reportedStateDefintionsFromDecodeState = [];
        reportedStateDefintionsFromDecodeTransition = [];

        reportedStatesFromDecodeState = [];
        reportedStatesFromDecodeTransition = [];

        var decoder:IStateDecoder = new MockStateDecoder(fsm, this);
        var stateModelInjector:IStateModelInjector = new StateModelInjector(decoder);
        stateModel = new StateModel();
        stateModelInjector.inject(stateModel);

    }

    [Test]
    public function ensure_that_each_state_xml_element_is_passed_to_the_decodeState_method():void {
        var expected:Array = [
            FSM.elements()[0],
            FSM.elements()[1],
            FSM.elements()[2],
            FSM.elements()[3],
            FSM.elements()[4],
            FSM.elements()[5],
            FSM.elements()[6]];

        setup(FSM);
        Assert.assertWithApply(assertArraysEqual, [expected, reportedStateDefintionsFromDecodeState])
    }

    [Test]
    public function ensure_that_each_state_xml_element_is_passed_to_the_decodeTransition_method():void {
        var expected:Array = [
            FSM.elements()[0],
            FSM.elements()[1],
            FSM.elements()[2],
            FSM.elements()[3],
            FSM.elements()[4],
            FSM.elements()[5],
            FSM.elements()[6]];

        setup(FSM);
        Assert.assertWithApply(assertArraysEqual, [expected, reportedStateDefintionsFromDecodeTransition])
    }

    [Test]
    public function ensure_that_each_state_decoded_is_passed_to_the_decodeTransition_method():void {
        setup(FSM);
        Assert.assertWithApply(assertArraysEqual, [reportedStatesFromDecodeState, reportedStatesFromDecodeTransition]);
    }

    [Test(expects="org.osflash.statemachine.errors.StateDecodingError")]
    public function ensure_that_duplicate_transition_names_in_same_state_throws_error():void {
        setup(TEST_DUPLICTE_TRANSITION_NAMES_FSM);
    }

    [Test(expects="org.osflash.statemachine.errors.StateDecodingError")]
    public function ensure_that_duplicate_state_names_throws_error():void {
        setup(TEST_DUPLICATE_STATE_NAMES_FSM);
    }

    [Test]
    public function ensure_that_transition_are_decoded_correctly_using_getTarget():void {
        var expected:Array = [ FIRST, SECOND, THIRD, FOURTH, FIFTH, EMPTY];
        var got:Array = [];
        setup(TESY_TRANSITION_DECODING_FSM);
        var state:IState = reportedStatesFromDecodeTransition[0] as IState;
        got.push(state.getTarget(TO_FIRST));
        got.push(state.getTarget(TO_SECOND));
        got.push(state.getTarget(TO_THIRD));
        got.push(state.getTarget(TO_FOURTH));
        got.push(state.getTarget(TO_FIFTH));
        got.push(state.getTarget(TO_EMPTY));
        Assert.assertWithApply(assertArraysEqual, [expected, got]);
    }

    [Test]
    public function ensure_that_transition_are_decoded_correctly_using_state_length():void {
        var expected:int = 6;
        setup(TESY_TRANSITION_DECODING_FSM);
        var state:IState = reportedStatesFromDecodeTransition[0] as IState;
        Assert.assertEquals( expected, state.length );
    }

    [Test]
    public function ensure_that_stateModel_has_correct_initialState():void {
        var expected:String = STARTING;
        setup(TEST_INITIAL_STATE_FSM);
        Assert.assertEquals( expected, stateModel.initialState.name );
    }

    [Test]
    public function ensure_that_stateModel_has_all_correct_states_registered():void {
        var expected:Array = [ true, true, true, true, true, false, true ];
        var got:Array = [];
        setup(FSM);
        got.push( stateModel.hasState( FIRST ));
        got.push( stateModel.hasState( SECOND ));
        got.push( stateModel.hasState( THIRD ));
        got.push( stateModel.hasState( FOURTH ));
        got.push( stateModel.hasState( FIFTH ));
        got.push( stateModel.hasState( SIXTH ));
        got.push( stateModel.hasState( EMPTY ));

        Assert.assertWithApply(assertArraysEqual, [expected, got]);
    }

    public function assertArraysEqual(expected:Array, got:Array):void {
        Assert.assertEquals(expected.length, got.length);
        if (expected.length != got.length)return;
        for (var i:int = 0; i < expected.length; i++) {
            Assert.assertStrictlyEquals(expected[i], got[i]);
        }
    }

    public function reportStateDefFromDecodeState(stateDef:XML):void {
        reportedStateDefintionsFromDecodeState.push(stateDef);
    }

    public function reportStateDefFromDecodeTransition(stateDef:XML):void {
        reportedStateDefintionsFromDecodeTransition.push(stateDef);
    }

    public function reportStateFromDecodeState(state:IState):void {
        reportedStatesFromDecodeState.push(state);
    }

    public function reportStateFromDecodeTransition(state:IState):void {
        reportedStatesFromDecodeTransition.push(state);
    }

    private static const STARTING:String = "starting";
    private static const FIRST:String = "first";
    private static const SECOND:String = "second";
    private static const THIRD:String = "third";
    private static const FOURTH:String = "fourth";
    private static const FIFTH:String = "fifth";
    private static const SIXTH:String = "sixth";
    private static const EMPTY:String = "empty";

    private static const TO_FIRST:String = "toFirst";
    private static const TO_SECOND:String = "toSecond";
    private static const TO_THIRD:String = "toThird";
    private static const TO_FOURTH:String = "toFourth";
    private static const TO_FIFTH:String = "toFifth";
    private static const TO_EMPTY:String = "toEmpty";

    private var FSM:XML =
            <fsm initial={STARTING}>
                <state  name={STARTING}/>
                <state  name={FIRST}/>
                <state  name={SECOND}/>
                <state  name={THIRD}/>
                <state  name={FOURTH}/>
                <state  name={FIFTH}/>
                <state  name={EMPTY}/>
            </fsm>;

    private var TESY_TRANSITION_DECODING_FSM:XML =
            <fsm initial={STARTING}>
                <state  name={STARTING}>
                    <transition action={TO_FIRST} target={FIRST}/>
                    <transition action={TO_SECOND} target={SECOND}/>
                    <transition action={TO_THIRD} target={THIRD}/>
                    <transition action={TO_FOURTH} target={FOURTH}/>
                    <transition action={TO_FIFTH} target={FIFTH}/>
                    <transition action={TO_EMPTY} target={EMPTY}/>
                </state>
            </fsm>;

    private var TEST_DUPLICTE_TRANSITION_NAMES_FSM:XML =
            <fsm initial={STARTING}>
                <state  name={STARTING}>
                    <transition action={TO_FIRST} target={FIRST}/>
                    <transition action={TO_SECOND} target={SECOND}/>
                    <transition action={TO_THIRD} target={THIRD}/>
                    <transition action={TO_FOURTH} target={FOURTH}/>
                    <transition action={TO_FIFTH} target={FIFTH}/>
                    <transition action={TO_FIFTH} target={EMPTY}/>
                </state>


            </fsm>;


     private var TEST_INITIAL_STATE_FSM:XML =
            <fsm initial={STARTING}>
                <state  name={FIRST}/>
                <state  name={SECOND}/>
                <state  name={THIRD}/>
                <state  name={STARTING}/>
            </fsm>;

    private var TEST_DUPLICATE_STATE_NAMES_FSM:XML =
            <fsm initial={STARTING}>
                <state  name={FIRST}/>
                <state  name={STARTING}/>
                <state  name={THIRD}/>
                <state  name={STARTING}/>
            </fsm>;


}
}
