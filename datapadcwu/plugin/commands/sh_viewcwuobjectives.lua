--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("ViewCwuObjectives");
COMMAND.tip = "View the CWU objectives.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (player:GetFaction() == FACTION_CWU) and player:GetSharedVar("PlayerPanelOpen") == 1 then
		Clockwork.datastream:Start(player, "EditCwuObjectives", Schema.cwuObjectives);
		player:SetSharedVar( "PlayerPanelOpen", 0 );
		player:SetSharedVar( "PlayerObjectivesOpen", 1 );
		
		if player:GetData("CWUleader") then
		player.editObjectivesAuthorised = true;
		else
		player.editObjectivesAuthorised = false;
		end;
		
	elseif player:GetSharedVar("PlayerPanelOpen") == 0 and (player:GetFaction() == FACTION_CWU) then
		Clockwork.player:Notify(player, "Use the PDA to open this menu!");
	else
		Clockwork.player:Notify(player, "You are not the CWU!");
		player:SetSharedVar( "PlayerPanelOpen", 0 );
		player:SetSharedVar( "PlayerObjectivesOpen", 0 );
	end;
end;

COMMAND:Register();