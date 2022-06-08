class PR_CCTV_Camera : Actor
{
	Default
	{
		Height 1;
		Radius 1;
		RenderStyle "Translucent";
		+NOCLIP
		+NOGRAVITY
	}
	States
	{
		Spawn:
			TNT1 A -1;
	}

	enum CameraStates
    {
        OffScreen = 0,
        FadeIn,
        OnScreen,
        FadeOut
    }

    CameraStates cameraState;
	int cameraFadeInTime;
    int cameraFadeOutTime;
    int cameraOnScreenTime;
    int cameraTimer;
    float cameraAlpha;

	override void BeginPlay()
	{
		Super.BeginPlay();
		cameraState = OffScreen;
        cameraFadeInTime = 10;
        cameraFadeOutTime = 35;
        cameraOnScreenTime = 35*5;
        cameraTimer = 0;
        cameraAlpha = 0;
	}

	play void Show()
	{
		cameraState = FadeIn;
        cameraTimer = cameraFadeInTime;
	}

	override void Tick()
    {
        ManageCameraStates();
    }

	play void ManageCameraStates()
    {
        if (cameraTimer == 0)
        {
            if (cameraState == OffScreen) { return; }
            else if (cameraState == FadeIn)
            {
                cameraState = OnScreen;
                cameraTimer = cameraOnScreenTime;            
            }
            else if (cameraState == OnScreen)
            {
                cameraState = FadeOut;
                cameraTimer = cameraFadeOutTime;
                cameraAlpha = 1.0;
            }
            else if (cameraState == FadeOut)
            {
                cameraState = OffScreen;
                cameraAlpha = 0.0;
            }
        }
        else
        {
            cameraTimer--;
            if (cameraState == FadeIn)
            {
                cameraAlpha = 1.0 - float(cameraTimer)/float(cameraFadeInTime);
            }
            else if (cameraState == FadeOut)
            {
                cameraAlpha = float(cameraTimer)/float(cameraFadeOutTime);
            }
        }		
    }

	static ui void DrawScreen(Actor playerActor, string cameraCvarName, float alpha)
	{
        if (!playerActor) { return; }
        PR_CCTV_DataToken token = PR_CCTV_DataToken(playerActor.FindInventory("PR_CCTV_DataToken"));
        if (!token) { return; }
		if (!token.hub) { return; }
		if (!token.user) { return; }
        int playerNumber = playerActor.PlayerNumber();
        string cameraTextureName = String.Format("%sPLAYER%d", cameraCvarName, playerNumber);
        string scaleCvarName = String.Format("PR_CCTV_%s_scale", cameraCvarName, playerNumber);
        string posXCvarName = String.Format("PR_CCTV_%s_x", cameraCvarName, playerNumber);
        string posYCvarName = String.Format("PR_CCTV_%s_y", cameraCvarName, playerNumber);
        string finetuneXCvarName = String.Format("PR_CCTV_%s_fineTune_x", cameraCvarName, playerNumber);
        string finetuneYCvarName = String.Format("PR_CCTV_%s_fineTune_y", cameraCvarName, playerNumber);

		float scale = CVar.GetCVar(scaleCvarName, playerActor.player).GetFloat();
        float posX = CVar.GetCVar(posXCvarName, playerActor.player).GetFloat();
        float posY = CVar.GetCVar(posYCvarName, playerActor.player).GetFloat();
        int finetuneX = CVar.GetCVar(finetuneXCvarName, playerActor.player).GetInt();
        int finetuneY = CVar.GetCVar(finetuneYCvarName, playerActor.player).GetInt();
		
        TextureId cameraTexture = TexMan.CheckForTexture(cameraTextureName,TexMan.TYPE_ANY);
        TextureId noSignalTexture = TexMan.CheckForTexture("CCTVNOSG",TexMan.TYPE_ANY);

        int textureWidth;
        int textureHeight;
        [textureWidth, textureHeight] = TexMan.GetSize(cameraTexture);

		int virtualWidth  = round(1 / scale * Screen.GetWidth());
		int virtualHeight = round(1 / scale * Screen.GetHeight());
		
		float x = posX * (Screen.GetWidth()  - textureWidth * scale) * (1 / scale) + finetuneX;
		float y = posY * (Screen.GetHeight() - textureHeight * scale) * (1 / scale) + finetuneY;
		
        Screen.DrawTexture(cameraTexture, false, x, y, DTA_KeepRatio, true, DTA_VIRTUALWIDTH, virtualWidth, DTA_VIRTUALHEIGHT, virtualHeight, DTA_ALPHA, alpha);
        //Screen.DrawTexture(noSignalTexture, false, x, y, DTA_KeepRatio, true, DTA_VIRTUALWIDTH, virtualWidth, DTA_VIRTUALHEIGHT, virtualHeight, DTA_ALPHA, alpha);
	}
}
