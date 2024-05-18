
--[[

UPDATE NOTES:

GOALS:
  XX Add soldier death delay and gunsound sfx.
  -- Have the soldiers carry guns.
  -- Polish the map surroundings.
  -- Create a smooth transition where the soldier doesn't teleport but moves to a node.
  			-- Warning. This will create a radical change in the coding of the soldier as 
  			the original soldier is destroyed and a literal new soldier is cloned and put on 
  			the node.
  ?? Polish the GUI.
  -- Create a better selection room.
  -- Create a waiting queue server.
  -- Create an ELO system.

VERSION 1.3 
- Tweak GUIs for different window sizes.
X Customize atmosphere for separate maps.
X Create darkened atmosphere for lobby.
- Add confirmation window for forfeits.
  
  
FOREST UPDATE PLANS:
    X Reset characters upon game start.
    -- Add better ambience
    X Add flash to guns
    X Add sound effects to soldiers moving
    X Add sound effects to construction
    X Rudimentary gun animations
    X Finish polishing of forest environment
    	X Trees
    	X Rocks
    	X Random structures
   	X Change gun fire to pistol fire
   	X Add sound for burning building
   	X Add sound for destruction
    	
    BUGS FOUND:
 	X Moving sounds are attempted to play even when the soldier enters a hotzone.
  
MAY 10, 2024

MAY 9, 2024
    -- Started on potential decor.

January 16, 2024
	-- Tweaked team management slightly.

January 15, 2024
    -- Revamped most GUI elements.
    -- Created a feature in which when a node is under threat of being destroyed,
       the buildings start smoking.
    -- Tweaked movement restrictions.
    -- Enabled voice chat.
    -- Changed priority system for enemy checks in which when a soldier lands on a node
       with an enemy turret and enemy soldier, instead of attacking the soldier first, 
       the soldier attacks the turret first. 

January 14, 2024
    -- Created a gray-like skybox.
    -- Added a light fog to the area.
    -- Changed part textures to grass and mud.
    -- Added a feature where when a soldier dies, a tombstone is left in its place.
    -- Adjusted troop Y-coordinates in octagonal nodes given they looked shorter in octagonal nodes than in rectagulars.
    -- Adjusted building Y-coordinates due to strange bug where the barracks were hovering very slightly above the ground.
    -- Fixed a bug in which the "spawn blocks" on the rectangular nodes could fall off.
    -- Changed the color of the hovering health GUI for the turrets.
    -- Added rain.
    -- Created a feature in which when a "fight" occurs (soldier v. soldier or soldier v. turret), all choices
       are halted until the animation is done.
 
January 13, 2024
	-- Fixed a bunch of coloring bugs.
	-- Fixed a new bug in which turrets could kill friendly soldiers.
	-- Optimized the code so that all of troop generation and "fights" are governed 
	   by turnManagement and not by 2 separate scripts.
	-- Added prices for construction on the GUI.
	-- Added a delay in which gunshots ring out when soldiers of conflicting side land
	   on the same node, to which afterwards, they die.
	-- Added to the turn label so it reflects whose turn it is.
	-- Added a wonky (and potentially buggy) / temporary tutorial GUI where users can access
	   the rules of the game.
	-- Changed max server size to 2 players.
	-- Tweaked nodes and soldiers so that they can be clicked from a farther range 
	   (200 --> 500 units max)

January 10, 2024
	-- Added feature in which tiles that soldiers step on changes their color to 
	   fit the soldier's team color.

Late January 9, 2024

	-- Added map selections
			- Center Game
			- The Ring
	-- Added an area in which the user can select a map to play on.
	-- Adjusted default walkspeed to be faster.

January 6, 2024

	THE BACKBONE OF TERRORTORY IS DONE.
	
		2,126 lines of code (can be optimized)
			Node Click Detection Scripts: 173 lines
			Soldier Movement: 303 lines
			GUI: 739 lines 
			Module Scripts: 877 lines 
			Other: 34 lines

 	----------------------------------------------------------------------------------------
	GAME SYSTEM
	---------------------------------------------------------------------------------------
	-- Fixed bug where Side B could move their troops at the beginning of the game despite it 
	   not being their turn. (Added movementRestrictor in StarterPlayerScripts)
	-- Fixed bug in which troop movement was allowed even when someone had 0 chips.
	-- Added destruction system.
			If a node with enemy buildings is surrounded by 3 troops for a full turn without interruption,
			the node's buildings get destroyed.
			However if at any point during that full turn interval that the troop number falls below
			3, the destruction process stops until the next turn.
	-- Added a warning GUI to show why an input may not be working (i.e. trying to buy something when
	   the player doesn't have enough money.)
	-- Created a rudimentary end game screen.
	-- Fixed bug in which the player can click on another troop while being in another troop decision time.
	

January 5, 2024

    ----------------------------------------------------------------------------------------
	GAME SYSTEM
	---------------------------------------------------------------------------------------
	-- Added a label that shows the enemy's amount of chips.
	-- Added factory functionality in which after every full turn, chips are 
	   given out to both sides.
	-- Added a label that shows what turn number it is.
	-- Added barracks functionality that generates troops when an even turn is coming up. 
	-- Added troop destruction where:
			 If a troop is put into a space where an enemy troop resides, both that troop 
			 and their troop dies.
	-- Added turret functionality.
			 Turrets eliminate enemy soldiers that come across its node. However, each time 
			 a troop attacks the turret, the turret's health is reduced by 1. 
			 When turret health is 0, the turret is destroyed.
	-- Added a billboard GUI that hovers above turrets that outline the health of turrets.
	-- Fixed bug in which the currencyGUI for the enemy was not updating when an enemy move was made.
	
	----------------------------------------------------------------------------------------
	BACKEND
	----------------------------------------------------------------------------------------
	-- Added updateCurrencyGUI event that fires on all clients so decisions that affect currency
	can then be seen on other clients.
	-- Removed an unnecessary attribute given to rectangular nodes (turretHere)
	-- Turrets have been given an attribute of what side owns the turret.

January 4, 2024 

    ----------------------------------------------------------------------------------------
	GAME SYSTEM
	---------------------------------------------------------------------------------------
	- Included the values for the currencies used: AChips & BChips
	- Created label that showcases the current currency of the system.
	       * Updates upon every buildDecisionEnd
	- Included a currency limitation system.
		   * User can no longer click on the buildBarracksButton nor
			 the buildFactoryButton when they are simply too poor.
	- Coded the teams.
	- Coded the turret building system
	- Added the currency deduction that's given when you move a troop.
	- Added the currency deduction that's given when you build a turret, barracks, or factory.
	- Added a rudimentary (but potentially buggy) turn system.
		*Turns can be passed from 1 side to another freely.
		*Ex: B side can only have their turn when A side has passed their turn.

	----------------------------------------------------------------------------------------
	BACKEND
	----------------------------------------------------------------------------------------
	- Created a verifyTroopPopulations() functiont to confirm the troopPopulation 
	  attribute on each node is correct.
	- Created a test button which allows both sides' chips to go to 1000.








STUFF LEFT TO CODE: 

NECESSITIES

X Assigning a side 

X Turret Generation
	X Also gives respect to the direction the turret should face.

X Soldier Spawning (in mapGenerators)
	X Referring to the 3 soldiers that spawn in the beginning of the game

X turnManagement
	X Currency additions
	X Soldier spawning around barracks

X? playerProfiles
	X Local in a game
	X To keep track of how much coins each player have
	X? Keeps track of whose barracks/factories are who.
	
X Soldier Movements
	X Allowing soldiers to move within the game
	X Death system in which if a soldier and enemy soldier is in the same mode, they die.
		
	
- Destruction system
	* At least 3 enemy soldiers need to hold an area in order for the node's buildings to be destroyed.
		-- ONLY CAN BE CODED AFTER TURN SYSTEM HAS BEEN MADE.
	
X User Interface
	X Client-side buttons which allow users to build things on the map actually.
	X Also allows soldiers to be clicked and moved to adjacent nodes.
	
- Win/Lose Condition
	* Tells the game when a game ends when the conditions are met:
		The buildings in the enemies' bases are destroyed.
		
- Resign Button

- Main Menu Screen


- Create Match Screen

WANTS: 

- Convenient soldier movement system that allows the player to move the soldier over multiple nodes and not one node at a time.


]]--

--[[
HANGING EXCEPTIONS IN THE CODE:

turnManagement.turnPayments
	-- Still requires code for player profiles/statistics
	-- BE VERY WARY ON HOW "ASideOccupied" and "BSideOccupied" is set.
		-- In the beginning stages of the game:
			Occupance is primarily determined 





]]


--[[
TROOP MOVEMENT

1) Player1 clicks on troop1
2) Player1 is able to click on available spaces (client-side)
3) troop1 goes to actual place (workplace)
4) 



]]