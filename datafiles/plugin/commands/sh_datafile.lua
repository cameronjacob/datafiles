local Clockwork = Clockwork;
local PLUGIN = PLUGIN;
local SCHEMA = Schema;

local COMMAND = Clockwork.command:New("Datafile");
COMMAND.text = "<string Name>";
COMMAND.tip = "View the datafile of someone.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	--local PlayerIsScanner = SCHEMA:IsPlayerCombineRank(player, "SCN");
	local PlayerIsOverwatch = player:GetFaction() == FACTION_OTA;
	--local PlayerIsLeader = SCHEMA:IsPlayerCombineRank(player, "RL");

    if (target) then
        if (cwDatafile:IsRestrictedFaction(target)) or (player:GetSharedVar("PlayerPanelOpen") == 0 and !PlayerIsOverwatch) then
			Clockwork.player:Notify(player, "This datafile does not exist or you should use the datapad to execute this command.");
		elseif (player:GetSharedVar("PlayerPanelOpen") == 1 and target:GetSharedVar("PlayerIsRestricted") == 0) or (PlayerIsOverwatch) then
			cwDatafile:HandleDatafile(player, target)
			player:SetSharedVar( "DatafileOpen", 1 );
			player:SetSharedVar( "PlayerPanelOpen", 0 );
			player:SetSharedVar( "PlayerEnterOpen", 0 );
		elseif (player:GetSharedVar("PlayerPanelOpen") == 1) and (!PlayerIsOverwatch) and (target:GetSharedVar("PlayerIsRestricted") == 1) then
			Clockwork.player:Notify(player, "This datafile has been restricted and is only accessible by RL or Dispatch.");
			player:SetSharedVar( "PlayerPanelOpen", 0 );
			player:SetSharedVar( "PlayerEnterOpen", 0 );
        end;
    else
		player:SetSharedVar( "PlayerEnterOpen", 0 );
        Clockwork.player:Notify(player, "This datafile does not exist.");
    end;
end;

COMMAND:Register();
