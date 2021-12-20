class PR_CCTV_HubUser
{
	int id;
    PR_CCTV_Hub hub;
    Actor user;

    int eventCursorPosition;

    play void GetNextItem()
    {
        if (hub.events.Size() == 0) { return; }
        eventCursorPosition++;
        eventCursorPosition = PR_CCTV_Math.Modulo(eventCursorPosition, hub.events.Size());
        
        PR_CCTV_MapEvent me = hub.events[eventCursorPosition];
        PR_CCTV_DebugMessages.DebugMessage(String.Format("Time: %d, Special: %d, Special name: %s, Activated line: %d, Activator class: %s, Activation type: %d", 
            me.timeStamp, me.special, hub.handler.lineActionDB.LineActions[me.special].name, me.activatedLine, me.activatorClass, me.activationType));
    }

    play void GetPreviousItem()
    {
        if (hub.events.Size() == 0) { return; }
        eventCursorPosition--;
        eventCursorPosition = PR_CCTV_Math.Modulo(eventCursorPosition, hub.events.Size());

        PR_CCTV_MapEvent me = hub.events[eventCursorPosition];
        PR_CCTV_DebugMessages.DebugMessage(String.Format("Time: %d, Special: %d, Special name: %s, Activated line: %d, Activator class: %s, Activation type: %d", 
            me.timeStamp, me.special, hub.handler.lineActionDB.LineActions[me.special].name, me.activatedLine, me.activatorClass, me.activationType));
    }

    play void OnMapEvent(PR_CCTV_MapEvent event)
    {

    }
}