![Image of Datafile](https://i.imgur.com/2DnlQyU.png)
# Datafiles
ORIGINAL PLUGIN BY JAMES - PERMISSION FOR RELEASE GRANTED

Conversion done by vex#0011.

## Note

Here's a full conversion of this plugin for HL2:RP v1.3.

There are still some things you will have to add manually. For example, I didn't add automatic population and implementation of the two custom columns this plugin adds into the characters table of the database. I left the two SQL queries you will have to use in the Installation section of the readme.

## Information

Edits made by vex#0011:
1. Now converted for use with HL2:RP v1.3.
2. Changed item world models to use vanilla GMod models to prevent errors.
3. Changed community-specific factions and unrecognizable names to more general use.

What does the datapad/pda's do?
1. Combine Datapad gives access to the /datafile, /managedatafile, /restrictdatafile, /scrubdatafile commands.
2. CWU datapad gives access to a limited version of the /datafile (adding notes) and custom CWU only objectives editable by CWU leader settable by /setcwulead and /removecwulead.
3. CMU datapad gives access to a limited version of the /datafile (adding medical notes) and custom CMU only objectives editable by CMU leader settable by /setcmulead and /removecmulead.

## Shared vars

1. LoyaltyPoints
2. BOL
3. LoyaltyTier
4. PlayerIsRestricted
5. DatafileOpen
6. ManagementOpen
7. PlayerObjectivesOpen
8. PlayerEnterOpen

## Unfinished

1. Didn't make SQL table creation automatic.
2. Didn't do CWU & CMU PDA attachments item-wise.
3. Apparently there's an error which I'm unable to recreate with the datapad derma.

## Installation

Place all four directories into your gamemodes/cwhl2rp/plugins/ folder.

Add these columns to the characters SQL table with datatype TEXT.
_GenericData
_Datafile

ie.
```
ALTER TABLE characters ADD _GenericData TEXT;
ALTER TABLE characters ADD _Datafile TEXT;
```

## Streamables 

1. https://streamable.com/vfjmu
2. https://streamable.com/9uou4
