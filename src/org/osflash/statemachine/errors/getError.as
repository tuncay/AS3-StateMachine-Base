
package org.osflash.statemachine.errors {

public function getError( code:int ):BaseStateError {
    return ErrorCodes.getError( code )
}
}
