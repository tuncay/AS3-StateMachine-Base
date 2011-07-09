package revisual.utils {

public interface ITokenInjector {
    function withThis( keyword:String, replace:* ):ITokenInjector

    function finalyWith( keyword:String, replace:* ):String

    function toString():String;
}

}
