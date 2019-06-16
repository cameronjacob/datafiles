local PLUGIN = PLUGIN;

-- COMBINE DATAPAD

--OPEN
util.AddNetworkString( "OpenPanel" )

local function GetPanelOpen( len, ply )
	local PanelOpen = net.ReadInt( 3 ) -- use the same number of bits that were written
	ply:SetSharedVar( "PlayerEnterOpen", PanelOpen );
end
net.Receive( "OpenPanel", GetPanelOpen )

--CLOSED
util.AddNetworkString( "ClosePanel" )

local function GetPanelClosed( len, ply )
	local PanelClosed = net.ReadInt( 3 ) -- use the same number of bits that were written
	ply:SetSharedVar( "PlayerEnterOpen", PanelClosed );
end
net.Receive( "ClosePanel", GetPanelClosed )