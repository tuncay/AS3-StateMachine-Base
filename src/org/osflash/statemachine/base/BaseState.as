package org.osflash.statemachine.base {

import org.osflash.statemachine.core.IState;

public class BaseState implements IState {

    protected var _transitions:Object = new Object();
    private var _name:String;
    private var _index:uint;

    public function BaseState( id:String, index:uint ):void {
        _name = id;
        _index = index;
    }

    public function get name():String {
        return _name;
    }

    public function get index():uint {
        return _index;
    }

    public function defineTransition( transitionName:String, target:String ):Boolean {
        if ( hasTrans( transitionName ) ) return false;
        _transitions[ transitionName ] = target;
        return true;
    }

    public function hasTrans( transitionName:String ):Boolean {
        if ( _transitions == null ) return false;
        return ( _transitions[ transitionName ] != null );
    }

    public function removeTrans( transitionName:String ):Boolean {
        const targetName:String = getTarget( transitionName );
        if ( targetName == null ) return false;
        delete _transitions[ transitionName ];
        return true;
    }

    public function getTarget( transitionName:String ):String {
        return _transitions[ transitionName ];
    }

    public function toString():String {
        return name + ":" + index;
    }

    public function transitionsToString():String {
        var a:Array = [];
        for ( var transitionName:String in _transitions ) {
            a.push( transitionName + ":" + _transitions[transitionName] )
        }
        return a.join( "," );
    }
}
}