local Clockwork = Clockwork;
local PLUGIN = PLUGIN;
local SCHEMA = Schema;

local COMMAND = Clockwork.command:New("RestrictDatafile");
COMMAND.text = "<string Name> <string Reason (empty to unrestrict)>";
COMMAND.tip = "Make someone their datafile (un)restricted.";
COMMAND.arguments = 1;
COMMAND.optionalArguments = 1;

function COMMAND:OnRun(player, arguments)
    local target = Clockwork.player:FindByID(arguments[1]);
    local text = table.concat(arguments, " ", 2);
	--local PlayerIsScanner = SCHEMA:IsPlayerCombineRank(player, "SCN");
	--local PlayerIsLeader = SCHEMA:IsPlayerCombineRank(player, "RL");
	local PlayerIsOverwatch = player:GetFaction() == FACTION_OW;

    if (!text or text == "") then
    	text = nil;
    end;

    if (target) then
    	if (player:GetSharedVar("PlayerPanelOpen") == 1 and PlayerIsOverwatch) then
    		if (text) then
	        	cwDatafile:SetRestricted(true, text, target, player);

	        	Clockwork.player:Notify(player, target:Name() .. "'s file has been restricted.");
				player:SetSharedVar( "PlayerPanelOpen", 0 );
				player:SetSharedVar( "PlayerEnterOpen", 0 );
				target:SetSharedVar("PlayerIsRestricted", 1);
    		else
	        	cwDatafile:SetRestricted(false, "", target, player);

	        	Clockwork.player:Notify(player, target:Name() .. "'s file has been unrestricted.");
				player:SetSharedVar( "PlayerPanelOpen", 0 );
				player:SetSharedVar( "PlayerEnterOpen", 0 );
				target:SetSharedVar("PlayerIsRestricted", 0);
    		end;
	    else
			player:SetSharedVar( "PlayerEnterOpen", 0 );
	    	Clockwork.player:Notify(player, "You do not have access to this command.");
	    end;
    else
		player:SetSharedVar( "PlayerEnterOpen", 0 );
        Clockwork.player:Notify(player, "You have entered an invalid character.");
    end;
end;

COMMAND:Register();