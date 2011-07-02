/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 19/04/11
 * Time: 09:13
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModelOwner;
import org.osflash.statemachine.uids.StateUID;
import org.osflash.statemachine.uids.StateTransitionUID;

public class StubStateModelForTestingStateModelInjector implements IStateModelOwner{

    private var _client:IStateRegistry;

    public function StubStateModelForTestingStateModelInjector( client:IStateRegistry ) {
        _client = client;
    }

    public function get initialState():IState {
        return null;
    }

    public function registerState( state:IState, initial:Boolean = false ):Boolean {
        _client.registerState( state );
        if( initial )
            _client.setInitial( state );
        return true;
    }

    public function removeState( stateName:String ):Boolean {
        return false;
    }

    public function hasState( stateName:String ):Boolean {
        return false;
    }

    public function getTargetState( transitionName:StateTransitionUID, state:IState ):IState {
        return null;
    }

    public function dispose():void {
    }
}
}
