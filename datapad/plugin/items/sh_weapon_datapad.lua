--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.name = "Civil Protection Datapad";
	ITEM.cost = 500;
	ITEM.model = "models/fruity/tablet/tablet_sfm.mdl";
	ITEM.weight = 1;
	ITEM.access = "v";
	ITEM.skin = 1
	ITEM.business = true;
	ITEM.uniqueID = "weapon_datapad";
	ITEM.weaponClass = "weapon_datapad";
	ITEM.category = "Civil Protection";
	ITEM.description = "A datapad for civil protection to manage civil and protection team protocols.";
	ITEM.hasFlashlight = true;
	ITEM.isAttachment = true;
	ITEM.loweredOrigin = Vector(3, 0, -4);
	ITEM.loweredAngles = Angle(0, 45, 0);
	ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
	ITEM.attachmentOffsetAngles = Angle(68.62, 108.4, 152.15);
	ITEM.attachmentOffsetVector = Vector(-1.41, 0.71, -6.36);
ITEM:Register();