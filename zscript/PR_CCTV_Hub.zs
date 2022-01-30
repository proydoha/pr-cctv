class PR_CCTV_Hub : Thinker
{
    PR_CCTV_EventHandler handler;

	int id;
    Array<PR_CCTV_HubUser> users;
    Array<PR_CCTV_MapEvent> events;

    play PR_CCTV_HubUser FindUserById(int id)
    {
        PR_CCTV_DebugMessages.DebugMessage(String.Format("Searching user #%d in hub #%d...", id, self.id));
		for (int i = 0; i < users.Size(); i++)
		{
			if (users[i].id == id)
			{
				PR_CCTV_DebugMessages.DebugMessage(String.Format("User #%d found in hub #%d", id, self.id));
				return users[i];
			}
		}
		PR_CCTV_DebugMessages.DebugMessage(String.Format("User #%d not found in hub #%d", id, self.id));
		PR_CCTV_HubUser newUser = CreateHubUserWithId(id);
		return newUser;
    }

    play PR_CCTV_HubUser CreateHubUserWithId(int id)
    {
        PR_CCTV_DebugMessages.DebugMessage(String.Format("Creating new user with #%d for hub #%d...", id, self.id));
        PR_CCTV_HubUser newUser = new("PR_CCTV_HubUser");
		newUser.id = id;
        newUser.hub = self;        
		users.push(newUser);
		PR_CCTV_DebugMessages.DebugMessage(String.Format("User #%d created for hub #%d", id, self.id));
		return newUser;
    }

    play void ConnectActor(Actor a)
    {
        PR_CCTV_DebugMessages.DebugMessage(String.Format("Connecting actor to hub..."));
        PR_CCTV_DataToken token = PR_CCTV_DataToken(a.FindInventory("PR_CCTV_DataToken"));
        PR_CCTV_HubUser hubUser = FindUserById(token.id);
        hubUser.user = a;
        token.hub = self;
        token.user = hubUser;
        hubUser.Init();
        PR_CCTV_DebugMessages.DebugMessage(String.Format("Hub #%d reference saved in token with id %d", token.hub.id, token.id));
    }

    play void RegisterMapEvent(PR_CCTV_MapEvent event)
    {
        PR_CCTV_DebugMessages.DebugMessage(
            String.Format("Hub #%d registered new event:", self.id));
        PR_CCTV_DebugMessages.DebugMessage(
            String.Format("Time: %d, Special: %d, Special name: %s, Activated line: %d, Activator class: %s, Activation type: %d, Activation counter: %d", 
            event.timeStamp, event.special, handler.lineActionDB.LineActions[event.special].name, event.activatedLine, event.activatorClass, event.activationType, event.activationCount));
        PR_CCTV_DebugMessages.DebugMessage(
            String.Format("Args: %d, %d, %d, %d, %d", 
            event.specialArgs[0], event.specialArgs[1], event.specialArgs[2], event.specialArgs[3], event.specialArgs[4]));
        events.push(event);
        for (int i = 0; i < users.Size(); i++)
		{
            users[i].OnMapEvent(event);
        }
    }
}