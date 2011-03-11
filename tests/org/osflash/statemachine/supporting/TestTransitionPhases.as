/**
 * Created by IntelliJ IDEA.
 * User: revisual.co.uk
 * Date: 11/03/11
 * Time: 10:06
 * To change this template use File | Settings | File Templates.
 */
package org.osflash.statemachine.supporting {
import org.osflash.statemachine.transitioning.TransitionPhase;

public class TestTransitionPhases {
    public static const NONE:TransitionPhase = new TransitionPhase("none", 1);
    public static const EXITING_GUARD:TransitionPhase = new TransitionPhase("exitingGuard", 2);
    public static const ENTERING_GUARD:TransitionPhase = new TransitionPhase("enteringGuard", 4);
    public static const ENTERED:TransitionPhase = new TransitionPhase("entered", 8);
    public static const TEAR_DOWN:TransitionPhase = new TransitionPhase("tearDown", 16);
    public static const CANCELLED:TransitionPhase = new TransitionPhase("cancelled", 32);
    public static const GLOBAL_CHANGED:TransitionPhase = new TransitionPhase("globalChanged", 64);
}
}
