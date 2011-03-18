/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 18/03/11
 * Time: 13:46
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.base.BaseXMLStateDecoder;
import org.osflash.statemachine.core.IState;

public class MockStateDecoder extends BaseXMLStateDecoder {

    private var _client:IDecodeReporter;

    public function MockStateDecoder( fsm:XML, client:IDecodeReporter ) {
        _client = client;
        super(fsm);
    }

    override public function decodeState(stateDef:Object):IState {
        var state:IState = new BaseState( stateDef.@name.toString() );
        _client.reportStateDefFromDecodeState( XML(stateDef) );
        _client.reportStateFromDecodeState( state );
        return state;
    }

    override protected function decodeTransitions(state:IState, stateDef:Object):void {
        super.decodeTransitions(state, stateDef);
        _client.reportStateFromDecodeTransition( state );
        _client.reportStateDefFromDecodeTransition( XML(stateDef) );
    }
}
}
