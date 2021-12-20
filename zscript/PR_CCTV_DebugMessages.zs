class PR_CCTV_DebugMessages
{
    static void DebugMessage(string message)
    {
        if (CVar.FindCvar("PR_CCTV_Debug").GetBool())
        {
            console.PrintF("[%d] CCTV Debug: %s", level.time, message);
        }
    }
}