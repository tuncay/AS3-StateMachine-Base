package org.osflash.statemachine.core {


public interface IState {

    function get name():String;

    function get index():uint

    function defineTransition( transitionName:String, target:String ):Boolean;

    function removeTrans( transitionName:String ):Boolean;

    function hasTrans( transitionName:String ):Boolean;

    function getTarget( transitionName:String ):String;

}
}