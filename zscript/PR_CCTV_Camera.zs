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
}