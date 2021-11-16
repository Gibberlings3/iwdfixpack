// syntax errors
REPLACE_TRIGGER_TEXT ~dedion~   ~ClassEx(Protagonist,Priest)~ ~ClassEx(Protagonist,CLERIC)~
REPLACE_ACTION_TEXT  ~dwylf~    ~SetGlobal(Looked_Mirror","GLOBAL", 1)~ ~SetGlobal("Looked_Mirror","GLOBAL",1)~
// syntax error fixes for gog-only version
REPLACE_TRIGGER_TEXT ~dfengla~  ~GlobaGT("8002_Archers_Dead","GLOBAL",4)~ ~GlobalGT("8002_Archers_Dead","GLOBAL",4)~
REPLACE_TRIGGER_TEXT ~dkayless~ ~NumTimesTalkedGT(0)~ ~NumTimesTalkedToGT(0)~

// fix for ambere (plainab)
ADD_TRANS_TRIGGER ~dambere~ 11 ~Global("Screwed_Ambere", "GLOBAL", 0)~  DO 0

// shouldn't make 'not a fisherman' comment if edion never claimed to be a fisherman
ADD_TRANS_TRIGGER DEDION 3 ~Global("EdionFisherman","LOCALS",1)~ DO 1
ADD_TRANS_ACTION DEDION BEGIN 0 END BEGIN 1 3 END ~SetGlobal("EdionFisherman","LOCALS",1)~
ADD_TRANS_ACTION DEDION BEGIN 1 END BEGIN 0   END ~SetGlobal("EdionFisherman","LOCALS",1)~

// pair ar9200 reveal with ar9200_revealed variable 1/3; see also drawl.dlg and droald.dlg
ALTER_TRANS DEMMRCH BEGIN 18 END BEGIN 0 END BEGIN ACTION ~~ END // remove SetGlobal("AR9200_Visited","GLOBAL",1)
ADD_TRANS_ACTION DEMMRCH BEGIN 17 END BEGIN 0 END ~SetGlobal("ar9200_revealed","GLOBAL",1)~
ADD_TRANS_TRIGGER DEMMRCH 17 ~!Global("ar9200_revealed","GLOBAL",1) !Global("ar9200_visited","GLOBAL",1)~ DO 0
EXTEND_TOP DEMMRCH 17 #0
  IF ~OR(2)
        Global("ar9200_revealed","GLOBAL",1)
        Global("ar9200_visited","GLOBAL",1)~ THEN REPLY #25711 GOTO 18
END

// hjollder's broken transition
ALTER_TRANS DHJOLLDE BEGIN 65 END BEGIN 3 END // file, state, trans
  BEGIN EPILOGUE ~GOTO 68~ END // go to proper response

// checking for wrong item resref
REPLACE_TRIGGER_TEXT ~dicasa~   ~PartyHasItem("jhosiwd2")~ ~PartyHasItem("jhoswd2")~

// keep mebdinga alive until she speaks 2/2; see mebding.cre
ADD_TRANS_ACTION DMEBD BEGIN 0 END BEGIN END ~DestroyItem("MIN1HP")~

// loosen variables for murdaugh's quest
REPLACE_TRIGGER_TEXT ~dmurdaug~ ~Global("Know_Murdaugh", *"GLOBAL", *0)~ ~Global("Murdaugh_Quest","GLOBAL",0)~
  
REPLACE_STATE_TRIGGER dplanar 69 
~GlobalGT("Hjollder_Quest","GLOBAL",2)
!Global("Exp_Pause","GLOBAL",1)
!Global("HOW_COMPLETED","GLOBAL",1)~

// planar spirit should go away if no question
ADD_TRANS_ACTION DPLANAR BEGIN    45 END BEGIN  5 END ~StartCutScene("gnDstSlf")~
ADD_TRANS_ACTION DPLANAR BEGIN  0 51 END BEGIN  6 END ~StartCutScene("gnDstSlf")~
ADD_TRANS_ACTION DPLANAR BEGIN  8 69 END BEGIN  7 END ~StartCutScene("gnDstSlf")~
ADD_TRANS_ACTION DPLANAR BEGIN    16 END BEGIN  8 END ~StartCutScene("gnDstSlf")~
ADD_TRANS_ACTION DPLANAR BEGIN    57 END BEGIN  9 END ~StartCutScene("gnDstSlf")~
ADD_TRANS_ACTION DPLANAR BEGIN    26 END BEGIN 10 END ~StartCutScene("gnDstSlf")~

// contact other plane waits until after exposure to drop hints about albion
REPLACE_TRIGGER_TEXT ~dplanar~ ~GlobalGT("Yuanti_Inferno","GLOBAL",0)~ ~Global("Yuanti_Inferno","GLOBAL",0) Global("CDTalkedAlbion","GLOBAL",1)~
ADD_TRANS_ACTION DALBION BEGIN 0 END BEGIN END ~SetGlobal("CDTalkedAlbion","GLOBAL",1)~// pair ar9200 reveal with ar9200_revealed variable 2/3; see also demmrch.dlg and droald.dlg
ADD_TRANS_ACTION DRAWL BEGIN 4 9 END BEGIN 0 END ~RevealAreaOnMap("ar9200") SetGlobal("ar9200_revealed","GLOBAL",1) DeleteJournalEntry(26298)~
ADD_TRANS_ACTION DRAWL BEGIN 11 END BEGIN 1 END ~RevealAreaOnMap("ar9200") SetGlobal("ar9200_revealed","GLOBAL",1) DeleteJournalEntry(26298)~
ADD_TRANS_ACTION DRAWL BEGIN 1 END BEGIN 2 END ~SetGlobal("ar9200_revealed","GLOBAL",1) DeleteJournalEntry(26298)~
ADD_TRANS_ACTION DRAWL BEGIN 2 END BEGIN 0 END ~SetGlobal("ar9200_revealed","GLOBAL",1) DeleteJournalEntry(26298)~
ADD_TRANS_ACTION DRAWL BEGIN 8 END BEGIN 1 END ~SetGlobal("ar9200_revealed","GLOBAL",1) DeleteJournalEntry(26298)~
ALTER_TRANS DRAWL BEGIN 5 END BEGIN 0 END BEGIN ACTION ~~ END // remove RevealAreaOnMap("ar9200")
ADD_TRANS_TRIGGER DRAWL 1 ~!Global("ar9200_revealed","GLOBAL",1) !Global("ar9200_visited","GLOBAL",1)~ DO 2
ADD_TRANS_TRIGGER DRAWL 2 ~!Global("ar9200_revealed","GLOBAL",1) !Global("ar9200_visited","GLOBAL",1)~ 4 9 DO 0
ADD_TRANS_TRIGGER DRAWL 8 ~!Global("ar9200_revealed","GLOBAL",1) !Global("ar9200_visited","GLOBAL",1)~ 11 DO 1
EXTEND_TOP DRAWL 1 #2
  IF ~OR(2)
        Global("ar9200_revealed","GLOBAL",1)
        Global("ar9200_visited","GLOBAL",1)~ THEN REPLY #21662 GOTO 3
END
EXTEND_TOP DRAWL 2 #0
  IF ~OR(2)
        Global("ar9200_revealed","GLOBAL",1)
        Global("ar9200_visited","GLOBAL",1)~ THEN REPLY #21662 GOTO 3
END
EXTEND_TOP DRAWL 4 9 #0
  IF ~OR(2)
        Global("ar9200_revealed","GLOBAL",1)
        Global("ar9200_visited","GLOBAL",1)~ THEN REPLY #21662 GOTO 5
END
EXTEND_TOP DRAWL 8 11 #1
  IF ~OR(2)
        Global("ar9200_revealed","GLOBAL",1)
        Global("ar9200_visited","GLOBAL",1)~ THEN REPLY #21662 GOTO 3
END

// pair ar9200 reveal with ar9200_revealed variable 3/3; see also demmrch.dlg and drawl.dlg
ADD_TRANS_ACTION DROALD BEGIN 17 END BEGIN 1 END ~SetGlobal("ar9200_revealed","GLOBAL",1) AddJournalEntry(23560) DeleteJournalEntry(26298)~
ADD_TRANS_ACTION DROALD BEGIN 0 1 END BEGIN 1 END ~SetGlobal("ar9200_revealed","GLOBAL",1)~
ADD_TRANS_ACTION DROALD BEGIN 2 END BEGIN 0 END ~SetGlobal("ar9200_revealed","GLOBAL",1)~
ADD_TRANS_TRIGGER DROALD 0 ~!Global("ar9200_revealed","GLOBAL",1) !Global("ar9200_visited","GLOBAL",1)~ 1 17 DO 1
ADD_TRANS_TRIGGER DROALD 2 ~!Global("ar9200_revealed","GLOBAL",1) !Global("ar9200_visited","GLOBAL",1)~ DO 0
EXTEND_TOP DROALD 0 1 #1
  IF ~OR(2) 
        Global("ar9200_revealed","GLOBAL",1) 
        Global("ar9200_visited","GLOBAL",1)~ THEN REPLY #22909 GOTO 3
END
EXTEND_TOP DROALD 17 #1
  IF ~!Global("Roald_Story","GLOBAL",1)
      OR(2)
        Global("ar9200_revealed","GLOBAL",1)
        Global("ar9200_visited","GLOBAL",1)~ THEN REPLY #22909 GOTO 3
END
EXTEND_TOP DROALD 2 #0
  IF ~OR(2)
        Global("ar9200_revealed","GLOBAL",1)
        Global("ar9200_visited","GLOBAL",1)~ THEN REPLY #22909 GOTO 3
END
