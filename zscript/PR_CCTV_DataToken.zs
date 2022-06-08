class PR_CCTV_DataToken : Inventory 
{
	int id;
	PR_CCTV_Hub hub;
	PR_CCTV_HubUser user;
	
	Default
	{
        +INVENTORY.UNDROPPABLE;
		Inventory.MaxAmount 1;
	}

	void GenerateId()
	{
		id = Random(-2147483648,2147483647);
	}
}
