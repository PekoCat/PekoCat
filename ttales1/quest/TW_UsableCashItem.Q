// $Id: TW_UsableItem.Q,v 1.94 2003/05/07 01:51:21 softmax Exp $

#Import quest/system.h
#Import quest/tales_system.h
#Import quest/tw_mssi.h
#Import quest/tw_util.h
#Import quest/TW_NPC_Talk.h
#Import quest/TW_UsableItem.h
#Import quest/TW_NPC_Clad.h
#Import quest/TW_ResetQuest_Last.h
#Import quest/TW_EP2_CHAP00_Log.h

//////////////////////////////////////////////////////////////////////////////////
//
// 캐릭터 염색약
//
//////////////////////////////////////////////////////////////////////////////////
function boolean
DyeUserColor(integer targetCharType, integer part, integer value)
{
	integer characterType;

	if (!NormalItemCanBeUsed()) return false;

	// check character type
	characterType = trigger.getCharacterType();

	if (characterType != targetCharType) {
		trigger.message(CANT_USE_OTHER_CHARACTER_ITEM, MSG_TYPE__SYSTEM);
		return false;
	}

	// set color
	trigger.setOrgColor(part, value);
	trigger.updateShape();

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
		Cash_Log();

	// send using effect
	controller.effectBy(trigger);

	return true;
}

// ***********************************************************************
// 루시안
// ***********************************************************************
quest
qUseItem1001255()				// 루시안 머리 염색약 0
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  0);
}

quest
qUseItem1001256()				// 루시안 머리 염색약 1
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  1);
}

quest
qUseItem1001257()				// 루시안 머리 염색약 2
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  2);
}

quest
qUseItem1001258()				// 루시안 머리 염색약 3
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  3);
}

quest
qUseItem1001259()				// 루시안 머리 염색약 4
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  4);
}

quest
qUseItem1001260()				// 루시안 머리 염색약 5
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  5);
}

quest
qUseItem1001261()				// 루시안 머리 염색약 6
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  6);
}

quest
qUseItem1001262()				// 루시안 머리 염색약 7
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  7);
}

quest
qUseItem1001263()				// 루시안 머리 염색약 8
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  8);
}



quest
qUseItem1001264()				// 루시안 몸통 염색약 0
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  0);
}

quest
qUseItem1001265()				// 루시안 몸통 염색약 1
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  1);
}

quest
qUseItem1001266()				// 루시안 몸통 염색약 2
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  2);
}

quest
qUseItem1001267()				// 루시안 몸통 염색약 3
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  3);
}

quest
qUseItem1001268()				// 루시안 몸통 염색약 4
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  4);
}

quest
qUseItem1001269()				// 루시안 몸통 염색약 5
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  5);
}

quest
qUseItem1001270()				// 루시안 몸통 염색약 6
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  6);
}

quest
qUseItem1001271()				// 루시안 몸통 염색약 7
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  7);
}

quest
qUseItem1001272()				// 루시안 몸통 염색약 8
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  8);
}



quest
qUseItem1001273()				// 루시안 액세서리1 염색약 0
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  0);
}

quest
qUseItem1001274()				// 루시안 액세서리1 염색약 1
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  1);
}

quest
qUseItem1001275()				// 루시안 액세서리1 염색약 2
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  2);
}

quest
qUseItem1001276()				// 루시안 액세서리1 염색약 3
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  3);
}

quest
qUseItem1001277()				// 루시안 액세서리1 염색약 4
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  4);
}

quest
qUseItem1001278()				// 루시안 액세서리1 염색약 5
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  5);
}

quest
qUseItem1001279()				// 루시안 액세서리1 염색약 6
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  6);
}

quest
qUseItem1001280()				// 루시안 액세서리1 염색약 7
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  7);
}

quest
qUseItem1001281()				// 루시안 액세서리1 염색약 8
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  8);
}



quest
qUseItem1001282()				// 루시안 액세서리3 염색약 0
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  0);
}

quest
qUseItem1001283()				// 루시안 액세서리3 염색약 1
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  1);
}

quest
qUseItem1001284()				// 루시안 액세서리3 염색약 2
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  2);
}

quest
qUseItem1001285()				// 루시안 액세서리3 염색약 3
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  3);
}

quest
qUseItem1001286()				// 루시안 액세서리3 염색약 4
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  4);
}

quest
qUseItem1001287()				// 루시안 액세서리3 염색약 5
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  5);
}

quest
qUseItem1001288()				// 루시안 액세서리3 염색약 6
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  6);
}

quest
qUseItem1001289()				// 루시안 액세서리3 염색약 7
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  7);
}

quest
qUseItem1001290()				// 루시안 액세서리3 염색약 8
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  8);
}



quest
qUseItem1001291()				// 루시안 액세서리2 염색약 0
{
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY2,  0);
}



quest
qUseItem1001292()				// 고렙 루시안 전용 머리 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  9);
}

quest
qUseItem1001293()				// 고렙 루시안 전용 머리 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  10);
}

quest
qUseItem1001294()				// 고렙 루시안 전용 몸통 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  9);
}

quest
qUseItem1001295()				// 고렙 루시안 전용 몸통 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  10);
}

quest
qUseItem1001296()				// 고렙 루시안 전용 악세서리1 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  9);
}

quest
qUseItem1001297()				// 고렙 루시안 전용 악세서리1 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  10);
}

quest
qUseItem1001298()				// 고렙 루시안 전용 악세서리3 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  9);
}

quest
qUseItem1001299()				// 고렙 루시안 전용 악세서리3 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  10);
}

// ***********************************************************************
// 보리스
// ***********************************************************************
quest
qUseItem1001301()				// 보리스 머리 염색약 0
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  0);
}

quest
qUseItem1001302()				// 보리스 머리 염색약 1
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  1);
}

quest
qUseItem1001303()				// 보리스 머리 염색약 2
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  2);
}

quest
qUseItem1001304()				// 보리스 머리 염색약 3
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  3);
}

quest
qUseItem1001305()				// 보리스 머리 염색약 4
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  4);
}

quest
qUseItem1001306()				// 보리스 머리 염색약 5
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  5);
}

quest
qUseItem1001307()				// 보리스 머리 염색약 6
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  6);
}

quest
qUseItem1001308()				// 보리스 머리 염색약 7
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  7);
}

quest
qUseItem1001309()				// 보리스 머리 염색약 8
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  8);
}



quest
qUseItem1001310()				// 보리스 몸통 염색약 0
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  0);
}

quest
qUseItem1001311()				// 보리스 몸통 염색약 1
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  1);
}

quest
qUseItem1001312()				// 보리스 몸통 염색약 2
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  2);
}

quest
qUseItem1001313()				// 보리스 몸통 염색약 3
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  3);
}

quest
qUseItem1001314()				// 보리스 몸통 염색약 4
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  4);
}

quest
qUseItem1001315()				// 보리스 몸통 염색약 5
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  5);
}

quest
qUseItem1001316()				// 보리스 몸통 염색약 6
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  6);
}

quest
qUseItem1001317()				// 보리스 몸통 염색약 7
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  7);
}

quest
qUseItem1001318()				// 보리스 몸통 염색약 8
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  8);
}



quest
qUseItem1001319()				// 보리스 액세서리1 염색약 0
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  0);
}

quest
qUseItem1001320()				// 보리스 액세서리1 염색약 1
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  1);
}

quest
qUseItem1001321()				// 보리스 액세서리1 염색약 2
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  2);
}

quest
qUseItem1001322()				// 보리스 액세서리1 염색약 3
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  3);
}

quest
qUseItem1001323()				// 보리스 액세서리1 염색약 4
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  4);
}

quest
qUseItem1001324()				// 보리스 액세서리1 염색약 5
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  5);
}

quest
qUseItem1001325()				// 보리스 액세서리1 염색약 6
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  6);
}

quest
qUseItem1001326()				// 보리스 액세서리1 염색약 7
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  7);
}

quest
qUseItem1001327()				// 보리스 액세서리1 염색약 8
{
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  8);
}



quest
qUseItem1001329()				// 고렙 보리스 전용 머리 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  9);
}

quest
qUseItem1001330()				// 고렙 보리스 전용 머리 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  10);
}

quest
qUseItem1001331()				// 고렙 보리스 전용 몸통 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  9);
}

quest
qUseItem1001332()				// 고렙 보리스 전용 몸통 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  10);
}

quest
qUseItem1001333()				// 고렙 보리스 전용 액세서리1 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  9);
}

quest
qUseItem1001334()				// 고렙 보리스 전용 액세서리1 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  10);
}

// ***********************************************************************
// 막시민
// ***********************************************************************
quest
qUseItem1001338()				// 막시민 머리 염색약 0
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  0);
}

quest
qUseItem1001339()				// 막시민 머리 염색약 1
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  1);
}

quest
qUseItem1001340()				// 막시민 머리 염색약 2
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  2);
}

quest
qUseItem1001341()				// 막시민 머리 염색약 3
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  3);
}

quest
qUseItem1001342()				// 막시민 머리 염색약 4
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  4);
}

quest
qUseItem1001343()				// 막시민 머리 염색약 5
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  5);
}

quest
qUseItem1001344()				// 막시민 머리 염색약 6
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  6);
}

quest
qUseItem1001345()				// 막시민 머리 염색약 7
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  7);
}

quest
qUseItem1001346()				// 막시민 머리 염색약 8
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  8);
}



quest
qUseItem1001347()				// 막시민 몸통 염색약 0
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  0);
}

quest
qUseItem1001348()				// 막시민 몸통 염색약 1
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  1);
}

quest
qUseItem1001349()				// 막시민 몸통 염색약 2
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  2);
}

quest
qUseItem1001350()				// 막시민 몸통 염색약 3
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  3);
}

quest
qUseItem1001351()				// 막시민 몸통 염색약 4
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  4);
}

quest
qUseItem1001352()				// 막시민 몸통 염색약 5
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  5);
}

quest
qUseItem1001353()				// 막시민 몸통 염색약 6
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  6);
}

quest
qUseItem1001354()				// 막시민 몸통 염색약 7
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  7);
}

quest
qUseItem1001355()				// 막시민 몸통 염색약 8
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  8);
}



quest
qUseItem1001356()				// 막시민 액세서리1 염색약 0
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  0);
}

quest
qUseItem1001357()				// 막시민 액세서리1 염색약 1
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  1);
}

quest
qUseItem1001358()				// 막시민 액세서리1 염색약 2
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  2);
}

quest
qUseItem1001359()				// 막시민 액세서리1 염색약 3
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  3);
}

quest
qUseItem1001360()				// 막시민 액세서리1 염색약 4
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  4);
}

quest
qUseItem1001361()				// 막시민 액세서리1 염색약 5
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  5);
}

quest
qUseItem1001362()				// 막시민 액세서리1 염색약 6
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  6);
}

quest
qUseItem1001363()				// 막시민 액세서리1 염색약 7
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  7);
}

quest
qUseItem1001364()				// 막시민 액세서리1 염색약 8
{
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  8);
}



quest
qUseItem1001366()				// 고렙 막시민 전용 머리 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  9);
}

quest
qUseItem1001367()				// 고렙 막시민 전용 머리 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  10);
}

quest
qUseItem1001368()				// 고렙 막시민 전용 몸통 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  9);
}

quest
qUseItem1001369()				// 고렙 막시민 전용 몸통 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  10);
}

quest
qUseItem1001370()				// 고렙 막시민 전용 액세서리1 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  9);
}

quest
qUseItem1001371()				// 고렙 막시민 전용 액세서리1 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  10);
}

// ***********************************************************************
// 티치엘
// ***********************************************************************
quest
qUseItem1001384()				// 티치엘 머리 염색약 0
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  0);
}

quest
qUseItem1001385()				// 티치엘 머리 염색약 1
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  1);
}

quest
qUseItem1001386()				// 티치엘 머리 염색약 2
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  2);
}

quest
qUseItem1001387()				// 티치엘 머리 염색약 3
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  3);
}

quest
qUseItem1001388()				// 티치엘 머리 염색약 4
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  4);
}

quest
qUseItem1001389()				// 티치엘 머리 염색약 5
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  5);
}

quest
qUseItem1001390()				// 티치엘 머리 염색약 6
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  6);
}

quest
qUseItem1001391()				// 티치엘 머리 염색약 7
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  7);
}

quest
qUseItem1001392()				// 티치엘 머리 염색약 8
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  8);
}



quest
qUseItem1001393()				// 티치엘 몸통 염색약 0
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  0);
}

quest
qUseItem1001394()				// 티치엘 몸통 염색약 1
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  1);
}

quest
qUseItem1001395()				// 티치엘 몸통 염색약 2
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  2);
}

quest
qUseItem1001396()				// 티치엘 몸통 염색약 3
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  3);
}

quest
qUseItem1001397()				// 티치엘 몸통 염색약 4
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  4);
}

quest
qUseItem1001398()				// 티치엘 몸통 염색약 5
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  5);
}

quest
qUseItem1001399()				// 티치엘 몸통 염색약 6
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  6);
}

quest
qUseItem1001400()				// 티치엘 몸통 염색약 7
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  7);
}

quest
qUseItem1001401()				// 티치엘 몸통 염색약 8
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  8);
}



quest
qUseItem1001402()				// 티치엘 액세서리1 염색약 0
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  0);
}

quest
qUseItem1001403()				// 티치엘 액세서리1 염색약 1
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  1);
}

quest
qUseItem1001404()				// 티치엘 액세서리1 염색약 2
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  2);
}

quest
qUseItem1001405()				// 티치엘 액세서리1 염색약 3
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  3);
}

quest
qUseItem1001406()				// 티치엘 액세서리1 염색약 4
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  4);
}

quest
qUseItem1001407()				// 티치엘 액세서리1 염색약 5
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  5);
}

quest
qUseItem1001408()				// 티치엘 액세서리1 염색약 6
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  6);
}

quest
qUseItem1001409()				// 티치엘 액세서리1 염색약 7
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  7);
}

quest
qUseItem1001410()				// 티치엘 액세서리1 염색약 8
{
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  8);
}



quest
qUseItem1001552()				// 고렙 티치엘 전용 머리 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  9);
}

quest
qUseItem1001553()				// 고렙 티치엘 전용 머리 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  10);
}

quest
qUseItem1001554()				// 고렙 티치엘 전용 몸통 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  9);
}

quest
qUseItem1001555()				// 고렙 티치엘 전용 몸통 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  10);
}

quest
qUseItem1001556()				// 고렙 티치엘 전용 액세서리1 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  9);
}

quest
qUseItem1001557()				// 고렙 티치엘 전용 액세서리1 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  10);
}

// ***********************************************************************
// 이스핀
// ***********************************************************************
quest
qUseItem1001412()				// 이스핀 머리 염색약 0
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  0);
}

quest
qUseItem1001413()				// 이스핀 머리 염색약 1
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  1);
}

quest
qUseItem1001414()				// 이스핀 머리 염색약 2
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  2);
}

quest
qUseItem1001415()				// 이스핀 머리 염색약 3
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  3);
}

quest
qUseItem1001416()				// 이스핀 머리 염색약 4
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  4);
}

quest
qUseItem1001417()				// 이스핀 머리 염색약 5
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  5);
}

quest
qUseItem1001418()				// 이스핀 머리 염색약 6
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  6);
}

quest
qUseItem1001419()				// 이스핀 머리 염색약 7
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  7);
}

quest
qUseItem1001420()				// 이스핀 머리 염색약 8
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  8);
}



quest
qUseItem1001421()				// 이스핀 몸통 염색약 0
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  0);
}

quest
qUseItem1001422()				// 이스핀 몸통 염색약 1
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  1);
}

quest
qUseItem1001423()				// 이스핀 몸통 염색약 2
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  2);
}

quest
qUseItem1001424()				// 이스핀 몸통 염색약 3
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  3);
}

quest
qUseItem1001425()				// 이스핀 몸통 염색약 4
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  4);
}

quest
qUseItem1001426()				// 이스핀 몸통 염색약 5
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  5);
}

quest
qUseItem1001427()				// 이스핀 몸통 염색약 6
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  6);
}

quest
qUseItem1001428()				// 이스핀 몸통 염색약 7
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  7);
}

quest
qUseItem1001429()				// 이스핀 몸통 염색약 8
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  8);
}



quest
qUseItem1001430()				// 이스핀 액세서리1 염색약 0
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  0);
}

quest
qUseItem1001431()				// 이스핀 액세서리1 염색약 1
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  1);
}

quest
qUseItem1001432()				// 이스핀 액세서리1 염색약 2
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  2);
}

quest
qUseItem1001433()				// 이스핀 액세서리1 염색약 3
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  3);
}

quest
qUseItem1001434()				// 이스핀 액세서리1 염색약 4
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  4);
}

quest
qUseItem1001435()				// 이스핀 액세서리1 염색약 5
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  5);
}

quest
qUseItem1001436()				// 이스핀 액세서리1 염색약 6
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  6);
}

quest
qUseItem1001437()				// 이스핀 액세서리1 염색약 7
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  7);
}

quest
qUseItem1001438()				// 이스핀 액세서리1 염색약 8
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  8);
}



quest
qUseItem1001439()				// 이스핀 액세서리2 염색약 0
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  0);
}

quest
qUseItem1001440()				// 이스핀 액세서리2 염색약 1
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  1);
}

quest
qUseItem1001441()				// 이스핀 액세서리2 염색약 2
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  2);
}

quest
qUseItem1001442()				// 이스핀 액세서리2 염색약 3
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  3);
}

quest
qUseItem1001443()				// 이스핀 액세서리2 염색약 4
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  4);
}

quest
qUseItem1001444()				// 이스핀 액세서리2 염색약 5
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  5);
}

quest
qUseItem1001445()				// 이스핀 액세서리2 염색약 6
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  6);
}

quest
qUseItem1001446()				// 이스핀 액세서리2 염색약 7
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  7);
}

quest
qUseItem1001447()				// 이스핀 액세서리2 염색약 8
{
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  8);
}



quest
qUseItem1001559()				// 고렙 이스핀 전용 머리 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  9);
}

quest
qUseItem1001560()				// 고렙 이스핀 전용 머리 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  10);
}

quest
qUseItem1001561()				// 고렙 이스핀 전용 몸통 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  9);
}

quest
qUseItem1001562()				// 고렙 이스핀 전용 몸통 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  10);
}

quest
qUseItem1001563()				// 고렙 이스핀 전용 액세서리1 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  9);
}

quest
qUseItem1001564()				// 고렙 이스핀 전용 액세서리1 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  10);
}

quest
qUseItem1001565()				// 고렙 이스핀 전용 액세서리2 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  9);
}

quest
qUseItem1001566()				// 고렙 이스핀 전용 액세서리2 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  10);
}

// ***********************************************************************
// 나야트레이
// ***********************************************************************
quest
qUseItem1001449()				// 나야트레이 머리 염색약 0
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  0);
}

quest
qUseItem1001450()				// 나야트레이 머리 염색약 1
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  1);
}

quest
qUseItem1001451()				// 나야트레이 머리 염색약 2
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  2);
}

quest
qUseItem1001452()				// 나야트레이 머리 염색약 3
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  3);
}

quest
qUseItem1001453()				// 나야트레이 머리 염색약 4
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  4);
}

quest
qUseItem1001454()				// 나야트레이 머리 염색약 5
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  5);
}

quest
qUseItem1001455()				// 나야트레이 머리 염색약 6
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  6);
}

quest
qUseItem1001456()				// 나야트레이 머리 염색약 7
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  7);
}

quest
qUseItem1001457()				// 나야트레이 머리 염색약 8
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  8);
}



quest
qUseItem1001458()				// 나야트레이 몸통 염색약 0
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  0);
}

quest
qUseItem1001459()				// 나야트레이 몸통 염색약 1
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  1);
}

quest
qUseItem1001460()				// 나야트레이 몸통 염색약 2
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  2);
}

quest
qUseItem1001461()				// 나야트레이 몸통 염색약 3
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  3);
}

quest
qUseItem1001462()				// 나야트레이 몸통 염색약 4
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  4);
}

quest
qUseItem1001463()				// 나야트레이 몸통 염색약 5
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  5);
}

quest
qUseItem1001464()				// 나야트레이 몸통 염색약 6
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  6);
}

quest
qUseItem1001465()				// 나야트레이 몸통 염색약 7
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  7);
}

quest
qUseItem1001466()				// 나야트레이 몸통 염색약 8
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  8);
}



quest
qUseItem1001467()				// 나야트레이 액세서리1 염색약 0
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  0);
}

quest
qUseItem1001468()				// 나야트레이 액세서리1 염색약 1
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  1);
}

quest
qUseItem1001469()				// 나야트레이 액세서리1 염색약 2
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  2);
}

quest
qUseItem1001470()				// 나야트레이 액세서리1 염색약 3
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  3);
}

quest
qUseItem1001471()				// 나야트레이 액세서리1 염색약 4
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  4);
}

quest
qUseItem1001472()				// 나야트레이 액세서리1 염색약 5
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  5);
}

quest
qUseItem1001473()				// 나야트레이 액세서리1 염색약 6
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  6);
}

quest
qUseItem1001474()				// 나야트레이 액세서리1 염색약 7
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  7);
}

quest
qUseItem1001475()				// 나야트레이 액세서리1 염색약 8
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  8);
}



quest
qUseItem1001476()				// 나야트레이 액세서리2 염색약 0
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  0);
}

quest
qUseItem1001477()				// 나야트레이 액세서리2 염색약 1
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  1);
}

quest
qUseItem1001478()				// 나야트레이 액세서리2 염색약 2
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  2);
}

quest
qUseItem1001479()				// 나야트레이 액세서리2 염색약 3
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  3);
}

quest
qUseItem1001480()				// 나야트레이 액세서리2 염색약 4
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  4);
}

quest
qUseItem1001481()				// 나야트레이 액세서리2 염색약 5
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  5);
}

quest
qUseItem1001482()				// 나야트레이 액세서리2 염색약 6
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  6);
}

quest
qUseItem1001483()				// 나야트레이 액세서리2 염색약 7
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  7);
}

quest
qUseItem1001484()				// 나야트레이 액세서리2 염색약 8
{
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  8);
}



quest
qUseItem1001568()				// 고렙 나야트레이 전용 머리 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  9);
}

quest
qUseItem1001569()				// 고렙 나야트레이 전용 머리 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  10);
}

quest
qUseItem1001570()				// 고렙 나야트레이 전용 몸통 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  9);
}

quest
qUseItem1001571()				// 고렙 나야트레이 전용 몸통 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  10);
}

quest
qUseItem1001572()				// 고렙 나야트레이 전용 액세서리1 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  9);
}

quest
qUseItem1001573()				// 고렙 나야트레이 전용 액세서리1 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  10);
}

quest
qUseItem1001574()				// 고렙 나야트레이 전용 액세서리2 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  9);
}

quest
qUseItem1001575()				// 고렙 나야트레이 전용 액세서리2 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  10);
}

// ***********************************************************************
// 시벨린
// ***********************************************************************
quest
qUseItem1001486()				// 시벨린 머리 염색약 0
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  0);
}

quest
qUseItem1001487()				// 시벨린 머리 염색약 1
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  1);
}

quest
qUseItem1001488()				// 시벨린 머리 염색약 2
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  2);
}

quest
qUseItem1001489()				// 시벨린 머리 염색약 3
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  3);
}

quest
qUseItem1001490()				// 시벨린 머리 염색약 4
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  4);
}

quest
qUseItem1001491()				// 시벨린 머리 염색약 5
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  5);
}

quest
qUseItem1001492()				// 시벨린 머리 염색약 6
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  6);
}

quest
qUseItem1001493()				// 시벨린 머리 염색약 7
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  7);
}

quest
qUseItem1001494()				// 시벨린 머리 염색약 8
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  8);
}



quest
qUseItem1001495()				// 시벨린 몸통 염색약 0
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  0);
}

quest
qUseItem1001496()				// 시벨린 몸통 염색약 1
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  1);
}

quest
qUseItem1001497()				// 시벨린 몸통 염색약 2
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  2);
}

quest
qUseItem1001498()				// 시벨린 몸통 염색약 3
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  3);
}

quest
qUseItem1001499()				// 시벨린 몸통 염색약 4
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  4);
}

quest
qUseItem1001500()				// 시벨린 몸통 염색약 5
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  5);
}

quest
qUseItem1001501()				// 시벨린 몸통 염색약 6
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  6);
}

quest
qUseItem1001502()				// 시벨린 몸통 염색약 7
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  7);
}

quest
qUseItem1001503()				// 시벨린 몸통 염색약 8
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  8);
}



quest
qUseItem1001504()				// 시벨린 액세서리1 염색약 0
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  0);
}

quest
qUseItem1001505()				// 시벨린 액세서리1 염색약 1
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  1);
}

quest
qUseItem1001506()				// 시벨린 액세서리1 염색약 2
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  2);
}

quest
qUseItem1001507()				// 시벨린 액세서리1 염색약 3
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  3);
}

quest
qUseItem1001508()				// 시벨린 액세서리1 염색약 4
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  4);
}

quest
qUseItem1001509()				// 시벨린 액세서리1 염색약 5
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  5);
}

quest
qUseItem1001510()				// 시벨린 액세서리1 염색약 6
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  6);
}

quest
qUseItem1001511()				// 시벨린 액세서리1 염색약 7
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  7);
}

quest
qUseItem1001512()				// 시벨린 액세서리1 염색약 8
{
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  8);
}



quest
qUseItem1001577()				// 고렙 시벨린 전용 머리 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  9);
}

quest
qUseItem1001578()				// 고렙 시벨린 전용 머리 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  10);
}

quest
qUseItem1001579()				// 고렙 시벨린 전용 몸통 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  9);
}

quest
qUseItem1001580()				// 고렙 시벨린 전용 몸통 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  10);
}

quest
qUseItem1001581()				// 고렙 시벨린 전용 액세서리1 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  9);
}

quest
qUseItem1001582()				// 고렙 시벨린 전용 액세서리1 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  10);
}

// ***********************************************************************
// 밀라
// ***********************************************************************
quest
qUseItem1001514()				// 밀라 머리 염색약 0
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  0);
}

quest
qUseItem1001515()				// 밀라 머리 염색약 1
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  1);
}

quest
qUseItem1001516()				// 밀라 머리 염색약 2
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  2);
}

quest
qUseItem1001517()				// 밀라 머리 염색약 3
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  3);
}

quest
qUseItem1001518()				// 밀라 머리 염색약 4
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  4);
}

quest
qUseItem1001519()				// 밀라 머리 염색약 5
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  5);
}

quest
qUseItem1001520()				// 밀라 머리 염색약 6
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  6);
}

quest
qUseItem1001521()				// 밀라 머리 염색약 7
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  7);
}

quest
qUseItem1001522()				// 밀라 머리 염색약 8
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  8);
}



quest
qUseItem1001523()				// 밀라 몸통 염색약 0
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  0);
}

quest
qUseItem1001524()				// 밀라 몸통 염색약 1
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  1);
}

quest
qUseItem1001525()				// 밀라 몸통 염색약 2
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  2);
}

quest
qUseItem1001526()				// 밀라 몸통 염색약 3
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  3);
}

quest
qUseItem1001527()				// 밀라 몸통 염색약 4
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  4);
}

quest
qUseItem1001528()				// 밀라 몸통 염색약 5
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  5);
}

quest
qUseItem1001529()				// 밀라 몸통 염색약 6
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  6);
}

quest
qUseItem1001530()				// 밀라 몸통 염색약 7
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  7);
}

quest
qUseItem1001531()				// 밀라 몸통 염색약 8
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  8);
}



quest
qUseItem1001532()				// 밀라 액세서리1 염색약 0
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  0);
}

quest
qUseItem1001533()				// 밀라 액세서리1 염색약 1
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  1);
}

quest
qUseItem1001534()				// 밀라 액세서리1 염색약 2
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  2);
}

quest
qUseItem1001535()				// 밀라 액세서리1 염색약 3
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  3);
}

quest
qUseItem1001536()				// 밀라 액세서리1 염색약 4
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  4);
}

quest
qUseItem1001537()				// 밀라 액세서리1 염색약 5
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  5);
}

