/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 19/04/11
 * Time: 09:15
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.core.IState;

public interface IStateRegistry {
    function registerState( state:IState ):void

    function setInitial( state:IState ):void;
}
}
