-- Copyright Novabox.org 2015

local PLUGIN = PLUGIN;

local bgtexture = Material("fruity/datapad.png")
local bigcolor = Color( 65, 65, 65, 255 )
local bigcolor1 = Color( 65, 65, 65, 255 )
local bigcolor2 = Color( 65, 65, 65, 255 )
local bigcolor3 = Color( 255, 0, 0, 75 )
local bigcolor4 = Color( 65, 65, 65, 255 )

surface.CreateFont("FrameDP", {
	font = "Couture",
	size = 30,
	weight = 500,
	antialias = true,
	shadow = false
} )

Clockwork.datastream:Hook("DrawCwupad", function(dataob)

FrameDP = vgui.Create( "DFrame" )
FrameDP:SetTitle( "PDA" )
FrameDP:SetSize( 475, 570 )
FrameDP:Center()
FrameDP:MakePopup()
FrameDP:ShowCloseButton(false)
FrameDP:SetDeleteOnClose(true)
FrameDP:SetDraggable( false )
FrameDP.Paint = function( self, w, h )
	surface.SetDrawColor(Color(40, 40, 40, 255));
    surface.DrawRect(0,0, w, h);
	
	surface.SetDrawColor(Color(0, 100, 200, 200));
    surface.DrawOutlinedRect(0, 0, w, h);
end

local Button2 = vgui.Create( "DButton", FrameDP )
local Button3 = vgui.Create( "DButton", FrameDP )
local Button4 = vgui.Create( "DButton", FrameDP )

Button4:SetText( "" )
Button4:SetPos( 455, 0 )
Button4:SetSize( 20, 20 )
Button4.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, bigcolor3 )
end

local y = FrameDP:GetTall()/1.6-250
local x = FrameDP:GetWide()/2-150

local y = y + 100
Button2:SetFont("FrameDP")
Button2:SetText( "VIEW OBJECTIVES" )
Button2:SetTextColor(Color(180, 180, 180, 255));
Button2:SetPos( x, y )
Button2:SetSize( 300, 50 )
Button2.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, bigcolor1 )
end
Button2.PaintOver = function( self, w, h )
	surface.SetDrawColor(39, 174, 96, 255)
	
	for i = 1, 3 do
		surface.DrawRect(0, h - 2, w, 2);
	end
end

Button2.DoClick = function()

	net.Start("ObjectivesPanelOpen")
	net.WriteInt( 1, 3 ) 
	net.SendToServer()
	
	Clockwork.option:PlaySound("click");
	Button2:Remove()
	Button3:Remove()

	LocalPlayer():ConCommand( "cwSay /ViewCwuObjectives" )
	FrameDP:Close()
end

local y = y + 100
Button3:SetFont("FrameDP")
Button3:SetText( "VIEW DATAFILE" )
Button3:SetTextColor(Color(180, 180, 180, 255));
Button3:SetPos( x, y )
Button3:SetSize( 300, 50 )
Button3.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, bigcolor2 )
end
Button3.PaintOver = function( self, w, h )
	surface.SetDrawColor(41, 128, 185, 255)
	
	for i = 1, 3 do
		surface.DrawRect(0, h - 2, w, 2);
	end
end
Button3.DoClick = function()

	net.Start("OpenPanel")
	net.WriteInt( 1, 3 ) 
	net.SendToServer()
	
	Clockwork.option:PlaySound("click");
	Button2:Remove()
	Button3:Remove()

	FrameDP:SetTitle( "PDA: ENTER INFORMATION" )
	
	local y = FrameDP:GetTall()/2-275
	local x = FrameDP:GetWide()/2-150
	local enterlabel = vgui.Create( "DLabel", FrameDP )
	enterlabel:SetFont("FrameDP")
	enterlabel:SetText( "ENTER NAME OR CID:" )
	enterlabel:SetTextColor( Color(255, 255, 255 ,255) )
	enterlabel:SetPos( x, y )
	enterlabel:SetSize( 515, 50 )

	local y = y + 100
	local cidnametext = vgui.Create("DTextEntry", FrameDP)
	cidnametext:SetText("")
	cidnametext:SetPos( x, y )
	cidnametext:SetSize( 300, 50 )
	cidnametext.OnEnter = function(self)
		local target = Clockwork.player:FindByID( self:GetValue() );
		if (target) then
			LocalPlayer():ConCommand( "cwSay /datafile "..self:GetValue() )
			FrameDP:Close()
		else
			Clockwork.chatBox:Add(Clockwork.Client, nil, "notify", "<:: "..self:GetValue().." is not a valid person. ::>")
		end
	end
end

Button4.DoClick = function()
	if (!Button3:IsValid()) then
	FrameDP:Close()
	LocalPlayer():ConCommand( "cwSay /cwupda" )
	
	net.Start("ClosePanel")
	net.WriteInt( 0, 3 ) 
	net.SendToServer()
	
	else
	LocalPlayer():ConCommand( "cwSay /closecwupda" )
	FrameDP:Close()
	end
	Clockwork.option:PlaySound("click");
end

Button2.OnCursorEntered = function()
	bigcolor1 = Color( 90, 90, 90, 255 )
	Clockwork.option:PlaySound("rollover");
end
Button2.OnCursorExited = function()
	bigcolor1 = Color( 65, 65, 65, 255 )
end

Button3.OnCursorEntered = function()
	bigcolor2 = Color( 90, 90, 90, 255 )
	Clockwork.option:PlaySound("rollover");
end
Button3.OnCursorExited = function()
	bigcolor2 = Color( 65, 65, 65, 255 )
end
end)

concommand.Add( "cw_cwupda", function( ply, cmd, args )
	ply:ConCommand( "cwSay /cwupda" )
end )


Clockwork.datastream:Hook("EditCwuObjectives", function(data)
	if (Schema.CwuobjectivesPanel and Schema.CwuobjectivesPanel:IsValid()) then
		Schema.CwuobjectivesPanel:Close();
		Schema.CwuobjectivesPanel:Remove();
	end;
	
	Schema.CwuobjectivesPanel = vgui.Create("cwCwuObjectives");
	Schema.CwuobjectivesPanel:Populate(data or "");
	Schema.CwuobjectivesPanel:MakePopup();
	
	gui.EnableScreenClicker(true);
end);