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
    public function calling_validate_calls_all_childrens_validate_methods():void {
        const expected:String = "[0]MIDV.d:testing,[1]MIDV.d:testing,[2]MIDV.d:testing,[3]MIDV.v,[4]MIDV.v,[5]MIDV.v";
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
        const validator:IDataValidator = new MockIDataValidator( this );
        _macroDataValidator.addValidator( validator );
        _macroDataValidator.addValidator( validator );
        _macroDataValidator.addValidator( validator );
    }

    public function get got():String {
        return _registry.join( "," );
    }

    public function pushResult( value:Object ):void {
        _registry.push( value );
    }
}
}
