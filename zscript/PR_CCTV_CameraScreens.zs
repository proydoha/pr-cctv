class PR_CCTV_CameraScreens
{
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