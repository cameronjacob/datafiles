Clockwork.kernel:IncludePrefixed("cl_plugin.lua")
Clockwork.kernel:IncludePrefixed("sv_plugin.lua")

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("PlayerPanelOpen", true);
	playerVars:Number("PlayerEnterOpen", true);
end;

concommand.Add( "PanelOpen", function( ply )
ply:SetSharedVar( "PlayerEnterOpen", 1 );
end )

concommand.Add( "PanelClosed", function( ply )
ply:SetSharedVar( "PlayerEnterOpen", 0 );
end )