/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 11/03/11
 * Time: 13:53
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.base.BaseState;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModel;

public class Stub_StateModel_withStates implements IStateModel{

    public const TARGET_STATE:IState =  new BaseState( "targetState" );
    public const INITIAL_STATE:IState =  new BaseState( "initialState" );

    public function Stub_StateModel_withStates() {
    }

    public function get initialState():IState {
        return INITIAL_STATE;
    }

    public function registerState(state:IState, initial:Boolean = false):Boolean {
        return false;
    }

    public function removeState(stateName:String):Boolean {
        return false;
    }

    public function hasState(stateName:String):Boolean {
        return false;
    }

    public function getTargetState(transitionName:String, state:IState):IState {
        return TARGET_STATE;
    }

    public function destroy():void {
    }
}
}
