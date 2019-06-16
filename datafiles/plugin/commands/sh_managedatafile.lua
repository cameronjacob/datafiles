local Clockwork = Clockwork;
local PLUGIN = PLUGIN;
local SCHEMA = Schema;

local COMMAND = Clockwork.command:New("ManageDatafile");
COMMAND.text = "<string Name>";
COMMAND.tip = "Manage the datafile of someone.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

function COMMAND:OnRun(player, arguments)
    local target = Clockwork.player:FindByID(table.concat(arguments, " "));
	local PlayerIsScanner = SCHEMA:IsPlayerCombineRank(player, "SCN");
	local PlayerIsLeader = SCHEMA:IsPlayerCombineRank(player, "RL");
	local PlayerIsOverwatch = player:GetFaction() == FACTION_OW;

    if (target) then
		if (player:GetSharedVar("PlayerPanelOpen") == 1 and PlayerIsLeader) or (PlayerIsScanner) or (PlayerIsOverwatch) then
			Clockwork.datastream:Start(player, "createManagementPanel", {target, cwDatafile:ReturnDatafile(target)});
			player:SetSharedVar( "PlayerPanelOpen", 0 );
			player:SetSharedVar( "PlayerEnterOpen", 0 );
			player:SetSharedVar( "ManagementOpen", 1 );
		else
			player:SetSharedVar( "PlayerEnterOpen", 0 );
			Clockwork.player:Notify(player, "This datafile does not exist or you do not have permission.");
		end;
	end;
end;

COMMAND:Register();
