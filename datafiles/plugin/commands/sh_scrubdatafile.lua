local Clockwork = Clockwork;
local PLUGIN = PLUGIN;
local SCHEMA = Schema;

local COMMAND = Clockwork.command:New("ScrubDatafile");
COMMAND.text = "<string Name>";
COMMAND.tip = "Scrub someone their datafile.";
COMMAND.access = "s";
COMMAND.arguments = 1;

function COMMAND:OnRun(player, arguments)
    local target = Clockwork.player:FindByID(table.concat(arguments, " "));
	local PlayerIsScanner = SCHEMA:IsPlayerCombineRank(player, "SCN");
	local PlayerIsLeader = SCHEMA:IsPlayerCombineRank(player, "RL");
	local PlayerIsOverwatch = player:GetFaction() == FACTION_OW;
	
    if (target) then
		if (player:GetSharedVar("PlayerPanelOpen") == 1 and PlayerIsLeader) or (PlayerIsScanner) or (PlayerIsOverwatch) then
			cwDatafile:ScrubDatafile(target);
			player:SetSharedVar( "PlayerPanelOpen", 0 );
			player:SetSharedVar( "PlayerEnterOpen", 0 );
		else
			player:SetSharedVar( "PlayerEnterOpen", 0 );
			Clockwork.player:Notify(player, "You have entered an invalid character or you do not have permission.");
		end;
	end;
end;

COMMAND:Register();