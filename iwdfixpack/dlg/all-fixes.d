// simple syntax errors
REPLACE_TRIGGER_TEXT ~daccalia~ ~SetGlobal(~ ~Global(~
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
  
// Amelia's backward journal entries
ALTER_TRANS DAMELIA BEGIN 5 END BEGIN 0   END BEGIN ~JOURNAL~ ~#2057~ END // nice journal
ALTER_TRANS DAMELIA BEGIN 5 END BEGIN 1   END BEGIN ~JOURNAL~ ~#2073~ END // evil journal
ALTER_TRANS DAMELIA BEGIN 5 END BEGIN 2 3 END BEGIN ~JOURNAL~ ~~ END // remove from repeat

// goes to wrong state
ALTER_TRANS DAPSEL BEGIN 13 END BEGIN 0 END // filename, state, trans
  BEGIN EPILOGUE ~GOTO 4~ END

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

// prisoners not realizing they're free due to bad DV checks
REPLACE_TRIGGER_TEXT ~dcapkid2~ ~GlobalLT("Talonites_Dead","GLOBAL"~ ~GlobalLT("Talonite_Dead","GLOBAL"~
REPLACE_TRIGGER_TEXT ~dcapkid2~ ~Global("Talonites_Dead","GLOBAL",10)~ ~GlobalGT("Talonite_Dead","GLOBAL",9)~
REPLACE_TRIGGER_TEXT ~dcapvil2~ ~GlobalLT("Talonites_Dead","GLOBAL"~ ~GlobalLT("Talonite_Dead","GLOBAL"~
REPLACE_TRIGGER_TEXT ~dcapvil2~ ~Global("Talonites_Dead","GLOBAL",10)~ ~GlobalGT("Talonite_Dead","GLOBAL",9)~

// bad random spread could cause no valid links error
REPLACE_TRIGGER_TEXT ~dckquest~ ~RandomNum(5,0)~ ~RandomNum(5,5)~

// remove xp exploit
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

ADD_TRANS_ACTION DLARREL
BEGIN 46 END
BEGIN 4 END
~TakePartyItem("EvaJour")~

// marchon of waterdeep non-sequitir
ALTER_TRANS DMARCH BEGIN 9 END BEGIN END
  BEGIN ~EPILOGUE~ ~GOTO 5~ END

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

// perdiem should only go through his post-rescue spiel once
ADD_STATE_TRIGGER DPERDIEM 15 ~Global("Crazy_Speech","GLOBAL",0)~

// tarnelm looking for wrong item here
REPLACE_TRIGGER_TEXT ~dtarnelm~ ~!PartyHasItem("Food")~ ~!PartyHasItem("potatoes")~

// wrong journal entry
ALTER_TRANS DWHITCOM BEGIN 8 END BEGIN END
  BEGIN ~JOURNAL~ ~#34499~ END