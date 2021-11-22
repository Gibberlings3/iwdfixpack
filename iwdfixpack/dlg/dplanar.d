// totlm dialogue for contact other plane
APPEND DPLANAR

  IF WEIGHT #-1 ~GlobalGT("Master_Quest","GLOBAL",0) GlobalLT("Master_Quest","GLOBAL",8)~ THEN BEGIN cespy0 SAY @100
    IF ~~ THEN REPLY @101 GOTO cespy_where
    IF ~~ THEN REPLY @102 GOTO cespy_hobart
    IF ~~ THEN REPLY @103 GOTO cespy_lure
    IF ~~ THEN REPLY @104 GOTO cespy_return
    IF ~~ THEN REPLY @105 GOTO cespy_malu
    IF ~Global("Know_Vexing","GLOBAL",1)
        !Global("Know_Truename","GLOBAL",1)
        OR(2)
          PartyHasItem("vexed")
          PartyHasItem("vexed2")~ THEN DO ~SetGlobal("Know_Truename","GLOBAL",1)~ REPLY #25298 GOTO cespy_vex
    IF ~~ THEN REPLY #25129 GOTO cespy_bye
  END

  IF ~~ THEN BEGIN cespy_where SAY @106
    IF ~~ THEN DO ~StartCutScene("gnDstSlf")~ EXIT
  END

  IF ~~ THEN BEGIN cespy_hobart SAY @107
    IF ~~ THEN DO ~StartCutScene("gnDstSlf")~ EXIT
  END

  IF ~~ THEN BEGIN cespy_lure SAY @108
    IF ~~ THEN DO ~StartCutScene("gnDstSlf")~ EXIT
  END

  IF ~~ THEN BEGIN cespy_return SAY @109
    IF ~~ THEN DO ~StartCutScene("gnDstSlf")~ EXIT
  END

  IF ~~ THEN BEGIN cespy_malu SAY @110
    IF ~~ THEN DO ~StartCutScene("gnDstSlf")~ EXIT
  END

  IF ~~ THEN BEGIN cespy_vex SAY @111
    IF ~~ THEN DO ~StartCutScene("gnDstSlf")~ EXIT
  END

  IF ~~ THEN BEGIN cespy_bye SAY @112
    IF ~~ THEN DO ~StartCutScene("gnDstSlf")~ EXIT
  END

END