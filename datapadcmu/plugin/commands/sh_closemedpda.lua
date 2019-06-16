local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("closemedpda");
COMMAND.tip = "Close the Medical PDA.";
COMMAND.flags = CMD_DEFAULT;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
		player:SetSharedVar( "PlayerPanelOpen", 0 );
end;

COMMAND:Register();