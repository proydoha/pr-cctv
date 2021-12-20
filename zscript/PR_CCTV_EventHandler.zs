class PR_CCTV_EventHandler : EventHandler
{
	PR_CCTV_HubManager hubManager;
	PR_CCTV_LineActionDB lineActionDB;
	
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
	}
	
	override void RenderOverlay(RenderEvent e) 
	{
		if (!e) { return; }
		Actor playerActor = e.camera;
		if (!playerActor) { return; }
		if (!playerActor.player) { return; }
		PR_CCTV_CameraScreens.DrawScreen(e.camera, "CAMERA1");
		PR_CCTV_CameraScreens.DrawScreen(e.camera, "CAMERA2");		
	}
	
	override void WorldLineActivated(WorldEvent e)
	{
		PR_CCTV_DebugMessages.DebugMessage("World Line Activated");
		hubManager.RegisterMapEvent(level.Time, level.lines[e.ActivatedLine.Index()].Special, e.ActivatedLine.Index(), e.Thing, e.ActivationType);
	}
	
	override void NetworkProcess (ConsoleEvent e)
	{
		PR_CCTV_DebugMessages.DebugMessage("Network Process");

		Actor playerActor = players[e.Player].mo;
		if (!playerActor) { return; }
		PR_CCTV_DataToken token = PR_CCTV_DataToken(playerActor.FindInventory("PR_CCTV_DataToken"));
		if (!token) { return; }
		if (!token.hub) { return; }
		if (!token.user) { return; }
				
		if (e.Name == "PR_CCTV_GetNextItem")
		{
		 	token.user.GetNextItem();
		} 
		else if (e.Name == "PR_CCTV_GetPreviousItem")
		{
			token.user.GetPreviousItem();
		}
	}
}