quest
qUseItem1001538()				// 밀라 액세서리1 염색약 6
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  6);
}

quest
qUseItem1001539()				// 밀라 액세서리1 염색약 7
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  7);
}

quest
qUseItem1001540()				// 밀라 액세서리1 염색약 8
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  8);
}



quest
qUseItem1001541()				// 밀라 액세서리2 염색약 0
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  0);
}

quest
qUseItem1001542()				// 밀라 액세서리2 염색약 1
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  1);
}

quest
qUseItem1001543()				// 밀라 액세서리2 염색약 2
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  2);
}

quest
qUseItem1001544()				// 밀라 액세서리2 염색약 3
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  3);
}

quest
qUseItem1001545()				// 밀라 액세서리2 염색약 4
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  4);
}

quest
qUseItem1001546()				// 밀라 액세서리2 염색약 5
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  5);
}

quest
qUseItem1001547()				// 밀라 액세서리2 염색약 6
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  6);
}

quest
qUseItem1001548()				// 밀라 액세서리2 염색약 7
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  7);
}

quest
qUseItem1001549()				// 밀라 액세서리2 염색약 8
{
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  8);
}



quest
qUseItem1001584()				// 고렙 밀라 전용 머리 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  9);
}

quest
qUseItem1001585()				// 고렙 밀라 전용 머리 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  10);
}

quest
qUseItem1001586()				// 고렙 밀라 전용 몸통 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  9);
}

quest
qUseItem1001587()				// 고렙 밀라 전용 몸통 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  10);
}

quest
qUseItem1001588()				// 고렙 밀라 전용 액세서리1 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  9);
}

quest
qUseItem1001589()				// 고렙 밀라 전용 액세서리1 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  10);
}

quest
qUseItem1001590()				// 고렙 밀라 전용 액세서리2 염색약 9
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  9);
}

quest
qUseItem1001591()				// 고렙 밀라 전용 액세서리2 염색약 10
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  10);
}

// ***********************************************************************
// 조슈아 Written by Han 2006. 11. 29
// ***********************************************************************
quest
qUseItem1006610()				// 조슈아 머리 염색약 (기본색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  0);
}

quest
qUseItem1006611()				// 조슈아 머리 염색약 (1색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  1);
}

quest
qUseItem1006612()				// 조슈아 머리 염색약 (2색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  2);
}

quest
qUseItem1006613()				// 조슈아 머리 염색약 (3색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  3);
}

quest
qUseItem1006614()				// 조슈아 머리 염색약 (4색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  4);
}

quest
qUseItem1006615()				// 조슈아 머리 염색약 (5색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  5);
}

quest
qUseItem1006616()				// 조슈아 머리 염색약 (6색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  6);
}

quest
qUseItem1006617()				// 조슈아 머리 염색약 (7색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  7);
}

quest
qUseItem1006618()				// 조슈아 머리 염색약 (8색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  8);
}

quest
qUseItem1006619()				// 조슈아 자켓 염색약 (기본색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  0);
}

quest
qUseItem1006620()				// 조슈아 자켓 염색약 (1색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  1);
}

quest
qUseItem1006621()				// 조슈아 자켓 염색약 (2색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  2);
}

quest
qUseItem1006622()				// 조슈아 자켓 염색약 (3색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  3);
}

quest
qUseItem1006623()				// 조슈아 자켓 염색약 (4색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  4);
}

quest
qUseItem1006624()				// 조슈아 자켓 염색약 (5색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  5);
}

quest
qUseItem1006625()				// 조슈아 자켓 염색약 (6색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  6);
}

quest
qUseItem1006626()				// 조슈아 자켓 염색약 (7색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  7);
}

quest
qUseItem1006627()				// 조슈아 자켓 염색약 (8색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  8);
}

quest
qUseItem1006628()				// 조슈아 바지 염색약 (기본색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  0);
}

quest
qUseItem1006629()				// 조슈아 바지 염색약 (1색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  1);
}

quest
qUseItem1006630()				// 조슈아 바지 염색약 (2색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  2);
}

quest
qUseItem1006631()				// 조슈아 바지 염색약 (3색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  3);
}

quest
qUseItem1006632()				// 조슈아 바지 염색약 (4색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  4);
}

quest
qUseItem1006633()				// 조슈아 바지 염색약 (5색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  5);
}

quest
qUseItem1006634()				// 조슈아 바지 염색약 (6색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  6);
}

quest
qUseItem1006635()				// 조슈아 바지 염색약 (7색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  7);
}

quest
qUseItem1006636()				// 조슈아 바지 염색약 (8색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  8);
}


quest
qUseItem1006637()				// 조슈아 소매 염색약 (기본색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  0);
}

quest
qUseItem1006638()				// 조슈아 소매 염색약 (1색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  1);
}

quest
qUseItem1006639()				// 조슈아 소매 염색약 (2색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  2);
}

quest
qUseItem1006640()				// 조슈아 소매 염색약 (3색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  3);
}

quest
qUseItem1006641()				// 조슈아 소매 염색약 (4색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  4);
}

quest
qUseItem1006642()				// 조슈아 소매 염색약 (5색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  5);
}

quest
qUseItem1006643()				// 조슈아 소매 염색약 (6색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  6);
}

quest
qUseItem1006644()				// 조슈아 소매 염색약 (7색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  7);
}

quest
qUseItem1006645()				// 조슈아 소매 염색약 (8색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  8);
}


quest
qUseItem1006646()				// 조슈아 잡화 염색약 (기본색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  0);
}

quest
qUseItem1006647()				// 조슈아 잡화 염색약 (1색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  1);
}

quest
qUseItem1006648()				// 조슈아 잡화 염색약 (2색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  2);
}

quest
qUseItem1006649()				// 조슈아 잡화 염색약 (3색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  3);
}

quest
qUseItem1006650()				// 조슈아 잡화 염색약 (4색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  4);
}

quest
qUseItem1006651()				// 조슈아 잡화 염색약 (5색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  5);
}

quest
qUseItem1006652()				// 조슈아 잡화 염색약 (6색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  6);
}

quest
qUseItem1006653()				// 조슈아 잡화 염색약 (7색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  7);
}

quest
qUseItem1006654()				// 조슈아 잡화 염색약 (8색)
{
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  8);
}


quest
qUseItem1006777()				// 고렙 조슈아 전용 머리 염색약 1
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  9);
}

quest
qUseItem1006778()				// 고렙 조슈아 전용 머리 염색약 2
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_HAIR,  10);
}

quest
qUseItem1006779()				// 고렙 조슈아 전용 상의 염색약 1
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  9);
}

quest
qUseItem1006780()				// 고렙 조슈아 전용 상의 염색약 2
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_BODY,  10);
}

quest
qUseItem1006781()				// 고렙 조슈아 전용 바지 염색약 1
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  9);
}

quest
qUseItem1006782()				// 고렙 조슈아 전용 바지 염색약 2
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY1,  10);
}

quest
qUseItem1006783()				// 고렙 조슈아 전용 소매 염색약 1
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  9);
}

quest
qUseItem1006784()				// 고렙 조슈아 전용 소매 염색약 2
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY2,  10);
}

quest
qUseItem1006785()				// 고렙 조슈아 전용 잡화 염색약 1
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  9);
}

quest
qUseItem1006786()				// 고렙 조슈아 전용 잡화 염색약 2
{
	if (trigger.getLevel() < SPECIAL_DYE_LEVEL_LIMIT)
	{
		trigger.message(TEXT_CANT_DYE_BECAUSE_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
	DyeUserColor(CHAR_TYPE4, USER_COLOR_ACCESSORY3,  10);
}
// ********************** 유저 간판 염색약 by kimo **********************
// 기본
quest
qUseItem1001593()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 0) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(0);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 우드
quest
qUseItem1001594()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 6) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(6);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 엠보싱
quest
qUseItem1001595()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 7) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(7);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
    	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 메탈릭
quest
qUseItem1001596()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 5) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(5);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 크림엘로우
quest
qUseItem1001597()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 3) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(3);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 파스텔 블루
quest
qUseItem1001598()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 2) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(2);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 핑키 핑크
quest
qUseItem1001599()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 4) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(4);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 에메랄드
quest
qUseItem1001600()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 1) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(1);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);

}

// 크리스마스 트리
quest
qUseItem1001602()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 9) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(9);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);

}

// 악마
quest
qUseItem1001603()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 10) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(10);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 천사
quest
qUseItem1001604()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 11) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(11);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 뱅글뱅글
quest
qUseItem1004945()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 12) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(12);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 무지개 물방울
quest
qUseItem1004946()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 29) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(29);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 꿈나라 풍선
quest
qUseItem1004947()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 30) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(30);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 반짝별
quest
qUseItem1004948()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 31) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(31);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 얼룩말
quest
qUseItem1004949()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 20) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(20);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 젖소
quest
qUseItem1004950()
{
	if (!NormalItemCanBeUsed()) return;
	if (trigger.getSignColor() == 28) {
		trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.setSignColor(28);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 레인보우 얼룩말 (13~20)
quest
qUseItem1004951()
{
	integer chkColor;

	if (!NormalItemCanBeUsed()) return;

	if (controller.checkAttribute("RAIN1") == true)
	{
		chkColor = String.toInteger(controller.getAttribute("RAIN1"));

		if (chkColor == 20)
		{
			chkColor = 13;
			controller.setAttribute("RAIN1",Integer.toString(chkColor));
		}
		else
		{
			chkColor = chkColor + 1;
			controller.setAttribute("RAIN1",Integer.toString(chkColor));
		}
	}
	else
	{
		chkColor = 13;
		controller.setAttribute("RAIN1",Integer.toString(chkColor));
	}

	trigger.setSignColor(chkColor);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
/*
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
*/
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

// 레인보우 젖소 (21~28)
quest
qUseItem1004952()
{
	integer chkColor;

	if (!NormalItemCanBeUsed()) return;

	if (controller.checkAttribute("RAIN2") == true)
	{
		chkColor = String.toInteger(controller.getAttribute("RAIN2"));

		if (chkColor == 28)
		{
			chkColor = 21;
			controller.setAttribute("RAIN2",Integer.toString(chkColor));
		}
		else
		{
			chkColor = chkColor + 1;
			controller.setAttribute("RAIN2",Integer.toString(chkColor));
		}
	}
	else
	{
		chkColor = 21;
		controller.setAttribute("RAIN2",Integer.toString(chkColor));
	}

	trigger.setSignColor(chkColor);
	trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
/*
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
*/
	Cash_Log();
	//trigger.updateAttr();
	trigger.updateShape();
	controller.effectBy(trigger);
}

quest
qUseItem1006691()
{
	if (!NormalItemCanBeUsed()) return;
	    if (trigger.getSignColor() == 32) {
			trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
				return;
				    }
		trigger.setSignColor(32);
		    trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
			// decrease number
			if (controller.canBeExhausted()) {
				    controller.decreaseNumber(1);
					}
			    Cash_Log();
				//trigger.updateAttr();
				trigger.updateShape();
				    controller.effectBy(trigger);
}

quest
qUseItem1006690()
{
	if (!NormalItemCanBeUsed()) return;
	    if (trigger.getSignColor() == 33) {
			trigger.message(TEXT_CASHITEM_SIGN_NOT_USE, MSG_TYPE__SYSTEM);
				return;
				    }
		trigger.setSignColor(33);
		    trigger.message(TEXT_CASHITEM_SIGN_USE, MSG_TYPE__SYSTEM);
			// decrease number
			if (controller.canBeExhausted()) {
				    controller.decreaseNumber(1);
					}
			    Cash_Log();
				//trigger.updateAttr();
				trigger.updateShape();
				    controller.effectBy(trigger);
}

quest
qUseItem1003371()	// 대상인의 뿔피리
{
	integer mapChk = trigger.getWorld().getNumber();

	if (mapChk == 718 || mapChk == 719 || mapChk == 720 || mapChk == 721)
	{
		trigger.message(TEXT_CASH_NEW_CHAR_JOSUA2, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getWorld().canPK() || trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD , MSG_TYPE__SYSTEM);
		return;
	}

//	trigger.setState(USER_STATE__EVENT, true);
	trigger.setState(USER_STATE__NO_PORTAL, true);
	trigger.setState(CREATURE_STATE__NO_MOVE, true);

	if (!NormalItemCanBeUsed()) {
		ItemUseEnd();
		return;
	}

	controller.setLocked(true);
	if (!trigger.startTrade(true, 160)) {
		controller.setLocked(false);
		ItemUseEnd();
		return;
	}

	Event.waitFor(EVENT_USER_MERCHANT);
	controller.setLocked(false);

	if (!Event.result(EVENT_USER_MERCHANT)) {
		ItemUseEnd();
		return;
	}

	controller.effectBy(trigger);
	ItemUseEnd();
}

quest
qUseItem1002814()	// 워프등록기
{
	integer i;

	if (!NormalItemCanBeUsed()) return;

	for (i = 0; i < 19; ++i)
		trigger.setWarpPoint(1, i, true);

	trigger.message(TEXT_SET_WARPPOINT, MSG_TYPE__SYSTEM);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
}

///////////////////////////////////////////////////////////
//
// 펫 염색약 - 2004.6.15 xyzin
//
///////////////////////////////////////////////////////////
function integer
WhatKindDye(integer itemDBID)
{
	// enum
	integer Liblio		= 0;
	integer Inyuit		= 1;
	integer Cruno		= 2;
	integer Jester		= 3;
	integer Ako		= 4;
	integer Weimei		= 5;
	integer Kabungkle	= 6;
	integer Clara		= 7;
	integer Snowwig		= 8;

	integer error 		= 99;

	// 리브리오 윗날개 , 아랫날개 , 몸
	if(itemDBID >= 1003066 && itemDBID <= 1003089)
	{
		return Liblio;
	}

	// 리브리오 귓방망이 : 2005.1.26 버그신고되었음 : 누락인것을 확인하여 추가함
	if(itemDBID >= 1004351 && itemDBID <= 1004358)
	{
		return Liblio;
	}

	// 이뉴이트 눈, 몸
	if(itemDBID >= 1003090 && itemDBID <= 1003105)
	{
		return Inyuit;
	}

	// 크루노 날개, 눈, 몸.
	if(itemDBID >= 1003106 && itemDBID <= 1003129)
	{
		return Cruno;
	}

	// 제스터 구슬, 몸
	if(itemDBID >= 1003130 && itemDBID <= 1003145)
	{
		return Jester;
	}

	// 이뉴이트 2단계 : 갑주, 장식
	if(itemDBID >= 1003327 && itemDBID <= 1003342)
	{
		return Inyuit;
	}

	// 제스터 2단계 : 머리
	if(itemDBID >= 1003343 && itemDBID <= 1003350)
	{
		return Jester;
	}

	// 이뉴이트 3단계 : 모자
	if(itemDBID >= 1003462 && itemDBID <= 1003469)
	{
		return Inyuit;
	}

	// 크누로 3단계 : 바지, 악세서리
	if(itemDBID >= 1003470 && itemDBID <= 1003485)
	{
		return Cruno;
	}

	// 제스터 3단계 : 옷, 크라운
	if(itemDBID >= 1003486 && itemDBID <= 1003501)
	{
		return Jester;
	}

	// 이뉴이트 4단계 : 토시, 신발
	if(itemDBID >= 1003677 && itemDBID <= 1003692)
	{
		return Inyuit;
	}

	// 제스터 4단계 : 태엽, 눈
	if(itemDBID >= 1003693 && itemDBID <= 1003708)
	{
		return Jester;
	}

	// 아코 : 몸, 귀코발, 눈, 장식 , 구슬
	if(itemDBID >= 1003776 && itemDBID <= 1003815)
	{
		return Ako;
	}

	// 웨이메이씨방새 : 몸,대나무, 목도리, 모자
	if(itemDBID >= 1004221 && itemDBID <= 1004252)
	{
		return Weimei;
	}

	// 카벙클 : 몸, 눈, 보석, 의상, 스카프, 고글, 가방
	if(itemDBID >= 1004565 && itemDBID <= 1004613)
	{
		return Kabungkle;
	}

	// 클라라 : 원피스, 머리, 신발, 머리띠, 우산, 눈
	if(itemDBID >= 1006007 && itemDBID <= 1006054)
	{
		return Clara;
	}

	// 스노위그 : 눈, 모자, 몸, 부리/발, 알껍질/깃
	if(itemDBID >= 1006221 && itemDBID <= 1006260)
	{
		return Snowwig;
	}
	return error;
}

function integer
WhatKindPet(integer petDBID)
{
	// enum
	integer Liblio		= 0;
	integer Inyuit		= 1;
	integer Cruno		= 2;
	integer Jester		= 3;
	integer Ako		= 4;
	integer Weimei		= 5;
	integer Kabungkle	= 6;
	integer Clara		= 7;
	integer Snowwig		= 8;

	integer error 		= 99;

	if(petDBID >= 2100263 && petDBID <= 2100266)	// 리브리오
		return Liblio;

	if(petDBID >= 2100655 && petDBID <= 2100658)	// 뉴 리브리오
		return Liblio;

	if(petDBID >= 2100267 && petDBID <= 2100270)	// 이뉴이트
		return Inyuit;

	if(petDBID >= 2100659 && petDBID <= 2100662)	// 뉴 이뉴이트
		return Inyuit;

	if(petDBID >= 2100271 && petDBID <= 2100274)	// 크루노
		return Cruno;

	if(petDBID >= 2100663 && petDBID <= 2100666)	// 뉴 크루노
		return Cruno;

	if(petDBID >= 2100275 && petDBID <= 2100278)	// 제스터
		return Jester;

	if(petDBID >= 2100667 && petDBID <= 2100670)	// 뉴 제스터
		return Jester;

	if(petDBID >= 2100485 && petDBID <= 2100488)	// 아코
		return Ako;

	if(petDBID >= 2100671 && petDBID <= 2100674)	// 뉴 아코
		return Ako;

	if(petDBID >= 2100511 && petDBID <= 2100514)	// 웨이메이
		return Weimei;

	if(petDBID >= 2100675 && petDBID <= 2100678)	// 뉴 웨이메이
		return Weimei;

	if(petDBID >= 2100607 && petDBID <= 2100609)	// 카벙클
		return Kabungkle;

	if(petDBID == 2100610)				// 카벙클
		return Kabungkle;

	if(petDBID >= 2100679 && petDBID <= 2100681)	// 뉴 카벙클
		return Kabungkle;

	if(petDBID == 2100687)				// 뉴 카벙클
		return Kabungkle;

	if(petDBID >= 2100876 && petDBID <= 2100879)	// 뉴 클라라
		return Clara;

	if(petDBID >= 2100911 && petDBID <= 2100914)	// 뉴 스노위그
		return Snowwig;

	return error;
}

function boolean
IsSuitableDye(integer itemDBID, integer petDBID)	// 아이템DBID와 펫DBID를 받아와 일일이 static 대입
{
	// enum
	integer Liblio		= 0;
	integer Inyuit		= 1;
	integer Cruno		= 2;
	integer Jester		= 3;
	integer Ako		= 4;
	integer Weimei		= 5;
	integer Kabungkle	= 6;
	integer Clara		= 7;
	integer Snowwig		= 8;

	integer DyeType;
	integer PetType;

	DyeType = WhatKindDye(itemDBID);
	PetType = WhatKindPet(petDBID);

	if(DyeType == Liblio)
	{
		if(PetType == Liblio)
			return true;
	}
	if(DyeType == Inyuit)
	{
		if(PetType == Inyuit)
			return true;
	}
	if(DyeType == Cruno)
	{
		if(PetType == Cruno)
			return true;
	}
	if(DyeType == Jester)
	{
		if(PetType == Jester)
			return true;
	}
	if(DyeType == Ako)
	{
		if(PetType == Ako)
			return true;
	}
	if(DyeType == Weimei)
	{
		if(PetType == Weimei)
			return true;
	}
	if(DyeType == Kabungkle)
	{
		if(PetType == Kabungkle)
			return true;
	}
	if(DyeType == Clara)
	{
		if(PetType == Clara)
			return true;
	}
	if(DyeType == Snowwig)
	{
		if(PetType == Snowwig)
			return true;
	}

/*
	// 리브리오
	2100263
	2100266

	// 이뉴이트
	2100267
	2100270

	// 크루노
	2100271
	2100274

	// 제스터
	2100275
	2100278

	// 아코
	2100485
	2100488

	// 웨이메이
	2100511
	2100514

	// 카벙클
	2100607
	2100609
*/
	return false;
}

function boolean
DyePetColor(integer part, integer value)
{
	object	pet;
	integer	itemDBID;
	integer petDBID;

	if (!NormalItemCanBeUsed()) return false;
	if (!trigger.hasPet())	return false;

	pet = trigger.getPet();

	itemDBID = String.toInteger(controller.getClassName());
	petDBID = String.toInteger(pet.getName());

	// 이 펫에게 사용할수 있는 염색약인가
	if(!IsSuitableDye(itemDBID, petDBID))
		return true;

	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);

		// set color
		pet.setColor(part, value);
		Cash_Log();
	}

	return true;
}
//----------------------------------------------------------------
quest
qUseItem1003066()				// 리브리오 윗날개 염색약 - 기본색
{
	DyePetColor( 2,0 );
}

quest
qUseItem1003067()				// 리브리오 윗날개 염색약 - 하늘
{
	DyePetColor( 2,1 );
}

quest
qUseItem1003068()				// 리브리오 윗날개 염색약 - 붉은갈
{
	DyePetColor( 2,2 );
}

quest
qUseItem1003069()				// 리브리오 윗날개 염색약 - 분홍
{
	DyePetColor( 2,3 );
}

quest
qUseItem1003070()				// 리브리오 윗날개 염색약 - 검은
{
	DyePetColor( 2,4 );
}

quest
qUseItem1003071()				// 리브리오 윗날개 염색약 - 보라
{
	DyePetColor( 2,5 );
}

quest
qUseItem1003072()				// 리브리오 윗날개 염색약 - 녹색
{
	DyePetColor( 2,6 );
}

quest
qUseItem1003073()				// 리브리오 윗날개 염색약 - 밝은회색
{
	DyePetColor( 2,7 );
}
//----------------------------------------------------------------

quest
qUseItem1003074()				// 리브리오 아래날개 염색약 - 기본색
{
	DyePetColor( 3,0 );
}

quest
qUseItem1003075()				// 리브리오 아랫날개 염색약 - 회색
{
	DyePetColor( 3,1 );
}

quest
qUseItem1003076()				// 리브리오 아랫날개 염색약 -
{
	DyePetColor( 3,2 );
}

quest
qUseItem1003077()				// 리브리오 아랫날개 염색약 -
{
	DyePetColor( 3,3 );
}

quest
qUseItem1003078()				// 리브리오 아랫날개 염색약 -
{
	DyePetColor( 3,4 );
}

quest
qUseItem1003079()				// 리브리오 아랫날개 염색약 -
{
	DyePetColor( 3,5 );
}

quest
qUseItem1003080()				// 리브리오 아랫날개 염색약 -
{
	DyePetColor( 3,6 );
}

quest
qUseItem1003081()				// 리브리오 아랫날개 염색약 -
{
	DyePetColor( 3,7 );
}
//----------------------------------------------------------------

quest
qUseItem1003082()				// 리브리오 몸 염색약 -
{
	DyePetColor( 0,0 );
}

quest
qUseItem1003083()				// 리브리오 몸 염색약 -
{
	DyePetColor( 0,1 );
}

quest
qUseItem1003084()				// 리브리오 몸 염색약 -
{
	DyePetColor( 0,2 );
}

quest
qUseItem1003085()				// 리브리오 몸 염색약 -
{
	DyePetColor( 0,3 );
}

quest
qUseItem1003086()				// 리브리오 몸 염색약 -
{
	DyePetColor( 0,4 );
}

quest
qUseItem1003087()				// 리브리오 몸 염색약 -
{
	DyePetColor( 0,5 );
}

quest
qUseItem1003088()				// 리브리오 몸 염색약 -
{
	DyePetColor( 0,6 );
}

quest
qUseItem1003089()				// 리브리오 몸 염색약 -
{
	DyePetColor( 0,7 );
}
//----------------------------------------------------------------

quest
qUseItem1003335()				// 이뉴이트 장식 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 4,0 );
	}
}

quest
qUseItem1003336()				// 이뉴이트 장식 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 4,1 );
	}
}

quest
qUseItem1003337()				// 이뉴이트 장식 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 4,2 );
	}
}

quest
qUseItem1003338()				// 이뉴이트 장식 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 4,3 );
	}
}

quest
qUseItem1003339()				// 이뉴이트 장식 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 4,4 );
	}
}

quest
qUseItem1003340()				// 이뉴이트 장식 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 4,5 );
	}
}

quest
qUseItem1003341()				// 이뉴이트 장식 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 4,6 );
	}
}

quest
qUseItem1003342()				// 이뉴이트 장식 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 4,7 );
	}
}
//----------------------------------------------------------------

quest
qUseItem1003327()				// 이뉴이트 돌(갑주) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 3,0 );
	}
}

quest
qUseItem1003328()				// 이뉴이트 돌(갑주) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 3,1 );
	}
}

quest
qUseItem1003329()				// 이뉴이트 돌(갑주) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 3,2 );
	}
}

quest
qUseItem1003330()				// 이뉴이트 돌(갑주) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 3,3 );
	}
}

quest
qUseItem1003331()				// 이뉴이트 돌(갑주) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 3,4 );
	}
}

quest
qUseItem1003332()				// 이뉴이트 돌(갑주) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 3,5 );
	}
}

quest
qUseItem1003333()				// 이뉴이트 돌(갑주) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 3,6 );
	}
}

quest
qUseItem1003334()				// 이뉴이트 돌(갑주) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 3,7 );
	}
}
//----------------------------------------------------------------

quest
qUseItem1003090()				// 이뉴이트 눈 염색약 -
{
	DyePetColor( 1,0 );
}

quest
qUseItem1003091()				// 이뉴이트 눈 염색약 -
{
	DyePetColor( 1,1 );
}

quest
qUseItem1003092()				// 이뉴이트 눈 염색약 -
{
	DyePetColor( 1,2 );
}

quest
qUseItem1003093()				// 이뉴이트 눈 염색약 -
{
	DyePetColor( 1,3 );
}

quest
qUseItem1003094()				// 이뉴이트 눈 염색약 -
{
	DyePetColor( 1,4 );
}

quest
qUseItem1003095()				// 이뉴이트 눈 염색약 -
{
	DyePetColor( 1,5 );
}

quest
qUseItem1003096()				// 이뉴이트 눈 염색약 -
{
	DyePetColor( 1,6 );
}

quest
qUseItem1003097()				// 이뉴이트 눈 염색약 -
{
	DyePetColor( 1,7 );
}
//----------------------------------------------------------------

quest
qUseItem1003098()				// 이뉴이트 몸 염색약 -
{
	DyePetColor( 0,0 );
}

quest
qUseItem1003099()				// 이뉴이트 몸 염색약 -
{
	DyePetColor( 0,1 );
}

quest
qUseItem1003100()				// 이뉴이트 몸 염색약 -
{
	DyePetColor( 0,2 );
}

quest
qUseItem1003101()				// 이뉴이트 몸 염색약 -
{
	DyePetColor( 0,3 );
}

quest
qUseItem1003102()				// 이뉴이트 몸 염색약 -
{
	DyePetColor( 0,4 );
}

quest
qUseItem1003103()				// 이뉴이트 몸 염색약 -
{
	DyePetColor( 0,5 );
}

quest
qUseItem1003104()				// 이뉴이트 몸 염색약 -
{
	DyePetColor( 0,6 );
}

quest
qUseItem1003105()				// 이뉴이트 몸 염색약 -
{
	DyePetColor( 0,7 );
}
//----------------------------------------------------------------

quest
qUseItem1003106()				// 크루노 날개 염색약 -
{
	DyePetColor( 2,0 );
}

quest
qUseItem1003107()				// 크루노 날개 염색약 -
{
	DyePetColor( 2,1 );
}

quest
qUseItem1003108()				// 크루노 날개 염색약 -
{
	DyePetColor( 2,2 );
}

