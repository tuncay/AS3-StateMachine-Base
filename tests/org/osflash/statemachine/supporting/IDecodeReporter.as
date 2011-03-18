/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 18/03/11
 * Time: 13:46
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.core.IState;

public interface IDecodeReporter {
    function reportStateDefFromDecodeState(stateDef:XML):void;
    function reportStateDefFromDecodeTransition(stateDef:XML):void;

    function reportStateFromDecodeState(state:IState):void;
    function reportStateFromDecodeTransition(state:IState):void;
}
}
