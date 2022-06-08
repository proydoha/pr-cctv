class PR_CCTV_FilterCriteriaTargetOnBacksideOfALine : PR_CCTV_FilterCriteriaBase
{
    static PR_CCTV_FilterCriteriaTargetOnBacksideOfALine Create()
    {
        return new("PR_CCTV_FilterCriteriaTargetOnBacksideOfALine");
    }

    override bool Check(PR_CCTV_MapEvent event, Actor hubUser)
    {
        bool checkResult;
        checkResult = false;
        PR_CCTV_LineAction la = PR_CCTV_LineActionDB.GetLineActionByNumber(event.special);
        int target = event.specialArgs[la.targets[event.targetId].arg];
        if (event.targetType == PR_CCTV_LineActionDB.TypeSector)
        {
            if (isSectorOnLineBackside(event.activatedLine, target))
            {
                checkResult = true;
            }
        }
        return checkResult;
    }

    bool isSectorOnLineBackside(int LineIndex, int SectorTag)
    {
        if (SectorTag == 0) { return true; }
        SectorTagIterator sti;
        int secnum;
        sti = level.CreateSectorTagIterator(SectorTag);
        secnum = sti.Next();
        while (secnum >= 0)
        {
            if (level.lines[LineIndex].BackSector)
            {
                if (level.lines[LineIndex].BackSector.Index() == level.Sectors[secnum].Index()) { return true; }
            }
            if (level.lines[LineIndex].FrontSector)
            {
                if (level.lines[LineIndex].FrontSector.Index() == level.Sectors[secnum].Index()) { return true; }
            }
            secnum = sti.Next();
        }
        return false;
    }
}