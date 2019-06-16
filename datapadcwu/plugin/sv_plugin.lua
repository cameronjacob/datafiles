local PLUGIN = PLUGIN;

--CWU DATAPAD

--OPEN
util.AddNetworkString( "ObjectivesPanelOpen" )

local function GetObjectivesOpen( len, ply )
	local ObjectivesOpen = net.ReadInt( 3 ) -- use the same number of bits that were written
	ply:SetSharedVar( "PlayerObjectivesOpen", ObjectivesOpen );
end
net.Receive( "ObjectivesPanelOpen", GetObjectivesOpen )

--CLOSED
util.AddNetworkString( "ObjectivesPanelClosed" )

local function GetObjectivesClosed( len, ply )
	local ObjectivesClosed = net.ReadInt( 3 ) -- use the same number of bits that were written
	ply:SetSharedVar( "PlayerObjectivesOpen", ObjectivesClosed );
end
net.Receive( "ObjectivesPanelClosed", GetObjectivesClosed )

--CWU Objectives panel
Clockwork.datastream:Hook("EditCwuObjectives", function(player, data)
	if (player.editObjectivesAuthorised and type(data) == "string") then
		if (Schema.cwuObjectives != data) then
			Schema.cwuObjectives = string.sub(data, 0, 500);
			
			Clockwork.kernel:SaveSchemaData("cwuobjectives", {
				text = Schema.cwuObjectives
			});
		end;
		
		player.editObjectivesAuthorised = nil;
	end;
end);