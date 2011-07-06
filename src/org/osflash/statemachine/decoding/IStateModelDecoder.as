package org.osflash.statemachine.decoding {

import org.osflash.statemachine.model.IStateModel;

public interface IStateModelDecoder {

    function inject( stateModel:IStateModel ):void

}
}