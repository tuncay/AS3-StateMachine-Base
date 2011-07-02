package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IState;
import org.osflash.statemachine.core.IStateDecoder;
import org.osflash.statemachine.core.UID;
import org.osflash.statemachine.uids.BaseUID;
import org.osflash.statemachine.errors.StateDecodingError;
import org.osflash.statemachine.uids.getUIDFromIdentifier;

public class BaseXMLStateDecoder implements IStateDecoder {

    private static const NULL_DATA_ERROR:String = "No FSM data has been defined, or the value passed is null";
    private static const STATE_WITH_SAME_NAME_ALREADY_REGISTERED:String = "A state with this name has already been registered: ";
    private static const TRANSITION_WITH_SAME_NAME_ALREADY_REGISTERED:String = "A transition with this name has already been registered: ";
    private static const INITIAL_STATE_ATTRIBUTE_NOT_DECLARED:String = "The initial state attribute is undefined";
    private static const INITIAL_STATE_NOT_FOUND:String = "The initial state attribute refers to a state that is not defined";
    private static const STATE_NAME_NOT_DECLARED:String = "The name attribute for this state element is undefined:";
    private static const TRANSITION_NAME_NOT_DECLARED:String = "The name attribute for this transition element is undefined:";
    private static const TRANSITION_TARGET_NOT_DECLARED:String = "The target attribute for this transition element is undefined:";
    private static const STATE_EQUALS:String = " state = ";
    private static const POSITION_EQUALS:String = " position = ";

    private var _fsm:XML;

    public function BaseXMLStateDecoder( fsm:XML = null ) {
        if ( fsm != null )
            setData( fsm );
    }

    public function setData( value:Object ):void {
        _fsm = XML( value );

        if ( _fsm == null )
            throw new StateDecodingError( NULL_DATA_ERROR );

        if ( _fsm.@initial == undefined )
            throw new StateDecodingError( INITIAL_STATE_ATTRIBUTE_NOT_DECLARED );

        const statenames:XMLList = _fsm..state.(hasOwnProperty( "@name" ) && @name == _fsm.@initial );

        if ( statenames.length() == 0 )
            throw new StateDecodingError( INITIAL_STATE_NOT_FOUND );
    }

    protected function getData():XML {
        return _fsm
    }

    public function getStateList():Array {

        if ( _fsm == null )
            throw new StateDecodingError( NULL_DATA_ERROR );

        const stateList:Array = [];
        const stateDefs:XMLList = _fsm..state;

        for ( var i:int; i < stateDefs.length(); i++ ) {
            const stateDef:XML = stateDefs[i];

            if ( stateDef.@name == undefined )
                throw new StateDecodingError( STATE_NAME_NOT_DECLARED + POSITION_EQUALS + stateDef.childIndex() );

            const state:IState = decodeState( stateDef );
            decodeTransitions( state, stateDef );

            if ( hasState( state, stateList ) )
                throw new StateDecodingError( STATE_WITH_SAME_NAME_ALREADY_REGISTERED + state.uid );

            stateList.push( state );
        }
        return stateList;
    }

    private function hasState( state:IState, stateList:Array ):Boolean {
        for each ( var s:IState in stateList )
            if ( state.uid == s.uid )return true;
        return false;
    }

    public function decodeState( stateDef:Object ):IState {
        const stateUID:UID = getUIDFromIdentifier( stateDef.@name );
        return new BaseState( stateUID );
    }

    public function isInitial( stateName:String ):Boolean {
        var initial:String = _fsm.@initial.toString();
        return (stateName == initial);
    }

    protected function decodeTransitions( state:IState, stateDef:Object ):void {
        var transitions:XMLList = stateDef..transition as XMLList;
        for ( var i:int; i < transitions.length(); i++ ) {
            var transDef:XML = transitions[i];
            validateTransitionDefinition( transDef );
            defineTransition( state, transDef );


        }
    }

    private function validateTransitionDefinition( transDef:XML ):void {
        if ( transDef.@name == undefined )
            throw new StateDecodingError( TRANSITION_NAME_NOT_DECLARED + STATE_EQUALS + state.uid + POSITION_EQUALS + transDef.childIndex() );
        if ( transDef.@target == undefined )
            throw new StateDecodingError( TRANSITION_TARGET_NOT_DECLARED + STATE_EQUALS + state.uid + POSITION_EQUALS + transDef.childIndex() );

    }

    private function defineTransition( state:IState, transDef:XML ):void {
        const transitionUID:UID = getUIDFromIdentifier( transDef.@name );
        const targetUID:UID = getUIDFromIdentifier( transDef.@target );


        state.defineTransition( transitionUID, targetUID )

        if ( ! state.hasTrans() )
            throw  new StateDecodingError( TRANSITION_WITH_SAME_NAME_ALREADY_REGISTERED );
    }

    public function destroy():void {
        _fsm = null;
    }
}
}