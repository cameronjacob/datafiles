local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("cwupda");
COMMAND.tip = "View the CWU PDA.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (player:GetFaction() == FACTION_CWU) or (Clockwork.player:HasFlags(player, "d")) then
		if (player:GetActiveWeapon():GetClass() == "weapon_cwupad") then
			Clockwork.datastream:Start(player, "DrawCwupad", Schema.cwuObjectives);
			player:SetSharedVar( "PlayerPanelOpen", 1 );
			
			if player:GetData("CWUleader") then
			player.editObjectivesAuthorised = true;
			else
			player.editObjectivesAuthorised = false;
			end;
			
		else
			Clockwork.player:Notify(player, "You are not the CWU or you do not have your pda out!");
		end;
	end;
end;

COMMAND:Register();