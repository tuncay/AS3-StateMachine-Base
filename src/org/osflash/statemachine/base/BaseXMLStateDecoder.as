package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateDecoder;
import org.osflash.statemachine.errors.StateDecodingError;

/**
 * Provides an abstract class for creating states defined in XML .
 */
public class BaseXMLStateDecoder implements IStateDecoder {

    private static const NULL_DATA_ERROR:String = "No FSM data has been defined, or the value passed is null";
    private static const TRANSITION_WITH_SAME_NAME_ALREADY_REGISTERED:String = "A transition with that name has already been registered: ";
    private static const INITIAL_STATE_NOT_DECLARED:String = "The initial state attribute is undefined";
    private static const INITIAL_STATE_NOT_FOUND:String = "The initial state attribute refers to a state that is not defined";
    private static const STATE_NAME_NOT_DECLARED:String = "The name attribute for this state element is undefined:";
    private static const TRANSITION_NAME_NOT_DECLARED:String = "The name attribute for this transition element is undefined:";
    private static const TRANSITION_TARGET_NOT_DECLARED:String = "The target attribute for this transition element is undefined:";
    private static const STATE_EQUALS:String = " state = ";
    private static const POSITION_EQUALS:String = " position = ";
    /**
     * @private
     */
    private var _fsm:XML;

    /**
     *
     * @param fsm the FSM definition.
     */
    public function BaseXMLStateDecoder(fsm:XML = null) {
        if (fsm != null)
            setData(fsm);
    }

    /**
     * Sets the FSM definition.
     * @param value
     */
    public function setData(value:Object):void {
        _fsm = XML(value);

        if( _fsm == null )
            throw new StateDecodingError( NULL_DATA_ERROR );

        if (_fsm.@initial == undefined)
            throw new StateDecodingError(INITIAL_STATE_NOT_DECLARED);

        var statenames:XMLList = _fsm..state.(hasOwnProperty("@name") && @name == _fsm.@initial );

        if (statenames.length() == 0)
            throw new StateDecodingError(INITIAL_STATE_NOT_FOUND);
    }

    /**
     * gets the fsm, definition
     */
    protected function getData():XML {
        return _fsm
    }

    /**
     * @inheritDoc     */
    public function getStateList():Array {

        if( _fsm == null )
            throw new StateDecodingError( NULL_DATA_ERROR );

        var stateList:Array = [];
        var stateDefs:XMLList = _fsm..state;

        for (var i:int; i < stateDefs.length(); i++) {
            var stateDef:XML = stateDefs[i];

            if (stateDef.@name == undefined)
                throw new StateDecodingError(STATE_NAME_NOT_DECLARED + POSITION_EQUALS + stateDef.childIndex());

            var state:IState = decodeState(stateDef);
            decodeTransitions(state, stateDef);
            stateList.push(state);
        }
        return stateList;
    }

    /**
     * This must be overridden in any subclass to decode the state definition and return a concrete state.
     * @param stateDef the state definition.
     * @return the decoded state.
     */
    public function decodeState(stateDef:Object):IState {
        return null
    }

    /**
     * Ascertains whether the given state is the initial state.
     * @param stateName the name of the given state.
     * @return the result
     */
    public function isInitial(stateName:String):Boolean {
        var initial:String = _fsm.@initial.toString();
        return (stateName == initial);
    }

    /**
     * Decodes the State's transitions from the state declaration
     * @param state the state into which to inject the transitions
     * @param stateDef the state's declaration
     */
    protected function decodeTransitions(state:IState, stateDef:Object):void {
        var transitions:XMLList = stateDef..transition as XMLList;
        for (var i:int; i < transitions.length(); i++) {
            var transDef:XML = transitions[i];
            //todo: write tests for these errors
            if (transDef.@name == undefined)
                throw new StateDecodingError(TRANSITION_NAME_NOT_DECLARED + STATE_EQUALS + state.name + POSITION_EQUALS + transDef.childIndex());
            if (transDef.@target == undefined)
                throw new StateDecodingError(TRANSITION_TARGET_NOT_DECLARED + STATE_EQUALS + state.name + POSITION_EQUALS + transDef.childIndex());

            if (! state.defineTrans(String(transDef.@name), String(transDef.@target)))
                throw  new StateDecodingError(TRANSITION_WITH_SAME_NAME_ALREADY_REGISTERED);
        }
    }

    /**
     * The destroy method for GC
     */
    public function destroy():void {
        _fsm = null;
    }
}
}