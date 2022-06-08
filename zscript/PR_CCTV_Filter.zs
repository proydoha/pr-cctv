class PR_CCTV_Filter
{
    Array<PR_CCTV_FilterCriteriaBase> criterias;

    void AddCriteria(PR_CCTV_FilterCriteriaBase criteria)
    {
        criterias.push(criteria);
    }

    bool CheckEvent(PR_CCTV_MapEvent event, Actor hubUser)
    {
        bool checkResult = true;
        for (int i = 0; i < criterias.Size(); i++)
        {
            bool criteriaResult = criterias[i].Check(event, hubUser);
            if (criteriaResult == false)
            {
                checkResult = false;
                break;
            }
        }
        return checkResult;
    }
}