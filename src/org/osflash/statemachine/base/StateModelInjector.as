/*
 ADAPTED FOR A STAND ALONE UTILITY FROM:
 PureMVC AS3 Utility - StateMachine
 Copyright (c) 2008 Neil Manuell, Cliff Hall
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.osflash.statemachine.base {
import org.osflash.statemachine.base.BaseStateMachine;
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateDecoder;
import org.osflash.statemachine.core.IStateModelInjector;
import org.osflash.statemachine.core.IStateModelOwner;
import org.osflash.statemachine.errors.StateDecodingError;

/**
 * Creates and registers a StateMachine described from a
 * data source.
 *
 * <P>
 * This allows reconfiguration of the StateMachine
 * without changing any code, as well as making it
 * easier than creating all the <code>IState</code>
 * instances and registering them with the
 * <code>StateMachine</code> at startup time.
 *
 * The FSMInjector delegates the knowledge of the data
 * format to its <code>IStateDecoder</code>
 *
 * @ see IStateDecoder
 * @ see IState
 * @ see IStateMachine
 */
public class StateModelInjector implements IStateModelInjector {

    private static const STATE_DECODER_MUST_NOT_BE_NULL:String = "IStateDecoder has not been declared";
    /**
     * The instance of the IStateDecoder
     */
    protected var _stateDecoder:IStateDecoder;

    /**
     * Creates an instance of the FSMInjector.
     * @param stateDecoder the decoder to be used in this instance.
     */
    public function StateModelInjector(stateDecoder:IStateDecoder) {
        _stateDecoder = stateDecoder;
    }

    /**
     * @inheritDoc
     */
    public function inject(stateModel:IStateModelOwner):void {

        if( _stateDecoder == null )
            throw new StateDecodingError( STATE_DECODER_MUST_NOT_BE_NULL );

        var states:Array = _stateDecoder.getStateList();
        for each (var state:IState in states) {
            stateModel.registerState(state, isInitial(state.name));
        }
    }

    /**
     * @inheritDoc
     */
    public function destroy():void {
        _stateDecoder.destroy();
        _stateDecoder = null;
    }

    /**
     * Determines whether the state name passed belongs to the initial state
     * @param stateName
     * @return whether the given state name belongs to the initial state or not.
     */
    protected function isInitial(stateName:String):Boolean {
        return _stateDecoder.isInitial(stateName);
    }


}
}