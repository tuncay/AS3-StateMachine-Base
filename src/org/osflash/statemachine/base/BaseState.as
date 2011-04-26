/*
 ADAPTED FOR ROBOTLEGS FROM:
 PureMVC AS3 Utility - StateMachine
 Copyright (c) 2008 Neil Manuell, Cliff Hall
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.osflash.statemachine.base {
import org.osflash.statemachine.core.IState;

/**
 * The Abstract class from which all states should extend.
 */
public class BaseState implements IState {

    /**
     *  Transition map of actions to target states.
     */
    protected var _transitions:Object = new Object();

    /**
     * @private
     */
    private var _name:String;

    /**
     * @private
     */
    private var _referringTransition:String;

    /**
     * This class is  ment to be extended.
     * @param name the name of the state.
     */
    public function BaseState(name:String):void {
        _name = name.toString();
    }

    /**
     * @inheritDoc
     */
    public function get name():String {
        return _name;
    }

    /**
     * @inheritDoc
     */
    public function get referringTransitionName():String {
        return _referringTransition;
    }

    /**
     * @inheritDoc
     */
    public function defineTrans(transitionName:String, target:String):Boolean {
        if (hasTrans(transitionName)) return false;
        _transitions[ transitionName ] = target;
        return true;
    }

    /**
     * @inheritDoc
     */
    public function hasTrans(transitionName:String):Boolean {
        if (_transitions == null) return false;
        return ( _transitions[ transitionName ] != null );
    }

    /**
     * @inheritDoc
     */
    public function removeTrans(transitionName:String):Boolean {
        if (getTarget(transitionName) == null) return false;
        delete _transitions[ transitionName ];
        return true;
    }

    /**
     * @inheritDoc
     */
    public function getTarget(transitionName:String):String {
        if (_transitions[ transitionName ] != null)
            _referringTransition = transitionName;

        return _transitions[ transitionName ];
    }

    /**
     * @inheritDoc
     */
    public function destroy():void {
        _transitions = null;
        _referringTransition = null;
    }
}
}