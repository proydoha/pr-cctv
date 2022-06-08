class PR_CCTV_LineAction
{
    string name;
    Array<PR_CCTV_LineActionTarget> targets;

    play void AddTarget(int tType, int tArg, int tZeroRule)
    {
        PR_CCTV_LineActionTarget target = new("PR_CCTV_LineActionTarget");
        target.type = tType;
        target.arg = tArg;
        target.zeroRule = tZeroRule;
        targets.push(target);
    }
}
