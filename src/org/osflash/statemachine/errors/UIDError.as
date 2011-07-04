package org.osflash.statemachine.errors {

/**

 */
public class UIDError extends Error {
    public static const NON_UNIQUE_IDENTIFIER:String = "This uids is not unique: ";

    public function UIDError( msg:String ) {
        super( msg );
    }
}
}