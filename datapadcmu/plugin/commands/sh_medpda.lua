local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("medpda");
COMMAND.tip = "View the Medical PDA.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (player:GetFaction() == FACTION_CMU) or (Clockwork.player:HasFlags(player, "d")) then
		if (player:GetActiveWeapon():GetClass() == "weapon_medicalpad") then
			Clockwork.datastream:Start(player, "DrawMedicalpad", Schema.medicalObjectives);
			player:SetSharedVar( "PlayerPanelOpen", 1 );
			
			if player:GetData("cmuleader") then
			player.editObjectivesAuthorised = true;
			else
			player.editObjectivesAuthorised = false;
			end;
			
		else
			Clockwork.player:Notify(player, "You are not the CMU or you do not have your pda out!");
		end;
	end;
end;

COMMAND:Register();