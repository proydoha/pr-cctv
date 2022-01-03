class PR_CCTV_HubUser
{
	int id;
    PR_CCTV_Hub hub;
    Actor user;
    PR_CCTV_CameraManager cameraManager;
    int eventCursorPosition;
    
    play void Init()
    {
        cameraManager = new("PR_CCTV_CameraManager");
        cameraManager.hubUser = self;
        cameraManager.Init();
    }

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
        //Example to try if everything works as expected

        //PR_CCTV_LineAction lineAction = hub.handler.lineActionDB.LineActions[event.special];
        //if (lineAction.targetType.Size() == 0) { return; }
        //if (lineAction.targetType[0] != hub.handler.lineActionDB.TypeSector) { return; }
        //cameraManager.BuildListOfTargetSectors(level.lines[event.activatedLine].args[lineAction.targetArg[0]], event.activatedLine, lineAction.targetZeroRule[0]);
        //cameraManager.BuildListOfTargetLinesFromSectors();
        //cameraManager.LookAtLine(0, event.activatedLine);
        //cameraManager.LookAtLine(1, cameraManager.lineTargets[0].Index());
    }
}