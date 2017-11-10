// syntax errors
REPLACE_ACTION_TEXT  ~dbandoth~ ~ForceAttack(protagonist, myself)~ ~~
REPLACE_ACTION_TEXT  ~dcusthan~ ~GiveItemCreatre(~ ~GiveItemCreate(~
REPLACE_TRIGGER_TEXT ~dcusthan~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_TRIGGER_TEXT ~ddenaini~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_TRIGGER_TEXT ~dfengla~  ~GlobaGT(~ ~GlobalGT(~
REPLACE_ACTION_TEXT  ~dferg~    ~IncrementGlobalOnce("\([^"]+\)", *"GLOBAL", *"\([^"]+\)", *"GLOBAL" *\(-?[0-9]+\))~
                                ~IncrementGlobalOnce("\1", "GLOBAL", "\2", "GLOBAL", \3)~
REPLACE_ACTION_TEXT  ~dgareth~  ~ForceAttack(protagonist, myself)~ ~~
REPLACE_ACTION_TEXT  ~dgina2~   ~TakeItem(~ ~TakePartyItem(~
REPLACE_TRIGGER_TEXT ~dgina2~   ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_ACTION_TEXT  ~dginafae~ ~TakeItem(~ ~TakePartyItem(~
REPLACE_TRIGGER_TEXT ~dginafae~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_TRIGGER_TEXT ~dgoblinc~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_ACTION_TEXT  ~dgorg~    ~ForceAttack(protagonist, myself)~ ~~
REPLACE_ACTION_TEXT  ~djoril~   ~F[ao]rceAttack(protagonist, myself)~ ~~
REPLACE_ACTION_TEXT  ~djorilbg~ ~ForceAttack(protagonist, myself)~ ~~
REPLACE_TRIGGER_TEXT ~dkayless~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_TRIGGER_TEXT ~dlehland~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_TRIGGER_TEXT ~dlethias~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_TRIGGER_TEXT ~dmarch~   ~Global("Marchon_Free",1)~ ~Global("Marchon_Free","GLOBAL",1)~
REPLACE_TRIGGER_TEXT ~dorrick~  ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_ACTION_TEXT  ~dtarnelm~ ~TakeItem(~ ~TakePartyItem(~
REPLACE_TRIGGER_TEXT ~dtealnis~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_TRIGGER_TEXT ~dvalesti~ ~NumTimesTalkedGT(~ ~NumTimesTalkedToGT(~
REPLACE_TRIGGER_TEXT ~dvalesti~ ~SetGlobal(~ ~Global(~

// fixes gaspar's non-sequitir (duplicated in how-fixes.d)
ALTER_TRANS DGASPAR BEGIN 15 END BEGIN 2 END // file, state, trans
  BEGIN EPILOGUE ~GOTO 5~ END // go to proper response

// one response in saablic checking for an item by an incorrect resref
REPLACE_TRIGGER_TEXT ~dsaablic~ ~PartyHasItem("Badge1")~ ~PartyHasItem("Krilag")~