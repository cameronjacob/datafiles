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

Clockwork.datastream:Hook("DrawDatapad", function(dataob)

FrameDP = vgui.Create( "DFrame" )
FrameDP:SetTitle( "DATAPAD" )
FrameDP:SetSize( 700, 570 )
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

local Button = vgui.Create( "DButton", FrameDP )
local Button2 = vgui.Create( "DButton", FrameDP )
local Button3 = vgui.Create( "DButton", FrameDP )
local Button4 = vgui.Create( "DButton", FrameDP )
local Button5 = vgui.Create( "DButton", FrameDP )

Button4:SetText( "" )
Button4:SetPos( 680, 0 )
Button4:SetSize( 20, 20 )
Button4.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, bigcolor3 )
end

local y = FrameDP:GetTall()/1.6-250
local x = FrameDP:GetWide()/2-150
Button:SetFont("FrameDP")
Button:SetText( "MANAGE DATAFILE" )
Button:SetTextColor(Color(180, 180, 180, 255));
Button:SetPos( x, y )
Button:SetSize( 300, 50 )

Button.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, bigcolor )
end
Button.PaintOver = function( self, w, h )
	surface.SetDrawColor(39, 174, 96, 255)
	
	for i = 1, 3 do
		surface.DrawRect(0, h - 2, w, 2);
	end
end

Button.DoClick = function()

	net.Start("OpenPanel")
	net.WriteInt( 1, 3 ) 
	net.SendToServer()
	
	Clockwork.option:PlaySound("click");
	Button:Remove()
	Button2:Remove()
	Button3:Remove()
	Button5:Remove()
	
	FrameDP:SetTitle( "DATAPAD: ENTER INFORMATION" )
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
			LocalPlayer():ConCommand( "cwSay /managedatafile "..self:GetValue() )
			FrameDP:Close()
		else
			Clockwork.chatBox:Add(Clockwork.Client, nil, "notify", "<:: "..self:GetValue().." is not a valid person. ::>")
		end
	end
end

local y = y + 100
Button2:SetFont("FrameDP")
Button2:SetText( "DATAFILE RESTRICTION" )
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

	net.Start("OpenPanel")
	net.WriteInt( 1, 3 ) 
	net.SendToServer()
	
	Clockwork.option:PlaySound("click");
	Button:Remove()
	Button2:Remove()
	Button3:Remove()
	Button5:Remove()

	FrameDP:SetTitle( "DATAPAD: ENTER INFORMATION" )
	
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
		if (target) and (target:GetSharedVar("PlayerIsRestricted") == 0) then
			LocalPlayer():ConCommand( "cwSay /restrictdatafile "..self:GetValue().." DISPATCH" )
			FrameDP:Close()
		elseif (target) and (target:GetSharedVar("PlayerIsRestricted") == 1) then
			LocalPlayer():ConCommand( "cwSay /restrictdatafile "..self:GetValue() )
			FrameDP:Close()
		else
			Clockwork.chatBox:Add(Clockwork.Client, nil, "notify", "<:: "..self:GetValue().." is not a valid person. ::>")
		end
	end
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
	Button:Remove()
	Button2:Remove()
	Button3:Remove()
	Button5:Remove()

	FrameDP:SetTitle( "DATAPAD: ENTER INFORMATION" )
	
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

local y = y + 100
Button5:SetFont("FrameDP")
Button5:SetText( "RESET DATAFILE" )
Button5:SetTextColor(Color(180, 180, 180, 255));
Button5:SetPos( x, y )
Button5:SetSize( 300, 50 )
Button5.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, bigcolor4 )
end
Button5.PaintOver = function( self, w, h )
	surface.SetDrawColor(231, 76, 60, 255)
	
	for i = 1, 3 do
		surface.DrawRect(0, h - 2, w, 2);
	end
end

Button5.DoClick = function()

	net.Start("OpenPanel")
	net.WriteInt( 1, 3 ) 
	net.SendToServer()
	
	Clockwork.option:PlaySound("click");
	Button:Remove()
	Button2:Remove()
	Button3:Remove()
	Button5:Remove()

	FrameDP:SetTitle( "DATAPAD: ENTER INFORMATION" )
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
			LocalPlayer():ConCommand( "cwSay /scrubdatafile "..self:GetValue() )
			FrameDP:Close()
		else
			Clockwork.chatBox:Add(Clockwork.Client, nil, "notify", "<:: "..self:GetValue().." is not a valid person. ::>")
		end
	end
end

Button4.DoClick = function()
	if (!Button5:IsValid()) then
	FrameDP:Close()
	LocalPlayer():ConCommand( "cwSay /datapad" )
	
	net.Start("ClosePanel")
	net.WriteInt( 0, 3 ) 
	net.SendToServer()
	
	else
	LocalPlayer():ConCommand( "cwSay /closedatapad" )
	FrameDP:Close()
	end
	Clockwork.option:PlaySound("click");
end

Button.OnCursorEntered = function()
	bigcolor = Color( 90, 90, 90, 255 )
	Clockwork.option:PlaySound("rollover");
end
Button.OnCursorExited = function()
	bigcolor = Color( 65, 65, 65, 255 )
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
Button5.OnCursorEntered = function()
	bigcolor4 = Color( 90, 90, 90, 255 )
	Clockwork.option:PlaySound("rollover");
end
Button5.OnCursorExited = function()
	bigcolor4 = Color( 65, 65, 65, 255 )
end
end)

concommand.Add( "cw_datapad", function( ply, cmd, args )
	ply:ConCommand( "cwSay /datapad" )
end )