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
}