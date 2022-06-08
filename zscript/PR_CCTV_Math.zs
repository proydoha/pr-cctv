class PR_CCTV_Math
{
    static int Modulo(int a, int b)
	{
		return int(((a % b) + b) % b);
	}
}
