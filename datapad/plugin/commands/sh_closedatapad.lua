local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("closedatapad");
COMMAND.tip = "Close the Combine Datapad.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
		player:SetSharedVar( "PlayerPanelOpen", 0 );
end;

COMMAND:Register();