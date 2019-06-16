--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("ViewCMUObjectives");
COMMAND.tip = "View the CMU objectives.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (player:GetFaction() == FACTION_CMU) and player:GetSharedVar("PlayerPanelOpen") == 1 then
		Clockwork.datastream:Start(player, "EditMedicalObjectives", Schema.medicalObjectives);
		player:SetSharedVar( "PlayerPanelOpen", 0 );
		player:SetSharedVar( "PlayerObjectivesOpen", 1 );
		
		if player:GetData("cmuleader") then
		player.editObjectivesAuthorised = true;
		else
		player.editObjectivesAuthorised = false;
		end;
		
	elseif player:GetSharedVar("PlayerPanelOpen") == 0 and (player:GetFaction() == FACTION_CMU) then
		Clockwork.player:Notify(player, "Use the PDA to open this menu!");
	else
		Clockwork.player:Notify(player, "You are not the CMU!");
		player:SetSharedVar( "PlayerPanelOpen", 0 );
		player:SetSharedVar( "PlayerObjectivesOpen", 0 );
	end;
end;

COMMAND:Register();