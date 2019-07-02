local PLUGIN = PLUGIN;

PLUGIN:SetGlobalAlias("cwDatafile");

Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("LoyaltyPoints", true);
	playerVars:Number("BOL", true);
	playerVars:Number("LoyaltyTier", true);
	playerVars:Number("PlayerIsRestricted", true);
	playerVars:Number("DatafileOpen", true);
	playerVars:Number("ManagementOpen", true);
end;

// All the categories possible. Yes, the names are quite annoying.
PLUGIN.Categories = {
	"med",      // Medical note.
	"union",    // Union (CWU, WI, UP) type note.
	"civil",    // Civil Protection/CTA type note.
};

// Permissions for the numerous factions.
PLUGIN.Permissions = {
	elevated = {
		"Administrator",
	},
	full = {
		"Overwatch Transhuman Arm",
		"Metropolice Force",
	},
	medical = {
		"Civil Medical Union",
	},
	cwu = {
		"Civil Worker's Union",
	},
	none = {
		"Citizen",
	},
};

// Factions that do not get access to the datafile & factions that do not get a datafile.
PLUGIN.RestrictedFactions = {
	"Alien Grunt",
	"Bird",
	"Houndeye",
	"Vortigaunt",
	"Zombie",
	"Houndeye"
};

// All the civil statuses. Just for verification purposes.
PLUGIN.CivilStatus = {
	"Anti-Citizen",
	"Working Class",
	"Middle Class",
	"Upper Class",
};

PLUGIN.EmploymentStatus = {
	"Overwatch Transhuman Arm",
	"Civil Protection",
	"Civil Worker's Union",
	"Civil Medical Union",
	"Citizen",
	"Biotic",
};

PLUGIN.Default = {
	GenericData = {
        bol = {false, ""},
        restricted = {false, ""},
        civilStatus = "Working Class",
		employmentStatus = "Citizen",
        lastSeen = os.date("%H:%M:%S - %d/%m/%Y", os.time()),
        points = 0,
        sc = 0,
	},
	civilianDatafile = {
        [1] = {
           	category = "union", // med, union, civil
            text = "TRANSFERRED TO DISTRICT WORKFORCE.",
            date = os.date("%H:%M:%S - %d/%m/%Y", os.time()),
            points = "0",
            poster = {"Overwatch", "BOT"},
        },
	},
	combineDatafile = {
        [1] = {
           	category = "union", // med, union, civil
            text = "INSTATED AS CIVIL PROTECTOR.",
            date = os.date("%H:%M:%S - %d/%m/%Y", os.time()),
            points = "0",
            poster = {"Overwatch", "BOT"},
        },
	},
};
