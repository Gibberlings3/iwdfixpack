// simple syntax errors
REPLACE_TRIGGER_TEXT ~ddirtyll~ ~CheckStat\([GL]\)T(Protagonist,CHR,\([0-9]+\))~ ~CheckStat\1T(Protagonist,\2,CHR)~
REPLACE_ACTION_TEXT  ~detemp~   ~AddXPVar("Level_1_Average")~ ~AddXPVar("Level_1_Average",18528)~
REPLACE_TRIGGER_TEXT ~dfgg~     ~ClassEx(Protagonist,Priest)~ ~ClassEx(Protagonist,CLERIC)~
REPLACE_ACTION_TEXT  ~dfrostbi~ ~ForceAttack(protagonist, myself)~ ~~
REPLACE_ACTION_TEXT  ~dgntgrd~  ~ForceAttack(protagonist, myself)~ ~~
REPLACE_TRIGGER_TEXT ~dmirek~   ~Global("AR3000_Visited", GLOBAL", 1)~ ~Global("AR3000_Visited","GLOBAL",1)~
REPLACE_TRIGGER_TEXT ~dorcchie~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_ACTION_TEXT  ~dorogchi~ ~ForceAttack(protagonist, myself)~ ~~
REPLACE_ACTION_TEXT  ~dosentry~ ~ForceAttack(protagonist, myself)~ ~~
REPLACE_TRIGGER_TEXT ~dperdiem~ ~ClassEx(Protagonist,Priest)~ ~ClassEx(Protagonist,CLERIC)~
REPLACE_TRIGGER_TEXT ~dserrhya~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_TRIGGER_TEXT ~dseth~    ~CheckStat\([GL]\)T(Protagonist,CHR,\([0-9]+\))~ ~CheckStat\1T(Protagonist,\2,CHR)~
REPLACE_TRIGGER_TEXT ~dseth~    ~CheckStat\([GL]\)T(Protagonist,INT,\([0-9]+\))~ ~CheckStat\1T(Protagonist,\2,INT)~
REPLACE_TRIGGER_TEXT ~dsoth~    ~ClassEx(Protagonist, ?Priest)~ ~ClassEx(Protagonist,CLERIC)~
REPLACE_ACTION_TEXT  ~dvera~    ~ForceAttack(protagonist, myself)~ ~~
REPLACE_ACTION_TEXT  ~dwinona~  ~ChangeStat(Protagonist,CHA,\([0-9]+\),SET)~ ~ChangeStat(Protagonist,CHR,\1,SET)~
REPLACE_ACTION_TEXT  ~dwinona~  ~GiveItemCreate("\([A-Za-z0-9]+\)",\([A-Za-z0-9]+\))~ ~GiveItemCreate("\1",\2,0,0,0)~

// only 4/5 random lines can fire
REPLACE_TRIGGER_TEXT dgntslav ~RandomNumLT(4,[ %TAB%]*5)~ ~RandomNum(5,4)~ // fixed bugged replies for this one first
REPLACE_TRIGGER_TEXT_REGEXP ~\(^ddugslav$\)\|\(^dgenmoni$\)\|\(^dgntslav$\)~ ~RandomNum(4,[ %TAB%]*0)~ ~RandomNum(5,5)~ // random generates 1 - x, so this never fires
REPLACE_TRIGGER_TEXT_REGEXP ~\(^ddugslav$\)\|\(^dgenmoni$\)\|\(^dgntslav$\)~ ~RandomNum(4,~   ~RandomNum(5,~ // refactor the other triggers

// extend class-specific replies to mutliclasses
ALTER_TRANS DACCALIA BEGIN 3 END BEGIN 2 END BEGIN "TRIGGER" ~ClassEx(Protagonist,DRUID)~ END // from druid
ALTER_TRANS DACCALIA BEGIN 3 END BEGIN 3 END BEGIN "TRIGGER" ~ClassEx(Protagonist,RANGER)~ END // from ranger
// also has an action being used as a trigger
ALTER_TRANS DACCALIA BEGIN 6 END BEGIN 1 END BEGIN "TRIGGER" ~~ END // removes SetGlobal("Jered_Stone","GLOBAL", 1)
ADD_TRANS_ACTION DACCALIA BEGIN 6 END BEGIN 1 END ~SetGlobal("Jered_Stone","GLOBAL",1)~ // and add it as an action

// albion sets journal entries too early
ALTER_TRANS dalbion BEGIN 0 END BEGIN END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS dalbion BEGIN 5 END BEGIN END BEGIN ~JOURNAL~ ~#3354~ END // and add it back
ALTER_TRANS dalbion BEGIN 18 END BEGIN 0 1 END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS dalbion BEGIN 23 END BEGIN END BEGIN ~JOURNAL~ ~#4343~ END // and add it back
  
// Amelia's journal entries - push entries back to state 8, but requires state 8 to be split evil/non-evil
ALTER_TRANS DAMELIA BEGIN 5 END BEGIN END BEGIN ~JOURNAL~ ~~ END // remove all journal entries
ALTER_TRANS DAMELIA BEGIN 8 END BEGIN END BEGIN ~JOURNAL~ ~#2057~ END // add 'good' journal here
ADD_TRANS_TRIGGER DAMELIA 8 ~!Alignment(LastTalkedToBy,MASK_EVIL)~    // make these non-evil replies
EXTEND_BOTTOM DAMELIA 8 // now copy state 8 replies for evil options with evil journal entry
  IF ~Alignment(LastTalkedToBy,MASK_EVIL)~ THEN REPLY #1797 JOURNAL #2073 GOTO 10
  IF ~Alignment(LastTalkedToBy,MASK_EVIL) Global("Kuldahar_Attack", "GLOBAL", 0)~ THEN REPLY #1798 JOURNAL #2073 GOTO 11
  IF ~Alignment(LastTalkedToBy,MASK_EVIL)~ THEN REPLY #1799 JOURNAL #2073 EXIT
END

// goes to wrong state
ALTER_TRANS DAPSEL BEGIN 13 END BEGIN 0 END // filename, state, trans
  BEGIN EPILOGUE ~GOTO 4~ END

// arundel sets journal too early... more complicated fix
ALTER_TRANS DARUNDEL BEGIN 42 END BEGIN END BEGIN ~JOURNAL~ ~~ END // remove all journal entries here
ADD_TRANS_ACTION DARUNDEL BEGIN 42 END BEGIN 2 END ~SetGlobal("AddEntry16556","LOCALS",1)~ // add var for alternate journal
ALTER_TRANS DARUNDEL BEGIN 46 END BEGIN END BEGIN ~JOURNAL~ ~#10626~ END // and add it back
EXTEND_BOTTOM DARUNDEL 46                                                // add alternate path for other journal
  IF ~Global("AddEntry16556","LOCALS",1)~ THEN JOURNAL #16556 EXIT
END

// fixes bandoth's random hostility
ALTER_TRANS DBANDOTH BEGIN 26 END BEGIN 0 END
  BEGIN ACTION ~EscapeArea()~ END

ALTER_TRANS DBANDOTH BEGIN 10 END BEGIN 2 END // filename, state, trans
  BEGIN ACTION ~SetGlobal("Dorn_Door","GLOBAL",1)~ END // removes hostility

//restructure bandoth's dialogue slightly
ADD_STATE_TRIGGER DBANDOTH 1 ~Global("Bandoth_Quest","GLOBAL",0)~
SET_WEIGHT DBANDOTH 0 #1 // never spoken
SET_WEIGHT DBANDOTH 1 #2 // spoken once+
SET_WEIGHT DBANDOTH 2 #3 // razorvine in progress
SET_WEIGHT DBANDOTH 3 #5 // raxorvine complete
SET_WEIGHT DBANDOTH 4 #6 // razorvine wonk
SET_WEIGHT DBANDOTH 6 #4 // forge is on

// allow bandoth to help with puzzle
EXTEND_BOTTOM DBANDOTH 0
  IF ~Global("PUZZLE_STAIRS_OPEN","GLOBAL",0) PartyHasItem("Kalabac")~ THEN REPLY #19609 GOTO 23
END
EXTEND_BOTTOM DBANDOTH 4
  IF ~Global("PUZZLE_STAIRS_OPEN","GLOBAL",0) PartyHasItem("Kalabac")~ THEN REPLY #19609 GOTO 23
END

// sister calliana not recognizing egenia's return
REPLACE_TRIGGER_TEXT ~dcallian~ ~Global("Talonite_Dead","GLOBAL",4)~ ~GlobalGT("Talonite_Dead","GLOBAL",9)~
ADD_TRANS_TRIGGER dcallian 2 ~!Global("Egenia_Talked","GLOBAL",1)~ DO 0 2
ADD_STATE_TRIGGER dcallian 8 ~!Global("Egenia_Talked","GLOBAL",1)~ 
// because of OR(), check how- or base-fixes
//REPLACE_STATE_TRIGGER dcallian 7 ~NumTimesTalkedToGT(0) OR(2) Global("Know_Egenia","GLOBAL",0) Global("Egenia_Talked","GLOBAL",1)~	

// prisoners not realizing they're free due to bad DV checks
REPLACE_TRIGGER_TEXT ~dcapkid2~ ~GlobalLT("Talonites_Dead","GLOBAL"~ ~GlobalLT("Talonite_Dead","GLOBAL"~
REPLACE_TRIGGER_TEXT ~dcapkid2~ ~Global("Talonites_Dead","GLOBAL",10)~ ~GlobalGT("Talonite_Dead","GLOBAL",9)~
REPLACE_TRIGGER_TEXT ~dcapvil2~ ~GlobalLT("Talonites_Dead","GLOBAL"~ ~GlobalLT("Talonite_Dead","GLOBAL"~
REPLACE_TRIGGER_TEXT ~dcapvil2~ ~Global("Talonites_Dead","GLOBAL",10)~ ~GlobalGT("Talonite_Dead","GLOBAL",9)~

// bad random spread could cause no valid links error
REPLACE_TRIGGER_TEXT ~dckquest~ ~RandomNum(5,0)~ ~RandomNum(5,5)~

// don't use 'dainty llew' reply outside of the 'dainty llew' state
ALTER_TRANS ddirtyll BEGIN 14 END BEGIN 2 END BEGIN ~REPLY~ ~#9945~ END

// remove xp exploit, let elisia vanish in peace
ADD_STATE_TRIGGER DELISIA 18 ~!Global("Elisia_Vanish","GLOBAL",1)~
ADD_TRANS_ACTION DELISIA BEGIN 20 END BEGIN END ~SetInterrupt(FALSE)~

// some of Llew's startstore calls using wrong resref
REPLACE_ACTION_TEXT  DDIRTYLL ~StartStore("LD_DL\([123]\)",Protagonist)~ ~StartStore("LDD_DL\1",Protagonist)~

// llew can now offer umber hulk armor
REPLACE DDIRTYLL
  IF ~GlobalLT("Umber_Hulk_Armor","GLOBAL",15)
      PartyHasItem("HideUmb")
      !NumTimesTalkedTo(0)~  THEN BEGIN 22 SAY #18333
    IF ~~ THEN REPLY #18334 DO ~TakePartyItemAll("HideUmb")
                                SetGlobal("Umber_Hulk_Armor","GLOBAL",15)
                                GiveItemCreate("UmHulk",Protagonist,1,1,1)~ GOTO 23
    IF ~~ THEN REPLY #18335 DO ~IncrementGlobal("Umber_Hulk_Armor","GLOBAL",1)~ GOTO 24
  END
END

SET_WEIGHT DDIRTYLL 22 #-1 // replace ignores weight for some reason

// grisella should only give cash if party asked for it
REPLACE_ACTION_TEXT DGRISELL ~GivePartyGold(5)~ ~~ // remove all
ADD_TRANS_TRIGGER DGRISELL 12 ~Global("Grisella_Cash","GLOBAL",1)~ DO 4
ADD_TRANS_ACTION DGRISELL BEGIN 12 END BEGIN 3 4 END ~GivePartyGold(5)~

// shouldn't be able to ask 'who's ilmadia' if you've already met her; see also dtarnelm
ADD_TRANS_ACTION dilmadia BEGIN 0 END BEGIN END ~SetGlobal("cd_met_ilmadia","GLOBAL",1)~

// when ilmadia goes hostile, also turn fire giants and her two lieutenants hostile
REPLACE_ACTION_TEXT DILMADIA ~Enemy()~ ~SetGlobal("%group_2_hostile%","MYAREA",1) Enemy()~

// jhonen sets journal entry too early
ALTER_TRANS djhonen BEGIN 10 END BEGIN 1 END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS djhonen BEGIN 13 END BEGIN END BEGIN ~JOURNAL~ ~#11408~ END // and add it back

// block pathway to kerish asking you to kill vera if you've already been down it and accepted/declined
ADD_TRANS_TRIGGER dkerish 6 ~Global("Kill_Vera","GLOBAL",0)~ DO 3

// kresselack sets journal entry too early
ALTER_TRANS dkressel BEGIN 28 END BEGIN 0 END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS dkressel BEGIN 30 END BEGIN END BEGIN ~JOURNAL~ ~#416~ END // and add it back

// kuldahar rumors include a random voiced line from arundel
REPLACE_STATE_TRIGGER dkurum 11 ~False()~ // false out arundel line
REPLACE_STATE_TRIGGER dkurum 15 ~RandomNum(15,12)~ // move in #16 into #12 slot
REPLACE_TRIGGER_TEXT  dkurum ~RandomNum(16,~ ~RandomNum(15,~ // refactor into random-of-15 instead of random-of-16
  
// close infinite garnet exploit for clerics
ADD_TRANS_TRIGGER DKUTOWNG 40 ~Global("Priest_Gem","GLOBAL",0)~ DO 0

// once you know eidan's fate, villagers will no longer his mysterious disappearance
// essentially, re-route anything going to state 20 to identical (new) state that doesn't mention eidan
ADD_TRANS_TRIGGER dkutowng 18 ~GlobalLT("Aldwin_Eidan","GLOBAL",2)~ 19 DO 0
EXTEND_TOP ~dkutowng~ 18 #1 IF ~Global("Aldwin_Eidan","GLOBAL",2)~ THEN REPLY #12648 GOTO state20copy END
EXTEND_TOP ~dkutowng~ 19 #1 IF ~Global("Aldwin_Eidan","GLOBAL",2)~ THEN REPLY #12653 GOTO state20copy END
APPEND ~dkutowng~
  IF ~~ THEN BEGIN state20copy SAY @131
    IF ~~ THEN REPLY #12637 GOTO 14
    IF ~~ THEN REPLY #12638 GOTO 0
    IF ~~ THEN REPLY #376 EXIT
  END
END

// have larrel actually take the journal
ADD_TRANS_ACTION DLARREL BEGIN 46 END BEGIN 4 END ~TakePartyItem("EvaJour")~

// prevent dupe journal entries from lethias; essentially dupe replies of states 15 and 16
ALTER_TRANS dlethias BEGIN 15 END BEGIN END BEGIN "TRIGGER" ~Global("cd_journal_14418","LOCALS",0)~ "ACTION" ~SetGlobal("cd_journal_14418","LOCALS",1)~ END
ALTER_TRANS dlethias BEGIN 16 END BEGIN END BEGIN "TRIGGER" ~Global("cd_journal_14419","LOCALS",0)~ "ACTION" ~SetGlobal("cd_journal_14419","LOCALS",1)~ END
EXTEND_BOTTOM dlethias 15 IF ~Global("cd_journal_14418","LOCALS",1)~ THEN REPLY #8535 GOTO 16 END
EXTEND_BOTTOM dlethias 15 IF ~Global("cd_journal_14418","LOCALS",1)~ THEN REPLY #8539 EXIT END
EXTEND_BOTTOM dlethias 16 IF ~Global("cd_journal_14419","LOCALS",1)~ THEN REPLY #8541 GOTO 4 END
EXTEND_BOTTOM dlethias 16 IF ~Global("cd_journal_14419","LOCALS",1)~ THEN REPLY #8542 EXIT END

// marchon of waterdeep non-sequitir
ALTER_TRANS DMARCH BEGIN 9 END BEGIN END
  BEGIN ~EPILOGUE~ ~GOTO 5~ END
  
// marketh's prematue EscapeArea can prevent Marketh_Gone being set
REPLACE_ACTION_TEXT DMARKETH ~\(GiveItem("valiant",Protagonist)\)[ %TAB%%LNL%%MNL%%WNL%]*EscapeArea()~ ~\1~ // remove EscapeArea()

// errors on marketh's replies w.r.t. ginafae
ALTER_TRANS DMARKETH BEGIN 0 END BEGIN 2 END BEGIN ~TRIGGER~ ~Global("Ginafae_Eye","GLOBAL",1)~ END // checking wrong variable
ALTER_TRANS DMARKETH BEGIN 2 END BEGIN 0 END BEGIN ~TRIGGER~ ~~ END                                 // wrong reply checking for variable' delete...
ALTER_TRANS DMARKETH BEGIN 2 END BEGIN 1 END BEGIN ~TRIGGER~ ~Global("Ginafae_Eye","GLOBAL",1)~ END // .. and put it on the correct one

// close mytos infinite xp loophole; add variable and dupe xp-granting replies
ADD_TRANS_TRIGGER DMYTOS 7 ~Global("CDMytosDiplomacy","MYAREA",0)~ DO 1 2 3 4
ADD_TRANS_ACTION DMYTOS BEGIN 7 END BEGIN 1 2 3 4 END ~SetGlobal("CDMytosDiplomacy","MYAREA",1)~
EXTEND_BOTTOM DMYTOS 7
  IF ~!Global("CDMytosDiplomacy","MYAREA",0)~ THEN REPLY #2586 GOTO 9
  IF ~ClassEx(Protagonist,Cleric)
      !Global("CDMytosDiplomacy","MYAREA",0)~ THEN REPLY #2587 GOTO 10
  IF ~ClassEx(Protagonist,Druid)
      !Global("CDMytosDiplomacy","MYAREA",0)~ THEN REPLY #2588 GOTO 10
  IF ~ClassEx(Protagonist,Paladin)
      !Global("CDMytosDiplomacy","MYAREA",0)~ THEN REPLY #2589 GOTO 10
END

// question about legs going to wrong place
ALTER_TRANS DNORL BEGIN 4 END BEGIN 1 END
  BEGIN EPILOGUE ~GOTO 3~ END

// should be setting quest variable on all replies  
ADD_TRANS_ACTION dogre BEGIN 0 END BEGIN 3 END ~SetGlobal("Ghereg_Head","GLOBAL",1)~
  
// close xp exploit
REPLACE_TRIGGER_TEXT DORRICK ~\([^!]PartyHasItem("bookmyt")\)~ ~\1 !Global("Orrick_Quest","GLOBAL",4)~

// perdiem should only go through his post-rescue spiel once
ADD_STATE_TRIGGER DPERDIEM 15 ~Global("Crazy_Speech","GLOBAL",0)~

// perdiem sets journal entries too early
ALTER_TRANS dperdiem BEGIN 0 END BEGIN END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS dperdiem BEGIN 3 END BEGIN END BEGIN ~JOURNAL~ ~#34302~ END // and add it back
ALTER_TRANS dperdiem BEGIN 8 15 END BEGIN END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS dperdiem BEGIN 12 END BEGIN END BEGIN ~JOURNAL~ ~#34296~ END // and add it back

// sheemish only sets journal entry in one branch
ALTER_TRANS DSHEEMIS BEGIN 8 END BEGIN 1 2 END BEGIN ~JOURNAL~ ~#34198~ END

// soth's journal entry about Dugmaren Brightmane comes one state too early
ALTER_TRANS dsoth BEGIN 7 END BEGIN END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS dsoth BEGIN 8 END BEGIN END BEGIN ~JOURNAL~ ~#34307~ END // and add it back

// shouldn't be able to ask 'who's ilmadia' if you've already met her; see also dilmadia
ADD_TRANS_TRIGGER dtarnelm 4 ~!Global("cd_met_ilmadia","GLOBAL",1) !Dead("Ilmadia")~ 16 DO 2

// tarnelm looking for wrong item here
REPLACE_TRIGGER_TEXT ~dtarnelm~ ~!PartyHasItem("Food")~ ~!PartyHasItem("potatoes")~

// vera sets journal entry too early
ALTER_TRANS dvera BEGIN 7 END BEGIN 1 END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS dvera BEGIN 15 END BEGIN END BEGIN ~JOURNAL~ ~#34300~ END // and add it back

// the voice sets journal entry too early
ALTER_TRANS dvoiceda BEGIN 0 END BEGIN END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS dvoiceda BEGIN 8 END BEGIN END BEGIN ~JOURNAL~ ~#34245~ END // and add it back

// wrong journal entry
ALTER_TRANS DWHITCOM BEGIN 8 END BEGIN END
  BEGIN ~JOURNAL~ ~#34499~ END

// yxunomei adds journal entry before you ask the question
ALTER_TRANS dyxun BEGIN 0 END BEGIN 4 END BEGIN ~JOURNAL~ ~~ END // remove here
ALTER_TRANS dyxun BEGIN 7 END BEGIN END BEGIN ~JOURNAL~ ~#4358~ END // and add it back