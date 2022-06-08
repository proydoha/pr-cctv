class PR_CCTV_BaseFilterCriteria abstract
{
    abstract bool Check(PR_CCTV_MapEvent event, Actor hubUser);
}

class PR_CCTV_ActivatorTypeFilterCriteria : PR_CCTV_BaseFilterCriteria
{
    PR_CCTV_ActivatorTypes expectedType;

    static PR_CCTV_ActivatorTypeFilterCriteria Create(PR_CCTV_ActivatorTypes expectedType)
    {
        PR_CCTV_ActivatorTypeFilterCriteria criteria = new("PR_CCTV_ActivatorTypeFilterCriteria");
        criteria.expectedType = expectedType;
        return criteria;
    }

    override bool Check(PR_CCTV_MapEvent event, Actor hubUser)
    {
        PR_CCTV_ActivatorTypes actualType;
        bool checkResult;

        if (event.activator.Player == null) { actualType = IsNotPlayer; }
        if (event.activator.Player != null) { actualType = IsOtherPlayer; }
        if (event.activator == hubUser)     { actualType = IsHubUser; }

        checkResult = expectedType == actualType;
        return checkResult;
    }

    enum PR_CCTV_ActivatorTypes
    {
        IsHubUser = 0,
        IsOtherPlayer,
        IsNotPlayer
    }
}

class PR_CCTV_ActivationCountFilterCriteria : PR_CCTV_BaseFilterCriteria
{
    int maximumCount;

    static PR_CCTV_ActivationCountFilterCriteria Create(int maximumCount)
    {
        PR_CCTV_ActivationCountFilterCriteria criteria = new("PR_CCTV_ActivationCountFilterCriteria");
        criteria.maximumCount = maximumCount;
        return criteria;
    }

    override bool Check(PR_CCTV_MapEvent event, Actor hubUser)
    {
        bool checkResult;
        checkResult = event.activationCount > maximumCount;
        return checkResult;
    }
}