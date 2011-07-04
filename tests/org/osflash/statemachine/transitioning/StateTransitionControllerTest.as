package org.osflash.statemachine.transitioning {

public class StateTransitionControllerTest {

    private var stateTransitionController:StateTransitionController;


    [Before]
    public function before():void {
        stateTransitionController = new StateTransitionController(null, null);

    }

    [After]
    public function tearDown():void {
        stateTransitionController = null;
    }

    [Test]
    public function test():void {

    }
}
}
