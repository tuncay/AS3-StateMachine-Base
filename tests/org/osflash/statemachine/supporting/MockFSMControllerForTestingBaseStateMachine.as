/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 21/04/11
 * Time: 09:40
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.base.BaseStateMachine;
import org.osflash.statemachine.base.Payload;
import org.osflash.statemachine.core.IPayload;
import org.osflash.statemachine.core.IState;

public class MockFSMControllerForTestingBaseStateMachine extends BaseStateMachine {

    private var _isTransitionLegal:Boolean;
    private var _isCancellationLegal:Boolean;
    private var _listenForStateChangeOnce_wasCalled:Boolean;
    private var _listenerToAddWas_invokeTransitionLater:Boolean;
    private var _onTransition_wasCalled:Boolean;
    private var _dispatchGeneralStateChanged_wasCalled:Boolean;
    private var _dispatchTransitionCancelled_wasCalled:Boolean;
    private var _isTransitioning_wasSetToTrueDurring_onTransiton:Boolean;
    private var _isTransitioning_wasSetToFalseAfter_onTransiton:Boolean;
    private var _cancelTransitionCallBack:Function;
    private var _onTransitionPayload_equalsCachedPayload:Boolean;
    private var _targetState:IState;

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
        return (_listenerToAddWas_invokeTransitionLater && _listenForStateChangeOnce_wasCalled);
    }

    public override function listenForStateChangeOnce( listener:Function ):* {
        _listenForStateChangeOnce_wasCalled = true;
        _listenerToAddWas_invokeTransitionLater = (listener == invokeTransitionLater);
        return null;
    }

    public function getFullTransitionResults( targetState:IState ):Boolean {
        return (targetState === _targetState &&
                _onTransition_wasCalled &&
                _onTransitionPayload_equalsCachedPayload &&
                _dispatchGeneralStateChanged_wasCalled &&
                _isTransitioning_wasSetToTrueDurring_onTransiton &&
                _isTransitioning_wasSetToFalseAfter_onTransiton);
    }

    public function getTransitionCancelledResults( targetState:IState ):Boolean {
        return (targetState === _targetState &&
                _onTransition_wasCalled &&
                _onTransitionPayload_equalsCachedPayload &&
                _dispatchTransitionCancelled_wasCalled &&
                _isTransitioning_wasSetToTrueDurring_onTransiton &&
                _isTransitioning_wasSetToFalseAfter_onTransiton);
    }


    protected override function onTransition( target:IState, payload:Object ):void {
        _targetState = target;
        _onTransitionPayload_equalsCachedPayload = cachedPayloadEquals( payload );
        _onTransition_wasCalled = true;
        _isTransitioning_wasSetToTrueDurring_onTransiton = isTransitioning;
        if ( _cancelTransitionCallBack != null ) _cancelTransitionCallBack();
    }

    protected override function dispatchGeneralStateChanged():void {
        _dispatchGeneralStateChanged_wasCalled = true;
        _isTransitioning_wasSetToFalseAfter_onTransiton = !isTransitioning;
    }

    protected override function dispatchTransitionCancelled():void {
        _dispatchTransitionCancelled_wasCalled = true;
        _isTransitioning_wasSetToFalseAfter_onTransiton = !isTransitioning;
    }


    // so caches arent reset and we can test there values
    override protected function reset():void {
    }
}
}
