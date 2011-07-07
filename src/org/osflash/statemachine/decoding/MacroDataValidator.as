package org.osflash.statemachine.decoding {


public class MacroDataValidator implements IDataValidator {

    private var _data:XML;
    private var _validators:Vector.<IDataValidator>;

    public function MacroDataValidator( data:XML ) {
        _data = data;
        initiateValidator();
    }

    protected function initiateValidator():void { }

    private function get validators():Vector.<IDataValidator> {
        return _validators || ( _validators = new <IDataValidator>[] );
    }

    protected function addValidatorClass( validatorClass:Class ):void {
         validators.push ( new validatorClass( _data ) );
    }

    public function validate():Object {
        for each ( var validator:IDataValidator in _data ) {
           validator.validate();
        }
        return _data;
    }

}
}