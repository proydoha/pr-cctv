class CCTV_CameraTarget : MapMarker
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
			CTGT B -1;
	}
}