quest
qUseItem1003109()				// 크루노 날개 염색약 -
{
	DyePetColor( 2,3 );
}

quest
qUseItem1003110()				// 크루노 날개 염색약 -
{
	DyePetColor( 2,4 );
}

quest
qUseItem1003111()				// 크루노 날개 염색약 -
{
	DyePetColor( 2,5 );
}

quest
qUseItem1003112()				// 크루노 날개 염색약 -
{
	DyePetColor( 2,6 );
}

quest
qUseItem1003113()				// 크루노 날개 염색약 -
{
	DyePetColor( 2,7 );
}
//----------------------------------------------------------------

quest
qUseItem1003114()				// 크루노 눈 염색약 -
{
	DyePetColor( 1,0 );
}

quest
qUseItem1003115()				// 크루노 눈 염색약 -
{
	DyePetColor( 1,1 );
}

quest
qUseItem1003116()				// 크루노 눈 염색약 -
{
	DyePetColor( 1,2 );
}

quest
qUseItem1003117()				// 크루노 눈 염색약 -
{
	DyePetColor( 1,3 );
}

quest
qUseItem1003118()				// 크루노 눈 염색약 -
{
	DyePetColor( 1,4 );
}

quest
qUseItem1003119()				// 크루노 눈 염색약 -
{
	DyePetColor( 1,5 );
}

quest
qUseItem1003120()				// 크루노 눈 염색약 -
{
	DyePetColor( 1,6 );
}

quest
qUseItem1003121()				// 크루노 눈 염색약 -
{
	DyePetColor( 1,7 );
}
//----------------------------------------------------------------

quest
qUseItem1003122()				// 크루노 몸 염색약 -
{
	DyePetColor( 0,0 );
}

quest
qUseItem1003123()				// 크루노 몸 염색약 -
{
	DyePetColor( 0,1 );
}

quest
qUseItem1003124()				// 크루노 몸 염색약 -
{
	DyePetColor( 0,2 );
}

quest
qUseItem1003125()				// 크루노 몸 염색약 -
{
	DyePetColor( 0,3 );
}

quest
qUseItem1003126()				// 크루노 몸 염색약 -
{
	DyePetColor( 0,4 );
}

quest
qUseItem1003127()				// 크루노 몸 염색약 -
{
	DyePetColor( 0,5 );
}

quest
qUseItem1003128()				// 크루노 몸 염색약 -
{
	DyePetColor( 0,6 );
}

quest
qUseItem1003129()				// 크루노 몸 염색약 -
{
	DyePetColor( 0,7 );
}
//----------------------------------------------------------------

quest
qUseItem1003343()				// 제스터 무늬 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 2,0 );
	}
}

quest
qUseItem1003344()				// 제스터 무늬 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 2,1 );
	}
}

quest
qUseItem1003345()				// 제스터 무늬 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 2,2 );
	}
}

quest
qUseItem1003346()				// 제스터 무늬 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 2,3 );
	}
}

quest
qUseItem1003347()				// 제스터 무늬 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 2,4 );
	}
}

quest
qUseItem1003348()				// 제스터 무늬 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 2,5 );
	}
}

quest
qUseItem1003349()				// 제스터 무늬 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 2,6 );
	}
}

quest
qUseItem1003350()				// 제스터 무늬 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1) {
		DyePetColor( 2,7 );
	}
}
//----------------------------------------------------------------

quest
qUseItem1003130()				// 제스터 구슬 염색약 -
{
	DyePetColor( 1,0 );
}

quest
qUseItem1003131()				// 제스터 구슬 염색약 -
{
	DyePetColor( 1,1 );
}

quest
qUseItem1003132()				// 제스터 구슬 염색약 -
{
	DyePetColor( 1,2 );
}

quest
qUseItem1003133()				// 제스터 구슬 염색약 -
{
	DyePetColor( 1,3 );
}

quest
qUseItem1003134()				// 제스터 구슬 염색약 -
{
	DyePetColor( 1,4 );
}

quest
qUseItem1003135()				// 제스터 구슬 염색약 -
{
	DyePetColor( 1,5 );
}

quest
qUseItem1003136()				// 제스터 구슬 염색약 -
{
	DyePetColor( 1,6 );
}

quest
qUseItem1003137()				// 제스터 구슬 염색약 -
{
	DyePetColor( 1,7 );
}
//----------------------------------------------------------------

quest
qUseItem1003138()				// 제스터 몸 염색약 -
{
	DyePetColor( 0,0 );
}

quest
qUseItem1003139()				// 제스터 몸 염색약 -
{
	DyePetColor( 0,1 );
}

quest
qUseItem1003140()				// 제스터 몸 염색약 -
{
	DyePetColor( 0,2 );
}

quest
qUseItem1003141()				// 제스터 몸 염색약 -
{
	DyePetColor( 0,3 );
}

quest
qUseItem1003142()				// 제스터 몸 염색약 -
{
	DyePetColor( 0,4 );
}

quest
qUseItem1003143()				// 제스터 몸 염색약 -
{
	DyePetColor( 0,5 );
}

quest
qUseItem1003144()				// 제스터 몸 염색약 -
{
	DyePetColor( 0,6 );
}

quest
qUseItem1003145()				// 제스터 몸 염색약 -
{
	DyePetColor( 0,7);
}

//--------------------------------------------------------------------

quest
qUseItem1003462()				// 이뉴이트 머리 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,0 );
	}
}

quest
qUseItem1003463()				// 이뉴이트 머리 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,1 );
	}
}

quest
qUseItem1003464()				// 이뉴이트 머리 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,2 );
	}
}

quest
qUseItem1003465()				// 이뉴이트 머리 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,3 );
	}
}

quest
qUseItem1003466()				// 이뉴이트 머리 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,4 );
	}
}

quest
qUseItem1003467()				// 이뉴이트 머리 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,5 );
	}
}

quest
qUseItem1003468()				// 이뉴이트 머리 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,6 );
	}
}

quest
qUseItem1003469()				// 이뉴이트 머리 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,7 );
	}
}

//--------------------------------------------------------------------

quest
qUseItem1003470()				// 크루노 바지 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 7,0 );
	}
}

quest
qUseItem1003471()				// 크루노 바지 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 7,1 );
	}
}

quest
qUseItem1003472()				// 크루노 바지 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 7,2 );
	}
}

quest
qUseItem1003473()				// 크루노 바지 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 7,3 );
	}
}

quest
qUseItem1003474()				// 크루노 바지 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 7,4 );
	}
}

quest
qUseItem1003475()				// 크루노 바지 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 7,5 );
	}
}

quest
qUseItem1003476()				// 크루노 바지 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 7,6 );
	}
}

quest
qUseItem1003477()				// 크루노 바지 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 7,7 );
	}
}

//--------------------------------------------------------------------

quest
qUseItem1003478()				// 크루노 악세사리(신발) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,0 );
	}
}

quest
qUseItem1003479()				// 크루노 악세사리(신발) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,1 );
	}
}

quest
qUseItem1003480()				// 크루노 악세사리(신발) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,2 );
	}
}

quest
qUseItem1003481()				// 크루노 악세사리(신발) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,3 );
	}
}

quest
qUseItem1003482()				// 크루노 악세사리(신발) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,4 );
	}
}

quest
qUseItem1003483()				// 크루노 악세사리(신발) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,5 );
	}
}

quest
qUseItem1003484()				// 크루노 악세사리(신발) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,6 );
	}
}

quest
qUseItem1003485()				// 크루노 악세사리(신발) 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,7 );
	}
}

//--------------------------------------------------------------------

quest
qUseItem1003486()				// 제스터 옷 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,0 );
	}
}

quest
qUseItem1003487()				// 제스터 옷 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,1 );
	}
}

quest
qUseItem1003488()				// 제스터 옷 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,2 );
	}
}

quest
qUseItem1003489()				// 제스터 옷 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,3 );
	}
}

quest
qUseItem1003490()				// 제스터 옷 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,4 );
	}
}

quest
qUseItem1003491()				// 제스터 옷 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,5 );
	}
}

quest
qUseItem1003492()				// 제스터 옷 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,6 );
	}
}

quest
qUseItem1003493()				// 제스터 옷 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,7 );
	}
}

//--------------------------------------------------------------------

quest
qUseItem1003494()				// 제스터 크라운 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,0 );
	}
}

quest
qUseItem1003495()				// 제스터 크라운 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,1 );
	}
}

quest
qUseItem1003496()				// 제스터 크라운 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,2 );
	}
}

quest
qUseItem1003497()				// 제스터 크라운 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,3 );
	}
}

quest
qUseItem1003498()				// 제스터 크라운 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,4 );
	}
}

quest
qUseItem1003499()				// 제스터 크라운 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,5 );
	}
}

quest
qUseItem1003500()				// 제스터 크라운 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,6 );
	}
}

quest
qUseItem1003501()				// 제스터 크라운 염색약 -
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,7 );
	}
}

//---------------------------------------------------------------펫 4단계 염색약 xyzin 2004. 9. 22

quest
qUseItem1003677()				// 이뉴이트 토시 - 퍼플 오커 (기본)
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,0 );
	}
}

quest
qUseItem1003678()				// 이뉴이트 토시 - 버프 브라운
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,1 );
	}
}

quest
qUseItem1003679()				// 이뉴이트 토시 - 바이올렛
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,2 );
	}
}

quest
qUseItem1003680()				// 이뉴이트 토시 - 레몬 옐로
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,3 );
	}
}

quest
qUseItem1003681()				// 이뉴이트 토시 - 펄스노우
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,4 );
	}
}

quest
qUseItem1003682()				// 이뉴이트 토시 - 체리쉬 핑크
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,5 );
	}
}

quest
qUseItem1003683()				// 이뉴이트 토시 - 스카이 블루
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,6 );
	}
}

quest
qUseItem1003684()				// 이뉴이트 토시 - 커디널 레드
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,7 );
	}
}

//---------------------------------------------------------------

quest
qUseItem1003685()				// 이뉴이트 신발 - 카디널레드(기본)
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,0 );
	}
}

quest
qUseItem1003686()				// 이뉴이트 신발 - 바이올렛
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,1 );
	}
}

quest
qUseItem1003687()				// 이뉴이트 신발 - 버프브라운
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,2 );
	}
}

quest
qUseItem1003688()				// 이뉴이트 신발 - 레몬옐로
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,3 );
	}
}

quest
qUseItem1003689()				// 이뉴이트 신발 - 퍼플오커
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,4 );
	}
}

quest
qUseItem1003690()				// 이뉴이트 신발 - 펄스노우
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,5 );
	}
}

quest
qUseItem1003691()				// 이뉴이트 신발 - 스카이블루
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,6 );
	}
}

quest
qUseItem1003692()				// 이뉴이트 신발 - 체리쉬핑크
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,7 );
	}
}

//---------------------------------------------------------------

quest
qUseItem1003693()				// 제스터 태엽 - 옐로우
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,0 );
	}
}

quest
qUseItem1003694()				// 제스터 태엽 - 카디널레드
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,1 );
	}
}

quest
qUseItem1003695()				// 제스터 태엽 - 핑크
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,2 );
	}
}

quest
qUseItem1003696()				// 제스터 태엽 - 블랙
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,3 );
	}
}

quest
qUseItem1003697()				// 제스터 태엽 - 그린터틀
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,4 );
	}
}

quest
qUseItem1003698()				// 제스터 태엽 - 아이스블루
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,5 );
	}
}

quest
qUseItem1003699()				// 제스터 태엽 - 실버코인
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,6 );
	}
}

quest
qUseItem1003700()				// 제스터 태엽 - 바이올렛
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 5,7 );
	}
}

//---------------------------------------------------------------

quest
qUseItem1003701()				// 제스터 눈 - 옐로우
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,0 );
	}
}

quest
qUseItem1003702()				// 제스터 눈 - 레드
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,1 );
	}
}

quest
qUseItem1003703()				// 제스터 눈 - 울트라마린
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,2 );
	}
}

quest
qUseItem1003704()				// 제스터 눈 - 그린
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,3 );
	}
}

quest
qUseItem1003705()				// 제스터 눈 - 실버그레이
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,4 );
	}
}

quest
qUseItem1003706()				// 제스터 눈 - 그롬옐로우
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,5 );
	}
}

quest
qUseItem1003707()				// 제스터 눈 - 브라운
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,6 );
	}
}

quest
qUseItem1003708()				// 제스터 눈 - 퍼플
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 4레벨 이상
		DyePetColor( 6,7 );
	}
}

// *********************************************************************
//        추가펫 - 2004.11.2 : 일본펫 [아코]
// *********************************************************************

//----------------------------------------------------------------
quest
qUseItem1003776()				// 아코 몸 황토색
{
	DyePetColor( 0,0 );
}

quest
qUseItem1003777()				// 아코 몸 하얀색
{
	DyePetColor( 0,1 );
}

quest
qUseItem1003778()				// 아코 몸 청회색
{
	DyePetColor( 0,2 );
}

quest
qUseItem1003779()				// 아코 몸 아이보리
{
	DyePetColor( 0,3 );
}

quest
qUseItem1003780()				// 아코 몸 회색
{
	DyePetColor( 0,4 );
}

quest
qUseItem1003781()				// 아코 몸 붉은색
{
	DyePetColor( 0,5 );
}

quest
qUseItem1003782()				// 아코 몸 노란색
{
	DyePetColor( 0,6 );
}

quest
qUseItem1003783()				// 아코 몸 까만색
{
	DyePetColor( 0,7);
}
//----------------------------------------------------------------
quest
qUseItem1003784()				// 아코 몸2 자주색
{
	DyePetColor( 1,0 );
}

quest
qUseItem1003785()				// 아코 몸2 분홍색
{
	DyePetColor( 1,1 );
}

quest
qUseItem1003786()				// 아코 몸2 파란색
{
	DyePetColor( 1,2 );
}

quest
qUseItem1003787()				// 아코 몸2 주황색
{
	DyePetColor( 1,3 );
}

quest
qUseItem1003788()				// 아코 몸2 갈색
{
	DyePetColor( 1,4 );
}

quest
qUseItem1003789()				// 아코 몸2 빨간색
{
	DyePetColor( 1,5 );
}

quest
qUseItem1003790()				// 아코 몸2 보라색
{
	DyePetColor( 1,6 );
}

quest
qUseItem1003791()				// 아코 몸2 회색
{
	DyePetColor( 1,7);
}
//----------------------------------------------------------------
quest
qUseItem1003792()				// 아코 눈 까만색
{
	DyePetColor( 2,0 );
}

quest
qUseItem1003793()				// 아코 눈 파란색
{
	DyePetColor( 2,1 );
}

quest
qUseItem1003794()				// 아코 눈 노란색
{
	DyePetColor( 2,2 );
}

quest
qUseItem1003795()				// 아코 눈 녹색
{
	DyePetColor( 2,3 );
}

quest
qUseItem1003796()				// 아코 눈 빨간색
{
	DyePetColor( 2,4 );
}

quest
qUseItem1003797()				// 아코 눈 회색
{
	DyePetColor( 2,5 );
}

quest
qUseItem1003798()				// 아코 눈 보라색
{
	DyePetColor( 2,6 );
}

quest
qUseItem1003799()				// 아코 눈 갈색
{
	DyePetColor( 2,7);
}
//----------------------------------------------------------------
quest
qUseItem1003800()				// 아코 장식 파란색
{
	DyePetColor( 3,0 );
}

quest
qUseItem1003801()				// 아코 장식 회색
{
	DyePetColor( 3,1 );
}

quest
qUseItem1003802()				// 아코 장식 녹색
{
	DyePetColor( 3,2 );
}

quest
qUseItem1003803()				// 아코 장식 노란색
{
	DyePetColor( 3,3 );
}

quest
qUseItem1003804()				// 아코 장식 빨간색
{
	DyePetColor( 3,4 );
}

quest
qUseItem1003805()				// 아코 장식 까만색
{
	DyePetColor( 3,5 );
}

quest
qUseItem1003806()				// 아코 장식 보라색
{
	DyePetColor( 3,6 );
}

quest
qUseItem1003807()				// 아코 장식 분홍색
{
	DyePetColor( 3,7);
}

//--------------------------------------------------------------------

quest
qUseItem1003808()				// 아코 구슬 금색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,0 );
	}
}

quest
qUseItem1003809()				// 아코 구슬 은색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,1 );
	}
}

quest
qUseItem1003810()				// 아코 구슬 분홍
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,2 );
	}
}

quest
qUseItem1003811()				// 아코 구슬 녹색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,3 );
	}
}

quest
qUseItem1003812()				// 아코 구슬 빨간
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,4 );
	}
}

quest
qUseItem1003813()				// 아코 구슬 까만
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,5 );
	}
}

quest
qUseItem1003814()				// 아코 구슬 보라
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,6 );
	}
}

quest
qUseItem1003815()				// 아코 구슬 파란
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,7 );
	}
}

// *********************************************************************
//        추가펫 - 2005.1.3 : 중국펫 [웨이메이]
// *********************************************************************

//----------------------------------------------------------------
quest
qUseItem1004221()				// 웨이메이 몸 황토색
{
	DyePetColor( 0,0 );
}

quest
qUseItem1004222()				// 웨이메이 몸 노란색
{
	DyePetColor( 0,1 );
}

quest
qUseItem1004223()				// 웨이메이 몸 붉은구리
{
	DyePetColor( 0,2 );
}

quest
qUseItem1004224()				// 웨이메이 몸 연녹색
{
	DyePetColor( 0,3 );
}

quest
qUseItem1004225()				// 웨이메이 몸 청록색
{
	DyePetColor( 0,4 );
}

quest
qUseItem1004226()				// 웨이메이 몸 파란색
{
	DyePetColor( 0,5 );
}

quest
qUseItem1004227()				// 웨이메이 몸 분홍색
{
	DyePetColor( 0,6 );
}

quest
qUseItem1004228()				// 웨이메이 몸 연보라색
{
	DyePetColor( 0,7 );
}
//----------------------------------------------------------------
quest
qUseItem1004245()				// 웨이메이 모자 주홍비단색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,0 );
	}
}

quest
qUseItem1004246()				// 웨이메이 모자 분홍비단색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,1 );
	}
}

quest
qUseItem1004247()				// 웨이메이 모자 찬파란비단색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,2 );
	}
}

quest
qUseItem1004248()				// 웨이메이 모자 옐로카키색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,3 );
	}
}

quest
qUseItem1004249()				// 웨이메이 모자 완두콩비단색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,4 );
	}
}

quest
qUseItem1004250()				// 웨이메이 모자 청보라비단색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,5 );
	}
}

quest
qUseItem1004251()				// 웨이메이 모자 갈색비단색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,6 );
	}
}

quest
qUseItem1004252()				// 웨이메이 모자 청록비단색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,7 );
	}
}
//----------------------------------------------------------------
quest
qUseItem1004237()				// 웨이메이 목도리 하늘색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,0 );
	}
}

quest
qUseItem1004238()				// 웨이메이 목도리 노란색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,1 );
	}
}

quest
qUseItem1004239()				// 웨이메이 목도리 주황색
{
 	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,2 );
	}
}

quest
qUseItem1004240()				// 웨이메이 목도리 완두콩색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,3 );
	}
}

quest
qUseItem1004241()				// 웨이메이 목도리 청록색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,4 );
	}
}

quest
qUseItem1004242()				// 웨이메이 목도리 분홍색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,5 );
	}
}

quest
qUseItem1004243()				// 웨이메이 목도리 보라색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,6 );
	}
}

quest
qUseItem1004244()				// 웨이메이 목도리 회청색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 2,7 );
	}
}
//----------------------------------------------------------------
quest
qUseItem1004229()				// 웨이메이 대나무 연녹색
{
	DyePetColor( 1,0 );
}

quest
qUseItem1004230()				// 웨이메이 대나무 금색
{
	DyePetColor( 1,1 );
}

quest
qUseItem1004231()				// 웨이메이 대나무 붉은구리색
{
	DyePetColor( 1,2 );
}

quest
qUseItem1004232()				// 웨이메이 대나무 연보라색
{
	DyePetColor( 1,3 );
}

quest
qUseItem1004233()				// 웨이메이 대나무 옥색
{
	DyePetColor( 1,4 );
}

quest
qUseItem1004234()				// 웨이메이 대나무 파란색
{
	DyePetColor( 1,5 );
}

quest
qUseItem1004235()				// 웨이메이 대나무 분홍색
{
	DyePetColor( 1,6 );
}

quest
qUseItem1004236()				// 웨이메이 대나무 은색
{
	DyePetColor( 1,7 );
}

// *********************************************************************
//        유료펫 - 2005.07.04 : 유료펫 [카벙클]
// *********************************************************************

//----------------------------------------------------------------
quest
qUseItem1004565()				// 카벙클 몸 화이트
{
	DyePetColor( 3,0 );
}

quest
qUseItem1004566()				// 카벙클 몸 핑크
{
	DyePetColor( 3,1 );
}

quest
qUseItem1004567()				// 카벙클 몸 퍼플
{
	DyePetColor( 3,2 );
}

quest
qUseItem1004568()				// 카벙클 몸 블루
{
	DyePetColor( 3,3 );
}

quest
qUseItem1004569()				// 카벙클 몸 아쿠아
{
	DyePetColor( 3,4 );
}

quest
qUseItem1004570()				// 카벙클 몸 그린
{
	DyePetColor( 3,5 );
}

quest
qUseItem1004571()				// 카벙클 몸 로즈
{
	DyePetColor( 3,6 );
}

quest
qUseItem1004572()				// 카벙클 몸 브라운
{
	DyePetColor( 3,7 );
}
//----------------------------------------------------------------
quest
qUseItem1004573()				// 카벙클 눈 블랙
{
	DyePetColor( 1,0 );
}

quest
qUseItem1004574()				// 카벙클 눈 핑크
{
	DyePetColor( 1,1 );
}

quest
qUseItem1004575()				// 카벙클 눈 퍼플
{
	DyePetColor( 1,2 );
}

quest
qUseItem1004576()				// 카벙클 눈 블루
{
	DyePetColor( 1,3 );
}

quest
qUseItem1004577()				// 카벙클 눈 토파즈
{
	DyePetColor( 1,4 );
}

quest
qUseItem1004578()				// 카벙클 눈 라이트그린
{
	DyePetColor( 1,5 );
}

quest
qUseItem1004579()				// 카벙클 눈 그레이
{
	DyePetColor( 1,6 );
}

quest
qUseItem1004580()				// 카벙클 눈 그린
{
	DyePetColor( 1,7);
}
//----------------------------------------------------------------
quest
qUseItem1004581()				// 카벙클 보석 레드
{
	DyePetColor( 2,0 );
}

quest
qUseItem1004582()				// 카벙클 보석 핑크
{
	DyePetColor( 2,1 );
}

quest
qUseItem1004583()				// 카벙클 보석 퍼플
{
	DyePetColor( 2,2 );
}

quest
qUseItem1004584()				// 카벙클 보석 블루
{
	DyePetColor( 2,3 );
}

quest
qUseItem1004585()				// 카벙클 보석 오렌지
{
	DyePetColor( 2,4 );
}

quest
qUseItem1004586()				// 카벙클 보석 그린
{
	DyePetColor( 2,5 );
}

quest
qUseItem1004587()				// 카벙클 보석 블랙
{
	DyePetColor( 2,6 );
}

quest
qUseItem1004588()				// 카벙클 보석 골드
{
	DyePetColor( 2,7);
}
//----------------------------------------------------------------
quest
qUseItem1004590()				// 카벙클 의상 카키
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,0 );
	}
}

quest
qUseItem1004591()				// 카벙클 의상 블랙
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,1 );
	}
}

quest
qUseItem1004592()				// 카벙클 의상 화이트
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,2 );
	}
}

quest
qUseItem1004593()				// 카벙클 의상 블루
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,3 );
	}
}

quest
qUseItem1004594()				// 카벙클 의상 브라운
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,4 );
	}
}

quest
qUseItem1004595()				// 카벙클 의상 그레이
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,5 );
	}
}

quest
qUseItem1004596()				// 카벙클 의상 베이지
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,6 );
	}
}

quest
qUseItem1004597()				// 카벙클 의상 레드
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 4,7);
	}
}

//--------------------------------------------------------------------
quest
qUseItem1004598()				// 카벙클 스카프 레드
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 0,0 );
	}
}

quest
qUseItem1004599()				// 카벙클 스카프 핑크
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 0,1 );
	}
}

quest
qUseItem1004600()				// 카벙클 스카프 퍼플
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 0,2 );
	}
}

quest
qUseItem1004601()				// 카벙클 스카프 블루
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 0,3 );
	}
}

quest
qUseItem1004602()				// 카벙클 스카프 오렌지
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 0,4 );
	}
}

quest
qUseItem1004603()				// 카벙클 스카프 그린
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 0,5 );
	}
}

quest
qUseItem1004604()				// 카벙클 스카프 블랙
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 0,6 );
	}
}

quest
qUseItem1004605()				// 카벙클 스카프 옐로우
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 0,7 );
	}
}
//----------------------------------------------------------------
quest
qUseItem1004606()				// 카벙클 고글,가방 브라운
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,0 );
	}
}

quest
qUseItem1004607()				// 카벙클 고글,가방 블랙
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,1 );
	}
}

quest
qUseItem1004608()				// 카벙클 고글,가방 레드
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,2 );
	}
}

quest
qUseItem1004609()				// 카벙클 고글,가방 퍼플
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,3 );
	}
}

quest
qUseItem1004610()				// 카벙클 고글,가방 로즈
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,4 );
	}
}

quest
qUseItem1004611()				// 카벙클 고글,가방 Lt퍼플
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,5 );
	}
}

quest
qUseItem1004612()				// 카벙클 고글,가방 Lt블루
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,6 );
	}
}

quest
qUseItem1004613()				// 카벙클 고글,가방 그린
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 5,7 );
	}
}
//----------------------------------------------------------------
quest
qUseItem1004351()				// 리브리오 귀 노랑
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 1,0 );
	}
}

quest
qUseItem1004352()				// 리브리오
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 1,1 );
	}
}

quest
qUseItem1004353()				// 리브리오
{
 	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 1,2 );
	}
}

quest
qUseItem1004354()				// 리브리오
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 1,3 );
	}
}

quest
qUseItem1004355()				// 리브리오
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 1,4 );
	}
}

quest
qUseItem1004356()				// 리브리오
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 1,5 );
	}
}

quest
qUseItem1004357()				// 리브리오
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 1,6 );
	}
}

quest
qUseItem1004358()				// 리브리오
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 1,7 );
	}
}
//----------------------------------------------------------------
quest
qUseItem1006007()				// 클라라 원피스 기본색
{
	DyePetColor( 0,0 );
}

quest
qUseItem1006008()				// 클라라 원피스 보라색
{
	DyePetColor( 0,1 );
}

quest
qUseItem1006009()				// 클라라 원피스 올리브색
{
	DyePetColor( 0,2 );
}

quest
qUseItem1006010()				// 클라라 원피스 초록색
{
	DyePetColor( 0,3 );
}

quest
qUseItem1006011()				// 클라라 원피스 빨간색
{
	DyePetColor( 0,4 );
}

quest
qUseItem1006012()				// 클라라 원피스 노란색
{
	DyePetColor( 0,5 );
}

quest
qUseItem1006013()				// 클라라 원피스 분홍색
{
	DyePetColor( 0,6 );
}

quest
qUseItem1006014()				// 클라라 원피스 파란색
{
	DyePetColor( 0,7 );
}
//----------------------------------------------------------------
quest
qUseItem1006031()				// 클라라 머리띠 자주색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,0 );
	}
}

quest
qUseItem1006032()				// 클라라 머리띠 검정색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,1 );
	}
}

quest
qUseItem1006033()				// 클라라 머리띠 파란색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,2 );
	}
}

quest
qUseItem1006034()				// 클라라 머리띠 초록색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,3 );
	}
}

quest
qUseItem1006035()				// 클라라 머리띠 보라색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,4 );
	}
}

quest
qUseItem1006036()				// 클라라 머리띠 노란색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,5 );
	}
}

