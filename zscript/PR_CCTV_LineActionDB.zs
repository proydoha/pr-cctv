class PR_CCTV_LineActionDB
{
    Array<PR_CCTV_LineAction> LineActions;

    enum PR_CCTV_TargetTypes
    {
        TypeUnknown = 0,
        TypeSector,
        TypeLine,
        TypeActor,
        TypePolyobjectNumber,
    }

    static PR_CCTV_LineAction GetLineActionByNumber(int special)
    {
        PR_CCTV_LineAction lineAction = null;
        PR_CCTV_EventHandler handler = PR_CCTV_EventHandler(EventHandler.Find("PR_CCTV_EventHandler"));
        if (handler)
        {
			lineAction = handler.lineActionDB.LineActions[special];
		}
        return lineAction;
    }

    play PR_CCTV_LineAction AddLineAction(string name)
    {
        PR_CCTV_LineAction lineAction = new("PR_CCTV_LineAction");
        lineAction.name = name;
        LineActions.push(lineAction);

        return lineAction;
    }

    play void InitDatabase()
    {
        PR_CCTV_LineAction lineAction;
        lineAction = AddLineAction("No_Special");
        lineAction = AddLineAction("Polyobj_StartLine");
        lineAction = AddLineAction("Polyobj_RotateLeft");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_RotateRight");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_Move");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_ExplicitLine");
        lineAction = AddLineAction("Polyobj_MoveTimes8");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_DoorSwing");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_DoorSlide");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Line_Horizon");
        lineAction = AddLineAction("Door_Close");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction.AddTarget(TypeSector, 2, false);
        lineAction = AddLineAction("Door_Open");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction.AddTarget(TypeSector, 2, false);
        lineAction = AddLineAction("Door_Raise");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction.AddTarget(TypeSector, 3, false);
        lineAction = AddLineAction("Door_LockedRaise");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction.AddTarget(TypeSector, 4, false);
        lineAction = AddLineAction("Door_Animated");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Autosave");
        lineAction = AddLineAction("Transfer_WallLight");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction = AddLineAction("Thing_Raise");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction = AddLineAction("StartConversation");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Thing_Stop");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction = AddLineAction("Floor_LowerByValue");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_LowerToLowest");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_LowerToNearest");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_RaiseByValue");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_RaiseToHighest");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_RaiseToNearest");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Stairs_BuildDown");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Stairs_BuildUp");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_RaiseAndCrush");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Pillar_Build");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Pillar_Open");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Stairs_BuildDownSync");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Stairs_BuildUpSync");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("ForceField");
        lineAction = AddLineAction("ClearForceField");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_RaiseByValueTimes8");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_LowerByValueTimes8");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_MoveToValue");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_Waggle");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Teleport_ZombieChanger");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeSector, 1, false);
        lineAction = AddLineAction("Ceiling_LowerByValue");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_RaiseByValue");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_CrushAndRaise");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_LowerAndCrush");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_CrushStop");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_CrushRaiseAndStay");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_CrushStop");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_MoveToValue");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Sector_Attach3dMidtex");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction.AddTarget(TypeSector, 1, false);
        lineAction = AddLineAction("GlassBreak");
        lineAction = AddLineAction("ExtraFloor_LightOnly");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetLink");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction.AddTarget(TypeSector, 1, false);
        lineAction = AddLineAction("Scroll_Wall");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction = AddLineAction("Line_SetTextureOffset");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction = AddLineAction("Sector_ChangeFlags");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Line_SetBlocking");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction = AddLineAction("Line_SetTextureScale");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction = AddLineAction("Sector_SetPortal");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_CopyScroller");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Polyobj_OR_MoveToSpot");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Plat_PerpetualRaise");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Plat_Stop");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Plat_DownWaitUpStay");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Plat_DownByValue");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Plat_UpWaitDownStay");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Plat_UpByValue");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_LowerInstant");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_RaiseInstant");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_MoveToValueTimes8");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_MoveToValueTimes8");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Teleport");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeSector, 1, false);
        lineAction = AddLineAction("Teleport_NoFog");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeSector, 2, false);
        lineAction = AddLineAction("ThrustThing");
        lineAction.AddTarget(TypeActor, 3, true);
        lineAction = AddLineAction("DamageThing");
        lineAction = AddLineAction("Teleport_NewMap");
        lineAction = AddLineAction("Teleport_EndGame");
        lineAction = AddLineAction("TeleportOther");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeActor, 1, false);
        lineAction = AddLineAction("TeleportGroup");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction.AddTarget(TypeActor, 1, false);
        lineAction.AddTarget(TypeActor, 2, false);
        lineAction = AddLineAction("TeleportInSector");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction.AddTarget(TypeActor, 1, false);
        lineAction.AddTarget(TypeActor, 2, false);
        lineAction = AddLineAction("Thing_SetConversation");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction = AddLineAction("ACS_Execute");
        lineAction = AddLineAction("ACS_Suspend");
        lineAction = AddLineAction("ACS_Terminate");
        lineAction = AddLineAction("ACS_LockedExecute");
        lineAction = AddLineAction("ACS_ExecuteWithResult");
        lineAction = AddLineAction("ACS_LockedExecuteDoor");
        lineAction = AddLineAction("Polyobj_MoveToSpot");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_Stop");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_MoveTo");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_OR_MoveTo");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_OR_RotateLeft");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_OR_RotateRight");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_OR_Move");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Polyobj_OR_MoveTimes8");
        lineAction.AddTarget(TypePolyobjectNumber, 0, false);
        lineAction = AddLineAction("Pillar_BuildAndCrush");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("FloorAndCeiling_LowerByValue");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("FloorAndCeiling_RaiseByValue");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_LowerAndCrushDist");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Sector_SetTranslucent");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_RaiseAndCrushDoom");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Scroll_Texture_Left");
        lineAction = AddLineAction("Scroll_Texture_Right");
        lineAction = AddLineAction("Scroll_Texture_Up");
        lineAction = AddLineAction("Scroll_Texture_Down");
        lineAction = AddLineAction("Ceiling_CrushAndRaiseSilentDist");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Door_WaitRaise");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction.AddTarget(TypeSector, 4, false);
        lineAction = AddLineAction("Door_WaitClose");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction.AddTarget(TypeSector, 3, false);
        lineAction = AddLineAction("Line_SetPortalTarget");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction.AddTarget(TypeLine, 1, false);
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("Light_ForceLightning");
        lineAction = AddLineAction("Light_RaiseByValue");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Light_LowerByValue");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Light_ChangeToValue");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Light_Fade");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Light_Glow");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Light_Flicker");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Light_Strobe");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Light_Stop");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Plane_Copy");
        lineAction.AddTarget(TypeUnknown, -1, false);
        lineAction.AddTarget(TypeUnknown, -1, false);
        lineAction.AddTarget(TypeUnknown, -1, false);
        lineAction = AddLineAction("Thing_Damage");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction = AddLineAction("Radius_Quake");
        lineAction = AddLineAction("Line_SetIdentification");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("Thing_Move");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeActor, 1, false);
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("Thing_SetSpecial");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction = AddLineAction("ThrustThingZ");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction = AddLineAction("UsePuzzleItem");
        lineAction = AddLineAction("Thing_Activate");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Thing_Deactivate");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Thing_Remove");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Thing_Destroy");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeSector, 2, false);
        lineAction = AddLineAction("Thing_Projectile");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Thing_Spawn");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Thing_ProjectileGravity");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Thing_SpawnNoFog");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Floor_Waggle");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Thing_SpawnFacing");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Sector_ChangeSound");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("Player_SetTeam");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("Team_Score");
        lineAction = AddLineAction("Team_GivePoints");
        lineAction = AddLineAction("Teleport_NoStop");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeSector, 1, false);
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("Line_SetPortal");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction.AddTarget(TypeLine, 1, false);
        lineAction = AddLineAction("SetGlobalFogParameter");
        lineAction = AddLineAction("FS_Execute");
        lineAction = AddLineAction("Sector_SetPlaneReflection");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_Set3dFloor");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetContents");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("[Not Listed on ZDoom Wiki]");
        lineAction = AddLineAction("Ceiling_CrushAndRaiseDist");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Generic_Crusher2");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetCeilingScale2");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetFloorScale2");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Plat_UpNearestWaitDownStay");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("NoiseAlert");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction.AddTarget(TypeActor, 1, false);
        lineAction = AddLineAction("SendToCommunicator");
        lineAction = AddLineAction("Thing_ProjectileIntercept");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeActor, 3, false);
        lineAction = AddLineAction("Thing_ChangeTID");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction = AddLineAction("Thing_Hate");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction.AddTarget(TypeActor, 1, false);
        lineAction = AddLineAction("Thing_ProjectileAimed");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeActor, 3, false);
        lineAction = AddLineAction("ChangeSkill");
        lineAction = AddLineAction("Thing_SetTranslation");
        lineAction.AddTarget(TypeActor, 0, true);
        lineAction = AddLineAction("Plane_Align");
        lineAction = AddLineAction("Line_Mirror");
        lineAction = AddLineAction("Line_AlignCeiling");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction = AddLineAction("Line_AlignFloor");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction = AddLineAction("Sector_SetRotation");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetCeilingPanning");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetFloorPanning");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetCeilingScale");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetFloorScale");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Static_Init");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("SetPlayerProperty");
        lineAction = AddLineAction("Ceiling_LowerToHighestFloor");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_LowerInstant");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_RaiseInstant");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_CrushRaiseAndStayA");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_CrushAndRaiseA");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_CrushAndRaiseSilentA");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_RaiseByValueTimes8");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_LowerByValueTimes8");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Generic_Floor");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Generic_Ceiling");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Generic_Door");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Generic_Lift");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Generic_Stairs");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Generic_Crusher");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Plat_DownWaitUpStayLip");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Plat_PerpetualRaiseLip");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("TranslucentLine");
        lineAction.AddTarget(TypeLine, 0, true);
        lineAction = AddLineAction("Transfer_Heights");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Transfer_FloorLight");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Transfer_CeilingLight");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetColor");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetFade");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetDamage");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Teleport_Line");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction.AddTarget(TypeLine, 1, false);
        lineAction = AddLineAction("Sector_SetGravity");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Stairs_BuildUpDoom");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetWind");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetFriction");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetCurrent");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Scroll_Texture_Both");
        lineAction.AddTarget(TypeLine, 0, true);
        lineAction = AddLineAction("Scroll_Texture_Model");
        lineAction.AddTarget(TypeLine, 0, false);
        lineAction = AddLineAction("Scroll_Floor");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Scroll_Ceiling");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Scroll_Texture_Offsets");
        lineAction = AddLineAction("ACS_ExecuteAlways");
        lineAction = AddLineAction("PointPush_SetForce");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction.AddTarget(TypeActor, 1, false);
        lineAction = AddLineAction("Plat_RaiseAndStayTx0");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Thing_SetGoal");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction.AddTarget(TypeActor, 1, false);
        lineAction = AddLineAction("Plat_UpByValueStayTx");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Plat_ToggleCeiling");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Light_StrobeDoom");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Light_MinNeighbor");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Light_MaxNeighbor");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_TransferTrigger");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_TransferNumeric");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("ChangeCamera");
        lineAction.AddTarget(TypeActor, 0, false);
        lineAction = AddLineAction("Floor_RaiseToLowestCeiling");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_RaiseByValueTxTy");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_RaiseByTexture");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_LowerToLowestTxTy");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_LowerToHighest");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Exit_Normal");
        lineAction = AddLineAction("Exit_Secret");
        lineAction = AddLineAction("Elevator_RaiseToNearest");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Elevator_MoveToFloor");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Elevator_LowerToNearest");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("HealThing");
        lineAction = AddLineAction("Door_CloseWaitOpen");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction.AddTarget(TypeSector, 4, false);
        lineAction = AddLineAction("Floor_Donut");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("FloorAndCeiling_LowerRaise");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_RaiseToNearest");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_LowerToLowest");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_LowerToFloor");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Ceiling_CrushRaiseAndStaySilA");
        lineAction.AddTarget(TypeSector, 0, true);
        lineAction = AddLineAction("Floor_LowerToHighestEE");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_RaiseToLowest");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_LowerToLowestCeiling");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_RaiseToCeiling");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_ToCeilingInstant");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_LowerByTexture");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_RaiseToHighest");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_ToHighestInstant");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_LowerToNearest");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_RaiseToLowest");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_RaiseToHighestFloor");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_ToFloorInstant");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_RaiseByTexture");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_LowerByTexture");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Stairs_BuildDownDoom");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Stairs_BuildUpDoomSync");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Stairs_BuildDownDoomSync");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Stairs_BuildUpDoomCrush");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Door_AnimatedClose");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_Stop");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_Stop");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetFloorGlow");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Sector_SetCeilingGlow");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Floor_MoveToValueAndCrush");
        lineAction.AddTarget(TypeSector, 0, false);
        lineAction = AddLineAction("Ceiling_MoveToValueAndCrush");
        lineAction.AddTarget(TypeSector, 0, false);
    }
}