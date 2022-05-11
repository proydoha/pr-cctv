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

    CameraStates cameraState;

    int cameraFadeInTime;
    int cameraFadeOutTime;
    int cameraOnScreenTime;
    int camera1Timer;
    int camera2Timer;
    float camera1Alpha;
    float camera2Alpha;

    enum CameraStates
    {
        OffScreen = 0,
        FadeIn,
        OnScreen,
        FadeOut
    }

    play void Init()
    {
        cameraManager = new("PR_CCTV_CameraManager");
        cameraManager.hubUser = self;
        cameraManager.Init();

        cameraState = OffScreen;
        cameraFadeInTime = 10;
        cameraFadeOutTime = 35;
        cameraOnScreenTime = 35*5;
        camera1Timer = 0;
        camera2Timer = 0;

        camera1Alpha = 0;
        camera2Alpha = 0;

        //TODO: Remove example filters
        eventsFilters.push(new("PR_CCTV_Filter"));
        eventsFilters[0].filterByActivationCount = true;
        eventsFilters[0].firstActivationOnly = true;
        camera1Filters.push(new("PR_CCTV_Filter"));
        camera1Filters[0].filterByActivatorIsHubUser = true;
    }

    //I think all of this management should be in a different class
    play void ManageCameraStates()
    {
        if (camera1Timer == 0)
        {
            if (cameraState == OffScreen) { return; }
            else if (cameraState == FadeIn)
            {
                cameraState = OnScreen;
                camera1Timer = cameraOnScreenTime;
                camera2Timer = cameraOnScreenTime;                
            }
            else if (cameraState == OnScreen)
            {
                cameraState = FadeOut;
                camera1Timer = cameraFadeOutTime;
                camera2Timer = cameraFadeOutTime;
                camera1Alpha = 1.0;
                camera2Alpha = 1.0;
            }
            else if (cameraState == FadeOut)
            {
                cameraState = OffScreen;
                camera1Alpha = 0.0;
                camera2Alpha = 0.0;
            }
        }
        else 
        {
            camera1Timer--;
            camera2Timer--;

            if (cameraState == FadeIn)
            {
                camera1Alpha = 1.0 - float(camera1Timer)/float(cameraFadeInTime);
                camera2Alpha = 1.0 - float(camera2Timer)/float(cameraFadeInTime);
            }
            else if (cameraState == FadeOut)
            {
                camera1Alpha = float(camera1Timer)/float(cameraFadeOutTime);
                camera2Alpha = float(camera2Timer)/float(cameraFadeOutTime);
            }
        }
    }

    play void ShowCamera()
    {
        cameraState = FadeIn;
        camera1Timer = cameraFadeInTime;
        camera2Timer = cameraFadeInTime;
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
            ShowCamera();
        }
        if (showCamera2)
        {
            if (event.targetType != PR_CCTV_LineActionDB.TypeSector) { return; }
            cameraManager.BuildListOfTargetSectors(event.target, event.activatedLine, event.targetZeroRule);
            cameraManager.BuildListOfTargetLinesFromSectors();
            cameraManager.LookAtLine(1, cameraManager.lineTargets[0].Index());
            ShowCamera();
        }
    }

    override void Tick()
    {
        ManageCameraStates();
    }
}