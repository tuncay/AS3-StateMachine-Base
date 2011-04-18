/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 18/04/11
 * Time: 17:11
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.base {
import org.flexunit.Assert;
import org.osflash.statemachine.core.IStateDecoder;

public class BaseXMLDecoderTest {

    private var decoder:IStateDecoder;

    public function setUp(fsm:XML):void {
        decoder = new BaseXMLStateDecoder(fsm);
    }

    [After]
    public function after():void {
        decoder = null;
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function when_null_value_is_passed_setData_throws_error():void {
        setUp(null);
        decoder.setData(null);
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function when_null_data_is_passed_to_constructor_getStateList_throws_error():void {
        setUp(null);
        decoder.getStateList();
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function if_no_initial_state_is_declared_in_data_setData_throws_error():void {
        setUp(NO_INITIAL_STATE_DECLARED);
    }

    [Test (expected="org.osflash.statemachine.errors.StateDecodingError")]
    public function if_initial_state_cannot_be_found_in_data_setData_throws_error():void {
        setUp(INITIAL_STATE_NOT_FOUND);
    }

    private const NO_INITIAL_STATE_DECLARED:XML =
            <fsm>
                <state name="one"/>
            </fsm>

    private const INITIAL_STATE_NOT_FOUND:XML =
            <fsm initial="two">
                <state name="one"/>
            </fsm>
}
}
