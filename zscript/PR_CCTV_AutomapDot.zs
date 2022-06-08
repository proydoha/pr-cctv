class PR_CCTV_AutomapDot : MapMarker
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
			CTGT D -1;
	}
}
