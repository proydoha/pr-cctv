class PR_CCTV_LineAction
{
    string name;
    
    Array<int> targetType;
    Array<int> targetArg;    
    Array<bool> targetZeroRule;

    play void AddTarget(int tType, int tArg, int tZeroRule)
    {
        targetType.push(tType);
        targetArg.push(tArg);
        targetZeroRule.push(tZeroRule);
    }
}