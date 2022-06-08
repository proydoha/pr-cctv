class PR_CCTV_HubUser : Thinker
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
    Array<PR_CCTV_MapEvent> eventQueue;

    play void Init()
    {
        cameraManager = new("PR_CCTV_CameraManager");
        cameraManager.hubUser = self;
        cameraManager.Init();

        //TODO: Remove example filters
        PR_CCTV_Filter filter1 = new("PR_CCTV_Filter");
        PR_CCTV_FilterCriteriaBase criteria1 = PR_CCTV_FilterCriteriaActivatorType.Create(PR_CCTV_FilterCriteriaActivatorType.IsHubUser);
        filter1.AddCriteria(criteria1);
        camera1Filters.push(filter1);

        PR_CCTV_Filter filter2 = new("PR_CCTV_Filter");
        PR_CCTV_FilterCriteriaBase criteria2 = PR_CCTV_FilterCriteriaActivationCount.Create(1);
        filter2.AddCriteria(criteria2);
        eventsFilters.push(filter2);

        PR_CCTV_Filter filter3 = new("PR_CCTV_Filter");
        PR_CCTV_FilterCriteriaBase criteria3 = PR_CCTV_FilterCriteriaTargetOnBacksideOfALine.Create();
        filter3.AddCriteria(criteria3);
        filter3.AddCriteria(criteria1);
        camera2Filters.push(filter3);
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
        //TODO: Add queue
        bool addEvent = true;
        for (int i = 0; i < eventsFilters.Size(); i++)
        {
            if (eventsFilters[i].CheckEvent(event, user))
            {
                addEvent = false;
                break;
            }
        }
        if (addEvent)
        {
            events.push(event);
        }

        bool showCamera1 = true;
        for (int i = 0; i < camera1Filters.Size(); i++)
        {
            if (camera1Filters[i].CheckEvent(event, user))
            {
                showCamera1 = false;
                break;
            }
        }
        bool showCamera2 = true;
        for (int i = 0; i < camera2Filters.Size(); i++)
        {
            if (camera2Filters[i].CheckEvent(event, user))
            {
                showCamera2 = false;
                break;
            }
        }
        if (showCamera1)
        {
            cameraManager.LookAtLine(0, event.activatedLine);
            cameraManager.camera[0].Show();
        }
        if (showCamera2)
        {
            if (event.targetType != PR_CCTV_LineActionDB.TypeSector) { return; }
            cameraManager.BuildListOfTargetSectors(event.target, event.activatedLine, event.targetZeroRule);
            cameraManager.BuildListOfTargetLinesFromSectors();
            cameraManager.LookAtLine(1, cameraManager.lineTargets[0].Index());
            cameraManager.camera[1].Show();
        }
    }
}
