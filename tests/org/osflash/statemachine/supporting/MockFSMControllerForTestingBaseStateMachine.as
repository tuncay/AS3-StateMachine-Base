/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 21/04/11
 * Time: 09:40
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.base.BaseStateMachine;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.transitioning.TransitionPhase;

public class MockFSMControllerForTestingBaseStateMachine extends BaseStateMachine {

    private var _isTransitionLegal:Boolean;
    private var _isCancellationLegal:Boolean;
    private var _listenForStateChangeOnce_wasCalled:Boolean;
    private var _listenerToAdd_was_invokeTransitionLater:Boolean;
    private var _onTransition_wasCalled:Boolean;
    private var _dispatchGeneralStateChanged_wasCalled:Boolean;
    private var _dispatchTransitionCancelled_wasCalled:Boolean;
    private var _isTransitioning_wasSetTo_true_during_onTransition:Boolean;
    private var _isTransitioning_wasSetTo_false_after_onTransition:Boolean;
    private var _cancelTransitionCallBack:Function;
    private var _onTransitionPayload_equals_cachedPayload:Boolean;
    private var _targetState:IState;
    private var _currentTransitionPhase_wasSetTo_GLOBAL_CHANGED_before_dispatchGeneralStateChange:Boolean;
    private var _currentTransitionPhase_wasSetTo_CANCELLED_before_dispatchTransitionCancelled:Boolean;
    private var _currentTransitionPhase_wasSetTo_NONE_before_resetProperties:Boolean;

    public function MockFSMControllerForTestingBaseStateMachine( initial:IState, target:IState ) {
        super( new StubIStateModelOwnerForTestingFSMController( initial, target ) );
    }

    protected override function get isTransitionLegal():Boolean {
        return _isTransitionLegal
    }

    protected override function get isCancellationLegal():Boolean {
        return _isCancellationLegal;
    }

    public function setIsTransitioningProperty( value:Boolean ):void {
        setIsTransitioning( value );
    }

    public function setIsTransitionLegalProperty( value:Boolean ):void {
        _isTransitionLegal = value;
    }

    public function setIsCancellationLegalProperty( value:Boolean ):void {
        _isCancellationLegal = value;
    }

    public function setCancelTransitionCallback( value:Function ):void {
        _cancelTransitionCallBack = value
    }

    public function cachedInfoEquals( value:String ):Boolean {
        return ( cachedInfo == value );
    }

    public function cachedPayloadEquals( value:Object ):Boolean {
        if( cachedPayload == null && value == null)return true;
        return cachedPayload.equals( value );
    }

    public function getTransitionLaterResults():Boolean {
        return (_listenerToAdd_was_invokeTransitionLater && _listenForStateChangeOnce_wasCalled);
    }

    public override function listenForStateChangeOnce( listener:Function ):* {
        _listenForStateChangeOnce_wasCalled = true;
        _listenerToAdd_was_invokeTransitionLater = (listener == invokeTransitionLater);
        return null;
    }

    public function getFullTransitionResults( targetState:IState ):Boolean {
        return (targetState === _targetState &&
                _onTransition_wasCalled &&
                _onTransitionPayload_equals_cachedPayload &&
                _dispatchGeneralStateChanged_wasCalled &&
                _isTransitioning_wasSetTo_true_during_onTransition &&
                _isTransitioning_wasSetTo_false_after_onTransition &&
               _currentTransitionPhase_wasSetTo_GLOBAL_CHANGED_before_dispatchGeneralStateChange &&
               _currentTransitionPhase_wasSetTo_NONE_before_resetProperties);
    }

    public function getTransitionCancelledResults( targetState:IState ):Boolean {
        return (targetState === _targetState &&
                _onTransition_wasCalled &&
                _onTransitionPayload_equals_cachedPayload &&
                _dispatchTransitionCancelled_wasCalled &&
                _isTransitioning_wasSetTo_true_during_onTransition &&
                _isTransitioning_wasSetTo_false_after_onTransition &&
                _currentTransitionPhase_wasSetTo_CANCELLED_before_dispatchTransitionCancelled &&
               _currentTransitionPhase_wasSetTo_NONE_before_resetProperties);
    }


    protected override function onTransition( target:IState, payload:Object ):void {
        _targetState = target;
        _onTransitionPayload_equals_cachedPayload = cachedPayloadEquals( payload );
        _onTransition_wasCalled = true;
        _isTransitioning_wasSetTo_true_during_onTransition = isTransitioning;
        if ( _cancelTransitionCallBack != null ) _cancelTransitionCallBack();
    }

    protected override function dispatchGeneralStateChanged():void {
        _currentTransitionPhase_wasSetTo_GLOBAL_CHANGED_before_dispatchGeneralStateChange =  currentTransitionPhase.equals( TransitionPhase.GLOBAL_CHANGED );
        _dispatchGeneralStateChanged_wasCalled = true;
        _isTransitioning_wasSetTo_false_after_onTransition = !isTransitioning;
    }

    protected override function dispatchTransitionCancelled():void {
        _currentTransitionPhase_wasSetTo_CANCELLED_before_dispatchTransitionCancelled =  currentTransitionPhase.equals( TransitionPhase.CANCELLED );
        _dispatchTransitionCancelled_wasCalled = true;
        _isTransitioning_wasSetTo_false_after_onTransition = !isTransitioning;
    }


    // so caches arent reset and we can test there values
    override protected function resetProperties():void {
         _currentTransitionPhase_wasSetTo_NONE_before_resetProperties =  currentTransitionPhase.equals( TransitionPhase.NONE );
    }
}
}
