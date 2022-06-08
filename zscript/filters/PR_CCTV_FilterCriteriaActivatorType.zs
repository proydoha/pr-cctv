class PR_CCTV_FilterCriteriaActivatorType : PR_CCTV_FilterCriteriaBase
{
    PR_CCTV_ActivatorTypes expectedType;

    static PR_CCTV_FilterCriteriaActivatorType Create(PR_CCTV_ActivatorTypes expectedType)
    {
        PR_CCTV_FilterCriteriaActivatorType criteria = new("PR_CCTV_FilterCriteriaActivatorType");
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