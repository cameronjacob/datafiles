local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("datapad");
COMMAND.tip = "View the Combine Datapad.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if (Schema:PlayerIsCombine(player)) or (Clockwork.player:HasFlags(player, "d") or (player:GetFaction() == FACTION_ADMIN)) then
		if (player:GetActiveWeapon():GetClass() == "weapon_datapad") then
			Clockwork.datastream:Start(player, "DrawDatapad");
			player.editObjectivesAuthorised = true;
			player:SetSharedVar( "PlayerPanelOpen", 1 );
		else
			Clockwork.player:Notify(player, "You are not the Combine or you do not have your datapad out!");
		end;
	end;
end;

COMMAND:Register();