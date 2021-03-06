class PR_CCTV_EventHandler : EventHandler
{
	PR_CCTV_HubManager hubManager;
	PR_CCTV_LineActionDB lineActionDB;
	Array<int> lineActivationCounter;
	
	override void OnRegister()
	{
		PR_CCTV_DebugMessages.DebugMessage("Event handler registered");
		hubManager = new("PR_CCTV_HubManager");
		hubManager.handler = self;
		lineActionDB = new("PR_CCTV_LineActionDB");
		lineActionDB.InitDatabase();		
	}

	override void PlayerEntered(PlayerEvent e)
	{
		PR_CCTV_DebugMessages.DebugMessage("Player entered");
		hubManager.FindHubsOnMap();
		hubManager.ConnectPlayerToHub(e.PlayerNumber);
	}
	
	override void WorldLoaded(WorldEvent e)
	{		
		PR_CCTV_DebugMessages.DebugMessage("World Loaded");
		for (int i = 0; i < level.Lines.Size(); i++)
		{
			lineActivationCounter.push(0);
		}
	}
	
	override void RenderOverlay(RenderEvent e) 
	{
		if (!e) { return; }
		Actor playerActor = e.camera;
		if (!playerActor) { return; }
		if (!playerActor.player) { return; }
		PR_CCTV_DataToken token = PR_CCTV_DataToken(playerActor.FindInventory("PR_CCTV_DataToken"));
		if (!token) { return; }
		if (!token.hub) { return; }
		if (!token.user) { return; }
		if (!token.user.cameraManager) { return; }
		if (token.user.cameraManager.camera.Size() == 0) { return; }
		float camera1Alpha = token.user.cameraManager.camera[0].cameraAlpha;
		float camera2Alpha = token.user.cameraManager.camera[1].cameraAlpha;
		PR_CCTV_Camera.DrawScreen(e.camera, "CAMERA1", camera1Alpha);
		PR_CCTV_Camera.DrawScreen(e.camera, "CAMERA2", camera2Alpha);
	}
	
	override void WorldLineActivated(WorldEvent e)
	{
		PR_CCTV_DebugMessages.DebugMessage("World Line Activated");
		int activatedLineIndex = e.ActivatedLine.Index();
		lineActivationCounter[activatedLineIndex]++;
		hubManager.RegisterMapEvent(level.Time, level.lines[activatedLineIndex].Special, activatedLineIndex, e.Thing, e.ActivationType, lineActivationCounter[activatedLineIndex]);
	}
	
	override void NetworkProcess (ConsoleEvent e)
	{
		//PR_CCTV_DebugMessages.DebugMessage("Network Process");

		Actor playerActor = players[e.Player].mo;
		if (!playerActor) { return; }
		PR_CCTV_DataToken token = PR_CCTV_DataToken(playerActor.FindInventory("PR_CCTV_DataToken"));
		if (!token) { return; }
		if (!token.hub) { return; }
		if (!token.user) { return; }
				
		if (e.Name == "PR_CCTV_GetNextItem")
		{
			PR_CCTV_DebugMessages.DebugMessage("Network Process: PR_CCTV_GetNextItem");
		 	token.user.GetNextItem();
		} 
		else if (e.Name == "PR_CCTV_GetPreviousItem")
		{
			PR_CCTV_DebugMessages.DebugMessage("Network Process: PR_CCTV_GetPreviousItem");
			token.user.GetPreviousItem();
		}
	}
}
