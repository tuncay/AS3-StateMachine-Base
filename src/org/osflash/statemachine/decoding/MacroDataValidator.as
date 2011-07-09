package org.osflash.statemachine.decoding {

public class MacroDataValidator implements IDataValidator {

    private var _data:Object;
    private var _validators:Vector.<IDataValidator>;

    public function MacroDataValidator( data:Object ) {
        _data = data;
    }

    public function set data( data:Object ):void {
        _data = data;
    }

    public function addValidator( validator:IDataValidator ):void {
        validator.data = _data;
        validators.push( validator );
    }

    public function validate():Object {
        for each ( var validator:IDataValidator in validators ) {
            validator.validate();
        }
        return _data;
    }

    private function get validators():Vector.<IDataValidator> {
        return _validators || ( _validators = new <IDataValidator>[] );
    }


}
}