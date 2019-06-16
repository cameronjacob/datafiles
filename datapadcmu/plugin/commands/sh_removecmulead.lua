--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("RemoveCmuLead");
COMMAND.tip = "Remove a player as CMU lead.";
COMMAND.text = "<string Name>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	
	if (IsValid(target)) then
		if (target:GetData("cmuleader")) then
			target:SetData("cmuleader", false);
			Clockwork.player:Notify(player, target:Name().." has been removed as CMU leader!");
		else
			Clockwork.player:Notify(player, target:Name().." is not CMU leader!");
		end;
	end;
end;

COMMAND:Register();