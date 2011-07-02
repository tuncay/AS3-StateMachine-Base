/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.logging {
import flexunit.framework.Assert;

import org.osflash.statemachine.model.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.ITransitionPhase;
import org.osflash.statemachine.uids.StateTransitionPhaseUID;

public class TraceStateLoggerTest {

    private var logger:TraceStateLogger;

    public function setUp( prefix:String = null, active:Boolean = true, flags:int = 127 ):void {

        logger = new TraceStateLogger( prefix, active, flags );
    }

    [After]
    public function after():void {
        logger = null;
    }

    [Test]
    public function calling_log_with_no_prefix_defined_lastMessage_returns_log_message():void {
        setUp();
        logger.log( MESSAGE );
        Assert.assertEquals( MESSAGE, logger.lastMessage );
    }

    [Test]
    public function calling_log_with_prefix_defined_lastMessage_returns_prefixed_message():void {
        setUp( LOGGER_PREFIX );
        logger.log( MESSAGE );
        var gotPrefix:String = logger.lastMessage.slice( 0, LOGGER_PREFIX.length );
        var gotMessage:String = logger.lastMessage.slice( LOGGER_PREFIX.length, logger.lastMessage.length );
        Assert.assertTrue(
                         gotPrefix == LOGGER_PREFIX &&
                         gotMessage == MESSAGE
                         );
    }

    [Test]
    public function calling_log_with_null_prefix_and_active_property_false_lastMessage_returns_null():void {
        setUp( null, false );
        logger.log( MESSAGE );
        Assert.assertNull( logger.lastMessage );
    }

    [Test]
    public function calling_log_with_prefix_and_active_property_false_lastMessage_returns_null():void {
        setUp( LOGGER_PREFIX, false );
        logger.log( MESSAGE );
        Assert.assertNull( logger.lastMessage );
    }

    [Test]
    public function calling_logPhase_with_no_prefix_defined_and_default_flags_lastMessage_contains_phase_and_state_name():void {
        setUp();
        logger.logPhase( EXITING_GUARD, STATE );
        assertPhaseNameAndStateName( EXITING_GUARD, STATE, logger.lastMessage );

    }

    [Test]
    public function calling_logPhase_with_prefix_defined_and_default_flags_lastMessage_contains_phase_and_state_name():void {
        setUp( LOGGER_PREFIX );
        logger.logPhase( EXITING_GUARD, STATE );
        assertPhaseNameAndStateName( EXITING_GUARD, STATE, logger.lastMessage, true );

    }

    [Test]
    public function calling_logPhase_with_prefix_defined_active_property_false_and_default_flags_lastMessage_returns_null():void {
        setUp( LOGGER_PREFIX, false );
        logger.logPhase( EXITING_GUARD, STATE );
        Assert.assertNull( logger.lastMessage );
    }

    [Test]
    public function calling_logPhase_with_prefix_null_active_property_false_and_default_flags_lastMessage_returns_null():void {
        setUp( null, false );
        logger.logPhase( EXITING_GUARD, STATE );
        Assert.assertNull( logger.lastMessage );
    }

    [Test]
    public function calling_logPhase_flags_set_for_ENTERED_only_lastMessage_returns_null_for_all_other_phases():void {
        setUp( null, true, ENTERED.index );
        logger.logPhase( NONE, STATE );
        logger.logPhase( EXITING_GUARD, STATE );
        logger.logPhase( ENTERING_GUARD, STATE );
        logger.logPhase( TEAR_DOWN, STATE );
        logger.logPhase( CANCELLED, STATE );
        logger.logPhase( GLOBAL_CHANGED, STATE );
        Assert.assertNull( logger.lastMessage );
    }

    [Test]
    public function calling_logPhase_flags_set_for_ENTERED_only__lastMessage_returns_message_for_ENTERED_phase():void {
        setUp( null, true, ENTERED.index );
        logger.logPhase( ENTERED, STATE );
        assertPhaseNameAndStateName( ENTERED, STATE, logger.lastMessage );
    }

    [Test]
    public function calling_logPhase_flags_set_for_ENTERED_TEAR_DOWN_and_CANCELLED__lastMessage_returns_null_for_all_other_phases():void {
        setUp( null, true, ENTERED.index | TEAR_DOWN.index | CANCELLED.index );
        logger.logPhase( NONE, STATE );
        logger.logPhase( EXITING_GUARD, STATE );
        logger.logPhase( ENTERING_GUARD, STATE );
        logger.logPhase( GLOBAL_CHANGED, STATE );
        Assert.assertNull( logger.lastMessage );
    }

    [Test]
    public function calling_logPhase_flags_set_for_ENTERED_TEAR_DOWN_and_CANCELLED__lastMessage_returns_message_for_ENTERED_phase():void {
        setUp( null, true, ENTERED.index | TEAR_DOWN.index  | CANCELLED.index );
        logger.logPhase( ENTERED, STATE );
        assertPhaseNameAndStateName( ENTERED, STATE, logger.lastMessage );
    }

    [Test]
    public function calling_logPhase_flags_set_for_ENTERED_TEAR_DOWN_and_CANCELLED__lastMessage_returns_message_for_TEAR_DOWN_phase():void {
        setUp( null, true, ENTERED.index | TEAR_DOWN.index  | CANCELLED.index );
        logger.logPhase( TEAR_DOWN, STATE );
        assertPhaseNameAndStateName( TEAR_DOWN, STATE, logger.lastMessage );
    }

     [Test]
    public function calling_logPhase_flags_set_for_ENTERED_TEAR_DOWN_and_CANCELLED__lastMessage_returns_message_for_CANCELLED_phase():void {
        setUp( null, true, ENTERED.index | TEAR_DOWN.index  | CANCELLED.index );
        logger.logPhase( CANCELLED, STATE );
        assertPhaseNameAndStateName( CANCELLED, STATE, logger.lastMessage );
    }

    private function assertPhaseNameAndStateName( phase:ITransitionPhase, state:IState, msg:String, prefix:Boolean = false ):void {
        const regExp1:RegExp = /\[(.+?)\]/g;
        const regExp2:RegExp = /(\[|\])/g;
        const result:Array = msg.match( regExp1 );
        var phaseName:String;
        var stateName:String;

        if ( !prefix ) {
            phaseName = String( result[0] ).replace( regExp2, "" );
            stateName = String( result[1] ).replace( regExp2, "" );
        } else {
            Assert.assertEquals( LOGGER_PREFIX, String( result[0] ) );
            phaseName = String( result[1] ).replace( regExp2, "" );
            stateName = String( result[2] ).replace( regExp2, "" );
        }

        Assert.assertEquals( phase.name, phaseName );
        Assert.assertEquals( state.id, stateName );
    }

    private static const LOGGER_PREFIX:String = "[TEST]";
    private static const MESSAGE:String = "Logger test message";

    private static const NONE:StateTransitionPhaseUID = new StateTransitionPhaseUID( "none", 1 );
    private static const EXITING_GUARD:StateTransitionPhaseUID = new StateTransitionPhaseUID( "exitingGuard", 2 );
    private static const ENTERING_GUARD:StateTransitionPhaseUID = new StateTransitionPhaseUID( "enteringGuard", 4 );
    private static const ENTERED:StateTransitionPhaseUID = new StateTransitionPhaseUID( "entered", 8 );
    private static const TEAR_DOWN:StateTransitionPhaseUID = new StateTransitionPhaseUID( "tearDown", 16 );
    private static const CANCELLED:StateTransitionPhaseUID = new StateTransitionPhaseUID( "cancelled", 32 );
    private static const GLOBAL_CHANGED:StateTransitionPhaseUID = new StateTransitionPhaseUID( "globalChanged", 64 );

    private static const STATE = new BaseState( "testing" );

}
}
