package org.osflash.statemachine.model.supporting {

import org.osflash.statemachine.model.TransitionBinding;

public interface IBindingRegistry {
    function setBinding( transitionBinding:TransitionBinding):void;
}
}
