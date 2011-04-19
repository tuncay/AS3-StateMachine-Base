/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 18/04/11
 * Time: 17:11
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import flexunit.framework.Assert;

import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateDecoder;
import org.osflash.statemachine.core.IStateModelInjector;
import org.osflash.statemachine.supporting.IStateRegistry;
import org.osflash.statemachine.supporting.StubStateModelForTestingStateModelInjector;

public class StateModelInjectorTest implements IStateRegistry {

    private var injector:IStateModelInjector;
    private var registeredStates:Array;
    private var initialState:IState;
    private var timesSetInitialCalled:int = 0;

    public function setUp( decoder:IStateDecoder = null ):void {
        registeredStates = [];
        injector = new StateModelInjector( decoder );
        injector.inject( new StubStateModelForTestingStateModelInjector( this ) )
    }

    public function createDecoderAndSetUp( fsm:XML ):void {
        setUp( new BaseXMLStateDecoder( fsm ) );
    }

    [After]
    public function after():void {
        registeredStates = null;
        timesSetInitialCalled = 0;
        injector = null;
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function when_null_value_is_passed_injection_throws_error():void {
        setUp( null );
    }

    [Test ]
    public function states_registered_should_be_IStates():void {
        createDecoderAndSetUp( THREE_CORRECTLY_DECLARED_STATES );
         for (var i:int = 0; i < registeredStates.length; i++) {
            Assert.assertTrue(registeredStates[i] is IState );
        }
    }

    [Test ]
    public function names_of_states_registered_states_should_be_as_expected():void {
        var expected:Array = [STARTING, LOADING, SAVING];
        createDecoderAndSetUp( THREE_CORRECTLY_DECLARED_STATES );
        Assert.assertEquals(expected.length, registeredStates.length );
        for (var i:int = 0; i < registeredStates.length; i++) {
            Assert.assertEquals(expected[i], IState(registeredStates[i]).name );
        }
    }

    [Test ]
    public function initial_state_should_be_set_once_only():void {
        createDecoderAndSetUp( THREE_CORRECTLY_DECLARED_STATES );
        Assert.assertEquals( 1, timesSetInitialCalled );
    }

    [Test ]
    public function initial_state_should_be_as_expected():void {
        createDecoderAndSetUp( THREE_CORRECTLY_DECLARED_STATES );
        var expectedInitialStateName:String = LOADING;
        Assert.assertEquals( expectedInitialStateName, initialState.name );
    }


    public function registerState( state:IState ):void {
        registeredStates.push( state );
    }

    public function setInitial( state:IState ):void {
        initialState = state;
        timesSetInitialCalled++;
    }


    private const STARTING:String = "starting";
    private const LOADING:String = "loading";
    private const SAVING:String = "saving";
    private const LOAD:String = "load";
    private const SAVE:String = "save";
    private const START:String = "start";


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
                  </fsm>;


}
}
