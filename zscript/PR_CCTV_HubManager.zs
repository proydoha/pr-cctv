class PR_CCTV_HubManager
{
	PR_CCTV_EventHandler handler;

	Array<PR_CCTV_Hub> hubs;
	
	play void FindHubsOnMap()
	{
		if (hubs.Size() > 0) { return; }
		PR_CCTV_DebugMessages.DebugMessage("Searching hubs...");
		ThinkerIterator ti = ThinkerIterator.Create("PR_CCTV_Hub",Thinker.STAT_DEFAULT);
		PR_CCTV_Hub hub = PR_CCTV_Hub(ti.Next(true));
		while(hub)
		{
			PR_CCTV_DebugMessages.DebugMessage(String.Format("Hub #%d found", hub.id));
			hubs.push(hub);
			hub = PR_CCTV_Hub(ti.Next(true));
		}
		if (hubs.Size() == 0)
		{
			PR_CCTV_DebugMessages.DebugMessage("Hub list is empty");
		}
		ti.Destroy();
	}

	play PR_CCTV_Hub FindHubById(int id)
	{
		PR_CCTV_DebugMessages.DebugMessage(String.Format("Searching hub #%d...", id));
		for (int i = 0; i < hubs.Size(); i++)
		{
			if (hubs[i].id == id)
			{
				PR_CCTV_DebugMessages.DebugMessage(String.Format("Hub #%d found", id));
				return hubs[i];
			}
		}
		PR_CCTV_DebugMessages.DebugMessage(String.Format("Hub #%d not found", id));
		PR_CCTV_Hub newHub = CreateHubWithId(id);
		return newHub;
	}

	play PR_CCTV_Hub CreateHubWithId(int id)
	{
		PR_CCTV_DebugMessages.DebugMessage(String.Format("Creating hub #%d...", id));
		PR_CCTV_Hub newHub = new("PR_CCTV_Hub");
		newHub.id = id;
		newHub.handler = handler;
		hubs.push(newHub);
		PR_CCTV_DebugMessages.DebugMessage(String.Format("Hub #%d created", id));
		return newHub;
	}

	play void ConnectActorToHub(Actor a, int hubId)
	{
		if (!a)
		{
			PR_CCTV_DebugMessages.DebugMessage(String.Format("Error, actor does not exist"));
			return;
		}		
		PR_CCTV_DebugMessages.DebugMessage(String.Format("Attempting to connect to hub #%d...", hubId));
		PR_CCTV_Hub hub = FindHubById(hubId);
		PR_CCTV_DebugMessages.DebugMessage(String.Format("Looking up data token..."));
		PR_CCTV_DataToken token = PR_CCTV_DataToken(a.FindInventory("PR_CCTV_DataToken"));
		if (!token)
		{
			PR_CCTV_DebugMessages.DebugMessage(String.Format("Token not found, generating one..."));
			PR_CCTV_DataToken token = PR_CCTV_DataToken(a.GiveInventoryType("PR_CCTV_DataToken"));
			token.GenerateId();
			PR_CCTV_DebugMessages.DebugMessage(String.Format("New token id: %d", token.id));
		}
		hub.ConnectActor(a);
	}

	play void ConnectPlayerToHub(int playerNumber)
	{
		PR_CCTV_DebugMessages.DebugMessage(String.Format("Connecting player #%d to hub...", playerNumber));
		PlayerInfo p = players[playerNumber];
		Actor playerActor = p.mo;
		int hubId = Cvar.GetCvar("PR_CCTV_HubId", p).GetInt();
		ConnectActorToHub(playerActor, hubId);
		PR_CCTV_DebugMessages.DebugMessage(String.Format("Player #%d is connected to hub #%d", playerNumber, hubId));
	}

	play void RegisterMapEvent(int timeStamp, int special, int activatedLine, Actor activator, int activationType, int activationCount)
	{
		//I've decided to treat multi-target line actions as separate events. One event for each target.
		PR_CCTV_LineAction la = handler.lineActionDB.LineActions[special];
		for (int i = 0; i < la.targets.Size(); i++)
		{
			//Do not create map event if target is 0 and there are no zero rule for it
			int target = level.lines[activatedLine].args[la.targets[i].arg];
			bool zeroRule = la.targets[i].zeroRule;
            if (target == 0 && zeroRule == false)
			{
				PR_CCTV_DebugMessages.DebugMessage("Warning: line was activated with Target: 0 and ZeroRule: false. Event not registered.");
				continue;
			}
			PR_CCTV_MapEvent event = new("PR_CCTV_MapEvent");
			event.timeStamp = timeStamp;
			event.special = special;
			event.activatedLine = activatedLine;
			event.activator = activator;
			event.activationType = activationType;
			event.activationCount = activationCount;
			event.targetType = la.targets[i].type;
			event.targetId = i;
			event.target = target;
			event.targetZeroRule = zeroRule;
			for (int i = 0; i < 4; i++)
			{
				event.specialArgs[i] = level.lines[event.activatedLine].args[i];
			}
			if (activator)
			{
				event.activatorClass = activator.GetClassName();
			}
			else
			{
				event.activatorClass = "[Unknown]";
			}
			for (int i = 0; i < hubs.Size(); i++)
			{
				hubs[i].RegisterMapEvent(event);
			}
		}
	}
}