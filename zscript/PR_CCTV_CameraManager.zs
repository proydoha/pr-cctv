class PR_CCTV_CameraManager
{
    PR_CCTV_HubUser hubUser;
    PR_CCTV_Camera[2] camera;
	Actor[2] cameraTarget;
    string[2] cameraTextureName;
    int maxCameraDistanceToTarget;
    int cameraPitch;
    bool ignoreBadCameraPlacements;

    Array<Sector> sectorTargets;
    Array<Line> lineTargets;
    Array<Actor> actorTargets;

    play void Init()
    {
        int i;
        int playerNumber = hubUser.user.PlayerNumber();
        for(i = 0; i < 2; i++)
		{
            camera[i] = PR_CCTV_Camera(Actor.Spawn("PR_CCTV_Camera", (0, 0, 0)));
            cameraTarget[i] = Actor.Spawn("PR_CCTV_CameraTarget", (0, 0, 0));
            cameraTextureName[i] = String.Format("CAMERA%dPLAYER%d", i + 1, playerNumber);
			TexMan.SetCameraToTexture(camera[i], cameraTextureName[i], 90);
        }
        cameraTarget[0].SetStateLabel("Target1");
        cameraTarget[1].SetStateLabel("Target2");
        maxCameraDistanceToTarget = 500;        
        cameraPitch = 0;
        ignoreBadCameraPlacements = true;
    }

    play void LookAtLine(int cameraNumber, int lineIndex)
    {
        Line targetLine = Level.Lines[lineIndex];
        vector3 targetPos = GetCameraTargetPositionOnLine(targetLine);
        cameraTarget[cameraNumber].SetOrigin(targetPos, false);
        vector3 cameraPos = GetCameraPositionOnLine(targetLine, cameraTarget[cameraNumber]);        
		camera[cameraNumber].SetOrigin(cameraPos, false);
		camera[cameraNumber].A_Face(cameraTarget[cameraNumber], 0, 0);
    }

    play vector3 GetCameraTargetPositionOnLine(line l)
	{
		double maximumHeight;
		double minimumHeight;
		double gapSize;
		double zCoord;
		
		if (l.FrontSector && l.BackSector) //Is line doublesided? (l.Flags & 0x00000004 > 0) ?
		{
			if (l.Activation & (SPAC_Use|SPAC_Impact|SPAC_Push|SPAC_UseThrough|SPAC_MUse|SPAC_MPush|SPAC_UseBack) > 0)
			{
                //It's probably a button, door or elevator and you're activating it by standing on the lower side
				zCoord = Min(l.FrontSector.GetPlaneTexZ(0), l.BackSector.GetPlaneTexZ(0)) + 28; //28 is PlayerPawn height/2
			}
            else 
			{
                //It's probably line that you cross and you're activating it by crossing the gap
				maximumHeight = Min(l.FrontSector.GetPlaneTexZ(1),l.BackSector.GetPlaneTexZ(1));
				minimumHeight = Max(l.FrontSector.GetPlaneTexZ(0),l.BackSector.GetPlaneTexZ(0));
				gapSize = Abs(maximumHeight - minimumHeight);
				zCoord = minimumHeight + gapSize/2;
				if (gapSize == 0)
                {
                    zCoord = minimumHeight + 28; //28 is PlayerPawn height/2
                }
			}
		}
		else //If line is not doublesided
		{
			Sector s;
			if (l.FrontSector) { s = l.FrontSector; } else { s = l.BackSector; }
			maximumHeight = s.GetPlaneTexZ(1);
			minimumHeight = s.GetPlaneTexZ(0);
			gapSize = Abs(maximumHeight - minimumHeight);
			zCoord = minimumHeight + 28; //28 is PlayerPawn height/2
		}
		return (l.V1.p + l.delta * 0.5, zCoord);
	}

    play vector3 GetCameraPositionOnLine(Line l, Actor TargetActor, bool OnFrontSide = true)
	{
		FLineTraceData d;
		double lineTraceAngle;
		if (OnFrontSide)
        {
            lineTraceAngle = atan2(l.delta.y, l.delta.x) - 90; //90 means perpendicular to line
        } 
		else
        {
            lineTraceAngle = atan2(l.delta.y, l.delta.x) + 90;
        }		
		TargetActor.LineTrace(lineTraceAngle, maxCameraDistanceToTarget, cameraPitch, TRF_THRUACTORS|TRF_THRUBLOCK|TRF_THRUHITSCAN, 0, 1, 0, data:d);
		if (d.HitType == TRACE_HitWall || d.HitType == TRACE_HitNone || d.HitType == TRACE_HitCeiling || d.HitType == TRACE_HitFloor)
		{ 
			return (d.HitLocation - d.HitDir * 4);
		} 
		else return (0, 0, 0);
	}

    play void BuildListOfTargetSectors(int targetSectorTag, int activatorLineIndex, bool zeroRule)
	{
		sectorTargets.Clear();
		SectorTagIterator sti;
        Sector targetSector;
		int secnum;
		if (targetSectorTag == 0 && zeroRule)
		{
			if (level.Lines[activatorLineIndex].BackSector)
            {
                targetSector = level.Lines[activatorLineIndex].BackSector;
                sectorTargets.push(targetSector);
            }
			else //I'm almost sure this will never happen
            {
                targetSector = level.Lines[activatorLineIndex].FrontSector;
                sectorTargets.push(targetSector);
            }
		}
		else 
		{
			sti = level.CreateSectorTagIterator(targetSectorTag);
			secnum = sti.Next();
			while (secnum >= 0) 
			{
                targetSector = level.Sectors[secnum];
				sectorTargets.push(targetSector);
				secnum = sti.Next();
			}
		}
	}

    play void BuildListOfTargetLinesFromSectors()
	{
		int i;
		int j;
		lineTargets.Clear();
        Actor probe = Actor.Spawn("Actor", (0, 0, 0));
		for(i=0;i<sectorTargets.Size();i++)
		{
			for(j=0;j<sectorTargets[i].Lines.Size();j++)
			{
				line l = sectorTargets[i].Lines[j];
				if (ignoreBadCameraPlacements)
				{
					probe.SetOrigin(GetCameraTargetPositionOnLine(l), false);
					probe.SetOrigin(GetCameraPositionOnLine(l, probe, true), false);
					if (probe.pos.z >= probe.CurSector.GetPlaneTexZ(1))
                    {
                        probe.SetOrigin((probe.pos.x, probe.pos.y, probe.CurSector.GetPlaneTexZ(1) - 1), false);
                    }
					if (probe.pos.z <= probe.CurSector.GetPlaneTexZ(0))
                    { 
                        probe.SetOrigin((probe.pos.x, probe.pos.y, probe.CurSector.GetPlaneTexZ(0) + 1), false);
                    }
					if (probe.FloorZ == probe.CeilingZ) { continue; }
					if (!level.IsPointInLevel(probe.pos)) { continue; }
					//if (l.Delta.Length() < minLineWidthForTarget) { continue; }
                    //Bad idea, in reality there can be very thin bars that will be skipped
				}
				lineTargets.Push(l);
			}
		}
        probe.Destroy();
	}
}