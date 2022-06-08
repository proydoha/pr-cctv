class PR_CCTV_Filter
{
    Array<PR_CCTV_BaseFilterCriteria> criterias;

    void AddCriteria(PR_CCTV_BaseFilterCriteria criteria)
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
    // bool filterByActivationCount;
    // bool firstActivationOnly;

    // bool filterByActivatorIsHubUser;
    // bool filterByActivatorIsOtherPlayer;
    // bool filterByActivatorIsNotPlayer;

    // bool filterSectorsOnLineBackSide;

    // bool CheckEvent(PR_CCTV_MapEvent event, Actor hubUser)
    // {
    //     bool checkResult = true;

    //     if (filterByActivationCount && firstActivationOnly)
    //     {
    //         if (event.activationCount > 1)
    //         {
    //             checkResult = false;
    //         }
    //     }

    //     if (event.activator)
    //     {
    //         bool isNotPlayer = false;
    //         bool isOtherPlater = false;
    //         bool isHubUser = false;
    //         if (event.activator.Player == null) { isNotPlayer = true; }
    //         if (event.activator.Player != null) { isOtherPlater = true; }
    //         if (event.activator == hubUser)     { isHubUser = true; isOtherPlater = false; }

    //         if (filterByActivatorIsHubUser && isHubUser)
    //         {
    //             checkResult = false;
    //         }
    //         if (filterByActivatorIsOtherPlayer && isOtherPlater)
    //         {
    //             checkResult = false;
    //         }
    //         if (filterByActivatorIsNotPlayer && isNotPlayer)
    //         {
    //             checkResult = false;
    //         }
    //     }

    //     PR_CCTV_LineAction la = PR_CCTV_LineActionDB.GetLineActionByNumber(event.special);
    //     int target = event.specialArgs[la.targets[event.targetId].arg];
    //     //bool zeroRule = la.targets[event.targetId].zeroRule;
    //     if (event.targetType == PR_CCTV_LineActionDB.TypeSector)
    //     {
    //         if (filterSectorsOnLineBackSide)
    //         {
    //             if (isSectorOnLineBackside(event.activatedLine, target))
    //             {
    //                 checkResult = false;
    //             }
    //         }
    //     }

    //     return checkResult;
    // }

    // //TODO: Move to the separate class?
    // bool isSectorOnLineBackside(int LineIndex, int SectorTag)
    // {
    //     if (SectorTag == 0) { return true; }
    //     SectorTagIterator sti;
    //     int secnum;
    //     sti = level.CreateSectorTagIterator(SectorTag);
    //     secnum = sti.Next();
    //     while (secnum >= 0)
    //     {
    //         if (level.lines[LineIndex].BackSector)
    //         {
    //             if (level.lines[LineIndex].BackSector.Index() == level.Sectors[secnum].Index()) { return true; }
    //         }
    //         if (level.lines[LineIndex].FrontSector)
    //         {
    //             if (level.lines[LineIndex].FrontSector.Index() == level.Sectors[secnum].Index()) { return true; }
    //         }
    //         secnum = sti.Next();
    //     }
    //     return false;
    // }
}