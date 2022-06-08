class PR_CCTV_FilterCriteriaActivationCount : PR_CCTV_FilterCriteriaBase
{
    int maximumCount;

    static PR_CCTV_FilterCriteriaActivationCount Create(int maximumCount)
    {
        PR_CCTV_FilterCriteriaActivationCount criteria = new("PR_CCTV_FilterCriteriaActivationCount");
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
