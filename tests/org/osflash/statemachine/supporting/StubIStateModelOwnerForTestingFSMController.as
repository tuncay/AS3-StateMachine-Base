/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 21/04/11
 * Time: 09:14
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateModelOwner;

public class StubIStateModelOwnerForTestingFSMController implements IStateModelOwner {

    private var _initial:IState;
    private var _target:IState;

    public function StubIStateModelOwnerForTestingFSMController( initial:IState, target:IState) {
        _initial = initial;
        _target = target;
    }

    public function get initialState():IState {
        return _initial;
    }

    public function getTargetState( transitionName:String, state:IState ):IState {
        return _target;
    }

    public function registerState( state:IState, initial:Boolean = false ):Boolean {
        return false;
    }

    public function removeState( stateName:String ):Boolean {
        return false;
    }

    public function hasState( stateName:String ):Boolean {
        return false;
    }

    public function destroy():void {
    }
}
}
