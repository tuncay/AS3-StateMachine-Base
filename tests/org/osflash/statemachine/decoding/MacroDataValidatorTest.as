package org.osflash.statemachine.decoding {

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.strictlyEqualTo;
import org.osflash.statemachine.decoding.supporting.MockIDataValidator;
import org.osflash.statemachine.supporting.IResultsRegistry;

public class MacroDataValidatorTest implements IResultsRegistry {

    private var _macroDataValidator:MacroDataValidator;
    private var _registry:Array;
    private var _data:String;

    [Before]
    public function before():void {
        initProps();
        initTestSubject();
        addValidatorsToTestSubject();
    }

    [After]
    public function after():void {
        _macroDataValidator = null;
        _registry = null;
        _data = null;
    }

    [Test]
    public function calling_validate_calls_all_childrens_validate_methods_in_correct_order():void {
        const expected:String = "[1]MIDV.d:testing,[2]MIDV.d:testing,[3]MIDV.d:testing,[1]MIDV.v,[2]MIDV.v,[3]MIDV.v";
        callValidateOnTestSubject();
        assertThat( got, equalTo( expected ) );
    }

    [Test]
    public function calling_validate_returns_the_subject_data():void {
        assertThat( callValidateOnTestSubject(), strictlyEqualTo( _data ) );
    }

    private function callValidateOnTestSubject():Object {
        return  _macroDataValidator.validate();
    }

    private function initProps():void {
        _registry = [];
        _data = "testing";
    }

    private function initTestSubject():void {
        _macroDataValidator = new MacroDataValidator( _data );
    }

    private function addValidatorsToTestSubject():void {
        _macroDataValidator.addValidator( new MockIDataValidator( this, 1 ) );
        _macroDataValidator.addValidator( new MockIDataValidator( this, 2 ) );
        _macroDataValidator.addValidator( new MockIDataValidator( this, 3 ) );
    }

    public function get got():String {
        return _registry.join( "," );
    }

    public function pushResult( value:Object ):void {
        _registry.push( value );
    }
}
}
