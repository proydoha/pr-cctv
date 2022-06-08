class PR_CCTV_CameraTarget : MapMarker
{
	Default
	{
		Height 1;
		Radius 1;
		RenderStyle "Translucent";	
        XScale 0.6;
        YScale 0.5;
		+NOCLIP
		+NOGRAVITY
	}
	States
	{
		Spawn:
			TNT1 A -1;
		Target1:
			CTGT B -1;
		Target2:
			CTGT C -1;
	}
}
