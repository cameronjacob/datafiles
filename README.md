![Image of Datafile](https://i.imgur.com/2DnlQyU.png)
# Datafiles
ORIGINAL PLUGIN BY JAMES - PERMISSION FOR RELEASE GRANTED
Conversion done by vex#0011.

_________________________
<b>Information</b>
_________________________

An edited version I worked on for a community that closed (unfinished).

Features different from the version by James:
1. BOL removal fixed.
2. Employment status config implemented.
3. Actual datapad items and sweps that switches materials when you use the datafile commands and need to be held in order to use the datafile commands.
4. CWU and CMU pda for those factions that allows either adding notes or medical notes.
5. RL and SCN able to use datafile management, restriction and reset commands.
6. Restriction now restricts datafile to be viewed only by RL and SCN.
7. A bunch of sharedvars added to use with other plugins.
8. Fixed some incorrect datastream names.
9. Transfered datafile SQL information to characters table instead of a whole new datafile table (did this because data transfered between characters if characters were deleted).

Edits made by vex#0011:
1. Now converted for use with HL2:RP v1.3.
2. Changed item world models to use vanilla GMod models to prevent errors.
3. Changed community-specific factions and unrecognizable names to more general use.

What does the datapad/pda's do?
1. Combine Datapad gives access to the /datafile, /managedatafile, /restrictdatafile, /scrubdatafile commands.
2. CWU datapad gives access to a limited version of the /datafile (adding notes) and custom CWU only objectives editable by CWU leader settable by /setcwulead and /removecwulead.
3. CMU datapad gives access to a limited version of the /datafile (adding medical notes) and custom CMU only objectives editable by CMU leader settable by /setcmulead and /removecmulead.

_________________________
<b>Shared vars</b> (playerVars:Number only) -- primarily used for datapad sweps material switching to work properly
_________________________

1. LoyaltyPoints
2. BOL
3. LoyaltyTier
4. PlayerIsRestricted
5. DatafileOpen
6. ManagementOpen
7. PlayerObjectivesOpen
8. PlayerEnterOpen

_________________________
<b>Unfinished</b>
_________________________

1. Didn't make SQL table creation automatic.
2. Didn't do CWU & CMU PDA attachments item-wise.
3. Apparently there's an error which I'm unable to recreate with the datapad derma.

_________________________
<b>Installation</b>
_________________________

Place all four directories into your gamemodes/cwhl2rp/plugins/ folder.

Add these columns to the characters SQL table with default variable "fill" (I didn't bother to make it create itself):
_GenericData
_Datafile

ie.
ALTER TABLE characters ADD _GenericData TEXT DEFAULT 'fill';
ALTER TABLE characters ADD _Datafile TEXT DEFAULT 'fill';

_________________________
<b>Streamables of the plugin(s)</b> - videos may or may not differ from what the plugin looks like now.
_________________________

1. https://streamable.com/vfjmu
2. https://streamable.com/9uou4
