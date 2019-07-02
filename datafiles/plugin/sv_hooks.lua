local PLUGIN = PLUGIN;

// Check if the player has a datafile or not. If not, create one.
function cwDatafile:PostPlayerSpawn(player)
	local bHasDatafile = cwDatafile:HasDatafile(player);
	// Nil because the bHasDatafile is not in every player their character data.
	if ((!bHasDatafile || bHasDatafile == nil) && !cwDatafile:IsRestrictedFaction(player)) then
		cwDatafile:CreateDatafile(player);
	end;

	// load the datafile again with the new changes.
	cwDatafile:LoadDatafile(player);
end;

// Function to load the datafile on the player's character. Used after updating something in the MySQL.
function cwDatafile:LoadDatafile(player)
	if (player:IsValid()) then
		local schemaFolder = Clockwork.kernel:GetSchemaFolder();
		local datafileTable = Clockwork.config:Get("mysql_characters_table"):Get();
		local character = player:GetCharacter();

		local queryObj = Clockwork.database:Select(datafileTable);
			queryObj:AddWhere("_CharacterID = ?", character.characterID);
			queryObj:AddWhere("_SteamID = ?", player:SteamID());
			queryObj:AddWhere("_Schema = ?", schemaFolder);
			queryObj:SetCallback(function(result)
				if (!IsValid(player)) then return; end;
				if (Clockwork.database:IsResult(result)) then
					character.file = {
						GenericData = Clockwork.json:Decode(result[1]._GenericData);
						Datafile = Clockwork.json:Decode(result[1]._Datafile);
					};
				end;
				cwDatafile:SetSharedVars(player);
			end);
		queryObj:Pull();
	end;
end;

// Create a datafile for the player.
function cwDatafile:CreateDatafile(player)
	if (player:IsValid()) then
		local schemaFolder = Clockwork.kernel:GetSchemaFolder();
		local datafileTable = Clockwork.config:Get("mysql_characters_table"):Get();
		local character = player:GetCharacter();
		local steamID = player:SteamID();

		// Set all the values.
		local queryObj = Clockwork.database:Update(datafileTable);
			queryObj:AddWhere("_Schema = ?", schemaFolder);
			queryObj:AddWhere("_SteamID = ?", steamID);
			queryObj:AddWhere("_CharacterID = ?", character.characterID);
			queryObj:SetValue("_GenericData", Clockwork.json:Encode(PLUGIN.Default.GenericData));
			queryObj:SetValue("_Datafile", Clockwork.json:Encode(PLUGIN.Default.civilianDatafile));
		queryObj:Push();

		// Change the hasDatafile bool to true to indicate the player has a datafile now.
		player:SetCharacterData("hasDatafile", true);
	end;
end;

// Returns true if the player has a datafile.
function cwDatafile:HasDatafile(player)
	return player:GetCharacterData("hasDatafile");
end;

// Datafile handler. Decides what to do when a player types /Datafile John Doe.
function cwDatafile:HandleDatafile(player, target)
	local playerValue = cwDatafile:ReturnPermission(player);
	local targetValue = cwDatafile:ReturnPermission(target);
	local bTargetIsRestricted, restrictedText = cwDatafile:IsRestricted(player);

	if (playerValue >= targetValue) then
		if (playerValue == 0) then
			Clockwork.player:Notify(player, "You are not authorized to access this datafile.");

			return false;
		end;

		local GenericData = cwDatafile:ReturnGenericData(target);
		local datafile = cwDatafile:ReturnDatafile(target);

		if (playerValue == 1) then
			if (target:GetSharedVar("PlayerIsRestricted") == 1) then
				Clockwork.player:Notify(player, "This datafile has been restricted; access denied. REASON: " .. restrictedText);

				return false;
			end;

			for k, v in pairs(datafile) do
				if (v.category == "civil") then
					table.remove(datafile, k);
				end;
			end;

			Clockwork.datastream:Start(player, "createRestrictedDatafile", {target, GenericData, datafile});
			
		elseif (playerValue == 2) then
			Clockwork.datastream:Start(player, "createMedicalDatafile", {target, GenericData, datafile});
		else
			Clockwork.datastream:Start(player, "createFullDatafile", {target, GenericData, datafile});
		end;

	elseif (playerValue < targetValue) then
		Clockwork.player:Notify(player, "You are not authorized to access this datafile.");

		return false;
	end;
end;

// Datastream

// Update the last seen.
Clockwork.datastream:Hook("updateLastSeen", function(player, data)
	local target = data[1];

	cwDatafile:UpdateLastSeen(target);
end);

// Update the civil status.
Clockwork.datastream:Hook("updateCivilStatus", function(player, data)
	local target = data[1];
	local civilStatus = data[2];

	cwDatafile:SetCivilStatus(target, player, civilStatus);
end);

// Update the employment status.
Clockwork.datastream:Hook("updateEmploymentStatus", function(player, data)
	local target = data[1];
	local employmentStatus = data[2];

	cwDatafile:SetEmploymentStatus(target, player, employmentStatus);
end);

// Add a new entry.
Clockwork.datastream:Hook("addEntry", function(player, data)
	local target = data[1];
	local category = data[2];
	local text = data[3];
	local points = data[4];

	cwDatafile:AddEntry(category, text, points, target, player, false);
end);

// Add/remove a BOL.
Clockwork.datastream:Hook("setBOL", function(player, data)
	local target = data[1];
	local bHasBOL = cwDatafile:ReturnBOL(player);

	if (bHasBOL == true) then
		cwDatafile:SetBOL(false, "", target, player);
	elseif (bHasBOL == false) then
		cwDatafile:SetBOL(true, "", target, player);
	end;
end);

// Send the points of the player back to the user.
Clockwork.datastream:Hook("requestPoints", function(player, data)
	local target = data[1];
	Clockwork.datastream:Start(player, "sendPoints", {cwDatafile:ReturnPoints(target)});
end);

// Remove a line from someone their datafile.
Clockwork.datastream:Hook("removeLine", function(player, data)
	local target = data[1];
	local key = data[2];
	local date = data[3];
	local category = data[4];
	local text = data[5];

	cwDatafile:RemoveEntry(player, target, key, date, category, text);
end);

// Refresh the active datafile panel of a player.
Clockwork.datastream:Hook("refreshFile", function(player, data)
	local target = data[1];
	player:SetSharedVar( "DatafileOpen", 1 );
	cwDatafile:HandleDatafile(player, target);
end);