quest
qUseItem1006037()				// 클라라 머리띠 노란색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,6 );
	}
}

quest
qUseItem1006038()				// 클라라 머리띠 올리브색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {	// 3레벨 이상
		DyePetColor( 3,7 );
	}
}
//----------------------------------------------------------------
quest
qUseItem1006015()				// 클라라 머리 빨간색
{
	DyePetColor( 4,0 );
}

quest
qUseItem1006016()				// 클라라 머리 검정색
{
	DyePetColor( 4,1 );
}

quest
qUseItem1006017()				// 클라라 머리 은색
{
	DyePetColor( 4,2 );
}

quest
qUseItem1006018()				// 클라라 머리 보라색
{
	DyePetColor( 4,3 );
}

quest
qUseItem1006019()				// 클라라 머리 초록색
{
	DyePetColor( 4,4 );
}

quest
qUseItem1006020()				// 클라라 머리 갈색
{
	DyePetColor( 4,5 );
}

quest
qUseItem1006021()				// 클라라 머리 노란색
{
	DyePetColor( 4,6 );
}

quest
qUseItem1006022()				// 클라라 머리 파란색
{
	DyePetColor( 4,7 );
}
//----------------------------------------------------------------
quest
qUseItem1006023()				// 클라라 신발 파란색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1 && pet.getLevel() < 4) {	// 2레벨 이상
		DyePetColor( 5,0 );
	}
}

quest
qUseItem1006024()				// 클라라 신발 보라색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1 && pet.getLevel() < 4) {	// 2레벨 이상
		DyePetColor( 5,1 );
	}
}

quest
qUseItem1006025()				// 클라라 신발 올리브색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1 && pet.getLevel() < 4) {	// 2레벨 이상
		DyePetColor( 5,2 );
	}
}

quest
qUseItem1006026()				// 클라라 신발 초록색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1 && pet.getLevel() < 4) {	// 2레벨 이상
		DyePetColor( 5,3 );
	}
}

quest
qUseItem1006027()				// 클라라 신발 빨간색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1 && pet.getLevel() < 4) {	// 2레벨 이상
		DyePetColor( 5,4 );
	}
}

quest
qUseItem1006028()				// 클라라 신발 노란색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1 && pet.getLevel() < 4) {	// 2레벨 이상
		DyePetColor( 5,5 );
	}
}

quest
qUseItem1006029()				// 클라라 신발 분홍색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1 && pet.getLevel() < 4) {	// 2레벨 이상
		DyePetColor( 5,6 );
	}
}

quest
qUseItem1006030()				// 클라라 신발 검정색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 1 && pet.getLevel() < 4) {	// 2레벨 이상
		DyePetColor( 5,7 );
	}
}
//----------------------------------------------------------------
quest
qUseItem1006039()				// 클라라 우산 초록색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 3레벨 이상
		DyePetColor( 7,0 );
	}
}

quest
qUseItem1006040()				// 클라라 우산 검정색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 3레벨 이상
		DyePetColor( 7,1 );
	}
}

quest
qUseItem1006041()				// 클라라 우산 파란색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 3레벨 이상
		DyePetColor( 7,2 );
	}
}

quest
qUseItem1006042()				// 클라라 우산 보라색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 3레벨 이상
		DyePetColor( 7,3 );
	}
}

quest
qUseItem1006043()				// 클라라 우산 노간색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 3레벨 이상
		DyePetColor( 7,4 );
	}
}

quest
qUseItem1006044()				// 클라라 우산 빨간색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 3레벨 이상
		DyePetColor( 7,5 );
	}
}

quest
qUseItem1006045()				// 클라라 우산 와인색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 3레벨 이상
		DyePetColor( 7,6 );
	}
}

quest
qUseItem1006046()				// 클라라 우산 분홍색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 3) {	// 3레벨 이상
		DyePetColor( 7,7 );
	}
}
//----------------------------------------------------------------
quest
qUseItem1006047()				// 클라라 눈 보라색
{
	DyePetColor( 6,0 );
}

quest
qUseItem1006048()				// 클라라 눈 검정색
{
	DyePetColor( 6,1 );
}

quest
qUseItem1006049()				// 클라라 눈 파란색
{
	DyePetColor( 6,2 );
}

quest
qUseItem1006050()				// 클라라 눈 청회색
{
	DyePetColor( 6,3 );
}

quest
qUseItem1006051()				// 클라라 눈 노란색
{
	DyePetColor( 6,4 );
}

quest
qUseItem1006052()				// 클라라 눈 빨간색
{
	DyePetColor( 6,5 );
}

quest
qUseItem1006053()				// 클라라 눈 분홍색
{
	DyePetColor( 6,6 );
}

quest
qUseItem1006054()				// 클라라 눈 초록색
{
	DyePetColor( 6,7 );
}
//******************************************************
// 펫 스노위그 염색약
// 2006.08.23 written by Han
//******************************************************
quest
qUseItem1006221()				// 스노위그 눈 기본색
{
	DyePetColor( 3,0 );
}

quest
qUseItem1006222()				// 스노위그 눈 회색
{
	DyePetColor( 3,1 );
}

quest
qUseItem1006223()				// 스노위그 눈 주황색
{
	DyePetColor( 3,2 );
}

quest
qUseItem1006224()				// 스노위그 눈 파란색
{
	DyePetColor( 3,3 );
}

quest
qUseItem1006225()				// 스노위그 눈 녹색
{
	DyePetColor( 3,4 );
}

quest
qUseItem1006226()				// 스노위그 눈 보라색
{
	DyePetColor( 3,5 );
}

quest
qUseItem1006227()				// 스노위그 눈 핑크색
{
	DyePetColor( 3,6 );
}

quest
qUseItem1006228()				// 스노위그 눈 연보라색
{
	DyePetColor( 3,7 );
}
//----------------------------------------------------------------
quest
qUseItem1006229()				// 스노위그 모자 기본색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {		// 2레벨 이상
		DyePetColor( 4,0 );
	}
}

quest
qUseItem1006230()				// 스노위그 모자 회색/녹색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {		// 2레벨 이상
		DyePetColor( 4,1 );
	}
}

quest
qUseItem1006231()				// 스노위그 모자 주황색/파란색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {		// 2레벨 이상
		DyePetColor( 4,2 );
	}
}

quest
qUseItem1006232()				// 스노위그 모자 파란색/와인색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {		// 2레벨 이상
		DyePetColor( 4,3 );
	}
}

quest
qUseItem1006233()				// 스노위그 모자 녹색/주황색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {		// 2레벨 이상
		DyePetColor( 4,4 );
	}
}

quest
qUseItem1006234()				// 스노위그 모자 보라색/하늘색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {		// 2레벨 이상
		DyePetColor( 4,5 );
	}
}

quest
qUseItem1006235()				// 스노위그 모자 핑크색/보라색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {		// 2레벨 이상
		DyePetColor( 4,6 );
	}
}

quest
qUseItem1006236()				// 스노위그 모자 연보라색/자주색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() > 2) {		// 2레벨 이상
		DyePetColor( 4,7 );
	}
}
//----------------------------------------------------------------
quest
qUseItem1006237()				// 스노위그 몸 기본색
{
	DyePetColor( 1,0 );
}

quest
qUseItem1006238()				// 스노위그 몸 베이지색
{
	DyePetColor( 1,1 );
}

quest
qUseItem1006239()				// 스노위그 몸 와인색
{
	DyePetColor( 1,2 );
}

quest
qUseItem1006240()				// 스노위그 몸 하늘색
{
	DyePetColor( 1,3 );
}

quest
qUseItem1006241()				// 스노위그 몸 녹색
{
	DyePetColor( 1,4 );
}

quest
qUseItem1006242()				// 스노위그 몸 황색
{
	DyePetColor( 1,5 );
}

quest
qUseItem1006243()				// 스노위그 몸 핑크색
{
	DyePetColor( 1,6 );
}

quest
qUseItem1006244()				// 스노위그 몸 연보라색
{
	DyePetColor( 1,7 );
}
//----------------------------------------------------------------
quest
qUseItem1006245()				// 스노위그 부리/발 기본색
{
	DyePetColor( 0,0 );
}

quest
qUseItem1006246()				// 스노위그 부리/발 주황색
{
	DyePetColor( 0,1 );
}

quest
qUseItem1006247()				// 스노위그 부리/발 회색
{
	DyePetColor( 0,2 );
}

quest
qUseItem1006248()				// 스노위그 부리/발 파란색
{
	DyePetColor( 0,3 );
}

quest
qUseItem1006249()				// 스노위그 부리/발 녹색
{
	DyePetColor( 0,4 );
}

quest
qUseItem1006250()				// 스노위그 부리/발 와인색
{
	DyePetColor( 0,5 );
}

quest
qUseItem1006251()				// 스노위그 부리/발 핑크색
{
	DyePetColor( 0,6 );
}

quest
qUseItem1006252()				// 스노위그 부리/발 연보라색
{
	DyePetColor( 0,7 );
}
//----------------------------------------------------------------
quest
qUseItem1006253()				// 스노위그 알껍질/깃끝 기본색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() != 3) {		// 1,2,4 레벨만 염색가능
		DyePetColor( 2,0 );
	}
}

quest
qUseItem1006254()				// 스노위그 알껍질/깃끝 회색/녹색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() != 3) {		// 1,2,4 레벨만 염색가능
		DyePetColor( 2,1 );
	}
}

quest
qUseItem1006255()				// 스노위그 알껍질/깃끝 주황색/파란색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() != 3) {		// 1,2,4 레벨만 염색가능
		DyePetColor( 2,2 );
	}
}

quest
qUseItem1006256()				// 스노위그 알껍질/깃끝 파란색/와인색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() != 3) {		// 1,2,4 레벨만 염색가능
		DyePetColor( 2,3 );
	}
}

quest
qUseItem1006257()				// 스노위그 알껍질/깃끝 녹색/주황색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() != 3) {		// 1,2,4 레벨만 염색가능
		DyePetColor( 2,4 );
	}
}

quest
qUseItem1006258()				// 스노위그 알껍질/깃끝 보라색/하늘색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() != 3) {		// 1,2,4 레벨만 염색가능
		DyePetColor( 2,5 );
	}
}

quest
qUseItem1006259()				// 스노위그 알껍질/깃끝 핑크색/보라색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() != 3) {		// 1,2,4 레벨만 염색가능
		DyePetColor( 2,6 );
	}
}

quest
qUseItem1006260()				// 스노위그 알껍질/깃끝 연보라색/자주색
{
	object	pet;

	if (!trigger.hasPet())	return;

	pet = trigger.getPet();
	if(pet.getLevel() != 3) {		// 1,2,4 레벨만 염색가능
		DyePetColor( 2,7 );
	}
}


quest
qUseItem1004470()		// 하이딩 포션
{
	if (trigger.getBuilderType() >= 1 && trigger.getBuilderType() <=5)
	{
		return;
	}

	UseSkill(trigger,"3000259",60);
	Cash_Log();
}

quest
qUseItem1004472()		// 디텍팅 포션
{
	UseSkill(trigger,"3000260",60);
	Cash_Log();
}


//******************************************************************************
// 유료화 아이템 구현 부분 Last Update 2005.06.09 Writtern by Han
//******************************************************************************
quest
qUseItem1004511()		// 펫 강제진화 (1레벨에서 2레벨로)
{
	object pet;
	integer petDBID;

	pet = trigger.getPet();

	petDBID = String.toInteger(pet.getName());

	if(!NormalItemCanBeUsed()) return;

	if(pet)
	{
		if(pet.getType() == 1 || pet.getType() == 3)
		{
			trigger.message(TEXT_MONSTER_PET, MSG_TYPE__SYSTEM);		// 몬스터 펫은 진화시킬수 없다는 메시지
			return;
		}
/*
		if(petDBID >= 2100682 && petDBID <= 2100686)
		{
			trigger.message(TEXT_MONSTER_PET, MSG_TYPE__SYSTEM);		// 몬스터 펫은 진화시킬수 없다는 메시지
			return;
		}
*/
		if(pet.getSkillActionInventory().getInSlot(1) != null)
		{
			if(pet.getLevel() == 1)
			{
				pet.levelUp();
			}
			else
			{
				trigger.message(TEXT_NOT_PET_LEVELUP, MSG_TYPE__SYSTEM);	// 레벨이 4일때는 사용할 수 없다는 메시지
				return;
			}
		}
		else
		{
			trigger.message(TEXT_NOT_PET_SKILL, MSG_TYPE__SYSTEM);		// 해당 레벨스킬을 배우지 않은 상태에서는 진화할수 없다는 메시지
			return;
		}
	}
	else
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);			// 펫이 없다는 메시지
		return;
	}

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1004543()		// 펫 강제진화 (2레벨에서 3레벨로)
{
	object pet;
	integer petDBID;

	pet = trigger.getPet();

	petDBID = String.toInteger(pet.getName());

	if(!NormalItemCanBeUsed()) return;

	if(pet)
	{
		if(pet.getType() == 1 || pet.getType() == 3)
		{
			trigger.message(TEXT_MONSTER_PET, MSG_TYPE__SYSTEM);		// 몬스터 펫은 진화시킬수 없다는 메시지
			return;
		}
/*
		if(petDBID >= 2100682 && petDBID <= 2100686)
		{
			trigger.message(TEXT_MONSTER_PET, MSG_TYPE__SYSTEM);		// 몬스터 펫은 진화시킬수 없다는 메시지
			return;
		}
*/
		if(pet.getSkillActionInventory().getInSlot(2) != null)
		{
			if(pet.getLevel() == 2)
			{
				pet.levelUp();
			}
			else
			{
				trigger.message(TEXT_NOT_PET_LEVELUP, MSG_TYPE__SYSTEM);	// 레벨이 4일때는 사용할 수 없다는 메시지
				return;
			}
		}
		else
		{
			trigger.message(TEXT_NOT_PET_SKILL, MSG_TYPE__SYSTEM);		// 해당 레벨스킬을 배우지 않은 상태에서는 진화할수 없다는 메시지
			return;
		}
	}
	else
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);			// 펫이 없다는 메시지
		return;
	}

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1004512()		// 재분배 스크롤 (스킬)
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.resetCharacter(RESET_CHAR_ACTION);
	trigger.getCastedSpellInventory().terminatePassiveAll();

	// 스킬퀘스트 진행했을 경우 스킬 배울 수 있게 남겨주기
	Setup_Skill();
	trigger.updateAttr();	// 혹시 몰라서 상태 업데이트

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	controller.effectBy(trigger);
}

quest
qUseItem1004510()		// 재분배 스크롤 (스탯)
{
	integer wNum;
	integer checkUserWeight, i;
	integer EquipPartCount = 8;

	if (!NormalItemCanBeUsed())	return;

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	// 초보자 던전 및 튜토리얼 대기실, 도플갱어 숲 대기실에서 사용 불가능
	if (wNum == 421 || wNum == 422 || wNum == 423 || wNum == 424 ||
	    wNum == 203 || wNum == 178 || wNum == 179 || wNum == 180)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 길이 좁은 연결통 맵
	if (wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
    	}

	// 요새에서 사용 불가능
	if(wNum == 46 || wNum == 53 || wNum == 59 || wNum == 93 || wNum == 98 || wNum == 115 ||
	   wNum == 116 || wNum == 348 || wNum == 387 || wNum == 388 || wNum == 389 || wNum == 390 ||
	   wNum == 417 || wNum == 282 || wNum == 283 || wNum == 284 || wNum == 285 || wNum == 286 ||
	   wNum == 287 || wNum == 288 || wNum == 289 || wNum == 290)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 크라이덴 평원 1, 2, 3, 4, 5, 6, 7, 8
	if(wNum == 4 || wNum == 9 || wNum == 65 || wNum == 10 || wNum == 66 ||
	   wNum == 18 || wNum == 17 || wNum == 58)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 페나인 숲 1, 2, 3, 4, 5, 6
	if(wNum == 88 || wNum == 89 || wNum == 117 || wNum == 85 || wNum == 201 || wNum == 236)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 셀바스 평원 1, 2, 4, 5, 6, 7, 8
	if(wNum == 67 || wNum == 119 || wNum == 55 || wNum == 0 || wNum == 19 ||
	   wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if (trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD , MSG_TYPE__SYSTEM);
		return;
	}

	checkUserWeight = trigger.getCarryingItemInventory().weight();

	if (checkUserWeight >= 750)
	{
		trigger.message(TEXT_NO_RESET_CAUSE_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	for (i=1; i<9; ++i)
	{
		if (trigger.getDescAtPart(i) == null)
		{
			EquipPartCount = EquipPartCount - 1;
		}
	}

	if (EquipPartCount != 0)
	{
		trigger.message(TEXT_NO_RESET_CAUSE_EQUIP, MSG_TYPE__SYSTEM);
		trigger.updateEquipAt(EQUIP_PART__ALL);
		trigger.updateAttr();				// 혹시 몰라서 상태 업데이트
		return;
	}

	trigger.addExp(100);
	trigger.resetCharacter(RESET_CHAR_LEVEL);
	trigger.getCastedSpellInventory().terminatePassiveAll();

	// 스킬퀘스트 진행했을 경우 스킬 배울 수 있게 남겨주기
	Setup_Skill();
	trigger.updateAttr();	// 혹시 몰라서 상태 업데이트
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1004527()		// 재분배 스크롤 (타입)
{
	if(!NormalItemCanBeUsed()) return;

	trigger.message(TEXT_CASHITEM_STAT_REDISTRIBUTION, MSG_TYPE__SYSTEM);

//	if (controller.canBeExhausted())
//		controller.decreaseNumber(1);
}

quest
qUseItem1004539()		// 재분배 스크롤 (스탯 + 스킬)
{
	integer wNum;
	integer checkUserWeight, i;
	integer EquipPartCount = 8;

	if (!NormalItemCanBeUsed())	return;

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	// 초보자 던전 및 튜토리얼 대기실, 도플갱어 숲 대기실에서 사용 불가능
	if (wNum == 421 || wNum == 422 || wNum == 423 || wNum == 424 ||
	    wNum == 203 || wNum == 178 || wNum == 179 || wNum == 180)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 길이 좁은 연결통 맵
	if (wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
    	}

	// 요새에서 사용 불가능
	if(wNum == 46 || wNum == 53 || wNum == 59 || wNum == 93 || wNum == 98 || wNum == 115 ||
	   wNum == 116 || wNum == 348 || wNum == 387 || wNum == 388 || wNum == 389 || wNum == 390 ||
	   wNum == 417 || wNum == 282 || wNum == 283 || wNum == 284 || wNum == 285 || wNum == 286 ||
	   wNum == 287 || wNum == 288 || wNum == 289 || wNum == 290)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 크라이덴 평원 1, 2, 3, 4, 5, 6, 7, 8
	if(wNum == 4 || wNum == 9 || wNum == 65 || wNum == 10 || wNum == 66 ||
	   wNum == 18 || wNum == 17 || wNum == 58)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 페나인 숲 1, 2, 3, 4, 5, 6
	if(wNum == 88 || wNum == 89 || wNum == 117 || wNum == 85 || wNum == 201 || wNum == 236)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 셀바스 평원 1, 2, 4, 5, 6, 7, 8
	if(wNum == 67 || wNum == 119 || wNum == 55 || wNum == 0 || wNum == 19 ||
	   wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if (trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD , MSG_TYPE__SYSTEM);
		return;
	}

	checkUserWeight = trigger.getCarryingItemInventory().weight();

	if (checkUserWeight >= 750)
	{
		trigger.message(TEXT_NO_RESET_CAUSE_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

//	InventorySlotCount = trigger.getEmptyInvenSlotCount();

	for (i=1; i<9; ++i)
	{
		if (trigger.getDescAtPart(i) == null)
		{
			EquipPartCount = EquipPartCount - 1;
		}
	}

	if (EquipPartCount != 0)
	{
		trigger.message(TEXT_NO_RESET_CAUSE_EQUIP, MSG_TYPE__SYSTEM);
		trigger.updateEquipAt(EQUIP_PART__ALL);
		trigger.updateAttr();				// 혹시 몰라서 상태 업데이트
		return;
	}

	// 초기화 함수를 실행한다.
//	trigger.getExpFromAllAbilityLevel();				// 스킬과 레벨을 경험치로 환원
	trigger.resetCharacter(RESET_CHAR_LEVEL + RESET_CHAR_ACTION);	// 초기화 스펙에 맞추어 캐릭터를 초기화
	trigger.getCastedSpellInventory().terminatePassiveAll();

	Setup_Skill();
	trigger.message(TEXT_REQUEST_SHARE_END, MSG_TYPE__SYSTEM);

	Cash_Log();
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	trigger.updateAttr();					// 혹시 몰라서 상태 업데이트
	controller.effectBy(trigger);
}

quest
qUseItem1004526()		// 펫 스킬 초기화 아이템
{
	object pet, inventory;
	integer petDBID;
	integer	ADDEDHP, ADDEDMP, ADDEDSP;

	inventory = trigger.getPetInventory();
	pet = trigger.getPet();

	petDBID = String.toInteger(pet.getName());

	if(!NormalItemCanBeUsed()) return;

	if (pet)
	{
		if(pet.getType() == 1 || pet.getType() == 3)
		{
			trigger.message(TEXT_MONSTER_PET2, MSG_TYPE__SYSTEM);	// 몬스터 펫은 사용할 수 없다는 메시지
			return;
		}
/*
		if(petDBID >= 2100682 && petDBID <= 2100686)
		{
			trigger.message(TEXT_MONSTER_PET2, MSG_TYPE__SYSTEM);	// 몬스터 펫은 사용할 수 없다는 메시지
			return;
		}
*/
		// 생명의 원천 스킬을 가지고 있을 때
		if (trigger.getCookie("PET_ADD_HP") != null)
		{
			ADDEDHP	= String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("PET_ADD_HP"));

			trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

			if(trigger.getHP() > trigger.getMaxHP())
				trigger.setHP(trigger.getMaxHP());

			if (ADDEDHP <= 0)
				trigger.resetCookie("ADDEDHP");
			else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

			trigger.resetCookie("PET_ADD_HP");
			trigger.resetCookie("ORIHP");
			trigger.resetCookie("ORIHP2");
			trigger.resetCookie("ORIHP_TIME");
			trigger.updateAttr();
		}
		// 마나의 흐름 스킬을 가지고 있을 때
		if (trigger.getCookie("PET_ADD_MP") != null)
		{
			ADDEDMP	= String.toInteger(trigger.getCookie("ADDEDMP")) - String.toInteger(trigger.getCookie("PET_ADD_MP"));

			trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);

			if(trigger.getMP() > trigger.getMaxMP())
				trigger.setMP(trigger.getMaxMP());

			if (ADDEDMP < 0)
				trigger.resetCookie("ADDEDMP");
			else trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

			trigger.resetCookie("PET_ADD_MP");
			trigger.resetCookie("ORIMP");
			trigger.resetCookie("ORIMP2");
			trigger.resetCookie("ORIMP_TIME");
			trigger.updateAttr();
		}
		// 힘의 향연 스킬을 가지고 있을 때
		if (trigger.getCookie("PET_ADD_SP") != null)
		{
			ADDEDSP	= String.toInteger(trigger.getCookie("ADDEDSP")) - String.toInteger(trigger.getCookie("PET_ADD_SP"));

			trigger.setMaxSP(trigger.getOrgMaxSP() + ADDEDSP);

			if(trigger.getSP() > trigger.getMaxSP())
				trigger.setSP(trigger.getMaxSP());

			if (ADDEDSP <= 0)
				trigger.resetCookie("ADDEDSP");
			else trigger.setCookie("ADDEDSP", Integer.toString(ADDEDSP), 0);

			trigger.resetCookie("PET_ADD_SP");
			trigger.resetCookie("ORISP");
			trigger.resetCookie("ORISP2");
			trigger.resetCookie("ORISP_TIME");
			trigger.updateAttr();
		}

		pet.skillInit();
	}
	else if (inventory.isEggInIncubator())
	{
		trigger.message(TEXT_PET_EGG_IN_INCUBATOR, MSG_TYPE__SYSTEM);
		return;
	}
	else
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);		// 펫이 없다는 메시지
		return;
	}

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}


function
boolean
CashMessage(integer mNum) {
	if (trigger.getBuilderType() == 1 || trigger.getBuilderType() == 2) {
		trigger.registerBroadcast(Util.filterCurse(trigger.getQuestArgument()), mNum);
	} else if (mNum % 2 == 0) {
		trigger.registerBroadcast(Util.filterCurse(trigger.getQuestArgument()) + " Click [" + trigger.getName() + "]", mNum);
	} else {
		trigger.registerBroadcast(Util.filterCurse(trigger.getQuestArgument()) + " From [" + trigger.getName() + "]", mNum);
	}
	return true;
}


quest
W0Msg()
{
	CashMessage(0);
	Cash_Log();
}

quest
W1Msg()
{
	CashMessage(1);
	Cash_Log();
}

quest
W2Msg()
{
	CashMessage(2);
	Cash_Log();
}

quest
W3Msg()
{
	CashMessage(3);
	Cash_Log();
}

quest
W4Msg()
{
	CashMessage(4);
	Cash_Log();
}

quest
W5Msg()
{
	CashMessage(5);
	Cash_Log();
}

quest
W6Msg()
{
	CashMessage(6);
	Cash_Log();
}

quest
W7Msg()
{
	CashMessage(7);
	Cash_Log();
}

quest
W8Msg()
{
	CashMessage(8);
	Cash_Log();
}

quest
W9Msg()
{
	CashMessage(9);
	Cash_Log();
}

quest
W10Msg()
{
	CashMessage(10);
	Cash_Log();
}

quest
W11Msg()
{
	CashMessage(11);
	Cash_Log();
}

quest
W12Msg()
{
	CashMessage(12);
	Cash_Log();
}

quest
W13Msg()
{
	CashMessage(13);
	Cash_Log();
}

quest
W100Msg()
{
	CashMessage(100);
	Cash_Log();
}

quest
W101Msg()
{
	CashMessage(101);
	Cash_Log();
}

quest
W102Msg()
{
	CashMessage(102);
	Cash_Log();
}

quest
W103Msg()
{
	trigger.registerBroadcast(Util.filterCurse(trigger.getQuestArgument()), 103);
	Cash_Log();
}

quest
qUseItem1004038()               // 외치기 뿔피리 : 초록색
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W5Msg", controller);
	Cash_Log();
}

quest
qUseItem1004039()               // 외치기 뿔피리 : 노란색
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W7Msg", controller);
	Cash_Log();
}

quest
qUseItem1004040()               // 외치기 뿔피리 : 븐홍색
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W11Msg", controller);
	Cash_Log();
}

quest
qUseItem1004041()               // 외치기 뿔피리 : 하늘색
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W3Msg", controller);
	Cash_Log();
}

quest
qUseItem1004042()               // 외치기 뿔피리 : 주황색
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W9Msg", controller);
	Cash_Log();
}

quest
qUseItem1004043()               // 외치기 뿔피리 : 체리핑크
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W13Msg", controller);
	Cash_Log();
}

quest
qUseItem1004044()               // 외치기 뿔피리 : 초록색 클릭
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W4Msg", controller);
	Cash_Log();
}

quest
qUseItem1004045()               // 외치기 뿔피리 : 노란색 클릭
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W6Msg", controller);
	Cash_Log();
}

quest
qUseItem1004046()               // 외치기 뿔피리 : 분홍색 클릭
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W10Msg", controller);
	Cash_Log();
}

quest
qUseItem1004047()               // 외치기 뿔피리 : 하늘색 클릭
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W2Msg", controller);
	Cash_Log();
}

quest
qUseItem1004048()               // 외치기 뿔피리 : 주황색 클릭
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W8Msg", controller);
	Cash_Log();
}

quest
qUseItem1004049()               // 외치기 뿔피리 : 체리핑크 클릭
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W12Msg", controller);
	Cash_Log();
}

quest
qUseItem1004050()               // 외치기 뿔피리 : 그라데이션1
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W101Msg", controller);
	Cash_Log();
}

quest
qUseItem1004051()               // 외치기 뿔피리 : 그라데이션1 클릭
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W100Msg", controller);
	Cash_Log();
}

