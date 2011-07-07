package org.osflash.statemachine.supporting {

    public class InjectTokenIntoString implements ITokenInjector {

        private var _value:String;

        public function InjectTokenIntoString( value:String ) {
            _value = value;
        }

        public function withThis( keyword:String, replace:* ):ITokenInjector {
            inject( keyword, replace );
            return this;
        }

         public function finallyWith( keyword:String, replace:* ):String {
            inject( keyword, replace );
            return _value;
        }

        private function inject( keyword:String, replace:* ):void {
            const regexp:RegExp = new RegExp( "\\$\\{(" + keyword + ")\\}", "g" );
            _value = _value.replace( regexp, replace.toString() );
        }

        public function toString():String {
            return _value;
        }
    }
}
