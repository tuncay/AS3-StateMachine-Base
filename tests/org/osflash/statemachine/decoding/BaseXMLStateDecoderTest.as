package org.osflash.statemachine.decoding {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.decoding.supporting.MockIDataValidator;
import org.osflash.statemachine.supporting.IResultsRegistry;

public class BaseXMLStateDecoderTest implements IResultsRegistry {

    private var _xmlStateDecoder:BaseXMLStateDecoder;
    private var _registry:Array;
    private var _data:String;
    private var _validator:IDataValidator;
    private const FSM:XML =
                  <fsm initial="state/initial">
                      <state name="state/starting" >
                          <transition name="transition/end" target="state/endinging"/>
                      </state>

                      <state name="state/middling" >
                          <transition name="transition/start" target="state/starting"/>
                          <transition name="transition/end" target="state/endinging"/>
                      </state>

                      <state name="state/ending" >
                          <transition name="transition/middle" target="state/middling"/>
                      </state>
                  </fsm>;

    [Before]
    public function before():void {
        initProps();
        initTestSubject();
    }

    [After]
    public function after():void {
        _xmlStateDecoder = null;
        _registry = null;
        _data = null;
    }

    [Test]
    public function getStates_should_decode_all_the_states_with_correct_names_and_indices():void {
        const expected:String = "state/starting:1,state/middling:2,state/ending:4";
        const results:String = _xmlStateDecoder.getStates().toString();
        assertThat( results, equalTo( expected ) );
    }

    [Test]
    public function getStates_should_decode_all_the_states_transitions_correctly():void {
        const results:Vector.<IState> = _xmlStateDecoder.getStates();
        //assertThatStatesHaveExpectedTransitions(results);
    }



    private function initProps():void {
        _registry = [];
        _validator = new MockIDataValidator( this, 1 );
        _validator.data = FSM;
    }

    private function initTestSubject():void {
        _xmlStateDecoder = new BaseXMLStateDecoder();
        _xmlStateDecoder.setData( _validator );
    }


    public function get got():String {
        return _registry.join( "," );
    }

    public function pushResult( value:Object ):void {
        _registry.push( value );
    }
}
}
