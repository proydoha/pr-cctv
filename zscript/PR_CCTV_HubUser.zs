class PR_CCTV_HubUser
{
	int id;
    PR_CCTV_Hub hub;
    Actor user;
    PR_CCTV_CameraManager cameraManager;
    int eventCursorPosition;
    Array<PR_CCTV_Filter> eventsFilters;
    Array<PR_CCTV_Filter> camera1Filters;
    Array<PR_CCTV_Filter> camera2Filters;
    Array<PR_CCTV_MapEvent> events;
    
    play void Init()
    {
        cameraManager = new("PR_CCTV_CameraManager");
        cameraManager.hubUser = self;
        cameraManager.Init();

        //TODO: Remove example filters
        eventsFilters.push(new("PR_CCTV_Filter"));
        eventsFilters[0].filterByActivationCount = true;
        eventsFilters[0].firstActivationOnly = true;
        camera1Filters.push(new("PR_CCTV_Filter"));
        camera1Filters[0].filterByActivatorIsHubUser = true;
    }

    play void GetNextItem()
    {
        int eventTotal = events.Size();
        if (eventTotal == 0) { return; }
        eventCursorPosition++;
        eventCursorPosition = PR_CCTV_Math.Modulo(eventCursorPosition, eventTotal);
        
        PR_CCTV_MapEvent me = events[eventCursorPosition];
        PR_CCTV_DebugMessages.DebugMessage(String.Format("[%d/%d] %s", (eventCursorPosition + 1), eventTotal, me.GetInformation()));
    }

    play void GetPreviousItem()
    {
        int eventTotal = events.Size();
        if (eventTotal == 0) { return; }
        eventCursorPosition--;
        eventCursorPosition = PR_CCTV_Math.Modulo(eventCursorPosition, eventTotal);

        PR_CCTV_MapEvent me = events[eventCursorPosition];
        PR_CCTV_DebugMessages.DebugMessage(String.Format("[%d/%d] %s", (eventCursorPosition + 1), eventTotal, me.GetInformation()));
    }

    play void OnMapEvent(PR_CCTV_MapEvent event)
    {
        //Check filters / Move cameras
        //TODO: Add queue, add fade in / fade out
        bool addToEvents = true;
        for (int i = 0; i < eventsFilters.Size(); i++)
        {
            if (eventsFilters[i].CheckEvent(event, user) == false)
            {
                addToEvents = false;
                break;
            }
        }
        if (addToEvents)
        {
            events.push(event);
        }

        bool showCamera1 = true;
        for (int i = 0; i < camera1Filters.Size(); i++)
        {
            if (camera1Filters[i].CheckEvent(event, user) == false)
            {
                showCamera1 = false;
                break;
            }
        }
        bool showCamera2 = true;
        for (int i = 0; i < camera2Filters.Size(); i++)
        {
            if (camera2Filters[i].CheckEvent(event, user) == false)
            {
                showCamera2 = false;
                break;
            }
        }
        if (showCamera1)
        {
            cameraManager.LookAtLine(0, event.activatedLine);
        }
        if (showCamera2)
        {
            if (event.targetType != PR_CCTV_LineActionDB.TypeSector) { return; }
            cameraManager.BuildListOfTargetSectors(event.target, event.activatedLine, event.targetZeroRule);
            cameraManager.BuildListOfTargetLinesFromSectors();
            cameraManager.LookAtLine(1, cameraManager.lineTargets[0].Index());
        }
    }
}