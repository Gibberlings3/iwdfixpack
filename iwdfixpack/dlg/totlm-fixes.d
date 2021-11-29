// syntax errors
REPLACE_ACTION_TEXT  ~drikasha~ ~,"?GLOBAL"?,~ ~,"GLOBAL",~
REPLACE_TRIGGER_TEXT ~drikasha~ ~,"?GLOBAL"?,~ ~,"GLOBAL",~

// harpy matriarch unused state, hostility
ALTER_TRANS DHARPY BEGIN 0 END BEGIN 2 END BEGIN EPILOGUE ~GOTO 2~ "REPLY" ~#10717~ END // route to unused state
ALTER_TRANS DHARPY BEGIN 7 END BEGIN 2 END BEGIN EPILOGUE ~GOTO 1~ END // route to hostile state

// bard reply kills the convo
ALTER_TRANS DHOBART BEGIN 0 END BEGIN 4 END BEGIN "EPILOGUE" ~GOTO 5~ END

// extend class-specific replies to mutliclasses
ALTER_TRANS DHOBART BEGIN 28 END BEGIN 2 END BEGIN "TRIGGER" ~Alignment(Protagonist,MASK_EVIL) ClassEx(Protagonist,CLERIC)~ END // from cleric
ALTER_TRANS DHOBART BEGIN 28 END BEGIN 3 END BEGIN "TRIGGER" ~Alignment(Protagonist,MASK_EVIL) ClassEx(Protagonist,MAGE)~ END // from mage