quest
qUseItem1004052()               // 외치기 뿔피리 : 하얀색
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W1Msg", controller);
	Cash_Log();
}

quest
qUseItem1004053()               // 외치기 뿔피리 : 하얀색 클릭
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W0Msg", controller);
	Cash_Log();
}

quest
qUseItem1004540()               // 외치기 뿔피리 : 그라데이션2 클릭
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W102Msg", controller);
	Cash_Log();
}

quest
qUseItem1004054()               // 외치기 뿔피리 : 익명 / 그라데이션2
{
	if(!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_SHOUTSCROLL_GET_MESSAGE, "W103Msg", controller);
	Cash_Log();
}


quest
qUseItem1004541()		// 펫 영양간식
{
	object inventory;
	inventory = trigger.getPetInventory();

	if(!NormalItemCanBeUsed()) return;

	if (trigger.getPet())
	{
		// 10000 = 100%
		//  5100 = 51%
		inventory.setSanitation(10000);	// 펫 청결도 Set 100%
		inventory.setNutrition(10000);	// 펫 영양도 Set 100%
	}
	else if (inventory.isEggInIncubator())
	{
		// 10000 = 100%
		//  5100 = 51%
		inventory.setSanitation(7000);	// 펫알 청결도 Set 70%
		inventory.setNutrition(7000);	// 펫알 영양도 Set 70%
	}
	else
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);					// 펫이 없다는 메시지
		return;
	}

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1003048()		// 부화 단축의 스크롤 (5시간)
{
	object	petInventory;
	integer cRatio;

	petInventory = trigger.getPetInventory();

	// 유저 데이터에 저장되는 영양도 값은 실제값보다 100배 : 나누기 100을 해주어야 정상값이 나온다.
	cRatio = petInventory.nutrition() / 100;

	if (!NormalItemCanBeUsed()) return;

	if (trigger.hasPet()) {
		trigger.message(TEXT_PET_HAS_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if (!petInventory.isEggInIncubator()) {
		trigger.message(TEXT_INCUBATOR_EGG_NOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (petInventory.eggMaxNutritionRatio() < cRatio)
	{
		trigger.message(TEXT_PET_RATIO_MAX1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PET_RATIO_MAX2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PET_RATIO_MAX_MIN, MSG_TYPE__SYSTEM);
		return;
	}

	if (petInventory.eggMinNutritionRatio() > cRatio)
	{
		trigger.message(TEXT_PET_RATIO_MIN1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PET_RATIO_MIN2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PET_RATIO_MAX_MIN, MSG_TYPE__SYSTEM);
		return;
	}

	// 60(초) * 60(분) = 3600(1시간) : 18000 = 3600 * 5
	if(petInventory.remainTime() <= 18000)
		petInventory.setRemainTime(10);
	else if (petInventory.remainTime() > 18000)
		petInventory.setRemainTime(petInventory.remainTime() - 18000);

	// decrease number
	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.message(TEXT_PET_INCUBATION_SHORT, MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1004529()		// 몬스터 생성 아이템
{
	integer rval, mx, my;
	integer wNum;

	mx =  trigger.getX();
	my =  trigger.getY();

	if (!NormalItemCanBeUsed()) return;

	// 싸움 가능 지역이 아닌 경우 체크
	if(!trigger.getWorld().canFight() || trigger.getWorld().isEventWorld()) {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	// 튜토리얼 맵에서 사용 불가
	if (wNum == 718 || wNum == 719 || wNum == 720 || wNum == 721)
	{
		trigger.message(TEXT_CASHITEM_NOT_USE_FIELD, MSG_TYPE__SYSTEM);
		return;
	}

	// 초보자 던전 및 튜토리얼 대기실 에서 사용 불가능
	if (wNum == 422 || wNum == 423 || wNum == 424 || wNum == 203)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 도플갱어 숲 로비에서 사용 불가능
	if(wNum == 178 || wNum == 179 || wNum == 180)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 요새에서 사용 불가능
	if(wNum == 46 || wNum == 53 || wNum == 59 || wNum == 93 || wNum == 98 || wNum == 115 ||
	   wNum == 116 || wNum == 348 || wNum == 387 || wNum == 388 || wNum == 389 || wNum == 390 ||
	   wNum == 417 || wNum == 282 || wNum == 283 || wNum == 284 || wNum == 285 || wNum == 286 ||
	   wNum == 287 || wNum == 288 || wNum == 289 || wNum == 290)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 크라이덴 1, 7, 페나인 숲 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 셀바스 평원 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 길이 좁은 연결통 맵
	if(wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	rval = Util.random(1, 1000);

	// 4%	젤리삐
	if(rval >= 960)
	{
		trigger.getWorld().genMonster("2100009", 1, "twJellypi.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 4%	리프젤리삐
	else if(rval >= 920)
	{
		trigger.getWorld().genMonster("2100023", 1, "twGrJellypiL.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 4%	프레타
	else if(rval >= 880)
	{
		trigger.getWorld().genMonster("2100003", 1, "twFreta.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 4%	덕 워리어
	else if(rval >= 840)
	{
		trigger.getWorld().genMonster("2100048", 1, "twDuckWarrior.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 4%	스쿠프
	else if(rval >= 800)
	{
		trigger.getWorld().genMonster("2100011", 1, "twScoop.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 4%	미네
	else if(rval >= 760)
	{
		trigger.getWorld().genMonster("2100019", 1, "twMine.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 4%	말벌
	else if(rval >= 720)
	{
		trigger.getWorld().genMonster("2100052", 1, "twHorseBee.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 4%	이파리맨
	else if(rval >= 680)
	{
		trigger.getWorld().genMonster("2100057", 1, "twIpariMan.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 4%	돌 골렘
	else if(rval >= 640)
	{
		trigger.getWorld().genMonster("2100058", 1, "twDolGolem.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 4%	스콜피온
	else if(rval >= 600)
	{
		trigger.getWorld().genMonster("2100061", 1, "twGrScorpion.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	허니베어
	else if(rval >= 570)
	{
		trigger.getWorld().genMonster("2100004", 1, "twHoneyBear.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	카니보레
	else if(rval >= 540)
	{
		trigger.getWorld().genMonster("2100020", 1, "twKaniBore.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	로글베글
	else if(rval >= 510)
	{
		trigger.getWorld().genMonster("2100018", 1, "twRogleBegle.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	베이빙
	else if(rval >= 480)
	{
		trigger.getWorld().genMonster("2100035", 1, "twBaybing.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	크레미노
	else if(rval >= 450)
	{
		trigger.getWorld().genMonster("2100042", 1, "twCramino.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	꿀벌
	else if(rval >= 420)
	{
		trigger.getWorld().genMonster("2100044", 1, "twHoneyBee.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	고무버블
	else if(rval >= 390)
	{
		trigger.getWorld().genMonster("2100068", 1, "twRubberTick.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	미라꿀
	else if(rval >= 360)
	{
		trigger.getWorld().genMonster("2100069", 1, "twBearPig.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	웜
	else if(rval >= 330)
	{
		trigger.getWorld().genMonster("2100095", 1, "twWorm.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	엘리멘탈
	else if(rval >= 300)
	{
		trigger.getWorld().genMonster("2100096", 1, "twElemental.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	미스틱 스워드
	else if(rval >= 270)
	{
		trigger.getWorld().genMonster("2100097", 1, "twSword.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	심퉁
	else if(rval >= 240)
	{
		trigger.getWorld().genMonster("2100010", 1, "twSimTong.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	샤피어
	else if(rval >= 210)
	{
		trigger.getWorld().genMonster("2100014", 1, "twSyaPeer.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	소라캡
	else if(rval >= 180)
	{
		trigger.getWorld().genMonster("2100041", 1, "twSoraCap.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	아레네
	else if(rval >= 150)
	{
		trigger.getWorld().genMonster("2100040", 1, "twAraene.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	케이브 도그
	else if(rval >= 120)
	{
		trigger.getWorld().genMonster("2100056", 1, "twCaveDog.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	덕워리어 던전
	else if(rval >= 90)
	{
		trigger.getWorld().genMonster("2100047", 1, "twDuckWarriorD.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	스노우 무스켈
	else if(rval >= 60)
	{
		trigger.getWorld().genMonster("2100091", 1, "twSnowMuskell.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	벳 블로우
	else if(rval >= 30)
	{
		trigger.getWorld().genMonster("2100092", 1, "twBatBlow.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 3%	피콕
	else
	{
		trigger.getWorld().genMonster("2100093", 1, "twPicok.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}


////////////////////////////////////////////////
// 유료 아이템 전용 퀘스트
////////////////////////////////////////////////

quest
qUseItem1003370()				// 진명 각인 스크롤 버전1
{
	object item;
	string aName, cName;
	integer cValue;
	item = controller.getObjectArgumentAt(0);

	if (!NormalItemCanBeUsed()) return;
	if (!item || !item.isEquippable())	return;
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	cName = item.getClassName();
	aName = Item.getDescClassNamed(cName);
	cValue = String.toInteger(cName);

	if (cValue >= 1002703 && cValue <= 1002753)
		item.setUserDefinedName(trigger.getName() + TEXT_SUBFIX_OF + String.split(" ", 1, aName));
	else
		item.setUserDefinedName(trigger.getName() + TEXT_SUBFIX_OF + aName);

	trigger.message(TEXT_USABLEITEM_SET_NAME, MSG_TYPE__SYSTEM);
	trigger.message(TEXT_CASH_OVERWRITE, MSG_TYPE__SYSTEM);

	controller.effectBy(trigger);

	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
}


quest
SetNamed()
{
	string bName;
	bName = "ⓢ" + Util.filterCurse(trigger.getQuestArgument());

	if (String.length(bName) > 30)
		trigger.message(TEXT_CASH_SIZEOVER, MSG_TYPE__SYSTEM);
	else {
	    trigger.setCookie("SetCN", bName, 0);
		trigger.message(TEXT_CASH_SETNAMED, MSG_TYPE__SYSTEM);
	}
}


quest
qUseItem1003372()				// 진명 각인 스크롤 버전2 이름 입력
{
	object item;
	string aName;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	if (!item || !item.isEquippable())	return;

	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().isEventWorld()) {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}
	
	aName = trigger.getCookie("SetCN");

	if (aName != null) {
		item.setUserDefinedName(aName);
		trigger.message(TEXT_USABLEITEM_SET_NAME, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_CASH_OVERWRITE, MSG_TYPE__SYSTEM);

		trigger.resetCookie("SetCN");

		controller.effectBy(trigger);

		if (controller.canBeExhausted())
		    controller.decreaseNumber(1);
		Cash_Log();

	} else {
		trigger.sendDescribeQuestMessage(TEXT_CASH_REAL_NAME, "SetNamed", controller);
	}
}


quest
qUseItem1004033()		// 몬스터 소환카드 (초보자)
{
	object mapValue;
	integer rval, mx, my;
	integer wNum;

	mapValue = trigger.getWorld();

	mx =  trigger.getX();
	my =  trigger.getY();

	if (!NormalItemCanBeUsed()) return;

	// 싸움 가능 지역이 아닌 경우 체크즈
	if(!mapValue.canFight() || mapValue.isEventWorld()) {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 사용 불가능 특정 지역 체크
	wNum = mapValue.getNumber();

	// 튜토리얼 맵에서 사용 불가
	if (wNum == 718 || wNum == 719 || wNum == 720 || wNum == 721)
	{
		trigger.message(TEXT_CASHITEM_NOT_USE_FIELD, MSG_TYPE__SYSTEM);
		return;
	}

	// 초보자 던전 및 튜토리얼 대기실 에서 사용 불가능
	if (wNum == 422 || wNum == 423 || wNum == 424 || wNum == 203)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 도플갱어 숲 로비에서 사용 불가능
	if(wNum == 178 || wNum == 179 || wNum == 180)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 요새에서 사용 불가능
	if(wNum == 46 || wNum == 53 || wNum == 59 || wNum == 93 || wNum == 98 || wNum == 115 ||
	   wNum == 116 || wNum == 348 || wNum == 387 || wNum == 388 || wNum == 389 || wNum == 390 ||
	   wNum == 417 || wNum == 282 || wNum == 283 || wNum == 284 || wNum == 285 || wNum == 286 ||
	   wNum == 287 || wNum == 288 || wNum == 289 || wNum == 290)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 크라이덴 1, 7, 페나인 숲 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 셀바스 평원 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 길이 좁은 연결통 맵
	if(wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	if (Util.getRealNationType() == JAPAN)		// vahma - japan setting
	{
	    if(wNum == 176 || wNum == 177 || wNum == 189 || wNum == 190)
	    {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	    }
	}

	rval = Util.random(0, 999);

	// 10%	젤리삐
	if(rval >= 900)
	{
		mapValue.genMonster("2100009", 1, "twJellypi.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	프레타
	else if(rval >= 800)
	{
		mapValue.genMonster("2100003", 1, "twFreta.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	심퉁
	else if(rval >= 700)
	{
		mapValue.genMonster("2100010", 1, "twSimTong.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	핸드
	else if(rval >= 600)
	{
		mapValue.genMonster("2100015", 1, "twHand.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	무투호
	else if(rval >= 500)
	{
		mapValue.genMonster("2100024", 1, "twMutuho.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	덕워리어 필드
	else if(rval >= 400)
	{
		mapValue.genMonster("2100048", 1, "twDuckWarrior.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	피켈
	else if(rval >= 300)
	{
		mapValue.genMonster("2100255", 1, "twPikel_Field.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	크리스탈 골렘
	else if(rval >= 200)
	{
		mapValue.genMonster("2100102", 1, "twCrystalGolem.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	사이몬
	else if(rval >= 100)
	{
		mapValue.genMonster("2100082", 1, "twCymon.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	스키아
	else
	{
		mapValue.genMonster("2100033", 1, "twSkiya.ptn", 1, mx-10, my-10, mx+10, my+10);
	}

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1004034()		// 몬스터 소환카드 (중급자)
{
	object mapValue;
	integer rval, mx, my;
	integer wNum;

	mapValue = trigger.getWorld();

	mx =  trigger.getX();
	my =  trigger.getY();

	if (!NormalItemCanBeUsed()) return;

	// 싸움 가능 지역이 아닌 경우 체크
	if(!mapValue.canFight() || mapValue.isEventWorld()) {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 사용 불가능 특정 지역 체크
	wNum = mapValue.getNumber();

	// 튜토리얼 맵에서 사용 불가
	if (wNum == 718 || wNum == 719 || wNum == 720 || wNum == 721)
	{
		trigger.message(TEXT_CASHITEM_NOT_USE_FIELD, MSG_TYPE__SYSTEM);
		return;
	}

	// 초보자 던전 및 튜토리얼 대기실 에서 사용 불가능
	if (wNum == 422 || wNum == 423 || wNum == 424 || wNum == 203)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 도플갱어 숲 로비에서 사용 불가능
	if(wNum == 178 || wNum == 179 || wNum == 180)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 요새에서 사용 불가능
	if(wNum == 46 || wNum == 53 || wNum == 59 || wNum == 93 || wNum == 98 || wNum == 115 ||
	   wNum == 116 || wNum == 348 || wNum == 387 || wNum == 388 || wNum == 389 || wNum == 390 ||
	   wNum == 417 || wNum == 282 || wNum == 283 || wNum == 284 || wNum == 285 || wNum == 286 ||
	   wNum == 287 || wNum == 288 || wNum == 289 || wNum == 290)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 크라이덴 1, 7, 페나인 숲 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 셀바스 평원 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 길이 좁은 연결통 맵
	if(wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}
	
	if (Util.getRealNationType() == JAPAN)		// vahma - japan setting
	{
	    if(wNum == 176 || wNum == 177 || wNum == 189 || wNum == 190)
	    {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	    }
	}

	rval = Util.random(0, 999);

	// 10%	샌드웜
	if(rval >= 900)
	{
		mapValue.genMonster("2100095", 1, "twWorm.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	플래임 샤피어
	else if(rval >= 800)
	{
		mapValue.genMonster("2100122", 1, "twFSyapeer.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	스피켈
	else if(rval >= 700)
	{
		mapValue.genMonster("2100292", 1, "twPikel_welter.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	기간틱 솔져
	else if(rval >= 600)
	{
		mapValue.genMonster("2100103", 1, "twGsolider.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	시클랜서 이등병
	else if(rval >= 500)
	{
		mapValue.genMonster("2100340", 1, "twSickleLance_11.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	개틀링 캐논
	else if(rval >= 400)
	{
		mapValue.genMonster("2100220", 1, "twTrap.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	하동
	else if(rval >= 300)
	{
		mapValue.genMonster("2100521", 1, "twDec10_Hadong.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	데블패러딘
	else if(rval >= 200)
	{
		mapValue.genMonster("2100298", 1, "twDevilPaladin.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	미스틱 스워드
//	else if(rval >= 100)		// vahma - temporary japan setting
	{
		mapValue.genMonster("2100097", 1, "twSword.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	점핑 퍼핏
/*	vahma - temporary japan setting
	else
	{
		mapValue.genMonster("2100519", 1, "twDec10_JumpingPuppy.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
*/

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1004035()		// 몬스터 소환카드 (상급자)
{
	object mapValue;
	integer rval, mx, my;
	integer wNum;

	mapValue = trigger.getWorld();

	mx =  trigger.getX();
	my =  trigger.getY();

	if (!NormalItemCanBeUsed()) return;

	// 싸움 가능 지역이 아닌 경우 체크
	if(!mapValue.canFight() || mapValue.isEventWorld()) {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 사용 불가능 특정 지역 체크
	wNum = mapValue.getNumber();

	// 튜토리얼 맵에서 사용 불가
	if (wNum == 718 || wNum == 719 || wNum == 720 || wNum == 721)
	{
		trigger.message(TEXT_CASHITEM_NOT_USE_FIELD, MSG_TYPE__SYSTEM);
		return;
	}

	// 초보자 던전 및 튜토리얼 대기실 에서 사용 불가능
	if (wNum == 422 || wNum == 423 || wNum == 424 || wNum == 203)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 도플갱어 숲 로비에서 사용 불가능
	if(wNum == 178 || wNum == 179 || wNum == 180)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 요새에서 사용 불가능
	if(wNum == 46 || wNum == 53 || wNum == 59 || wNum == 93 || wNum == 98 || wNum == 115 ||
	   wNum == 116 || wNum == 348 || wNum == 387 || wNum == 388 || wNum == 389 || wNum == 390 ||
	   wNum == 417 || wNum == 282 || wNum == 283 || wNum == 284 || wNum == 285 || wNum == 286 ||
	   wNum == 287 || wNum == 288 || wNum == 289 || wNum == 290)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 크라이덴 1, 7, 페나인 숲 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 셀바스 평원 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 길이 좁은 연결통 맵
	if(wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	if (Util.getRealNationType() == JAPAN)		// vahma - japan setting
	{
	    if(wNum == 176 || wNum == 177 || wNum == 189 || wNum == 190)
	    {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	    }
	}

	rval = Util.random(0, 999);

	// 10%	카벙클
	if(rval >= 900)
	{
		mapValue.genMonster("2100575", 1, "twMar03_Carbuncle.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	기가메우라
	else if(rval >= 800)
	{
		mapValue.genMonster("2100549", 1, "twFeb17_Gigameura.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	치우
	else if(rval >= 700)
	{
		mapValue.genMonster("2100595", 1, "twMay18_DoggaebiCiu.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	하드펀처
	else if(rval >= 600)
	{
		mapValue.genMonster("2100550", 1, "twFeb17_HardPuncher.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	레물레스
	else if(rval >= 500)
	{
		mapValue.genMonster("2100258", 1, "twLemures.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	발칸캐논
	else if(rval >= 400)
	{
		mapValue.genMonster("2100383", 1, "twValkan.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	알루코
	else if(rval >= 300)
	{
		mapValue.genMonster("2100553", 1, "twFeb22_Alruko.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	드라군
	else if(rval >= 200)
	{
		mapValue.genMonster("2100212", 1, "twDragon.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	계도인
	else if(rval >= 100)
	{
		mapValue.genMonster("2100555", 1, "twFeb22_TaoistChicken.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 10%	크리스탈 트럼프 돌
	else
	{
		mapValue.genMonster("2100341", 1, "twTrumpDoll_Cry.ptn", 1, mx-10, my-10, mx+10, my+10);
	}

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1004036()		// 몬스터 소환카드 (고급)
{
	object mapValue;
	integer rval, mx, my;
	integer wNum;

	mapValue = trigger.getWorld();

	mx =  trigger.getX();
	my =  trigger.getY();

	if (!NormalItemCanBeUsed()) return;

	// 싸움 가능 지역이 아닌 경우 체크
	if(!mapValue.canFight() || mapValue.isEventWorld()) {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 사용 불가능 특정 지역 체크
	wNum = mapValue.getNumber();

	// 튜토리얼 맵에서 사용 불가
	if (wNum == 718 || wNum == 719 || wNum == 720 || wNum == 721)
	{
		trigger.message(TEXT_CASHITEM_NOT_USE_FIELD, MSG_TYPE__SYSTEM);
		return;
	}

	// 초보자 던전 및 튜토리얼 대기실 에서 사용 불가능
	if (wNum == 422 || wNum == 423 || wNum == 424 || wNum == 203)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// 도플갱어 숲 로비에서 사용 불가능
	if(wNum == 178 || wNum == 179 || wNum == 180)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 요새에서 사용 불가능
	if(wNum == 46 || wNum == 53 || wNum == 59 || wNum == 93 || wNum == 98 || wNum == 115 ||
	   wNum == 116 || wNum == 348 || wNum == 387 || wNum == 388 || wNum == 389 || wNum == 390 ||
	   wNum == 417 || wNum == 282 || wNum == 283 || wNum == 284 || wNum == 285 || wNum == 286 ||
	   wNum == 287 || wNum == 288 || wNum == 289 || wNum == 290)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 크라이덴 1, 7, 페나인 숲 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 셀바스 평원 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// 길이 좁은 연결통 맵
	if(wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	}

	if (Util.getRealNationType() == JAPAN)		// vahma - japan setting
	{
	    if(wNum == 176 || wNum == 177 || wNum == 189 || wNum == 190)
	    {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		trigger.message(mapValue.getName(), MSG_TYPE__SYSTEM);
		return;
	    }
	}
// vahma - japan settings for probability
	rval = Util.random(0, 950);

	if(rval == 950)		// vahma - japan setting
	{
	    mapValue.genMonster("2100094", 1, "twGram.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	금령시
	if(rval >= 900)		// vahma - japan setting
	{
		mapValue.genMonster("2100596", 1, "twMay23_KangSheeBoss.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	독각귀
	else if(rval >= 850)
	{
		mapValue.genMonster("2100593", 1, "twMay18_DoggaebiBoss.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	흑랑
	else if(rval >= 800)
	{
		mapValue.genMonster("2100578", 1, "twApr14_HadesEnvoy.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	가시무시
	else if(rval >= 750)
	{
		mapValue.genMonster("2100627", 1, "twJul15_KasiMusi.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	크레미노 타투
	else if(rval >= 700)
	{
		mapValue.genMonster("2100524", 1, "twDec15_CraminoTatu.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	엔피니온
	else if(rval >= 650)
	{
		mapValue.genMonster("2100109", 1, "twEnvinion.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	포세이른
	else if(rval >= 600)
	{
		mapValue.genMonster("2100193", 1, "twPoseidon.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	유니비
	else if(rval >= 550)
	{
		mapValue.genMonster("2100386", 1, "twUnibi.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	뚜뚜 킹
	else if(rval >= 500)
	{
		mapValue.genMonster("2100194", 1, "twDduKing.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	뚜뚜 퀸
	else if(rval >= 450)
	{
		mapValue.genMonster("2100195", 1, "twDduQueen.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	데스 프레타
	else if(rval >= 400)
	{
		mapValue.genMonster("2100118", 1, "twFretaDeath.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	진 아지다하카
	else if(rval >= 350)
	{
		mapValue.genMonster("2100119", 1, "twAzidahaka_J.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	랏 펌프킨
	else if(rval >= 300)
	{
		mapValue.genMonster("2100123", 1, "twPumkinRot.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	데블 제너럴
	else if(rval >= 200)
	{
		mapValue.genMonster("2100359", 1, "twDGeneral.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	호검희
	else if(rval >= 150)
	{
		mapValue.genMonster("2100557", 1, "twFeb22_SwordShaman.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	블러디 돌
	else if(rval >= 100)
	{
		mapValue.genMonster("2100221", 1, "twMechanic.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	이블헤어
	else if(rval >= 50)
	{
		mapValue.genMonster("2100533", 1, "twJan11_EvilHair.ptn", 1, mx-10, my-10, mx+10, my+10);
	}
	// 5%	캣핸즈
	else
	{
		mapValue.genMonster("2100534", 1, "twJan14_CatHand.ptn", 1, mx-10, my-10, mx+10, my+10);
	}

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1004037()		// 펫 가사상태 회복
{
	object pet;

	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(pet)
	{
		if(!pet.resurrectPaidPet())
		{
			trigger.message(TEXT_PET_APPARENT_DEATH, MSG_TYPE__SYSTEM);
			return;
		}
	}
	else
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);		// 펫이 없다는 메시지
		return;
	}

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1004542()		// 부활 포션 (100%)
{
	integer wNum;

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	// PVP 이벤트 지역
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.isDead())
	{
		trigger.resurrect(false);
		trigger.setHP(trigger.getMaxHP());

		trigger.castNamedWithDuration("3000212", 60);
		trigger.castNamedWithDuration("3000210", 180);

		// send using effect
		controller.effectBy(trigger);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else if (trigger.getHP() <= 0)
	{
		trigger.resurrect(false);
		trigger.setHP(trigger.getMaxHP());

		trigger.castNamedWithDuration("3000212", 60);
		trigger.castNamedWithDuration("3000210", 180);

		// send using effect
		controller.effectBy(trigger);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else
	{
		trigger.message(TEXT_NOT_RESURRECTION, MSG_TYPE__SYSTEM);
		return;
	}
}

quest
qUseItem1004651()		// 부활 포션 (70%)
{
	integer tempHp;
	integer wNum;

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	// PVP 이벤트 지역
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, MSG_TYPE__SYSTEM);
		return;
	}

	tempHp = trigger.getMaxHP() * 70 / 100;

	if (trigger.isDead())
	{
		trigger.resurrect(false);
		trigger.setHP(tempHp);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else if (trigger.getHP() <= 0)
	{
		trigger.resurrect(false);
		trigger.setHP(tempHp);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else
	{
		trigger.message(TEXT_NOT_RESURRECTION, MSG_TYPE__SYSTEM);
		return;
	}
}

quest
qUseItem1004652()		// 부활 포션 (40%)
{
	integer tempHp;
	integer wNum;

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	// PVP 이벤트 지역
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, MSG_TYPE__SYSTEM);
		return;
	}

	tempHp = trigger.getMaxHP() * 40 / 100;

	if (trigger.isDead())
	{
		trigger.resurrect(false);
		trigger.setHP(tempHp);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else if (trigger.getHP() <= 0)
	{
		trigger.resurrect(false);
		trigger.setHP(tempHp);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else
	{
		trigger.message(TEXT_NOT_RESURRECTION, MSG_TYPE__SYSTEM);
		return;
	}
}

quest
qUseItem1004653()		// 부활 포션 (10%)
{
	integer tempHp;
	integer wNum;

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	// PVP 이벤트 지역
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, MSG_TYPE__SYSTEM);
		return;
	}

	tempHp = trigger.getMaxHP() * 10 / 100;

	if (trigger.isDead())
	{
		trigger.resurrect(false);
		trigger.setHP(tempHp);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else if (trigger.getHP() <= 0)
	{
		trigger.resurrect(false);
		trigger.setHP(tempHp);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else
	{
		trigger.message(TEXT_NOT_RESURRECTION, MSG_TYPE__SYSTEM);
		return;
	}
}

quest qUseItem1004079()		// 파티 폭죽
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
	// send using effect
	controller.effectBy(trigger);
}


//******************************************************
// 캐릭터 레인보우 염색약
// 2006.01.04 written by Han
//******************************************************

quest qUseItem1001606()		// 루시안 머리 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  1);
		trigger.message(CHAR0_RAINBOW_HAIR_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  2);
		trigger.message(CHAR0_RAINBOW_HAIR_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  3);
		trigger.message(CHAR0_RAINBOW_HAIR_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  4);
		trigger.message(CHAR0_RAINBOW_HAIR_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  5);
		trigger.message(CHAR0_RAINBOW_HAIR_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  6);
		trigger.message(CHAR0_RAINBOW_HAIR_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_HAIR,  7);
		trigger.message(CHAR0_RAINBOW_HAIR_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001607()		// 루시안 옷 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  1);
		trigger.message(CHAR0_RAINBOW_BODY_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  2);
		trigger.message(CHAR0_RAINBOW_BODY_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  3);
		trigger.message(CHAR0_RAINBOW_BODY_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  4);
		trigger.message(CHAR0_RAINBOW_BODY_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  5);
		trigger.message(CHAR0_RAINBOW_BODY_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  6);
		trigger.message(CHAR0_RAINBOW_BODY_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_BODY,  7);
		trigger.message(CHAR0_RAINBOW_BODY_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001608()		// 루시안 잡화 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  1);
		trigger.message(CHAR0_RAINBOW_ACCE1_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  2);
		trigger.message(CHAR0_RAINBOW_ACCE1_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  3);
		trigger.message(CHAR0_RAINBOW_ACCE1_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  4);
		trigger.message(CHAR0_RAINBOW_ACCE1_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  5);
		trigger.message(CHAR0_RAINBOW_ACCE1_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  6);
		trigger.message(CHAR0_RAINBOW_ACCE1_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY1,  7);
		trigger.message(CHAR0_RAINBOW_ACCE1_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001609()		// 루시안 바지 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  1);
		trigger.message(CHAR0_RAINBOW_ACCE2_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  2);
		trigger.message(CHAR0_RAINBOW_ACCE2_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  3);
		trigger.message(CHAR0_RAINBOW_ACCE2_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  4);
		trigger.message(CHAR0_RAINBOW_ACCE2_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  5);
		trigger.message(CHAR0_RAINBOW_ACCE2_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  6);
		trigger.message(CHAR0_RAINBOW_ACCE2_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE0, USER_COLOR_ACCESSORY3,  7);
		trigger.message(CHAR0_RAINBOW_ACCE2_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001610()		// 보리스 머리 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  1);
		trigger.message(CHAR1_RAINBOW_HAIR_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  2);
		trigger.message(CHAR1_RAINBOW_HAIR_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  3);
		trigger.message(CHAR1_RAINBOW_HAIR_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  4);
		trigger.message(CHAR1_RAINBOW_HAIR_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  5);
		trigger.message(CHAR1_RAINBOW_HAIR_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  6);
		trigger.message(CHAR1_RAINBOW_HAIR_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_HAIR,  7);
		trigger.message(CHAR1_RAINBOW_HAIR_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001611()		// 보리스 옷 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  1);
		trigger.message(CHAR1_RAINBOW_BODY_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  2);
		trigger.message(CHAR1_RAINBOW_BODY_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  3);
		trigger.message(CHAR1_RAINBOW_BODY_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  4);
		trigger.message(CHAR1_RAINBOW_BODY_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  5);
		trigger.message(CHAR1_RAINBOW_BODY_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  6);
		trigger.message(CHAR1_RAINBOW_BODY_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_BODY,  7);
		trigger.message(CHAR1_RAINBOW_BODY_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001612()		// 보리스 벨트 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  1);
		trigger.message(CHAR1_RAINBOW_ACCE1_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  2);
		trigger.message(CHAR1_RAINBOW_ACCE1_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  3);
		trigger.message(CHAR1_RAINBOW_ACCE1_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  4);
		trigger.message(CHAR1_RAINBOW_ACCE1_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  5);
		trigger.message(CHAR1_RAINBOW_ACCE1_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  6);
		trigger.message(CHAR1_RAINBOW_ACCE1_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE1, USER_COLOR_ACCESSORY1,  7);
		trigger.message(CHAR1_RAINBOW_ACCE1_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001613()		// 막시민 머리 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  1);
		trigger.message(CHAR2_RAINBOW_HAIR_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  2);
		trigger.message(CHAR2_RAINBOW_HAIR_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  3);
		trigger.message(CHAR2_RAINBOW_HAIR_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  4);
		trigger.message(CHAR2_RAINBOW_HAIR_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  5);
		trigger.message(CHAR2_RAINBOW_HAIR_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  6);
		trigger.message(CHAR2_RAINBOW_HAIR_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_HAIR,  7);
		trigger.message(CHAR2_RAINBOW_HAIR_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001614()		// 막시민 옷 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  1);
		trigger.message(CHAR2_RAINBOW_BODY_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  2);
		trigger.message(CHAR2_RAINBOW_BODY_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  3);
		trigger.message(CHAR2_RAINBOW_BODY_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  4);
		trigger.message(CHAR2_RAINBOW_BODY_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  5);
		trigger.message(CHAR2_RAINBOW_BODY_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  6);
		trigger.message(CHAR2_RAINBOW_BODY_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_BODY,  7);
		trigger.message(CHAR2_RAINBOW_BODY_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001615()		// 막시민 바지 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  1);
		trigger.message(CHAR2_RAINBOW_ACCE1_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  2);
		trigger.message(CHAR2_RAINBOW_ACCE1_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  3);
		trigger.message(CHAR2_RAINBOW_ACCE1_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  4);
		trigger.message(CHAR2_RAINBOW_ACCE1_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  5);
		trigger.message(CHAR2_RAINBOW_ACCE1_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  6);
		trigger.message(CHAR2_RAINBOW_ACCE1_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE2, USER_COLOR_ACCESSORY1,  7);
		trigger.message(CHAR2_RAINBOW_ACCE1_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001616()		// 시벨린 머리 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  1);
		trigger.message(CHAR3_RAINBOW_HAIR_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  2);
		trigger.message(CHAR3_RAINBOW_HAIR_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  3);
		trigger.message(CHAR3_RAINBOW_HAIR_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  4);
		trigger.message(CHAR3_RAINBOW_HAIR_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  5);
		trigger.message(CHAR3_RAINBOW_HAIR_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  6);
		trigger.message(CHAR3_RAINBOW_HAIR_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_HAIR,  7);
		trigger.message(CHAR3_RAINBOW_HAIR_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001617()		// 시벨린 바지 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  1);
		trigger.message(CHAR3_RAINBOW_BODY_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  2);
		trigger.message(CHAR3_RAINBOW_BODY_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  3);
		trigger.message(CHAR3_RAINBOW_BODY_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  4);
		trigger.message(CHAR3_RAINBOW_BODY_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  5);
		trigger.message(CHAR3_RAINBOW_BODY_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  6);
		trigger.message(CHAR3_RAINBOW_BODY_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_BODY,  7);
		trigger.message(CHAR3_RAINBOW_BODY_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001618()		// 시벨린 옷 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  1);
		trigger.message(CHAR3_RAINBOW_ACCE1_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  2);
		trigger.message(CHAR3_RAINBOW_ACCE1_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  3);
		trigger.message(CHAR3_RAINBOW_ACCE1_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  4);
		trigger.message(CHAR3_RAINBOW_ACCE1_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  5);
		trigger.message(CHAR3_RAINBOW_ACCE1_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  6);
		trigger.message(CHAR3_RAINBOW_ACCE1_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE3, USER_COLOR_ACCESSORY1,  7);
		trigger.message(CHAR3_RAINBOW_ACCE1_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001619()		// 밀라 머리 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  1);
		trigger.message(CHAR7_RAINBOW_HAIR_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  2);
		trigger.message(CHAR7_RAINBOW_HAIR_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  3);
		trigger.message(CHAR7_RAINBOW_HAIR_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  4);
		trigger.message(CHAR7_RAINBOW_HAIR_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  5);
		trigger.message(CHAR7_RAINBOW_HAIR_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  6);
		trigger.message(CHAR7_RAINBOW_HAIR_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_HAIR,  7);
		trigger.message(CHAR7_RAINBOW_HAIR_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001620()		// 밀라 옷 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  1);
		trigger.message(CHAR7_RAINBOW_BODY_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  2);
		trigger.message(CHAR7_RAINBOW_BODY_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  3);
		trigger.message(CHAR7_RAINBOW_BODY_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  4);
		trigger.message(CHAR7_RAINBOW_BODY_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  5);
		trigger.message(CHAR7_RAINBOW_BODY_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  6);
		trigger.message(CHAR7_RAINBOW_BODY_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_BODY,  7);
		trigger.message(CHAR7_RAINBOW_BODY_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001621()		// 밀라 벨트 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  1);
		trigger.message(CHAR7_RAINBOW_ACCE1_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  2);
		trigger.message(CHAR7_RAINBOW_ACCE1_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  3);
		trigger.message(CHAR7_RAINBOW_ACCE1_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  4);
		trigger.message(CHAR7_RAINBOW_ACCE1_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  5);
		trigger.message(CHAR7_RAINBOW_ACCE1_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  6);
		trigger.message(CHAR7_RAINBOW_ACCE1_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY1,  7);
		trigger.message(CHAR7_RAINBOW_ACCE1_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001622()		// 밀라 장갑 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  1);
		trigger.message(CHAR7_RAINBOW_ACCE2_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  2);
		trigger.message(CHAR7_RAINBOW_ACCE2_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  3);
		trigger.message(CHAR7_RAINBOW_ACCE2_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  4);
		trigger.message(CHAR7_RAINBOW_ACCE2_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  5);
		trigger.message(CHAR7_RAINBOW_ACCE2_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  6);
		trigger.message(CHAR7_RAINBOW_ACCE2_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE7, USER_COLOR_ACCESSORY2,  7);
		trigger.message(CHAR7_RAINBOW_ACCE2_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001623()		// 티치엘 머리 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  1);
		trigger.message(CHAR8_RAINBOW_HAIR_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  2);
		trigger.message(CHAR8_RAINBOW_HAIR_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  3);
		trigger.message(CHAR8_RAINBOW_HAIR_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  4);
		trigger.message(CHAR8_RAINBOW_HAIR_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  5);
		trigger.message(CHAR8_RAINBOW_HAIR_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  6);
		trigger.message(CHAR8_RAINBOW_HAIR_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_HAIR,  7);
		trigger.message(CHAR8_RAINBOW_HAIR_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001624()		// 티치엘 옷 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  1);
		trigger.message(CHAR8_RAINBOW_BODY_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  2);
		trigger.message(CHAR8_RAINBOW_BODY_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  3);
		trigger.message(CHAR8_RAINBOW_BODY_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  4);
		trigger.message(CHAR8_RAINBOW_BODY_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  5);
		trigger.message(CHAR8_RAINBOW_BODY_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  6);
		trigger.message(CHAR8_RAINBOW_BODY_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_BODY,  7);
		trigger.message(CHAR8_RAINBOW_BODY_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001625()		// 티치엘 구두 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  1);
		trigger.message(CHAR8_RAINBOW_ACCE1_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  2);
		trigger.message(CHAR8_RAINBOW_ACCE1_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  3);
		trigger.message(CHAR8_RAINBOW_ACCE1_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  4);
		trigger.message(CHAR8_RAINBOW_ACCE1_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  5);
		trigger.message(CHAR8_RAINBOW_ACCE1_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  6);
		trigger.message(CHAR8_RAINBOW_ACCE1_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE8, USER_COLOR_ACCESSORY1,  7);
		trigger.message(CHAR8_RAINBOW_ACCE1_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001626()		// 이스핀 머리 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  1);
		trigger.message(CHAR9_RAINBOW_HAIR_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  2);
		trigger.message(CHAR9_RAINBOW_HAIR_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  3);
		trigger.message(CHAR9_RAINBOW_HAIR_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  4);
		trigger.message(CHAR9_RAINBOW_HAIR_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  5);
		trigger.message(CHAR9_RAINBOW_HAIR_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  6);
		trigger.message(CHAR9_RAINBOW_HAIR_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_HAIR,  7);
		trigger.message(CHAR9_RAINBOW_HAIR_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001627()		// 이스핀 하의 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  1);
		trigger.message(CHAR9_RAINBOW_BODY_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  2);
		trigger.message(CHAR9_RAINBOW_BODY_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  3);
		trigger.message(CHAR9_RAINBOW_BODY_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  4);
		trigger.message(CHAR9_RAINBOW_BODY_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  5);
		trigger.message(CHAR9_RAINBOW_BODY_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  6);
		trigger.message(CHAR9_RAINBOW_BODY_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_BODY,  7);
		trigger.message(CHAR9_RAINBOW_BODY_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001628()		// 이스핀 잡화 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  1);
		trigger.message(CHAR9_RAINBOW_ACCE1_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  2);
		trigger.message(CHAR9_RAINBOW_ACCE1_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  3);
		trigger.message(CHAR9_RAINBOW_ACCE1_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  4);
		trigger.message(CHAR9_RAINBOW_ACCE1_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  5);
		trigger.message(CHAR9_RAINBOW_ACCE1_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  6);
		trigger.message(CHAR9_RAINBOW_ACCE1_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY1,  7);
		trigger.message(CHAR9_RAINBOW_ACCE1_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001629()		// 이스핀 옷 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  1);
		trigger.message(CHAR9_RAINBOW_ACCE2_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  2);
		trigger.message(CHAR9_RAINBOW_ACCE2_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  3);
		trigger.message(CHAR9_RAINBOW_ACCE2_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  4);
		trigger.message(CHAR9_RAINBOW_ACCE2_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  5);
		trigger.message(CHAR9_RAINBOW_ACCE2_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  6);
		trigger.message(CHAR9_RAINBOW_ACCE2_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE9, USER_COLOR_ACCESSORY2,  7);
		trigger.message(CHAR9_RAINBOW_ACCE2_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001630()		// 나야트레이 머리 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  1);
		trigger.message(CHAR10_RAINBOW_HAIR_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  2);
		trigger.message(CHAR10_RAINBOW_HAIR_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  3);
		trigger.message(CHAR10_RAINBOW_HAIR_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  4);
		trigger.message(CHAR10_RAINBOW_HAIR_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  5);
		trigger.message(CHAR10_RAINBOW_HAIR_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  6);
		trigger.message(CHAR10_RAINBOW_HAIR_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_HAIR,  7);
		trigger.message(CHAR10_RAINBOW_HAIR_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001631()		// 나야트레이 외투 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  1);
		trigger.message(CHAR10_RAINBOW_BODY_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  2);
		trigger.message(CHAR10_RAINBOW_BODY_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  3);
		trigger.message(CHAR10_RAINBOW_BODY_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  4);
		trigger.message(CHAR10_RAINBOW_BODY_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  5);
		trigger.message(CHAR10_RAINBOW_BODY_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  6);
		trigger.message(CHAR10_RAINBOW_BODY_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_BODY,  7);
		trigger.message(CHAR10_RAINBOW_BODY_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001632()		// 나야트레이 옷 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  1);
		trigger.message(CHAR10_RAINBOW_ACCE1_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  2);
		trigger.message(CHAR10_RAINBOW_ACCE1_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  3);
		trigger.message(CHAR10_RAINBOW_ACCE1_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  4);
		trigger.message(CHAR10_RAINBOW_ACCE1_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  5);
		trigger.message(CHAR10_RAINBOW_ACCE1_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  6);
		trigger.message(CHAR10_RAINBOW_ACCE1_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY1,  7);
		trigger.message(CHAR10_RAINBOW_ACCE1_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1001633()		// 나야트레이 잡화 염색약
{
	integer cTime, cWeekday;

	if (!NormalItemCanBeUsed()) return;

	cTime = Util.getTick();
	cWeekday = Util.getWday(cTime);

	// 0(일), 1(월), 2(화), 3(수), 4(목), 5(금), 6(토)
	if(cWeekday == 0) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  1);
		trigger.message(CHAR10_RAINBOW_ACCE2_COLOR1, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 1) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  2);
		trigger.message(CHAR10_RAINBOW_ACCE2_COLOR2, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 2) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  3);
		trigger.message(CHAR10_RAINBOW_ACCE2_COLOR3, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 3) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  4);
		trigger.message(CHAR10_RAINBOW_ACCE2_COLOR4, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 4) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  5);
		trigger.message(CHAR10_RAINBOW_ACCE2_COLOR5, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 5) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  6);
		trigger.message(CHAR10_RAINBOW_ACCE2_COLOR6, MSG_TYPE__SYSTEM);
	}
	else if(cWeekday == 6) {
		DyeUserColor(CHAR_TYPE10, USER_COLOR_ACCESSORY2,  7);
		trigger.message(CHAR10_RAINBOW_ACCE2_COLOR7, MSG_TYPE__SYSTEM);
	}

	Cash_Log();
}

quest qUseItem1004095()		// 팀 부활 포션 (100%)
{
	object container, user;
	string useName;
	integer member_cnt, i, j, wNum, cFlag = 0;

	container = Container.create();
	trigger.getTeamMemberTypedToContainer(0, container);
	member_cnt = container.size();

	useName = trigger.getName();

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	// PVP 이벤트 지역
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.hasTeam())
	{
		for (i = 0; i <	member_cnt; ++i)
		{
			user = container.at(i);
			if (wNum == user.getWorld().getNumber())
				if (user.isDead() || user.getHP() <= 0)
					cFlag = 1;
		}

		// 팀원 중 한명이라도 사망했을 때
		if (cFlag == 1)
		{
			for (j = 0; j <	member_cnt; ++j)
			{
				user = container.at(j);
				user.resurrect(false);
				user.setHP(user.getMaxHP());
				user.message("[ " + useName + " ] " + TEXT_USE_TEAM_RESURRECTION, MSG_TYPE__SYSTEM);
				// send using effect
				controller.effectBy(user);
			}
			Cash_Log();
			if (controller.canBeExhausted())
				controller.decreaseNumber(1);
		}
		else
		{
			trigger.message(TEXT_NOT_TEAM_RESURRECTION, MSG_TYPE__SYSTEM);
			return;
		}
	}
	else
	{
		if (trigger.isDead())
		{
			trigger.resurrect(false);
			trigger.setHP(trigger.getMaxHP());

			// send using effect
			controller.effectBy(trigger);

			Cash_Log();
			if (controller.canBeExhausted())
				controller.decreaseNumber(1);
		}
		else if (trigger.getHP() <= 0)
		{
			trigger.resurrect(false);
			trigger.setHP(trigger.getMaxHP());

			// send using effect
			controller.effectBy(trigger);

			Cash_Log();
			if (controller.canBeExhausted())
				controller.decreaseNumber(1);
		}
		else
		{
			trigger.message(TEXT_NOT_RESURRECTION, MSG_TYPE__SYSTEM);
			return;
		}
	}
	return;
}

quest qUseItem1004097()		// 팀 회복 포션 (100%)
{
	object container, user;
	string useName;
	integer member_cnt, i, wNum;

	container = Container.create();
	trigger.getTeamMemberTypedToContainer(0, container);
	member_cnt = container.size();

	useName = trigger.getName();

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	if (!NormalItemCanBeUsed()) return;

	// PVP 이벤트 지역
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.hasTeam())
	{
		for (i = 0; i <	member_cnt; ++i)
		{
			user = container.at(i);
			if (wNum == user.getWorld().getNumber())
			{
				if (user.isDead() || user.getHP() <= 0)
					user.message(TEXT_NOT_TEAM_RECOVERY, MSG_TYPE__SYSTEM);
				else
				{
					user.setHP(user.getMaxHP());
					user.message("[ " + useName + " ] " + TEXT_USE_TEAM_RECOVERY, MSG_TYPE__SYSTEM);
					// send using effect
					controller.effectBy(user);
				}
			}
		}
		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else
	{
		trigger.setHP(trigger.getMaxHP());
		trigger.message("[ " + useName + " ] " + TEXT_USE_TEAM_RECOVERY, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	return;
}

quest qUseItem1004098()		// 스페셜 팀 회복 포션 (100%)
{
	object container, user;
	string useName;
	integer member_cnt, i, wNum;

	container = Container.create();
	trigger.getTeamMemberTypedToContainer(0, container);
	member_cnt = container.size();

	useName = trigger.getName();

	// 사용 불가능 특정 지역 체크
	wNum = trigger.getWorld().getNumber();

	if (!NormalItemCanBeUsed()) return;

	// PVP 이벤트 지역
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.hasTeam())
	{
		for (i = 0; i <	member_cnt; ++i)
		{
			user = container.at(i);
			if (wNum == user.getWorld().getNumber())
			{
				if (user.isDead() || user.getHP() <= 0)
					user.message(TEXT_NOT_SPECIAL_TEAM_RECOVERY, MSG_TYPE__SYSTEM);
				else
				{
					user.setHP(user.getMaxHP());
					user.castNamedWithDuration("3000212", 60);
					user.castNamedWithDuration("3000210", 180);
					user.message("[ " + useName + " ] " + TEXT_USE_SPECIAL_TEAM_RECOVERY, MSG_TYPE__SYSTEM);
					// send using effect
					controller.effectBy(user);
				}
			}
		}
		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	else
	{
		trigger.setHP(trigger.getMaxHP());
		trigger.message("[ " + useName + " ] " + TEXT_USE_SPECIAL_TEAM_RECOVERY, MSG_TYPE__SYSTEM);
		trigger.castNamedWithDuration("3000212", 60);
		trigger.castNamedWithDuration("3000210", 180);

		// send using effect
		controller.effectBy(trigger);

		Cash_Log();
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
	return;
}

//******************************************************
// 유료 펫 장착 아이템
// 2006.02.01 written by Han
//******************************************************
function
boolean
sPetSkill(string petSkillID)
{
	object pet, inventory;
	integer petDBID;

	inventory = trigger.getPetInventory();
	pet = trigger.getPet();

	petDBID = String.toInteger(pet.getName());

	if(!NormalItemCanBeUsed()) return false;
/*
	// 장착하려는 유료펫 스킬을 가지고 있을 때
	if(pet.getSkillActionInventory().getNamed(petSkillID) != null)
	{
		trigger.message(TEXT_CASH_PET_SKILL_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return false;
	}
*/
	// 장착하려는 유료펫 스킬을 가지고 있을 때
	if (pet.getSpecialAction(petSkillID))
	{
		trigger.message(TEXT_CASH_PET_SKILL_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return false;
	}

	if (pet)
	{
		if(pet.getType() == 1 || pet.getType() == 3)
		{
			trigger.message(TEXT_MONSTER_PET, MSG_TYPE__SYSTEM);	// 몬스터 펫은 사용할수 없다는 메시지
			return false;
		}
/*
		if(petDBID >= 2100682 && petDBID <= 2100686)
		{
			trigger.message(TEXT_MONSTER_PET, MSG_TYPE__SYSTEM);	// 몬스터 펫은 사용할수 없다는 메시지
			return false;
		}
*/
		pet.setSpecialAction(petSkillID);
	}
	else if (inventory.isEggInIncubator())
	{
		trigger.message(TEXT_PET_EGG_IN_INCUBATOR, MSG_TYPE__SYSTEM);
		return false;
	}
	else
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);		// 펫이 없다는 메시지
		return false;
	}
	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	return true;
}

quest qUseItem1003373()		// 펫 S스킬 추가 스크롤 : E (보물찾기)
{
	sPetSkill("3001629");
}

quest qUseItem1006173()		// 펫 S스킬 추가 스크롤 (경험)
{
	sPetSkill("3001566");
}

quest qUseItem1006324()		// 펫 S스킬 추가 스크롤 (근성)
{
	sPetSkill("3001631");
}

//******************************************************
// 아이디툴팁 배경변화 아이템
// 2006.02.01 written by Han
//******************************************************

// 아이디툴팁 배경변화 아이템 (기본색)
quest
qUseItem1004194()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 0)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(0);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (핑크색)
quest
qUseItem1004195()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 1)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(1);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (노란색)
quest
qUseItem1004196()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 2)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(2);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (회색)
quest
qUseItem1004197()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 3)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(3);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (자주색)
quest
qUseItem1004198()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 4)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(4);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (핑크 + 귀)
quest
qUseItem1004199()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 5)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(5);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (노랑 + 귀)
quest
qUseItem1004200()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 6)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(6);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (자주 + 귀)
quest
qUseItem1004201()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 7)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(7);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (개구리)
quest
qUseItem1004925()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 8)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(8);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (알록달록)
quest
qUseItem1004926()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 9)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(9);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (블루캔디)
quest
qUseItem1004927()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 10)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(10);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (핑크캔디)
quest
qUseItem1004928()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 11)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(11);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (블루핑크캔디)
quest
qUseItem1004929()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 12)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(12);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (삼색캔디)
quest
qUseItem1004930()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 13)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(13);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (몽당연필)
quest
qUseItem1004931()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 14)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(14);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (반창고)
quest
qUseItem1004932()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 15)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(15);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (물방울)
quest
qUseItem1004933()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 16)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(16);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (핑크하트귀)
quest
qUseItem1004934()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 17)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(17);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 아이디툴팁 배경변화 아이템 (왕관)
quest
qUseItem1006174()
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.getToolTipColor() == 18)
	{
		trigger.message(TEXT_CASH_ID_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.setToolTipColor(18);
	trigger.message(TEXT_CASHITEM_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

//******************************************************
// 펫 아이디툴팁 배경변화 아이템
// 2006.03.10 written by Han
//******************************************************

// 펫 아이디툴팁 배경변화 아이템 (기본색)
quest
qUseItem1004186()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 0)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(0);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (핑크색)
quest
qUseItem1004187()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 1)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(1);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (노란색)
quest
qUseItem1004188()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 2)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(2);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (회색)
quest
qUseItem1004189()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 3)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(3);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (자주색)
quest
qUseItem1004190()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 4)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(4);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (핑크 + 귀)
quest
qUseItem1004191()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 5)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(5);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (노랑 + 귀)
quest
qUseItem1004192()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 6)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(6);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (자주 + 귀)
quest
qUseItem1004193()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 7)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(7);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (개구리)
quest
qUseItem1004935()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 8)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(8);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (알록달록)
quest
qUseItem1004936()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 9)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(9);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (블루캔디)
quest
qUseItem1004937()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 10)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(10);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (핑크캔디)
quest
qUseItem1004938()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 11)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(11);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (블루핑크캔디)
quest
qUseItem1004939()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 12)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(12);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (삼색캔디)
quest
qUseItem1004940()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 13)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(13);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (몽당연필)
quest
qUseItem1004941()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 14)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(14);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (반창고)
quest
qUseItem1004942()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 15)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(15);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (물방울)
quest
qUseItem1004943()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 16)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(16);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

// 펫 아이디툴팁 배경변화 아이템 (핑크하트귀)
quest
qUseItem1004944()
{
	object pet;
	pet = trigger.getPet();

	if(!NormalItemCanBeUsed()) return;

	if(!pet)
	{
		trigger.message(TEXT_NOT_PET, MSG_TYPE__SYSTEM);	// 펫이 없다는 메시지
		return;
	}

	if (pet.getToolTipColor() == 17)
	{
		trigger.message(TEXT_CASH_PET_CHANGE_ITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	pet.setToolTipColor(17);
	trigger.message(TEXT_CASHITEM_PET_TOOLTIP_USE, MSG_TYPE__SYSTEM);
	// send using effect
	controller.effectBy(trigger);

	Cash_Log();
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

//***************************************************************************************************

quest qUseItem1004971()		// 챕터 에피소드1 엔딩 리플레이
{
	integer	UseCount = 0;

	if(!NormalItemCanBeUsed()) return;

	// 싸움가능 지역, 이벤트월드 사용금지
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.checkAttribute("CH_END") == true)
		UseCount = String.toInteger(controller.getAttribute("CH_END"));

	if (controller.canBeExhausted() && UseCount >= 1) {
		Cash_Log();
		controller.sweepNumbered(1);
	}
	else controller.setAttribute("CH_END",Integer.toString(UseCount+1));

	BeginVE("1464.vse");
}

//******************************************************
// 일본 경험치 상승 아이템 (1.5배)
// 2006.05.22 written by Han
//******************************************************
quest
qUseItem1005006()		// 경험치 상승 아이템 (1시간 지속)
{
	object castedSpellInven;
	string cCookie_Exp;
	integer timeTick;

	if(!NormalItemCanBeUsed()) return;

	timeTick = Util.getTick();

	castedSpellInven = trigger.getCastedSpellInventory();

	// 이미 경험치 상승 스킬을 사용중이라면 아이템 사용 불가
	if (castedSpellInven.hasNamed("3000002"))
	{
		trigger.message(TEXT_CASH_EXP_ITEM_USE, MSG_TYPE__SYSTEM);
		return;
	}

	cCookie_Exp = trigger.getCookie("ExpItem");

	if (cCookie_Exp != null)
	{
		if (Util.getDay(String.toInteger(cCookie_Exp)) != Util.getDay(timeTick))
		{
			trigger.castNamedWithDuration("3000002", 3600);

			// send using effect
			controller.effectBy(trigger);
			trigger.message(TEXT_USABLEITEM_MESSAGE1 + trigger.getName() + TEXT_USABLEITEM_MESSAGE2 + controller.getDesc() + TEXT_USABLEITEM_MESSAGE_GET_ITEM, MSG_TYPE__SYSTEM);
			Util.log("##Skill item use [" + trigger.getName() + "] when [" + Util.getTimeString("%A %b %d %T") + "] Skill ID [ 3000002 ]");
			trigger.setCookie("ExpItem", Integer.toString(timeTick), 0);
			return;
		}
		else
		{
			trigger.message(TEXT_CASH_EXP_ITEM_CHECK, MSG_TYPE__SYSTEM);
			return;
		}
	}
	else
	{
		trigger.castNamedWithDuration("3000002", 3600);

		// send using effect
		controller.effectBy(trigger);
		trigger.message(TEXT_USABLEITEM_MESSAGE1 + trigger.getName() + TEXT_USABLEITEM_MESSAGE2 + controller.getDesc() + TEXT_USABLEITEM_MESSAGE_GET_ITEM, MSG_TYPE__SYSTEM);
		Util.log("##Skill item use [" + trigger.getName() + "] when [" + Util.getTimeString("%A %b %d %T") + "] Skill ID [ 3000002 ]");
		trigger.setCookie("ExpItem", Integer.toString(timeTick), 0);
		return;
	}
}


quest qUseItem1006077()		// 챕터11 다이제스트 (유료 아이템)
{
	integer	UseCount = 0;

	if(!NormalItemCanBeUsed()) return;

	// 싸움가능 지역, 이벤트월드 사용금지
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.checkAttribute("CH11") == true)
		UseCount = String.toInteger(controller.getAttribute("CH11"));

	if (controller.canBeExhausted() && UseCount >= 1) {
		Cash_Log();
		controller.sweepNumbered(1);
	}
	else controller.setAttribute("CH11",Integer.toString(UseCount+1));

	BeginVE("1472.vse");	// 챕터11_1
	BeginVE("1210.vse");	// 카밀의 분노
	BeginVE("1473.vse");	// 챕터11_2
	BeginVE("1216.vse");	// 분신살해
	BeginVE("1474.vse");	// 챕터11_3
	BeginVE("1237.vse");	// 오를란느의 상식
	BeginVE("1475.vse");	// 챕터11_4
	BeginVE("1243.vse");	// 신뢰의 증거
	BeginVE("1476.vse");	// 챕터11_5
	BeginVE("1247.vse");	// 폭탄 설치
	BeginVE("1477.vse");	// 챕터11_6
	BeginVE("1249.vse");	// 괴로운 대가
	BeginVE("1478.vse");	// 챕터11_7
	BeginVE("1250.vse");	// 사면초가
	BeginVE("1479.vse");	// 챕터11_8
	BeginVE("1481.vse");	// 기억 복구
	BeginVE("1480.vse");	// 챕터11_9
	BeginVE("1260.vse");	// 꿈의 재생
}

quest qUseItem1006133()		// 챕터12 다이제스트 (유료 아이템)
{
	integer chType;
	integer	UseCount = 0;

	chType = trigger.getCharacterType();

	if(!NormalItemCanBeUsed()) return;

	// 싸움가능 지역, 이벤트월드 사용금지
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.checkAttribute("CH12") == true)
		UseCount = String.toInteger(controller.getAttribute("CH12"));

	if (controller.canBeExhausted() && UseCount >= 1) {
		Cash_Log();
		controller.sweepNumbered(1);
	}
	else controller.setAttribute("CH12",Integer.toString(UseCount+1));

	if(chType == CHAR_TYPE3 || chType == CHAR_TYPE10)	// 시벨린, 나야트레이
	{
		BeginVE("1482.vse");	// 시벨린 챕터12_1
		BeginVE("1304.vse");	// 불시의 만남
		BeginVE("1483.vse");	// 시벨린 챕터12_2
		BeginVE("1320.vse");	// 흐릿한 목소리
		BeginVE("1484.vse");	// 시벨린 챕터12_3
		BeginVE("1322.vse");	// 가밀라의 기억1
		BeginVE("1485.vse");	// 시벨린 챕터12_4
		BeginVE("1326.vse");	// 탄생석의 또 다른 힘
		BeginVE("1486.vse");	// 시벨린 챕터12_5
		BeginVE("1330.vse");	// 마지막 임무
		BeginVE("1487.vse");	// 시벨린 챕터12_6
		BeginVE("1313.vse");	// 분열하는 흑의 검사
		BeginVE("1488.vse");	// 챕터12 공통 이벤트
		BeginVE("1316.vse");	// 디스크의 재생
	}
	else
	{
		BeginVE("1489.vse");	// 루시안 챕터12_1
		BeginVE("1277.vse");	// 근심중에도 의지를!
		BeginVE("1490.vse");	// 루시안 챕터12_2
		BeginVE("1505.vse");	// 카리드 탈출구
		BeginVE("1491.vse");	// 루시안 챕터12_3
		BeginVE("0573.vse");	// 동상이몽
		BeginVE("1291.vse");	// 이스핀과의 재회
		BeginVE("1492.vse");	// 루시안 챕터12_4
		BeginVE("1296.vse");	// 고대종족 발견
		BeginVE("1493.vse");	// 루시안 챕터12_5
		BeginVE("1507.vse");	// 진짜 흑의검사는 누구?
		BeginVE("1494.vse");	// 루시안 챕터12_6
		BeginVE("1508.vse");	// 텅 빈 본거지
		BeginVE("1495.vse");	// 루시안 챕터12_7
		BeginVE("1313.vse");	// 분열하는 흑의검사
		BeginVE("1488.vse");	// 챕터12 공통 이벤트
		BeginVE("1316.vse");	// 디스크의 재생
	}
}

quest qUseItem1006191()		// 챕터13-1 다이제스트 (유료 아이템)
{
	integer	UseCount = 0;

	if(!NormalItemCanBeUsed()) return;

	// 싸움가능 지역, 이벤트월드 사용금지
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.checkAttribute("CH13_1") == true)
		UseCount = String.toInteger(controller.getAttribute("CH13_1"));

	if (controller.canBeExhausted() && UseCount >= 1) {
		Cash_Log();
		controller.sweepNumbered(1);
	}
	else controller.setAttribute("CH13_1",Integer.toString(UseCount+1));

	BeginVE("1496.vse");	// 챕터13-1_1
	BeginVE("1509.vse");	// 그리운 얼굴
	BeginVE("1497.vse");	// 챕터13-1_2
	BeginVE("1510.vse");	// 카림하룬의 패배
	BeginVE("1364.vse");	// 설복
	BeginVE("1498.vse");	// 챕터13-1_3
	BeginVE("1511.vse");	// 마지막예언2
	BeginVE("1499.vse");	// 챕터13-1_4
	BeginVE("1370.vse");	// 슬픈 미래
	BeginVE("1500.vse");	// 챕터13-1_5
	BeginVE("1372.vse");	// 진정한 주인이여
	BeginVE("1501.vse");	// 챕터13-1_6
	BeginVE("1374.vse");	// 대륙의 이상현상
	BeginVE("1502.vse");	// 챕터13-1_7
	BeginVE("1377.vse");	// 에델을 위해
	BeginVE("1378.vse");	// 정체불명의 조언자
	BeginVE("1512.vse");	// 진정한 결의
}

quest qUseItem1006192()		// 챕터13_2 다이제스트 (유료 아이템)
{
	object loc;

	integer chType;
	integer	UseCount = 0;

	chType = trigger.getCharacterType();

	if(!NormalItemCanBeUsed()) return;

	// 싸움가능 지역, 이벤트월드 사용금지
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.checkAttribute("CH13_2") == true)
		UseCount = String.toInteger(controller.getAttribute("CH13_2"));

	if (controller.canBeExhausted() && UseCount >= 1) {
		Cash_Log();
		controller.sweepNumbered(1);
	}
	else controller.setAttribute("CH13_2",Integer.toString(UseCount+1));

	// 전체공통 부분
	BeginVE("1395.vse");	// 피에 젖은 손
	BeginVE("1503.vse");	// 챕터13-2_1

	if (chType == CHAR_TYPE0)		// 루시안
	{
		BeginVE("1407.vse");	// 환영일 뿐
		BeginVE("1504.vse");	// 챕터13-2_2
		BeginVE("1408.vse");	// 두려움과 떨림
		BeginVE("1513.vse");	// 챕터13 전투1
		BeginVE("1416.vse");	// 공포의 정체
		BeginVE("1513.vse");	// 챕터13 전투2
		BeginVE("1424.vse");	// 함께 가자
	}
	else if (chType == CHAR_TYPE1)		// 보리스
	{
		BeginVE("1439.vse");	// 환영일 뿐
		BeginVE("1504.vse");	// 챕터13-2_2
		BeginVE("1409.vse");	// 두려움과 떨림
		BeginVE("1513.vse");	// 챕터13 전투1
		BeginVE("1417.vse");	// 공포의 정체
		BeginVE("1513.vse");	// 챕터13 전투2
		BeginVE("1425.vse");	// 함께 가자
	}
	else if (chType == CHAR_TYPE2)		// 막시민
	{
		BeginVE("1440.vse");	// 환영일 뿐
		BeginVE("1504.vse");	// 챕터13-2_2
		BeginVE("1410.vse");	// 두려움과 떨림
		BeginVE("1513.vse");	// 챕터13 전투1
		BeginVE("1418.vse");	// 공포의 정체
		BeginVE("1513.vse");	// 챕터13 전투2
		BeginVE("1426.vse");	// 함께 가자
	}
	else if (chType == CHAR_TYPE3)		// 시벨린
	{
		BeginVE("1441.vse");	// 환영일 뿐
		BeginVE("1504.vse");	// 챕터13-2_2
		BeginVE("1411.vse");	// 두려움과 떨림
		BeginVE("1513.vse");	// 챕터13 전투1
		BeginVE("1419.vse");	// 공포의 정체
		BeginVE("1513.vse");	// 챕터13 전투2
		BeginVE("1427.vse");	// 함께 가자
	}
	else if (chType == CHAR_TYPE7)		// 밀라
	{
		BeginVE("1442.vse");	// 환영일 뿐
		BeginVE("1504.vse");	// 챕터13-2_2
		BeginVE("1412.vse");	// 두려움과 떨림
		BeginVE("1513.vse");	// 챕터13 전투1
		BeginVE("1420.vse");	// 공포의 정체
		BeginVE("1513.vse");	// 챕터13 전투2
		BeginVE("1428.vse");	// 함께 가자
	}
	else if (chType == CHAR_TYPE8)		// 티치엘
	{
		BeginVE("1443.vse");	// 환영일 뿐
		BeginVE("1504.vse");	// 챕터13-2_2
		BeginVE("1413.vse");	// 두려움과 떨림
		BeginVE("1513.vse");	// 챕터13 전투1
		BeginVE("1421.vse");	// 공포의 정체
		BeginVE("1513.vse");	// 챕터13 전투2
		BeginVE("1429.vse");	// 함께 가자
	}
	else if (chType == CHAR_TYPE9)		// 이스핀
	{
		BeginVE("1444.vse");	// 환영일 뿐
		BeginVE("1504.vse");	// 챕터13-2_2
		BeginVE("1414.vse");	// 두려움과 떨림
		BeginVE("1513.vse");	// 챕터13 전투1
		BeginVE("1422.vse");	// 공포의 정체
		BeginVE("1513.vse");	// 챕터13 전투2
		BeginVE("1430.vse");	// 함께 가자
	}
	else if (chType == CHAR_TYPE10)		// 나야트레이
	{
		BeginVE("1445.vse");	// 환영일 뿐
		BeginVE("1504.vse");	// 챕터13-2_2
		BeginVE("1415.vse");	// 두려움과 떨림
		BeginVE("1513.vse");	// 챕터13 전투1
		BeginVE("1423.vse");	// 공포의 정체
		BeginVE("1513.vse");	// 챕터13 전투2
		BeginVE("1431.vse");	// 함께 가자
	}

	// 전체공통 부분
	BeginVE("1432.vse");	// 아티펙트의 흔적
	BeginVE("1433.vse");	// 기다리는 사람
	BeginVE("1451.vse");	// 에피2 예고1
	BeginVE("1452.vse");	// 에피2 예고2
	BeginVE("1453.vse");	// 에피2 예고3
	BeginVE("1454.vse");	// 에피2 예고4
	BeginVE("1434.vse");	// 함께 있으니까
	BeginVE("1513.vse");	// 챕터13 전투3
	BeginVE("1435.vse");	// 최후의 최후까지
	BeginVE("1436.vse");	// 마지막 싸움
	BeginVE("1513.vse");	// 챕터13 전투4
	BeginVE("1514.vse");	// 이야기의 지속
	BeginVE("1464.vse");	// 엔딩 동영상

	loc = Location.create();
	loc.set(666,100,100);

	trigger.teleportTo(loc);
}

//******************************************************
// 슈퍼 커플링 (가칭)
// 2006.07.18 written by Han
//******************************************************
quest qUseItem1006166()		// 날 보러 와요
{
	string targetName;

	if(!NormalItemCanBeUsed()) return;

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.checkAttribute("meetuser") != true)
	{
		trigger.message(TEXT_CASH_MEET_ITEM_NOT_USE1, MSG_TYPE__SYSTEM);
		return;
	}

	targetName = controller.getAttribute("meetuser");

	if (trigger.getName() == targetName)
	{
		trigger.message(TEXT_CASH_MEET_ITEM_NOT_USE2, MSG_TYPE__SYSTEM);
		return;
	}

	trigger.meet(targetName);
	Cash_Log();
}

//******************************************************
// 원격상점
// 2006.07.18 written by Han
//******************************************************
quest qUseItem1006169()		// 원격 상점
{
	integer mapChk = trigger.getWorld().getNumber();

	if(!NormalItemCanBeUsed()) return;

	if (mapChk == 718 || mapChk == 719 || mapChk == 720 || mapChk == 721)
	{
		trigger.message(TEXT_CASH_NEW_CHAR_JOSUA2, MSG_TYPE__SYSTEM);
		return;
	}

	// 이벤트월드 사용금지
	if(trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	trigger.openMerchantMenu("2200514");
	Cash_Log();
}

//******************************************************
// 선물상자
// 2006.08.02 written by Han
//******************************************************
quest qUseItem1002338()		// 조합아이템 보상용 선물상자
{
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 10) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	userName = trigger.getName();
	tickTime = Util.getTick();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	// 하얀색 외치기 뿔피리 3개 지급
	trigger.addItemClassNamed("1004540", 3);	// vahma - japan setting
	trigger.message(TEXT_CASH_MANUFACTURE_FAIL_REPARATION, MSG_TYPE__SYSTEM);

	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	Util.log(time_Info + Item_Info + world_Info);

	controller.effectBy(trigger);
}

//******************************************************
// NPC 호감도 상승 아이템
// 2006.08.21 written by Han
//******************************************************
quest qUseItem1006193()				// NPC 호감도 상승 아이템
{
	object NPC;

	integer cGoodWill;

	if (!NormalItemCanBeUsed()) return;

	NPC = controller.getObjectArgumentAt(0);

	// NPC 가 아닌 대상에게는 사용불가
	if (!NPC.isMerchant())
	{
		trigger.message(TEXT_CASH_NPC_GOODWILL_USE_FAIL, MSG_TYPE__SYSTEM);
		return;
	}

	cGoodWill = NPC.getGoodwillFor(trigger);

	if (cGoodWill >= 32000)			// NPC 테이블 최대 호감도 수치를 넘을 수 없다
	{
		trigger.message(TEXT_CASH_NPC_GOODWILL_MAX, MSG_TYPE__SYSTEM);
		return;
	}
	else if (cGoodWill <= 0)		// 마이너스 호감도일때는 무조건 호감도 500 Set
	{
		trigger.setGoodwillFor(NPC, 500);
	}
	else					// 호감도 증가
	{
		cGoodWill = cGoodWill + 500;

		if (cGoodWill >= 32000)
			trigger.setGoodwillFor(NPC, 32000);

		trigger.setGoodwillFor(NPC, cGoodWill);
	}

	trigger.message(TEXT_CASH_NPC_GOODWILL_UP, MSG_TYPE__SYSTEM);

	controller.effectBy(trigger);

	if (controller.canBeExhausted())
	{
	    Cash_Log();
	    controller.sweepNumbered(1);
	}
}

//******************************************************
// 에피소드 2 시작 아이템
// 2006.08.21 written by Han
//******************************************************
quest qUseItem1006262()				// 에피소드 2 시작 아이템
{
	integer chType;
	integer nValue;
	integer episode		= 2;
	integer gSwitch		= 1;
	integer swClear		= 1;

	chType = trigger.getCharacterType();

	if (!NormalItemCanBeUsed()) return;

	// 싸움가능 지역, 이벤트월드 사용금지
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}
/*
	if (trigger.getLevel() < 35)
	{
		trigger.message(TEXT_CASH_EP2_CH0_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
*/
	nValue = trigger.getGlobalSwitch(episode, gSwitch);
	if(nValue > 0)
	{
		trigger.message(TEXT_CASH_EP2_CH0_START, MSG_TYPE__SYSTEM);
		return;
	}

	if (chType == CHAR_TYPE0)		// 루시안
	{
		trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_L001);
		BeginVE("1348.vse");
	}
	else if (chType == CHAR_TYPE1)		// 보리스
	{
		trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_B001);
		BeginVE("1351.vse");
	}
	else if (chType == CHAR_TYPE2)		// 막시민
	{
		trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_X001);
		BeginVE("1353.vse");
	}
	else if (chType == CHAR_TYPE3)		// 시벨린
	{
		trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_S001);
		BeginVE("1355.vse");
	}
	else if (chType == CHAR_TYPE7)		// 밀라
	{
		trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_M001);
		BeginVE("1392.vse");
	}
	else if (chType == CHAR_TYPE8)		// 티치엘
	{
		trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_T001);
		BeginVE("1393.vse");
	}
	else if (chType == CHAR_TYPE9)		// 이스핀
	{
		trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_I001);
		BeginVE("1515.vse");
	}
	else if (chType == CHAR_TYPE10)		// 나야트레이
	{
		trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_N001);
		BeginVE("1516.vse");
	}

	// 스위치 값 변경
	trigger.setGlobalSwitch(episode, gSwitch, swClear);
	trigger.sendGlobalSwitchForSwitch(episode, gSwitch);

	trigger.putGlobalSwitchLog(episode, TEXT_EP2_CHAP00_START);
	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		Cash_Log();
		controller.sweepNumbered(1);
	}
}

//******************************************************
// 아이템 내구도 증가 아이템 (+5)
// 2006.11.01 written by Han
//******************************************************
quest qUseItem1006435()				// 아이템 내구도 증가 (+5)
{
	object item;
	integer Endurance, maxEndurance;
	integer upValue, maxValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);

	// 유저상점 올라간 아이템인지 체크
	if (item.isLocked())
	{
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	Endurance = item.getMaxTEIP(TEIP__ENDURANCE);
	maxEndurance = item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__UPPER);
	maxValue = maxEndurance + 20;

	if (!trigger.isMonster() && item && item.isEquippable())
	{
		if (Endurance >= maxValue)
		{
			trigger.message(TEXT_CASH_ENDURANCE_MAX , MSG_TYPE__SYSTEM);
			return;
		}

		upValue = Endurance + 5;

		// 결과값이 최대값보다 클 경우 최대값으로 보정
		if (upValue >= maxValue)
			upValue = maxValue;

		item.setMaxTEIP(TEIP__ENDURANCE, upValue);
		item.setTEIP(TEIP__ENDURANCE, upValue);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		Cash_Log();
	}
}

//******************************************************
// 아이템 경도 증가 아이템 (+3)
// 2006.11.01 written by Han
//******************************************************
quest qUseItem1006436()				// 아이템 경도 증가 (+3)
{
	object item;
	integer Firmness, maxFirmness;
	integer upValue, maxValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);

	// 유저상점 올라간 아이템인지 체크
	if (item.isLocked())
	{
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	Firmness = item.getTEIP(TEIP__FIRMNESS);
	maxFirmness = item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__UPPER);
	maxValue = maxFirmness + 20;

	if (!trigger.isMonster() && item && item.isEquippable())
	{
		if (Firmness >= maxValue)
		{
			trigger.message(TEXT_CASH_FIRMNESS_MAX , MSG_TYPE__SYSTEM);
			return;
		}

		upValue = Firmness + 3;

		// 결과값이 최대값보다 클 경우 최대값으로 보정
		if (upValue >= maxValue)
			upValue = maxValue;

		item.setTEIP(TEIP__FIRMNESS, upValue);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		Cash_Log();
	}
}

//******************************************************
// NPC 호감도 스카우터 아이템 (호감도 살펴보기)
// 2006.11.01 written by Han
//******************************************************
quest qUseItem1006437()				// NPC 호감도 스카우터
{
	object NPC;

	integer cGoodWill;

	if (!NormalItemCanBeUsed()) return;

	NPC = controller.getObjectArgumentAt(0);

	// NPC 가 아닌 대상에게는 사용불가
	if (!NPC.isMerchant())
	{
		trigger.message(TEXT_CASH_NPC_GOODWILL_USE_FAIL, MSG_TYPE__SYSTEM);
		return;
	}

	cGoodWill = NPC.getGoodwillFor(trigger);

	trigger.message(TEXT_CASH_NPC_GOODWILL_SCOUTER1 + cGoodWill + TEXT_CASH_NPC_GOODWILL_SCOUTER2, MSG_TYPE__SYSTEM);

	controller.effectBy(trigger);

//	Cash_Log();
}

//************************************************************************
// 캐릭터 슬롯 추가 아이템
//
// 캐릭터 슬롯 추가는 최대 3개 까지 할 수 있다 (현재는 2개까지 만으로)
// 1. 서버 메소드 getExtraCharacterSlot() : 리턴값은 현재 추가 슬롯의 수
//    추가하지 않았다면 0 값이 Max 수치라면 3 값
// 2. 서버 메소드 setExtraCharacterSlot(integer extraCharacterSlot)
//    지정된 값만큼 슬롯 추가 (Max 수치 3을 넘으면 false 리턴)
// 2006.11.01 written by Han
//************************************************************************
quest qUseItem1006538()				// 캐릭터 슬롯 추가 아이템
{
	if (!NormalItemCanBeUsed()) return;

	if (trigger.getExtraCharacterSlot() >= 2)
	{
		trigger.message(TEXT_CASH_PC_SLOT_NOT, MSG_TYPE__SYSTEM);
		return;
	}
	else
	{
		if (trigger.setExtraCharacterSlot(trigger.getExtraCharacterSlot() + 1))
		{
			if (controller.canBeExhausted())
				controller.decreaseNumber(1);

			Cash_Log();
			trigger.message(TEXT_CASH_PC_SLOT_ADD, MSG_TYPE__SYSTEM);
		}
		else
		{
			trigger.message(TEXT_CASH_PC_SLOT_ADD_FAIL, MSG_TYPE__SYSTEM);
			return;
		}
	}
}

//******************************************************
// 증표 패키지 아이템
// 2006.11.14 written by Stunlee
//******************************************************
function
boolean
GiveItem(string itemID, integer UserLV, integer PrivateDay)
{
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	if (trigger.getLevel() > UserLV)
	{
		trigger.message(TEXT_USELEVEL_HIGH, MSG_TYPE__SYSTEM);
		return false;
	}

	if (trigger.getLevel() < (UserLV - 14))
	{
		trigger.message(TEXT_USELEVEL_LOW, MSG_TYPE__SYSTEM);
		return false;
	}

	// Log Info
	userName = trigger.getName();
	tickTime = Util.getTick();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	// 만들어서 들어갈 아이템
	trigger.addItemClassNamed(itemID, 1);
	ExpireItem(itemID, 60*60*24*PrivateDay);
	Item_Info = "From Gift Certificate : +ITEM [ " + itemID + " ] ";
	Util.log(time_Info + Item_Info + world_Info);

	return true;
}
//******************************************************
// 초보자 패키지 아이템
// 2006.11.14 written by Stunlee
//******************************************************
quest qUseItem1006574()			// 초보자용 검투사 패키지(막시민 + 보리스용)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 보리스, 막시민 일때만 사용가능
	if (chType != CHAR_TYPE1 && chType != CHAR_TYPE2)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR1_CHAR2, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006320", 15, 14))					// 초보 검투사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006318", 15, 14))					// 초보 검투사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_HAND1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006314", 15, 14))					// 초보 검투사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 초보 무기
	if (trigger.getDBID() == 2000001 || trigger.getDBID() == 2000002)
	{
		itemID = "1006312";		// 물복 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_GLADIATOR_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000015 || trigger.getDBID() == 2000016) 
	{
		itemID = "1006311";		// 베기 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_GLADIATOR_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000029 || trigger.getDBID() == 2000030) 
	{
		itemID = "1006313";		// 마검 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_GLADIATOR_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006575()			// 초보자용 검투사 패키지(루시안 + 이스핀)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 루시안, 이스핀 일때만 사용가능
	if (chType != CHAR_TYPE0 && chType != CHAR_TYPE9)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR0_CHAR9, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006320", 15, 14))					// 초보 검투사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006315", 15, 14))					// 초보 검투사 실드
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_HAND2, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006314", 15, 14))					// 초보 검투사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 초보 무기
	if (trigger.getDBID() == 2000028 || trigger.getDBID() == 2000009)
	{
		itemID = "1006309";		// 찌름 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_GLADIATOR_ARMS4, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000000 || trigger.getDBID() == 2000023)
	{
		itemID = "1006310";		// 물복 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_GLADIATOR_ARMS5, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000014 || trigger.getDBID() == 2000037)
	{
		itemID = "1006311";		// 베기 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_GLADIATOR_ARMS2, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006576()			// 초보자용 마법사 패키지(티치엘)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 티치엘 일때만 사용가능
	if (chType != CHAR_TYPE8)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR8, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006321", 15, 14))					// 초보 마법사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_ARMMOR2, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006316", 15, 14))					// 초보 마법사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_HAND3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006314", 15, 14))					// 초보 마법사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 초보 무기
	if (trigger.getDBID() == 2000008)
	{
		itemID = "1006306";		// 공격형 티치엘
		trigger.message(TEXT_PACKAGE_MAGICIAN_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000022)
	{
		itemID = "1006307";		// 보조형 티치엘
		trigger.message(TEXT_PACKAGE_MAGICIAN_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000036)
	{
		itemID = "1006308";		// 전투형 티치엘
		trigger.message(TEXT_PACKAGE_MAGICIAN_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006577()			// 초보자용 해적 패키지(밀라)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 밀라 일때만 사용가능
	if (chType != CHAR_TYPE7)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR7, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006322", 15, 14))					// 초보 해적 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_ARMMOR3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006317", 15, 14))					// 초보 해적 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_HAND4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006314", 15, 14))					// 초보 해적 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	
	// 초보 무기
	if (trigger.getDBID() == 2000007)
	{
		itemID = "1006304";		// 베기형 밀라
		trigger.message(TEXT_PACKAGE_CORSAIR_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000021)
	{
		itemID = "1006305";		// 물복형 밀라
		trigger.message(TEXT_PACKAGE_CORSAIR_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000035)
	{
		itemID = "1006305";		// 물복형 밀라
		trigger.message(TEXT_PACKAGE_CORSAIR_ARMS2, MSG_TYPE__SYSTEM);
	}
	
	if (!GiveItem(itemID, 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006578()			// 초보자용 버서커 패키지(시벨린)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 시벨린 일때만 사용가능
	if (chType != CHAR_TYPE3)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR3, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006320", 15, 14))					// 초보 버서커 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006319", 15, 14))					// 초보 버서커 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_HAND5, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006314", 15, 14))					// 초보 버서커 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	
	// 초보 무기
	if (trigger.getDBID() == 2000003)
	{
		itemID = "1006302";		// 찌름형 시벨린
		trigger.message(TEXT_PACKAGE_BUSUKER_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000017)
	{
		itemID = "1006303";		// 물복형 시벨린
		trigger.message(TEXT_PACKAGE_BUSUKER_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000031)
	{
		itemID = "1006303";		// 물복형 시벨린
		trigger.message(TEXT_PACKAGE_BUSUKER_ARMS2, MSG_TYPE__SYSTEM);
	}
	if (!GiveItem(itemID, 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006579()			// 초보자용 어쌔신 패키지(나야트레이)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 나야트레이 일때만 사용가능
	if (chType != CHAR_TYPE10)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR10, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006322", 15, 14))					// 초보 어쌔신 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_ARMMOR3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006317", 15, 14))					// 초보 어쌔신 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_HAND4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006314", 15, 14))					// 초보 어쌔신 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 초보 무기
	if (trigger.getDBID() == 2000010)
	{
		itemID = "1006299";		// 찌름형 나야
		trigger.message(TEXT_PACKAGE_ASSASSIN_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000024)
	{
		itemID = "1006300";		// 물복형 나야
		trigger.message(TEXT_PACKAGE_ASSASSIN_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000038)
	{
		itemID = "1006301";		// 베기형 나야
		trigger.message(TEXT_PACKAGE_ASSASSIN_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006770()			// 초보자용 강령술사 패키지(조슈아)
{
	string itemID1, itemID2;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 조슈아 일때만 사용가능
	if (chType != CHAR_TYPE4)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR4, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006766", 15, 14))					// 초보 강령술사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_ARMMOR4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006314", 15, 14))					// 초보 강령술사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 초보 무기
	if (trigger.getDBID() == 2000004)	// 강화형 조슈아
	{
		itemID1 = "1006750";
		itemID2 = "1006758";
		trigger.message(TEXT_PACKAGE_DIVINE_ARMS1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_BEGINNER_HAND6, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000018)	// 변화형 조슈아
	{
		itemID1 = "1006754";
		itemID2 = "1006762";
		trigger.message(TEXT_PACKAGE_DIVINE_ARMS2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_BEGINNER_HAND7, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000032)	// 방출형 조슈아
	{
		itemID1 = "1006754";
		itemID2 = "1006758";
		trigger.message(TEXT_PACKAGE_DIVINE_ARMS2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_BEGINNER_HAND6, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID1, 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem(itemID2, 15, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

//******************************************************
// 중급 패키지 아이템
// 2006.11.14 written by Stunlee
//******************************************************
quest qUseItem1006580()			// 중급 검투사 패키지(막시민 + 보리스용)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 보리스, 막시민 일때만 사용가능
	if (chType != CHAR_TYPE1 && chType != CHAR_TYPE2)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR1_CHAR2, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006358", 30, 14))					// 중급 검투사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006356", 30, 14))					// 중급 검투사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_HAND1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006352", 30, 14))					// 중급 검투사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 중급 무기
	if (trigger.getDBID() == 2000001 || trigger.getDBID() == 2000002) 
	{
		itemID = "1006350";		// 물복 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_MEDIATE_GLADIATOR_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000015 || trigger.getDBID() == 2000016) 
	{
		itemID = "1006349";		// 베기 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_MEDIATE_GLADIATOR_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000029 || trigger.getDBID() == 2000030) 
	{
		itemID = "1006351";		// 마검 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_MEDIATE_GLADIATOR_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006581()			// 중급용 검투사 패키지(루시안 + 이스핀)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 루시안, 이스핀 일때만 사용가능
	if (chType != CHAR_TYPE0 && chType != CHAR_TYPE9)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR0_CHAR9, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006358", 30, 14))					// 중급 검투사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006353", 30, 14))					// 중급 검투사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_HAND2, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006352", 30, 14))					// 중급 검투사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 30, 14))		
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 중급 무기
	if (trigger.getDBID() == 2000028 || trigger.getDBID() == 2000009) 
	{
		itemID = "1006347";		// 찌름 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_MEDIATE_GLADIATOR_ARMS4, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000000 || trigger.getDBID() == 2000023)
	{
		itemID = "1006348";		// 물복 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_MEDIATE_GLADIATOR_ARMS5, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000014 || trigger.getDBID() == 2000037)
	{
		itemID = "1006349";		// 베기 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_MEDIATE_GLADIATOR_ARMS2, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006582()			// 중급용 마법사 패키지(티치엘)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 티치엘 일때만 사용가능
	if (chType != CHAR_TYPE8)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR8, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006359", 30, 14))					// 중급 마법사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_ARMMOR2, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006354", 30, 14))					// 중급 마법사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_HAND3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006352", 30, 14))					// 중급 마법사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 중급 무기
	if (trigger.getDBID() == 2000008)
	{
		itemID = "1006344";		// 공격형 티치엘
		trigger.message(TEXT_PACKAGE_MEDIATE_MAGICIAN_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000022)
	{
		itemID = "1006345";		// 보조형 티치엘
		trigger.message(TEXT_PACKAGE_MEDIATE_MAGICIAN_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000036)
	{
		itemID = "1006346";		// 전투형 티치엘
		trigger.message(TEXT_PACKAGE_MEDIATE_MAGICIAN_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006583()			// 중급 해적 패키지(밀라)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 밀라 일때만 사용가능
	if (chType != CHAR_TYPE7)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR7, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006360", 30, 14))					// 중급 해적 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_ARMMOR3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006355", 30, 14))					// 중급 해적 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_HAND4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006352", 30, 14))					// 중급 해적 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 중급 무기
	if (trigger.getDBID() == 2000007)
	{
		itemID = "1006342";		// 베기형 밀라
		trigger.message(TEXT_PACKAGE_MEDIATE_CORSAIR_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000021)
	{
		itemID = "1006343";		// 물복형 밀라
		trigger.message(TEXT_PACKAGE_MEDIATE_CORSAIR_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000035)
	{
		itemID = "1006343";		// 물복형 밀라
		trigger.message(TEXT_PACKAGE_MEDIATE_CORSAIR_ARMS2, MSG_TYPE__SYSTEM);
	}
	if (!GiveItem(itemID, 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006584()			// 중급 버서커 패키지(시벨린)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 시벨린 일때만 사용가능
	if (chType != CHAR_TYPE3)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR3, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006358", 30, 14))					// 중급 버서커 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006357", 30, 14))					// 중급 버서커 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_HAND5, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006352", 30, 14))					// 중급 버서커 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 중급 무기
	if (trigger.getDBID() == 2000003)
	{
		itemID = "1006340";		// 찌름형 시벨린
		trigger.message(TEXT_PACKAGE_MEDIATE_BUSUKER_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000017)
	{
		itemID = "1006341";		// 물복형 시벨린
		trigger.message(TEXT_PACKAGE_MEDIATE_BUSUKER_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000031)
	{
		itemID = "1006341";		// 물복형 시벨린
		trigger.message(TEXT_PACKAGE_MEDIATE_BUSUKER_ARMS2, MSG_TYPE__SYSTEM);
	}
	if (!GiveItem(itemID, 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006585()			// 중급 어쌔신 패키지(나야트레이)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 나야트레이 일때만 사용가능
	if (chType != CHAR_TYPE10)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR10, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006360", 30, 14))					// 중급 어쌔신 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_ARMMOR3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006355", 30, 14))					// 중급 어쌔신 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_HAND4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006352", 30, 14))					// 중급 어쌔신 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 중급 무기
	if (trigger.getDBID() == 2000010)
	{
		itemID = "1006337";		// 찌름형 나야
		trigger.message(TEXT_PACKAGE_MEDIATE_ASSASSIN_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000024)
	{
		itemID = "1006338";		// 물복형 나야
		trigger.message(TEXT_PACKAGE_MEDIATE_ASSASSIN_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000038)
	{
		itemID = "1006339";		// 베기형 나야
		trigger.message(TEXT_PACKAGE_MEDIATE_ASSASSIN_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006771()			// 중급 강령술사 패키지(조슈아)
{
	string itemID1, itemID2;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 조슈아 일때만 사용가능
	if (chType != CHAR_TYPE4)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR4, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006767", 30, 14))					// 중급 강령술사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_ARMMOR4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006352", 30, 14))					// 중급 강령술사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MEDIATE_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 중급 무기
	if (trigger.getDBID() == 2000004)	// 강화형 조슈아
	{
		itemID1 = "1006751";
		itemID2 = "1006759";
		trigger.message(TEXT_PACKAGE_MEDIATE_DIVINE_ARMS1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_MEDIATE_HAND6, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000018)	// 변화형 조슈아
	{
		itemID1 = "1006755";
		itemID2 = "1006763";
		trigger.message(TEXT_PACKAGE_MEDIATE_DIVINE_ARMS2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_MEDIATE_HAND7, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000032)	// 방출형 조슈아
	{
		itemID1 = "1006755";
		itemID2 = "1006759";
		trigger.message(TEXT_PACKAGE_MEDIATE_DIVINE_ARMS2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_MEDIATE_HAND6, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID1, 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem(itemID2, 30, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

//******************************************************
// 숙련 패키지 아이템
// 2006.11.14 written by Stunlee
//******************************************************
quest qUseItem1006586()			// 숙련 검투사 패키지(막시민 + 보리스용)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 보리스, 막시민 일때만 사용가능
	if (chType != CHAR_TYPE1 && chType != CHAR_TYPE2)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR1_CHAR2, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006382", 45, 14))					// 숙련 검투사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006380", 45, 14))					// 숙련 검투사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_HAND1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006376", 45, 14))					// 숙련 검투사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 숙련 무기
	if (trigger.getDBID() == 2000001 || trigger.getDBID() == 2000002)
	{
		itemID = "1006374";		// 물복 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_MASTERY_GLADIATOR_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000015 || trigger.getDBID() == 2000016)
	{
		itemID = "1006373";		// 베기 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_MASTERY_GLADIATOR_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000029 || trigger.getDBID() == 2000030) 
	{
		itemID = "1006375";		// 마검 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_MASTERY_GLADIATOR_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006587()			// 숙련 검투사 패키지(루시안 + 이스핀)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 루시안, 이스핀 일때만 사용가능
	if (chType != CHAR_TYPE0 && chType != CHAR_TYPE9)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR0_CHAR9, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006382", 45, 14))					// 숙련 검투사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006377", 45, 14))					// 숙련 검투사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_HAND2, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006376", 45, 14))					// 숙련 검투사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 숙련 무기
	if (trigger.getDBID() == 2000028 || trigger.getDBID() == 2000009) 
	{
		itemID = "1006371";		// 찌름 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_MASTERY_GLADIATOR_ARMS4, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000000 || trigger.getDBID() == 2000023) 
	{
		itemID = "1006372";		// 물복 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_MASTERY_GLADIATOR_ARMS5, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000014 || trigger.getDBID() == 2000037) 
	{
		itemID = "1006373";		// 베기 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_MASTERY_GLADIATOR_ARMS2, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006588()			// 숙련의 마법사 패키지(티치엘)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 티치엘 일때만 사용가능
	if (chType != CHAR_TYPE8)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR8, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006383", 45, 14))					// 숙련 마법사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_ARMMOR2, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006378", 45, 14))					// 숙련 마법사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_HAND3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006376", 45, 14))					// 숙련 마법사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 숙련 무기
	if (trigger.getDBID() == 2000008)
	{
		itemID = "1006368";		// 공격형 티치엘
		trigger.message(TEXT_PACKAGE_MASTERY_MAGICIAN_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000022)
	{
		itemID = "1006369";		// 보조형 티치엘
		trigger.message(TEXT_PACKAGE_MASTERY_MAGICIAN_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000036)
	{
		itemID = "1006370";		// 전투형 티치엘
		trigger.message(TEXT_PACKAGE_MASTERY_MAGICIAN_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006589()			// 숙련 해적 패키지(밀라)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 밀라 일때만 사용가능
	if (chType != CHAR_TYPE7)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR7, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006384", 45, 14))					// 숙련 해적 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_ARMMOR3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006379", 45, 14))					// 숙련 해적 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_HAND4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006376", 45, 14))					// 숙련 해적 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);


	// 숙련 무기
	if (trigger.getDBID() == 2000007)
	{
		itemID = "1006366";		// 베기형 밀라
		trigger.message(TEXT_PACKAGE_MASTERY_CORSAIR_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000021)
	{
		itemID = "1006367";		// 물복형 밀라
		trigger.message(TEXT_PACKAGE_MASTERY_CORSAIR_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000035)
	{
		itemID = "1006367";		// 물복형 밀라
		trigger.message(TEXT_PACKAGE_MASTERY_CORSAIR_ARMS2, MSG_TYPE__SYSTEM);
	}
	if (!GiveItem(itemID, 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006590()			// 숙련 버서커 패키지(시벨린)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 시벨린 일때만 사용가능
	if (chType != CHAR_TYPE3)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR3, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006382", 45, 14))				// 숙련 버서커 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006381", 45, 14))				// 숙련 버서커 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_HAND5, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006376", 45, 14))				// 숙련 버서커 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 숙련 무기
	if (trigger.getDBID() == 2000003)
	{
		itemID = "1006364";		// 찌름형 시벨린
		trigger.message(TEXT_PACKAGE_MASTERY_BUSUKER_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000017)
	{
		itemID = "1006365";		// 물복형 시벨린
		trigger.message(TEXT_PACKAGE_MASTERY_BUSUKER_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000031)
	{
		itemID = "1006365";		// 물복형 시벨린
		trigger.message(TEXT_PACKAGE_MASTERY_BUSUKER_ARMS2, MSG_TYPE__SYSTEM);
	}
	if (!GiveItem(itemID, 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006591()			// 숙련 어쌔신 패키지(나야트레이)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 나야트레이 일때만 사용가능
	if (chType != CHAR_TYPE10)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR10, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006384", 45, 14))			// 숙련 어쌔신 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_ARMMOR3, MSG_TYPE__SYSTEM);


	if (!GiveItem("1006379", 45, 14))			// 숙련 어쌔신 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_HAND4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006376", 45, 14))			// 숙련 어쌔신 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 숙련 무기
	if (trigger.getDBID() == 2000010)
	{
		itemID = "1006361";		// 찌름형 나야
		trigger.message(TEXT_PACKAGE_MASTERY_ASSASSIN_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000024)
	{
		itemID = "1006362";		// 물복형 나야
		trigger.message(TEXT_PACKAGE_MASTERY_ASSASSIN_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000038)
	{
		itemID = "1006363";		// 베기형 나야
		trigger.message(TEXT_PACKAGE_MASTERY_ASSASSIN_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

quest qUseItem1006772()			// 숙련 강령술사 패키지(조슈아)
{
	string itemID1, itemID2;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 조슈아 일때만 사용가능
	if (chType != CHAR_TYPE4)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR4, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006768", 45, 14))					// 숙련 강령술사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_ARMMOR4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006376", 45, 14))					// 숙련 강령술사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_MASTERY_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 숙련 무기
	if (trigger.getDBID() == 2000004)	// 강화형 조슈아
	{
		itemID1 = "1006752";
		itemID2 = "1006760";
		trigger.message(TEXT_PACKAGE_MASTERY_DIVINE_ARMS1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_MASTERY_HAND6, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000018)	// 변화형 조슈아
	{
		itemID1 = "1006756";
		itemID2 = "1006764";
		trigger.message(TEXT_PACKAGE_MASTERY_DIVINE_ARMS2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_MASTERY_HAND7, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000032)	// 방출형 조슈아
	{
		itemID1 = "1006756";
		itemID2 = "1006760";
		trigger.message(TEXT_PACKAGE_MASTERY_DIVINE_ARMS2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_MASTERY_HAND6, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID1, 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem(itemID2, 45, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}


//******************************************************
// 고급 패키지 아이템
// 2006.11.14 written by Stunlee
//******************************************************
quest qUseItem1006592()			// 고급 검투사 패키지(막시민 + 보리스용)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 보리스, 막시민 일때만 사용가능
	if (chType != CHAR_TYPE1 && chType != CHAR_TYPE2)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR1_CHAR2, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006406", 60, 14))		// 고급 검투사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006404", 60, 14))		// 고급 검투사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_HAND1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006400", 60, 14))		// 고급 검투사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_FOOTGEAR, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006323", 60, 14))		// 초보자 증표
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 고급 무기
	if (trigger.getDBID() == 2000001 || trigger.getDBID() == 2000002)
	{
		itemID = "1006398";		// 물복 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_HIGH_GLADIATOR_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000015 || trigger.getDBID() == 2000016)
	{
		itemID = "1006397";		// 베기 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_HIGH_GLADIATOR_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000029 || trigger.getDBID() == 2000030)
	{
		itemID = "1006399";		// 마검 보리스 & 막시민
		trigger.message(TEXT_PACKAGE_HIGH_GLADIATOR_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 60, 14))		// 초보자 증표
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
}

quest qUseItem1006593()			// 고급 검투사 패키지(루시안 + 이스핀)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 루시안, 이스핀 일때만 사용가능
	if (chType != CHAR_TYPE0 && chType != CHAR_TYPE9)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR0_CHAR9, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006406", 60, 14))		// 고급 검투사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_ARMMOR1, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006401", 60, 14))		// 고급 검투사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_HAND2, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006400", 60, 14))		// 고급 검투사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_FOOTGEAR, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006323", 60, 14))		// 초보자 증표
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 고급 무기
	if (trigger.getDBID() == 2000028 || trigger.getDBID() == 2000009)
	{
		itemID = "1006395";		// 찌름 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_HIGH_GLADIATOR_ARMS4, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000000 || trigger.getDBID() == 2000023)
	{
		itemID = "1006396";		// 물복 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_HIGH_GLADIATOR_ARMS5, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000014 || trigger.getDBID() == 2000037)
	{
		itemID = "1006397";		// 베기 루시안 & 이스핀
		trigger.message(TEXT_PACKAGE_HIGH_GLADIATOR_ARMS2, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
}

quest qUseItem1006594()			// 고급 마법사 패키지(티치엘)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 티치엘 일때만 사용가능
	if (chType != CHAR_TYPE8)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR8, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006407", 60, 14))		// 고급 마법사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_ARMMOR2, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006402", 60, 14))		// 고급 마법사 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_HAND3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006400", 60, 14))		// 고급 마법사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_FOOTGEAR, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006323", 60, 14))		// 초보자 증표
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 고급 무기
	if (trigger.getDBID() == 2000008)
	{
		itemID = "1006392";		// 공격형 티치엘
		trigger.message(TEXT_PACKAGE_HIGH_MAGICIAN_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000022)
	{
		itemID = "1006393";		// 보조형 티치엘
		trigger.message(TEXT_PACKAGE_HIGH_MAGICIAN_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000036)
	{
		itemID = "1006394";		// 전투형 티치엘
		trigger.message(TEXT_PACKAGE_HIGH_MAGICIAN_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
}

quest qUseItem1006595()			// 고급 해적 패키지(밀라)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 밀라 일때만 사용가능
	if (chType != CHAR_TYPE7)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR7, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006408", 60, 14))		// 고급 해적 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_ARMMOR3, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006403", 60, 14))		// 고급 해적 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_HAND4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006400", 60, 14))		// 고급 해적 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_FOOTGEAR, MSG_TYPE__SYSTEM);


	if (!GiveItem("1006323", 60, 14))		// 초보자 증표
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 고급 무기
	if (trigger.getDBID() == 2000007)
	{
		itemID = "1006390";		// 베기형 밀라
		trigger.message(TEXT_PACKAGE_HIGH_CORSAIR_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000021)
	{
		itemID = "1006391";		// 물복형 밀라
		trigger.message(TEXT_PACKAGE_HIGH_CORSAIR_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000035)
	{
		itemID = "1006391";		// 물복형 밀라
		trigger.message(TEXT_PACKAGE_HIGH_CORSAIR_ARMS2, MSG_TYPE__SYSTEM);
	}
	if (!GiveItem(itemID, 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
}

quest qUseItem1006596()			// 고급 버서커 패키지(시벨린)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 시벨린 일때만 사용가능
	if (chType != CHAR_TYPE3)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR3, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006406", 60, 14))		// 고급 버서커 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_ARMMOR1, MSG_TYPE__SYSTEM);
	
	if (!GiveItem("1006405", 60, 14))		// 고급 버서커 건틀릿
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_HAND5, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006400", 60, 14))		// 고급 버서커 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_FOOTGEAR, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006323", 60, 14))		// 초보자 증표
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 고급 무기
	if (trigger.getDBID() == 2000003)
	{
		itemID = "1006388";		// 찌름형 시벨린
		trigger.message(TEXT_PACKAGE_HIGH_BUSUKER_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000017)
	{
		itemID = "1006389";		// 물복형 시벨린
		trigger.message(TEXT_PACKAGE_HIGH_BUSUKER_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000031)
	{
		itemID = "1006389";		// 물복형 시벨린
		trigger.message(TEXT_PACKAGE_HIGH_BUSUKER_ARMS2, MSG_TYPE__SYSTEM);
	}
	if (!GiveItem(itemID, 60, 14))		// 고급 버서커 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
}

quest qUseItem1006597()			// 고급 어쌔신 패키지(나야트레이)
{
	string itemID;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	chType = trigger.getCharacterType();

	if(!ChkInven(5, 200)) return;

        // 나야트레이 일때만 사용가능
	if (chType != CHAR_TYPE10)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR10, MSG_TYPE__SYSTEM);
		return;
	}

	// 고급 어쌔신 메일
	if (!GiveItem("1006408", 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_ARMMOR3, MSG_TYPE__SYSTEM);

	// 고급 어쌔신 건틀릿
	if (!GiveItem("1006403", 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_HAND4, MSG_TYPE__SYSTEM);
	// 고급 어쌔신 신발
	if (!GiveItem("1006400", 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 고급 무기
	if (trigger.getDBID() == 2000010)
	{
		itemID = "1006385";		// 찌름형 나야
		trigger.message(TEXT_PACKAGE_HIGH_ASSASSIN_ARMS1, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000024)
	{
		itemID = "1006386";		// 물복형 나야
		trigger.message(TEXT_PACKAGE_HIGH_ASSASSIN_ARMS2, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000038)
	{
		itemID = "1006387";		// 베기형 나야
		trigger.message(TEXT_PACKAGE_HIGH_ASSASSIN_ARMS3, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID, 60, 14))		// 기부아이템~
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	Cash_Log();
}

quest qUseItem1006773()			// 중급 강령술사 패키지(조슈아)
{
	string itemID1, itemID2;
	integer chType;

	if(!NormalItemCanBeUsed()) return;

	// 아이템 지급 전에 슬롯이랑 무게랑 체크한다.
	if(!ChkInven(5, 200)) return;

	chType = trigger.getCharacterType();

        // 조슈아 일때만 사용가능
	if (chType != CHAR_TYPE4)
	{
		trigger.message(TEXT_PACKAGE_USE_CHAR4, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem("1006769", 60, 14))					// 숙련 강령술사 메일
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_ARMMOR4, MSG_TYPE__SYSTEM);

	if (!GiveItem("1006400", 60, 14))					// 숙련 강령술사 신발
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_HIGH_FOOTGEAR, MSG_TYPE__SYSTEM);

	// 초보자 증표
	if (!GiveItem("1006323", 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.message(TEXT_PACKAGE_BEGINNER_SYMBOL, MSG_TYPE__SYSTEM);

	// 숙련 무기
	if (trigger.getDBID() == 2000004)	// 강화형 조슈아
	{
		itemID1 = "1006753";
		itemID2 = "1006761";
		trigger.message(TEXT_PACKAGE_HIGH_DIVINE_ARMS1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_HIGH_HAND6, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000018)	// 변화형 조슈아
	{
		itemID1 = "1006757";
		itemID2 = "1006765";
		trigger.message(TEXT_PACKAGE_HIGH_DIVINE_ARMS2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_HIGH_HAND7, MSG_TYPE__SYSTEM);
	}
	else if (trigger.getDBID() == 2000032)	// 방출형 조슈아
	{
		itemID1 = "1006757";
		itemID2 = "1006761";
		trigger.message(TEXT_PACKAGE_HIGH_DIVINE_ARMS2, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_PACKAGE_HIGH_HAND6, MSG_TYPE__SYSTEM);
	}

	if (!GiveItem(itemID1, 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (!GiveItem(itemID2, 60, 14))
	{
		trigger.message(TEXT_PACKAGE_GIVE_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	Cash_Log();
}

//******************************************************
// 쪽지 아이템
// 2006.12.08 written by Han
//******************************************************
quest qUseItem1006747()		// 쪽지 보내기 수량 충전
{
	integer mailUseCount;

	if (!NormalItemCanBeUsed()) return;

	mailUseCount = trigger.getMailUseCount();


	if (mailUseCount >= 1)
	{
		trigger.message(TEXT_CASH_SEND_ITEM1, MSG_TYPE__SYSTEM);
		return;
	}
	else
	{
		// 최대 5를 넘을 수 없다.
		trigger.setMailUseCount(5);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		Cash_Log();
	}
}

//******************************************************
// 조슈아 제한 풀기 아이템
// 2006.12.08 written by Han
//******************************************************
quest qUseItem1006661()		// 할리퀸 마스크
{
	integer chType;
	integer nValue;

	integer episode		= 2;
	integer gSwitch		= 1;

	integer swCondition	= 2;
	integer swClear		= 3;

	integer mapChk = trigger.getWorld().getNumber();

	chType = trigger.getCharacterType();

	if (!NormalItemCanBeUsed()) return;

	// 싸움가능 지역, 이벤트월드 사용금지
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if (mapChk == 718 || mapChk == 719 || mapChk == 720 || mapChk == 721)
	{
		trigger.message(TEXT_CASH_NEW_CHAR_JOSUA2, MSG_TYPE__SYSTEM);
		return;
	}

	// 조슈아 체크
	if(chType != CHAR_TYPE4)
	{
		trigger.message(TEXT_CASH_NEW_CHAR_JOSUA_NOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getCookie("NEW_JOSUA") == "YES")
	{
		trigger.message(TEXT_CASH_NEW_CHAR_JOSUA, MSG_TYPE__SYSTEM);
		return;
	}

	nValue = trigger.getGlobalSwitch(episode, gSwitch);

	// 일본 전용 추가 기능 구현
	if (Util.getRealNationType() != JAPAN)
	{
		if (nValue <= 1)
		{
			trigger.setGlobalSwitch(episode, gSwitch, swCondition);
			trigger.sendGlobalSwitchForSwitch(episode, gSwitch);
			trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_JPlo02);
			trigger.updateAttr();

			BeginVE("1610.vse");
		}
	}

	if (nValue == swCondition)
	{
		// decrease number
		if (controller.canBeExhausted())
		{
			Cash_Log();
			controller.sweepNumbered(1);
		}

		trigger.setCookie("NEW_JOSUA", "YES", 0);

		// 스위치 값 변경
		trigger.setGlobalSwitch(episode, gSwitch, swClear);
		trigger.sendGlobalSwitchForSwitch(episode, gSwitch);
		trigger.putGlobalSwitchLog(episode,TEXT_EP2_CHAP00_J001);

		// false 일 경우
		if (trigger.isLimited())
			trigger.setLimited(false);	// 캐릭터 제한 풀기

		trigger.updateAttr();

		BeginVE("1611.vse");

		// 클라드 플리마켓으로 이동
		SetDynamicField(317,236,268);

		// send using effect
		controller.effectBy(trigger);
	}
	return;
}
