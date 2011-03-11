/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 09/03/11
 * Time: 16:26
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.core.IFSMController;
import org.osflash.statemachine.core.IFSMControllerOwner;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.ITransitionPhase;

public class MockFSMController implements IFSMControllerOwner, IFSMController {

    private var _currentState:IState;
    private var _isTransitioning:Boolean;

    public function MockFSMController() {
    }

    public function get hasChangedListener():Boolean {
        return false;
    }

    public function listenForIncomingCalls(listener:Function):Function {
        return null;
    }

    public function dispatchStateChange(stateName:String):void {
    }

    public function setCurrentState(state:IState):void {
        _currentState = state;
    }

    public function setIsTransitioning(value:Boolean):void {
        _isTransitioning = value;
    }

    public function setTransitionPhase(value:ITransitionPhase):void {
    }

    public function setReferringTransition(value:String):void {
    }

    public function destroy():void {
    }

    public function get currentStateName():String {
        return _currentState.name;
    }

    public function get referringTransitionName():String {
        return "";
    }

    public function get isTransitioning():Boolean {
        return _isTransitioning;
    }

    public function get transitionPhase():ITransitionPhase {
        return null;
    }

    public function transition(transitionName:String, payload:Object = null):void {
    }

    public function cancelStateTransition(reason:String, payload:Object = null):void {
    }

    public function listenForStateChange(listener:Function):Function {
        return null;
    }

    public function stopListeningForStateChange(listener:Function):Function {
        return null;
    }

    public function listenForStateChangeOnce(listener:Function):Function {
        return null;
    }
}
}
