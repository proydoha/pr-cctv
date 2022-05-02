class PR_CCTV_MapEvent
{
    int timeStamp;
	int special;
	int activatedLine;
	Actor activator;
	string activatorClass;
    int activationType;
	int[5] specialArgs;
	int activationCount;
	int targetType;
	int targetId;
	int target;
	bool targetZeroRule;

	string GetInformation()
	{
		string specialName = PR_CCTV_LineActionDB.GetLineActionByNumber(special).name;

		return String.Format("Time: %d, Special: %d, Special name: %s, Activated line: %d, Activator class: %s, Activation type: %d", 
            timeStamp, special, specialName, activatedLine, activatorClass, activationType);
	}

	string GetArgsInformation()
	{
		return String.Format("Args: %d, %d, %d, %d, %d", specialArgs[0], specialArgs[1], specialArgs[2], specialArgs[3], specialArgs[4]);
	}

	string GetAdditionalInformation()
	{
		return String.Format("Activation count: %d, Target type: %d, Target id: %d, Target: %d, Target Zero Rule: %d",
			activationCount, targetType, targetId, target, targetZeroRule);
	}
}