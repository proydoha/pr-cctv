class PR_CCTV_CameraTarget : MapMarker
{
	Default
	{
		Height 1;
		Radius 1;
		RenderStyle "Translucent";		
        XScale 1.2;
        YScale 1.0;
		+NOCLIP
		+NOGRAVITY
	}
	States
	{
		Spawn:
			CTGT B -1;
	}
}