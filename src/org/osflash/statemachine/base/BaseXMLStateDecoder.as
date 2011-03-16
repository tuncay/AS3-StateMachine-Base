package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateDecoder;
import org.osflash.statemachine.errors.StateDecodingError;

/**
 * Provides an abstract class for creating states defined in XML .
 */
public class BaseXMLStateDecoder implements IStateDecoder {
    /**
     * @private
     */
    private var _fsm:XML;

    /**
     *
     * @param fsm the FSM definition.
     */
    public function BaseXMLStateDecoder( fsm:XML )
    {
        setData( fsm );
    }

    /**
     * Sets the FSM definition.
     * @param value
     */
    public function setData( value:Object ):void { _fsm = XML( value ); }

    /**
     * gets the fsm, definition
     */
    protected function getData():XML { return _fsm }

    /**
     * @inheritDoc     */
    public function getStateList():Array
    {
        var stateList:Array = [];
        var stateDefs:XMLList = _fsm..state;
        for ( var i:int; i < stateDefs.length(); i++ ) {
            var stateDef:XML = stateDefs[i];
            var state:IState = decodeState( stateDef );
            stateList.push( state );
        }
        return stateList;
    }

    /**
     * This must be overridden in any subclass to decode the state definition and return a concrete state.
     * @param stateDef the state definition.
     * @return the decoded state.
     */
    public function decodeState( stateDef:Object ):IState { return null }

    /**
     * Ascertains whether the given state is the initial state.
     * @param stateName the name of the given state.
     * @return the result
     */
    public function isInitial( stateName:String ):Boolean
    {
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
            if(! state.defineTrans(String(transDef.@action), String(transDef.@target)) )
                throw  new StateDecodingError( StateDecodingError.TRANSITION_WITH_SAME_NAME_ALREADY_REGISTERED );
        }
    }

    /**
     * The destroy method for GC
     */
    public function destroy():void
    {
        _fsm = null;
    }
}
}