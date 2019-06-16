local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("closecwupda");
COMMAND.tip = "Close the CWU PDA.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
		player:SetSharedVar( "PlayerPanelOpen", 0 );
end;

COMMAND:Register();