package revisual.utils {

public function injectThis( value:String ):ITokenInjector {
    return new InjectTokenIntoString( value );
}

}
