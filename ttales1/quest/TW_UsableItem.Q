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


quest
qPickItem()
{
//	// check type class. only item can call this quest
//	if (controller.getTypeName() != "Item") {
//		Util.log("! invalid type [" + controller.getTypeName() + "] instead of item");
//		return;
//	}
//
//	// TODO: check item class and determin which jobs should be done
}


quest
qDropItem()
{
//	// check type class. only item can call this quest
//	if (controller.getTypeName() != "Item") {
//		Util.log("! invalid type [" + controller.getTypeName() + "] instead of item");
//		return;
//	}
//
//	// TODO: check item class and determin which jobs should be done
}

quest
qCanGiveToUser()
{
	// ¿¸º”¿ª «“ ºˆ ¿÷¥¬ æ∆¿Ã≈€ ¿Øπ´ √º≈© 1¿Ã∏È ∞°¥… 0¿Ã∏È ∫“∞°
	if (controller.canBelong() == 1)
	{
		if (controller.getClassName() == "1006166")
		{
			if (controller.getAttribute("meetuser") == null)
				controller.setAttribute("meetuser", trigger.getName());
		}
/*
		if (!controller.isCashItem())
		{
			trigger.message(TEXT_CASHITEM_NOT_BELONG, MSG_TYPE__SYSTEM);
			return;
		}
*/
		// ¿ÃπÃ ¿¸º”¿ª «— æ∆¿Ã≈€ ¿Œ∞°∏¶ √º≈© (0¿Ã∏È ∞°¥… 1¿Ã∏È ∫“∞°)
		if (controller.belong() == 0)
		{
			// º≠πˆø°º≠ setBelong √≥∏Æ
//			controller.setBelong(1);
			Machine.setBooleanReturn(true);
		}
		else
			Machine.setBooleanReturn(false);
	}
	else
		Machine.setBooleanReturn(false);
}

quest
qCanDropCash()
{
	if (Util.getRealNationType() == JAPAN)
		Machine.setBooleanReturn(true);
	else
		Machine.setBooleanReturn(false);
}


quest
qDropCashItem()
{
	integer iSeed, nSeed;
	string iName;
	iName = controller.getClassName();

	if (Util.getRealNationType() == JAPAN ) {
		iSeed = controller.getPrice() / 4;
//		if (iSeed < 1)		// vahma - setting for japan
			iSeed = 1;

		nSeed = trigger.getAvailGold();
		if (nSeed < iSeed) {
			trigger.setGold(trigger.getGold() + iSeed);
			iSeed = nSeed;
		} else {
			trigger.setGold(trigger.getGold() + iSeed);
		}

		trigger.message(TEXT_CASH_ITEM_DROP_SEED + iSeed, MSG_TYPE__SYSTEM);
		Util.log("! Cash Item Drop! # Item[ " + iName + " / " + controller.getDescClassNamed(iName) + " : " + iSeed + "], User[" + trigger.getName() + "], when[" + Util.getTimeString("%A %b %d %T") + "] at [" + trigger.getWorld().getNumber() + "]");
	} else {
		trigger.message(TEXT_CASH_ITEM_DROP, MSG_TYPE__SYSTEM);
		Util.log("! Cash Item Drop! # Item[ " + iName + " / " + controller.getDescClassNamed(iName) + "], User[" + trigger.getName() + "], when[" + Util.getTimeString("%A %b %d %T") + "] at [" + trigger.getWorld().getNumber() + "]");
	}
	controller.sweep();
}


quest
qUseItem()
{
//	string useQuestName;
//	useQuestName	= "qUseItem" + controller.getClassName();
//	controller.giveQuestTo(useQuestName, trigger, /* no argument */"");
}


function boolean
checkMinMax(object item, integer TEIP)
{
	integer current = item.getTEIP(TEIP);

	if (current <= 0) {
		trigger.message(CANT_USE_FOR_ZERO_VALUE , MSG_TYPE__SYSTEM);
		return false;
	}
	if (current >= item.getMaxTEIP(TEIP)) {
		trigger.message(CANT_USE_FOR_MAX_VALUE , MSG_TYPE__SYSTEM);
		return false;
	}
	return true;
}

function boolean
checkMinMaxOfMax(object item, integer TEIP, integer value)
{
	integer tmpValue = item.getMaxTEIP(TEIP) + value;

	if (tmpValue <= 0) {
		trigger.message(CANT_USE_FOR_ZERO_VALUE_MAX , MSG_TYPE__SYSTEM);
		return false;
	}
	if (tmpValue > 255) {
		trigger.message(CANT_USE_FOR_MAX_VALUE_MAX , MSG_TYPE__SYSTEM);
		return false;
	}
	return true;
}

function boolean
checkMinOfMax(object item, integer TEIP, integer value)
{
	integer tmpValue = item.getTEIP(TEIP) + value;

	if (tmpValue <= 0) {
		trigger.message(CANT_USE_FOR_ZERO_VALUE , MSG_TYPE__SYSTEM);
		return false;
	}
	if (tmpValue > 255) {
		trigger.message(CANT_USE_FOR_MAX_VALUE , MSG_TYPE__SYSTEM);
		return false;
	}
	return true;
}

function boolean
checkManufactureCnt(object item)
{
	if (item.getManufactureCnt() >= item.getMaxManufactureCnt()) {
		trigger.message(TEXT_USABLEITEM_MAX_MANUFACTURE , MSG_TYPE__SYSTEM);
		return false;
	} else
		return true;
}

function void
checkCrack(object item, integer randomValue)		// æ∆¿Ã≈€ ∆ƒº’ √≥∏ÆøÎ «‘ºˆ by stsoul
{
	integer randcnt = Util.random(0, 99);
	integer mapChk = trigger.getWorld().getNumber();
	integer chkvalue = 0 - randomValue;

	if (mapChk == 7 || mapChk == 114) {
		randcnt = randcnt - 5;
	} else if (mapChk == 47 || mapChk == 50 || mapChk == 303 || mapChk == 317) {
		randcnt = randcnt - 3;
	}

	if (trigger.getCharacterType() == CHAR_TYPE0 || trigger.getCharacterType() == CHAR_TYPE8) {
		randcnt = randcnt - 2;
	}

	if (randcnt < 50) return 0;
	if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, chkvalue)) return 0;
	if (!checkMinMaxOfMax(item, TEIP__FIRMNESS, chkvalue)) return 0;

	item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - randomValue);
	item.setTEIP(TEIP__FIRMNESS, item.getTEIP(TEIP__FIRMNESS) - randomValue);
	trigger.message(TEXT_USABLEITEM_MINUS_ENDURANCE1 + randomValue + TEXT_USABLEITEM_MINUS_ENDURANCE2 , MSG_TYPE__SYSTEM);
	trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE1 + randomValue + TEXT_USABLEITEM_MINUS_ENDURANCE2 , MSG_TYPE__SYSTEM);
	return 1;
}


function boolean
checkBreak(object item)				// æ∆¿Ã≈€ ∆ƒ±´ √≥∏Æ ∞¸∑√ √º≈©øÎ «‘ºˆ by stsoul
{
	integer randcnt = Util.random(0, 99);
	integer mapChk = trigger.getWorld().getNumber();

	if (!item.canBeUnequippedBy(trigger)) return false;
//	if (!item.canBeUsedBy(trigger)) return false;

	if (item.getManufactureCnt() > 3)
		randcnt = randcnt + 30;
	else if (item.getManufactureCnt() > 2)
		randcnt = randcnt + 20;
	else if (item.getManufactureCnt() > 1)
		randcnt = randcnt + 10;

	if (mapChk == 7 || mapChk == 114)
		randcnt = randcnt - 7;
	else if (mapChk == 47 || mapChk == 50 || mapChk == 303 || mapChk == 317)
		randcnt = randcnt - 4;

	if (trigger.getCharacterType() == CHAR_TYPE0 || trigger.getCharacterType() == CHAR_TYPE8) {
		randcnt = randcnt - 2;
	}

	if (randcnt > 60) {
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_ITEM , MSG_TYPE__SYSTEM);
		item.sweep();
//		trigger.removeItemClassNamed(item.getClassName(), 1);

		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return false;
	} else
		return true;
}


function boolean
checkDeCount(object item, integer success)				// æ∆¿Ã≈€ «’º∫»∏ºˆ ∞®º“ √≥∏Æ ∞¸∑√ √º≈©øÎ «‘ºˆ by stsoul
{
	integer randcnt = Util.random(0, 99);
	integer mapChk = trigger.getWorld().getNumber();

	if (!item.canBeUnequippedBy(trigger)) return false;
//	if (!item.canBeUsedBy(trigger)) return false;

	if (item.getManufactureCnt() > 3)
		randcnt = randcnt;
	else if (item.getManufactureCnt() > 2)
		randcnt = randcnt + 10;
	else if (item.getManufactureCnt() > 1)
		randcnt = randcnt + 20;

	if (mapChk == 7 || mapChk == 114)
		success = success + 100;
	else if (mapChk == 47 || mapChk == 50 || mapChk == 303 || mapChk == 317)
		success = success + 100;

	if (trigger.getCharacterType() == CHAR_TYPE0 || trigger.getCharacterType() == CHAR_TYPE8) {
		success = success + 100;
	}

	if (randcnt < (100 - success)) {
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_ITEM , MSG_TYPE__SYSTEM);
		item.sweep();
//		trigger.removeItemClassNamed(item.getClassName(), 1);

		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return false;
	} else
		return true;
}


function boolean
NormalItemCanBeUsed()
{
	if (trigger.isDead()) {
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return false;
	} else {
		return true;
	}
}

function boolean
ResurrectItemCanBeUsed(object target)
{
	if (target.isAlive()) {
		trigger.message(CANT_USE_FOR_NON_GHOST, MSG_TYPE__SYSTEM);
		return false;
	} else if (target.getWorld().canPK()) {
		if (trigger.getWorld().getNumber() == 103) {		// øÓøµøÎ PK « µÂ¿œ ∞ÊøÏ øπø‹√≥∏Æ
			return true;
		} else {
			trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, MSG_TYPE__SYSTEM);
			return false;
		}
	} else {
		return true;
	}
}

function boolean
ItemDownHP(object target, integer value)
{
	integer oldValue;
	integer newValue;

	// ¿«µµµ» πŸøÕ Ω«¡¶ Ω∫≈©∏≥∆Æ ≥ªøÎ¿Ã ¥Ÿ∏£∞‘ ±∏«ˆµ«æÓ ¿÷æÓº≠ ºˆ¡§«‘.
	// value = value + target.getHP() * target.getDefence() / 2 / 100;
	// value = value - value * target.getDefence() / 2 / 100;
	value = (value - (value * target.getDefence() / 256)) / 2;

	if (value <= 0) {
		// do nothing
		return true;
	} else if (target.getHP() <= 1) {
		return false;
	} else {
		oldValue = target.getHP();

		if (oldValue - value <= 1) target.setHP(1);
		else target.setHP(oldValue - value);

		newValue = target.getHP();

		// update attribute
		target.updateAttr();

		// send message
		target.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_HP + (oldValue - newValue) + TEXT_USABLEITEM_ENDURANCE_MESSAGE_DOWN, MSG_TYPE__SYSTEM);
		return true;
	}
}


function boolean
ItemUpHP(object target, integer value)
{
	integer oldValue;
	integer newValue;

	if (target.isState(CREATURE_STATE__NO_HP_REGEN)) {
		target.message(CANT_USE_FOR_NO_HP_REGEN_STATE, MSG_TYPE__SYSTEM);
		return false;
	}

	if (!target.getWorld().canUsePotion()) {
		target.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_FILED, MSG_TYPE__SYSTEM);
		return false;
	}

	// ≥Ïªˆ «≥º± »∏∫π √≥∏Æ. ¿”Ω√ -_-;
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004467")
		value = value + (value * 3 / 10) + value * target.getDefence() / 2 / 100;
	else
		value = value + value * target.getDefence() / 2 / 100;

	// √º∑¬¿Ã 0 ¿œ∂ßµµ »∏∫πµ«¥¬ πˆ±◊ ºˆ¡§. ƒ≥∏Ø≈Õ∞° ¡◊æÓ¿÷¿ª∂ßø°¥¬ «„∞°. (∫Œ»∞ æ∆¿Ã≈€ ªÁøÎ)
	if(target.isAlive() && target.getHP()==0)
		return false;

	if (value <= 0) {
		Util.log("! invalid hp value " + value + " in ItemUpHP()");
		return false;
	} else if (target.getMaxHP() == target.getHP()) {
		target.message(HP_UP_MESSAGE_PREFIX + FULL_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return false;
	} // else {
		oldValue = target.getHP();

		if (target.getMaxHP() < oldValue + value)
			target.setHP(target.getMaxHP());
		else
			target.setHP(oldValue + value);

		newValue = target.getHP();
		//Util.log("old " + oldValue);
		//Util.log("new " + newValue);

		// update attribute
		target.updateAttr();

		// send message
		target.message(HP_UP_MESSAGE_PREFIX + (newValue - oldValue) + HP_UP_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return true;
	// }
}

function boolean
ItemBalloonUpHP(object target, integer value)
{
	integer oldValue;
	integer newValue;

	if (target.isState(CREATURE_STATE__NO_HP_REGEN)) {
		target.message(CANT_USE_FOR_NO_HP_REGEN_STATE, MSG_TYPE__SYSTEM);
		return false;
	}

	if (!target.getWorld().canUsePotion()) {
		target.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_FILED, MSG_TYPE__SYSTEM);
		return false;
	}

	value = value * 3 / 10;

	// √º∑¬¿Ã 0 ¿œ∂ßµµ »∏∫πµ«¥¬ πˆ±◊ ºˆ¡§. ƒ≥∏Ø≈Õ∞° ¡◊æÓ¿÷¿ª∂ßø°¥¬ «„∞°. (∫Œ»∞ æ∆¿Ã≈€ ªÁøÎ)
	if(target.isAlive() && target.getHP()==0)
		return false;

	if (value <= 0) {
		Util.log("! invalid hp value " + value + " in ItemUpHP()");
		return false;
	} else if (target.getMaxHP() == target.getHP()) {
		target.message(HP_UP_MESSAGE_PREFIX + FULL_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return false;
	} // else {

	oldValue = target.getHP();

	if (target.getMaxHP() < oldValue + value)
		target.setHP(target.getMaxHP());
	else
		target.setHP(oldValue + value);

	newValue = target.getHP();
	//Util.log("old " + oldValue);
	//Util.log("new " + newValue);

	// update attribute
	target.updateAttr();

	// send message
	target.message(HP_UP_MESSAGE_BALLOON + (newValue - oldValue) + HP_UP_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
	return true;
	// }
}

function boolean
ItemDownMP(object target, integer value)
{
	integer oldValue;
	integer newValue;

	// ¿«µµµ» πŸøÕ Ω«¡¶ Ω∫≈©∏≥∆Æ ≥ªøÎ¿Ã ¥Ÿ∏£∞‘ ±∏«ˆµ«æÓ ¿÷æÓº≠ ºˆ¡§«‘.
	// value = value + target.getMP() * target.getMagicResist() / 4 / 100;
	value = value - value * target.getMagicResist() / 4 / 100;

	if (value <= 0) {
		// do nothing
		return true;
	} else if (target.getMP() < value) {
		return false;
	} else {
		oldValue = target.getMP();
		target.setMP(oldValue - value);

		newValue = target.getMP();

		// update attribute
		target.updateAttr();

		// send message
		target.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_MP + (oldValue - newValue) + TEXT_USABLEITEM_ENDURANCE_MESSAGE_DOWN, MSG_TYPE__SYSTEM);
		return true;
	}
}

function boolean
ItemUpMP(object target, integer value)
{
	integer oldValue;
	integer newValue;

	if (target.isState(CREATURE_STATE__NO_MP_REGEN)) {
		target.message(CANT_USE_FOR_NO_MP_REGEN_STATE, MSG_TYPE__SYSTEM);
		return false;
	}

	// ≥Î∂ı «≥º± »∏∫π √≥∏Æ. ¿”Ω√ -_-;
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")
		value = value + (value * 3 / 10) + target.getMagicResist() / 4 * target.getMP() / 150;
	else
		// πˆ±◊ ¡ˆº”¿∏∑Œ ¿Œ«ÿ ¬•¡ı≥™¥¬ ªÛ≈¬∞° µ«æ˙¿∏π«∑Œ ¥Ÿ¿Ω∞˙ ∞∞¿Ã ºˆ¡§«ﬂ¿∏∏Á ∞Ëº” ∞Ì√ƒ≥™∞°æﬂ «‘. 122 -> 150
		value = value + target.getMagicResist() / 4 * target.getMP() / 150;
		//value = value + value * target.getMagicResist() / 4 / 100;

	if (value <= 0) {
		Util.log("! invalid mp value " + value + " in ItemUpMP()");
		return false;
	} else if (target.getMaxMP() == target.getMP()) {
		target.message(MP_UP_MESSAGE_PREFIX + FULL_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return false;
	} else {
		oldValue = target.getMP();

		if (target.getMaxMP() < oldValue + value) target.setMP(target.getMaxMP());
		else target.setMP(oldValue + value);

		newValue = target.getMP();
		//Util.log("old " + oldValue);
		//Util.log("new " + newValue);

		// update attribute
		target.updateAttr();

		// send message
		target.message(MP_UP_MESSAGE_PREFIX + (newValue - oldValue) + MP_UP_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return true;
	}
}

function boolean
ItemBalloonUpMP(object target, integer value)
{
	integer oldValue;
	integer newValue;

	if (target.isState(CREATURE_STATE__NO_MP_REGEN)) {
		target.message(CANT_USE_FOR_NO_MP_REGEN_STATE, MSG_TYPE__SYSTEM);
		return false;
	}

	value = value * 3 / 10;

	if (value <= 0) {
		Util.log("! invalid mp value " + value + " in ItemUpMP()");
		return false;
	} else if (target.getMaxMP() == target.getMP()) {
		target.message(MP_UP_MESSAGE_PREFIX + FULL_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return false;
	} else {
		oldValue = target.getMP();

		if (target.getMaxMP() < oldValue + value) target.setMP(target.getMaxMP());
		else target.setMP(oldValue + value);

		newValue = target.getMP();
		//Util.log("old " + oldValue);
		//Util.log("new " + newValue);

		// update attribute
		target.updateAttr();

		// send message
		target.message(MP_UP_MESSAGE_BALLOON + (newValue - oldValue) + MP_UP_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return true;
	}
}

function boolean
ItemDownSP(object target, integer value)
{
	integer oldValue;
	integer newValue;

	// ¿«µµµ» πŸøÕ Ω«¡¶ Ω∫≈©∏≥∆Æ ≥ªøÎ¿Ã ¥Ÿ∏£∞‘ ±∏«ˆµ«æÓ ¿÷æÓº≠ ºˆ¡§«‘.
	// value = value + target.getSP() * target.getSP() / 3 / 100;
	// value = value + value * target.getSP() / 3 / 100;
	value = value - value * target.getDex() / 3 / 100;

	if (value <= 0) {
		// do nothing
		return true;
	} else if (target.getSP() < value) {
		return false;
	} else {
		oldValue = target.getSP();
		target.setSP(oldValue - value);

		newValue = target.getSP();

		// update attribute
		target.updateAttr();

		// send message
		target.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_SP + (oldValue - newValue) + TEXT_USABLEITEM_ENDURANCE_MESSAGE_DOWN, MSG_TYPE__SYSTEM);
		return true;
	}
}

function boolean
ItemUpSP(object target, integer value)
{
	integer oldValue;
	integer newValue;

	if (target.isState(CREATURE_STATE__NO_SP_REGEN)) {
		target.message(CANT_USE_FOR_NO_SP_REGEN_STATE, MSG_TYPE__SYSTEM);
		return false;
	}

	// ¿«µµµ» πŸøÕ Ω«¡¶ Ω∫≈©∏≥∆Æ ≥ªøÎ¿Ã ¥Ÿ∏£∞‘ ±∏«ˆµ«æÓ ¿÷æÓº≠ ºˆ¡§«‘.
	// value = value + target.getSP() * target.getSP() / 3 / 100;
	// value = value + value * target.getSP() / 3 / 100;
	value = value + value * target.getDex() / 3 / 100;

	if (value <= 0) {
		Util.log("! invalid sp value " + value + " in ItemUpSP()");
		return false;
	} else if (target.getMaxSP() == target.getSP()) {
		target.message(SP_UP_MESSAGE_PREFIX + FULL_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return false;
	} else {
		oldValue = target.getSP();

		if (target.getMaxSP() < oldValue + value) target.setSP(target.getMaxSP());
		else target.setSP(oldValue + value);

		newValue = target.getSP();

		//Util.log("old " + oldValue);
		//Util.log("new " + newValue);

		// update attribute
		target.updateAttr();

		// send message
		target.message(SP_UP_MESSAGE_PREFIX + (newValue - oldValue) + SP_UP_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return true;
	}
}

function boolean
UseSkill(object target, string skillID, integer duration)
{
	if (!NormalItemCanBeUsed()) return false;

	// decrease number
	if (controller.canBeExhausted())  controller.decreaseNumber(1);

	target.castNamedWithDuration(skillID,duration);

	// send using effect
	controller.effectBy(target);
	target.message(TEXT_USABLEITEM_MESSAGE1 + trigger.getName() + TEXT_USABLEITEM_MESSAGE2 + controller.getDesc() + TEXT_USABLEITEM_MESSAGE_GET_ITEM, MSG_TYPE__SYSTEM);
	Util.log("##Skill item use [" + trigger.getName() + "] when [" + Util.getTimeString("%A %b %d %T") + "] Skill ID [ " + skillID + " ]");

	return true;
}

function boolean
UseSkillByProb(object target, string skillID, integer duration, integer deno, integer mole)
{
	if (!NormalItemCanBeUsed()) return false;

	// decrease number
	if (controller.canBeExhausted())  controller.decreaseNumber(1);

	if (Util.random(1, deno) < mole)	target.castNamedWithDuration(skillID,duration);
	else return false;

	// send using effect
	controller.effectBy(target);
	target.message(TEXT_USABLEITEM_MESSAGE1 + trigger.getName() + TEXT_USABLEITEM_MESSAGE2 + controller.getDesc() + TEXT_USABLEITEM_MESSAGE_GET_ITEM, MSG_TYPE__SYSTEM);

	return true;
}


function boolean
ItemGetEXP(object target, integer value)
{
	integer tLV, uLV, LV, gExp;

	if (target.getCookie("RESR") != null) {
		trigger.message(TEXT_RESURRECT_TIME, MSG_TYPE__SYSTEM);
		return false;
	}

	uLV = trigger.getLevel();
	tLV = target.getLevel();

	if (tLV <= uLV)
		LV = 1;
	else
		LV = tLV - uLV;

	if (LV >= 50)
		gExp = 500;
	else
		gExp = 10 * LV;

	gExp = gExp / value;

	if (gExp < 1)
		gExp = 1;

	// 1»∏ ∫Œ»∞µ«∏È 1∫– ¿ÃªÛ ªÛ¥ÎπÊø°∞‘ ∫Œ»∞ ∞Ê«Ëƒ° ¡¶∞¯ æ»«‘
	target.setCookie("RESR", "ALR", 60 + LV);
	trigger.addExp(gExp);
	return true;
}


quest
WriteLoveConfession()
{
	controller.setAttribute("LOVE_MESSAGE", Util.filterCurse(trigger.getQuestArgument()) + " </n></n><c9></r>[From " + trigger.getName() + "]");
	trigger.message(TEXT_LOVE_CONFESSION_WRITE, MSG_TYPE__SYSTEM);
}

quest
LOVE_INPUT()					// ∞ÌπÈ æ≤±‚
{
	trigger.sendDescribeQuestMessage(TEXT_LOVE_CONFESSION_INPUT, "WriteLoveConfession", controller);
}

quest
LOVE_CANCEL()					// ∞ÌπÈ æ≤±‚ ∞≈∫Œ
{
	trigger.message(TEXT_LOVE_CONFESSION_FAIL, MSG_TYPE__SYSTEM);
}




// EACH item
quest
qUseItem1000013()				// ∑πµÂ «„∫Í
{
/*
	Util.log("- in");

	controller.cast("0", trigger);
*/

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// hp 30 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 30)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 30)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 30);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000014()				// µ˛±‚ Ω√∑¥
{
/*
	Util.log("- in2");
	controller.cast("1", trigger);
*/

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// hp 60 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 60)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 60)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 60);
	}
	
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000015()				// µ˛±‚ ¡÷Ω∫
{
/*
	Util.log("- in3");
	controller.cast("2", trigger);
*/

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// hp 120 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 120)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 120)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 120);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000016()				// »˙∏µ ∆˜º« (º“)
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// hp 200 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 200)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 200)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 200);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000017()				// »˙∏µ ∆˜º« (¡ﬂ)
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// hp 350 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 350)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 350)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 350);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000018()				// »˙∏µ ∆˜º« (¥Î)
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// hp 500 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 500)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 500)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 500);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000019()				// ∂Û¿Ã«¡ ∆˜º« (º“)
{
	integer toUp;
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// max hp ¿« 10% ∏∏≈≠
	toUp = trigger.getMaxHP() * 10 / 100;
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, toUp)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, toUp)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, toUp);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000020()				// ∂Û¿Ã«¡ ∆˜º« (¡ﬂ)
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// max hp ¿« 30% ∏∏≈≠
	toUp = trigger.getMaxHP() * 30 / 100;
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, toUp)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, toUp)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, toUp);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000021()				// ∂Û¿Ã«¡ ∆˜º« (¥Î)
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// max hp ¿« 50% ∏∏≈≠
	toUp = trigger.getMaxHP() * 50 / 100;
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, toUp)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, toUp)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, toUp);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000022()				// ª˝∏Ì¿« ¡∂∞¢
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_HP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_HP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// max hp ¿« 100% ∏∏≈≠
	toUp = trigger.getMaxHP();
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, toUp)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, toUp)) return;
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest						// ±◊∏∞ «„∫Í
qUseItem1000024()
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// mp 10 »∏∫π
	if (!HardCode.itemUpMP(trigger, 10)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 10);

	// send using effect
	controller.effectBy(trigger);
}

quest						// ≈∞¿ß Ω√∑¥
qUseItem1000025()
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// mp 20 »∏∫π
	if (!HardCode.itemUpMP(trigger, 20)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 20);

	// send using effect
	controller.effectBy(trigger);
}

quest						// ≈∞¿ß ¡÷Ω∫
qUseItem1000026()
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// mp 30 »∏∫π
	if (!HardCode.itemUpMP(trigger, 30)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 30);

	// send using effect
	controller.effectBy(trigger);
}

quest						// ∏∂≥™ ∆˜º« (º“)
qUseItem1000027()
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// mp 60 »∏∫π
	if (!HardCode.itemUpMP(trigger, 60)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 60);

	// send using effect
	controller.effectBy(trigger);
}

quest						// ∏∂≥™ ∆˜º« (¡ﬂ)
qUseItem1000028()
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// mp 90 »∏∫π
	if (!HardCode.itemUpMP(trigger, 90)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 90);

	// send using effect
	controller.effectBy(trigger);
}

quest						// ∏∂≥™ ∆˜º« (¥Î)
qUseItem1000029()
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// mp 120 »∏∫π
	if (!HardCode.itemUpMP(trigger, 120)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 120);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000030()				// ø°≥ ¡ˆ ∆˜º« (º“)
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// max mp ¿« 10% ∏∏≈≠
	toUp = trigger.getMaxMP() * 10 / 100;
	if (!HardCode.itemUpMP(trigger, toUp)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, toUp);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000031()				// ø°≥ ¡ˆ ∆˜º« (¡ﬂ)
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// max mp ¿« 30% ∏∏≈≠
	toUp = trigger.getMaxMP() * 30 / 100;
	if (!HardCode.itemUpMP(trigger, toUp)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, toUp);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000032()				// ø°≥ ¡ˆ ∆˜º« (¥Î)
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// max mp ¿« 50% ∏∏≈≠
	toUp = trigger.getMaxMP() * 50 / 100;
	if (!HardCode.itemUpMP(trigger, toUp)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, toUp);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000033()				// ∏∂≥™¿« ∞·¡§
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_MP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_MP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// max mp ¿« 100% ∏∏≈≠
	toUp = trigger.getMaxMP();
	if (!HardCode.itemUpMP(trigger, toUp)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}


quest
qUseItem1000035()				// πŸ¿Ãø√∑ø «„∫Í
{
	object target;
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	target = controller.getObjectArgumentAt(0);
	if (!target) return;
	if (!ResurrectItemCanBeUsed(target)) return;

	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);

	toUp = 1;
	HardCode.itemUpHP(target, toUp);
	// ≥Ïªˆ «≥º± »∏∫π √≥∏Æ. ¿”Ω√
	// if (target.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004467")
	//	if (!ItemBalloonUpHP(target, toUp)) return;

	target.resurrect(false);
	ItemGetEXP(target, 7);
	controller.effectBy(target);
}

quest
qUseItem1000036()				// ∏ÆπŸ¿Ã∫Í ∆ƒøÏ¥ı
{
	object target;
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	target = controller.getObjectArgumentAt(0);
	if (!target) return;
	if (!ResurrectItemCanBeUsed(target)) return;

	if (controller.canBeExhausted())
    	controller.decreaseNumber(1);

	toUp = 10;
	HardCode.itemUpHP(target, toUp);
	// ≥Ïªˆ «≥º± »∏∫π √≥∏Æ. ¿”Ω√
	// if (target.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004467")
	//	if (!ItemBalloonUpHP(target, toUp)) return;

	target.resurrect(false);
	ItemGetEXP(target, 6);
	controller.effectBy(target);
}

quest
qUseItem1000037()				// ∏ÆπŸ¿Ã∫Í µÂ∏µ≈©
{
	object target;
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	target = controller.getObjectArgumentAt(0);
	if (!target) return;
	if (!ResurrectItemCanBeUsed(target)) return;

	if (controller.canBeExhausted())
    	controller.decreaseNumber(1);

	toUp = 50;
	HardCode.itemUpHP(target, toUp);
	// ≥Ïªˆ «≥º± »∏∫π √≥∏Æ. ¿”Ω√
	// if (target.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004467")
	//	if (!ItemBalloonUpHP(target, toUp)) return;

	target.resurrect(false);
	ItemGetEXP(target, 5);
	controller.effectBy(target);
}

quest
qUseItem1000038()				// ∏Æº≠∑∫º« ∆˜º«(º“)
{
	object target;
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	target = controller.getObjectArgumentAt(0);
	if (!target) return;
	if (!ResurrectItemCanBeUsed(target)) return;

	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);

	toUp = target.getMaxHP() * 10 / 100;
	HardCode.itemUpHP(target, toUp);
	// ≥Ïªˆ «≥º± »∏∫π √≥∏Æ. ¿”Ω√
	//if (target.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004467")
	//if (!ItemBalloonUpHP(target, toUp)) return;

	toUp = target.getMaxMP() * 10 / 100;
	HardCode.itemUpMP(target, toUp);
	// ≥Î∂ı «≥º± »∏∫π √≥∏Æ. ¿”Ω√
	//if (target.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")
	//if (!ItemBalloonUpMP(target, toUp)) return;

	target.resurrect(false);
	ItemGetEXP(target, 4);
	controller.effectBy(target);
}

quest
qUseItem1000039()				// ∏Æº≠∑∫º« ∆˜º«(¡ﬂ)
{
	object target;
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	target = controller.getObjectArgumentAt(0);
	if (!target) return;
	if (!ResurrectItemCanBeUsed(target)) return;

	if (controller.canBeExhausted())
    	controller.decreaseNumber(1);

	toUp = target.getMaxHP() * 30 / 100;
	HardCode.itemUpHP(target, toUp);
	// ≥Ïªˆ «≥º± »∏∫π √≥∏Æ. ¿”Ω√
	//if (target.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004467")
	//if (!ItemBalloonUpHP(target, toUp)) return;

	toUp = target.getMaxMP() * 30 / 100;
	HardCode.itemUpMP(target, toUp);
	// ≥Î∂ı «≥º± »∏∫π √≥∏Æ. ¿”Ω√
	// if (target.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")
	//if (!ItemBalloonUpMP(target, toUp)) return;

	target.resurrect(false);
	ItemGetEXP(target, 3);
	controller.effectBy(target);
}

quest
qUseItem1000040()				// ∏Æº≠∑∫º« ∆˜º«(¥Î)
{
	object target;
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	target = controller.getObjectArgumentAt(0);
	if (!target) return;
	if (!ResurrectItemCanBeUsed(target)) return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	toUp = target.getMaxHP() * 50 / 100;
	HardCode.itemUpHP(target, toUp);
	// ≥Ïªˆ «≥º± »∏∫π √≥∏Æ. ¿”Ω√
	//if (target.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004467")
	//	if (!ItemBalloonUpHP(target, toUp)) return;

	toUp = target.getMaxMP() * 50 / 100;
	HardCode.itemUpMP(target, toUp);
	// ≥Î∂ı «≥º± »∏∫π √≥∏Æ. ¿”Ω√
	//if (target.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")
	//	if (!ItemBalloonUpMP(target, toUp)) return;

	target.resurrect(false);
	ItemGetEXP(target, 2);
	controller.effectBy(target);
}

quest
qUseItem1000041()				// ø§∏Øº≠
{
	object target;
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	target = controller.getObjectArgumentAt(0);
	if (!target) return;
	if (!ResurrectItemCanBeUsed(target)) return;

	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);

	toUp = target.getMaxHP();
	HardCode.itemUpHP(target, toUp);
	toUp = target.getMaxMP();
	HardCode.itemUpMP(target, toUp);
	toUp = target.getMaxSP();
	ItemUpSP(target, toUp);

	target.resurrect(false);
	ItemGetEXP(target, 1);
	controller.effectBy(target);
}

quest
qUseItem1000149()				// ¿Æ
{
	object loc;

	if(!NormalItemCanBeUsed()) return;

	// discard if world is event world
	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

//	if (!trigger.getWorld().canTeleport()) {
	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isAlive()) return;
	// if (controller.canBeExhausted())
	    // controller.decreaseNumber(1);

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	controller.sweepNumbered(1);
/*
	if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		loc = Location.create();
		loc.set(667,255,253);

		trigger.teleportTo(loc);
		return;
	}
*/
	// send using effect
	// controller.effectBy(trigger);

	trigger.teleportTo(trigger.lastVisitedVillageLoc());
}


quest
qUseItem1002968()				// ≈¨∂ÛµÂ øˆ«¡ ƒ´µÂ
{
	object loc;
	// ¥Î∏∏µÓø° ¿˚øÎ«“ ∂© ª©º≠ ¿˚øÎ«ÿæﬂ «‘. isPaid
	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isAlive()) return;

	if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_NOT_GROUP, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	// controller.decreaseNumber(1);
	controller.sweepNumbered(1);

	// controller.effectBy(trigger);

	loc = Location.create();
	loc.set(1, 300, 300);

	trigger.teleportTo(loc);
}

quest
qUseItem1002969()				// ≥™∏£∫Ò≈© øˆ«¡ ƒ´µÂ
{
	object loc;
	// ¥Î∏∏µÓø° ¿˚øÎ«“ ∂© ª©º≠ ¿˚øÎ«ÿæﬂ «‘. isPaid
	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isAlive()) return;

	if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_NOT_GROUP, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	// controller.decreaseNumber(1);
	controller.sweepNumbered(1);

	// controller.effectBy(trigger);

	loc = Location.create();
	loc.set(30, 290, 290);

	trigger.teleportTo(loc);
}

quest
qUseItem1002970()				// ∂Û¿Ãµæ∆ øˆ«¡ ƒ´µÂ
{
	object loc;
	// ¥Î∏∏µÓø° ¿˚øÎ«“ ∂© ª©º≠ ¿˚øÎ«ÿæﬂ «‘. isPaid
	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isAlive()) return;

	if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_NOT_GROUP, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	// controller.decreaseNumber(1);
	controller.sweepNumbered(1);

	// controller.effectBy(trigger);

	loc = Location.create();
	loc.set(82, 160, 180);

	trigger.teleportTo(loc);
}

quest
qUseItem1002971()				// ƒ´øÔ øˆ«¡ ƒ´µÂ
{
	object loc;
	// ¥Î∏∏µÓø° ¿˚øÎ«“ ∂© ª©º≠ ¿˚øÎ«ÿæﬂ «‘. isPaid
	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isAlive()) return;

	if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_NOT_GROUP, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	// controller.decreaseNumber(1);
	controller.sweepNumbered(1);

	// controller.effectBy(trigger);

	loc = Location.create();
	loc.set(15, 200, 200);

	trigger.teleportTo(loc);
}

quest
qUseItem1003884()				// ±ÍπﬂªØ±‚ ¥Î±‚Ω« øˆ«¡ ƒ´µÂ
{
	object loc;
	// ¥Î∏∏µÓø° ¿˚øÎ«“ ∂© ª©º≠ ¿˚øÎ«ÿæﬂ «‘. isPaid
	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isAlive()) return;

	if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_NOT_GROUP, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	// controller.decreaseNumber(1);
	controller.sweepNumbered(1);

	// controller.effectBy(trigger);

	loc = Location.create();
	loc.set(446, 104, 100);

	trigger.teleportTo(loc);
}

quest
qUseItem1000150()				// Ω≈¡∂¿« ±Í≈–
{
	// discard if world is event world
	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	// if (!trigger.getWorld().canTeleport()) {
	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isAlive()) return;
/*
//	trigger.sendSelectQuestMessage("Ω≈¡∂¿« ±Í≈–¿ª ªÁøÎ«œΩ√∞⁄Ω¿¥œ±Ó?»Æ¿Œ«œΩ« ∞ÊøÏ π´¡∂∞« ªÁøÎµÀ¥œ¥Ÿ", "qUseItem1000150_1", "null", controller);
//	if (controller.canBeExhausted())
		// controller.decreaseNumber(1);

	// send using effect
	// controller.effectBy(trigger);

	controller.sweepNumbered(1);

//	trigger.sendWarpPoint();
	trigger.sendWarpPoint(1);
*/

	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getWorld().allowedWarpGroup() == 0)
	{
		controller.sweepNumbered(1);
//		trigger.sendWarpPoint();
		trigger.sendWarpPoint(1);
	}
	else if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_NOT_GROUP, MSG_TYPE__SYSTEM);
		return;
	}
	return;
}


quest
qUseItem1000150_1()				// Ω≈¡∂¿« ±Í≈– ªÁøÎ √≥∏Æ
{
	if (trigger.getWorld().allowedWarpGroup() == 0)
	{
		controller.sweepNumbered(1);
//		trigger.sendWarpPoint();
		trigger.sendWarpPoint(1);
	}
	else if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_NOT_GROUP, MSG_TYPE__SYSTEM);
		return;
	}
	return;
}

quest
qUseItem1000002()				// »•¿«¡∂∞¢
{
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000076()				// ºˆº±µµ±∏
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -1)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getTEIP(TEIP__ENDURANCE) + 5);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 1); // setTEIP and setMaxTEIP in Item class have already included update func

		trigger.message(TEXT_USABLEITEM_ENDURANCE1_5 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000077()				// ∂´≥≥≈∞∆Æ
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -1)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getTEIP(TEIP__ENDURANCE) + 10);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 1); // setTEIP and setMaxTEIP in Item class have already included update func

		trigger.message(TEXT_USABLEITEM_ENDURANCE1_10 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000078()				// πÈ∂¯≈∞∆Æ
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -1)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getTEIP(TEIP__ENDURANCE) + 20);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 1); // setTEIP and setMaxTEIP in Item class have already included update func

		trigger.message(TEXT_USABLEITEM_ENDURANCE1_20 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000079()				// ∏‡µ˘≈∞∆Æ (º“)
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -2)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getTEIP(TEIP__ENDURANCE) + 30);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 2); // setTEIP and setMaxTEIP in Item class have already included update func

		trigger.message(TEXT_USABLEITEM_ENDURANCE1_30 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000080()				// ∏‡µ˘≈∞∆Æ(¡ﬂ)
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -2)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getTEIP(TEIP__ENDURANCE) + 40);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 2); // setTEIP and setMaxTEIP in Item class have already included update func

		trigger.message(TEXT_USABLEITEM_ENDURANCE1_40 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000081()				// ∆–ƒ°≈∞∆Æ(º“)
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getTEIP(TEIP__ENDURANCE) + 10);

		trigger.message(TEXT_USABLEITEM_ENDURANCE10 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	}
}

quest
qUseItem1000082()				// ∆–ƒ°≈∞∆Æ(¡ﬂ)
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getTEIP(TEIP__ENDURANCE) + 20);

		trigger.message(TEXT_USABLEITEM_ENDURANCE20 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000083()				// ∏Æ∆‰æÓ≈∞∆Æ(º“)
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getTEIP(TEIP__ENDURANCE) + 30);

		trigger.message(TEXT_USABLEITEM_ENDURANCE30 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000084()				// ∏Æ∆‰æÓ≈∞∆Æ(¡ﬂ)
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getTEIP(TEIP__ENDURANCE) + 50);

		trigger.message(TEXT_USABLEITEM_ENDURANCE50 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000085()				// ∏ÆΩ∫≈‰æÓºº∆Æ
{
	object item;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!item.getCanBeRepaired()) return;

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkMinMax(item, TEIP__ENDURANCE)) return;

		item.setTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE));

		trigger.message(TEXT_USABLEITEM_ENDURANCE100 , MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000086()				// ≥ª±∏º∫Ω∫«¡∑π¿Ã(º“) - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, 2)) return;

		if(item.getTEIP(TEIP__ENDURANCE)==item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(0, 2);
		if (item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT) < item.getMaxTEIP(TEIP__ENDURANCE) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__ENDURANCE);
			if (randomValue < 1) randomValue = 0;
			item.setMaxTEIP(TEIP__ENDURANCE, item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT));
		}
		else item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func

		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_MAX_ENDURANCE + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__ENDURANCE)==item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000087()				// ≥ª±∏º∫Ω∫«¡∑π¿Ã(¡ﬂ) - ºˆ¡§
{
	object item;
	integer randomValue;
	integer randcnt;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, 3)) return;

		if(item.getTEIP(TEIP__ENDURANCE)==item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(1, 3);
		if (item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT) < item.getMaxTEIP(TEIP__ENDURANCE) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__ENDURANCE);
			if (randomValue < 1) randomValue = 0;
			item.setMaxTEIP(TEIP__ENDURANCE, item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT));
		}
		else item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func

		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_MAX_ENDURANCE + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);
		randcnt = Util.random(0, 99);

		if (randcnt > 50) ;
		else if (!checkMinOfMax(item, TEIP__FIRMNESS, -randomValue)) ;
		else {
			item.setTEIP(TEIP__FIRMNESS, item.getTEIP(TEIP__FIRMNESS) - randomValue);
			trigger.message(TEXT_USABLEITEM_FIRMNESS + randomValue + TEXT_USABLEITEM_MESSAGE1_1 , MSG_TYPE__SYSTEM);
		}

		if(item.getTEIP(TEIP__ENDURANCE)==item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000088()				// ≥ª±∏º∫Ω∫«¡∑π¿Ã(¥Î) - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, 4)) return;

		if(item.getTEIP(TEIP__ENDURANCE)==item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		if (!checkBreak(item)) return;

		randomValue = Util.random(2, 4);
		if (item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT) < item.getMaxTEIP(TEIP__ENDURANCE) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__ENDURANCE);
			if (randomValue < 1) randomValue = 0;
			item.setMaxTEIP(TEIP__ENDURANCE, item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT));
		}
		else item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func

		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_MAX_ENDURANCE+ randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__ENDURANCE)==item.getLowerOrUpperTEIP(TEIP__ENDURANCE, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000089()				// ª˛«¡≥ 
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__STAB)) return;

		if(item.getTEIP(TEIP__STAB)==item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(0, 2);
		if (item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__STAB) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__STAB);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__STAB, item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__STAB, item.getTEIP(TEIP__STAB) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_STAB + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__STAB)==item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000090()				// ≈∞¥◊ºº∆Æ - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__STAB)) return;

		if(item.getTEIP(TEIP__STAB)==item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(1, 3);
		if (item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__STAB) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__STAB);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__STAB, item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__STAB, item.getTEIP(TEIP__STAB) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_STAB + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__STAB)==item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		checkCrack(item, randomValue);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000091()				// ¡¶∑√≈∞∆Æ - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__STAB)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -1)) return;

		if(item.getTEIP(TEIP__STAB)==item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		if (!checkBreak(item)) return;

		randomValue = Util.random(2, 4);
		if (item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__STAB) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__STAB);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__STAB, item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__STAB, item.getTEIP(TEIP__STAB) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_STAB + randomValue + TEXT_USABLEITEM_MANUFACTURE_UP, MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__STAB)==item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000092()				// Ω∫∆Æ∑æ
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__HACK)) return;

		if(item.getTEIP(TEIP__STAB)==item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(0, 2);
		if (item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__HACK) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__HACK);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__HACK, item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__HACK, item.getTEIP(TEIP__HACK) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_HACK + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__STAB)==item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000093()				// º˝µπ - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__HACK)) return;

		if(item.getTEIP(TEIP__HACK)==item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(1, 3);
		if (item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__HACK) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__HACK);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__HACK, item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__HACK, item.getTEIP(TEIP__HACK) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_HACK + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__HACK)==item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		checkCrack(item, randomValue);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000094()				// ±◊∂Û¿Œ¥ı - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__HACK)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -1)) return;

		if(item.getTEIP(TEIP__HACK)==item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		if (!checkBreak(item)) return;

		randomValue = Util.random(2, 4);
		if (item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__HACK) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__HACK);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__HACK, item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__HACK, item.getTEIP(TEIP__HACK) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_HACK + randomValue + TEXT_USABLEITEM_MANUFACTURE_UP , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__HACK)==item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}


quest
qUseItem1000095()				// ≈∫º∫∑Œº«(º“)
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
		// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
		if (item.isLocked()) {
			trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
			return;
		}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__DEFENSE)) return;

		if(item.getTEIP(TEIP__DEFENSE)==item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(0, 2);
		if (item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__DEFENSE) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__DEFENSE);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__DEFENSE, item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__DEFENSE, item.getTEIP(TEIP__DEFENSE) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_DEF + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__DEFENSE)==item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000096()				// ≈∫º∫∑Œº«(¡ﬂ) - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__DEFENSE)) return;

		if(item.getTEIP(TEIP__DEFENSE)==item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(1, 3);
		if (item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__DEFENSE) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__DEFENSE);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__DEFENSE, item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__DEFENSE, item.getTEIP(TEIP__DEFENSE) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_DEF + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__DEFENSE)==item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		checkCrack(item, randomValue);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000097()				// ≈∫º∫∑Œº«(¥Î) - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__DEFENSE)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -1)) return;

		if(item.getTEIP(TEIP__DEFENSE)==item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		if (!checkBreak(item)) return;

		randomValue = Util.random(2, 4);
		if (item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__DEFENSE) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__DEFENSE);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__DEFENSE, item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__DEFENSE, item.getTEIP(TEIP__DEFENSE) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_DEF + randomValue + TEXT_USABLEITEM_MANUFACTURE_UP , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__DEFENSE)==item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000098()				// ∏∂∑¬ ∞≠»≠¡¶ (º“)
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__MAGIC_ATTACK)) return;

		if(item.getTEIP(TEIP__MAGIC_ATTACK)==item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(0, 2);
		if (item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__MAGIC_ATTACK) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__MAGIC_ATTACK);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__MAGIC_ATTACK, item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__MAGIC_ATTACK, item.getTEIP(TEIP__MAGIC_ATTACK) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_INT + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__MAGIC_ATTACK)==item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000099()				// ∏∂∑¬ ∞≠»≠¡¶ (¡ﬂ) - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__MAGIC_ATTACK)) return;

		if(item.getTEIP(TEIP__MAGIC_ATTACK)==item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(1, 3);
		if (item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__MAGIC_ATTACK) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__MAGIC_ATTACK);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__MAGIC_ATTACK, item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__MAGIC_ATTACK, item.getTEIP(TEIP__MAGIC_ATTACK) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_INT + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__MAGIC_ATTACK)==item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		checkCrack(item, randomValue);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000100()				 // ∏∂∑¬ ∞≠»≠¡¶ (¥Î) - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__MAGIC_ATTACK)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -1)) return;

		if(item.getTEIP(TEIP__MAGIC_ATTACK)==item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		if (!checkBreak(item)) return;

		randomValue = Util.random(2, 4);
		if (item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__MAGIC_ATTACK) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__MAGIC_ATTACK);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__MAGIC_ATTACK, item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__MAGIC_ATTACK, item.getTEIP(TEIP__MAGIC_ATTACK) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_INT + randomValue + TEXT_USABLEITEM_MANUFACTURE_UP , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__MAGIC_ATTACK)==item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000101()				// ø‰¡§¿«∞°»£
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__MAGIC_DEFENSE)) return;

		if(item.getTEIP(TEIP__MAGIC_DEFENSE)==item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(0, 2);
		if (item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__MAGIC_DEFENSE) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__MAGIC_DEFENSE);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__MAGIC_DEFENSE, item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__MAGIC_DEFENSE, item.getTEIP(TEIP__MAGIC_DEFENSE) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_MR + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__MAGIC_DEFENSE)==item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000102()				// √µªÁ¿«∞°»£ - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__MAGIC_DEFENSE)) return;

		if(item.getTEIP(TEIP__MAGIC_DEFENSE)==item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(1, 3);
		if (item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__MAGIC_DEFENSE) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__MAGIC_DEFENSE);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__MAGIC_DEFENSE, item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__MAGIC_DEFENSE, item.getTEIP(TEIP__MAGIC_DEFENSE) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_MR + randomValue +  TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__MAGIC_DEFENSE)==item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		checkCrack(item, randomValue);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000103()				// ø©Ω≈¿«∞°»£ - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__MAGIC_DEFENSE)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -1)) return;

		if(item.getTEIP(TEIP__MAGIC_DEFENSE)==item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		if (!checkBreak(item)) return;

		randomValue = Util.random(2, 4);
		if (item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__MAGIC_DEFENSE) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__MAGIC_DEFENSE);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__MAGIC_DEFENSE, item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__MAGIC_DEFENSE, item.getTEIP(TEIP__MAGIC_DEFENSE) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 1);

		trigger.message(TEXT_USABLEITEM_ATTACK_MR + randomValue + TEXT_USABLEITEM_MANUFACTURE_UP , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__MAGIC_DEFENSE)==item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}

quest
qUseItem1000104()				// ∞Ê»≠¡¶(º“)
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);

	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__FIRMNESS)) return;

		if(item.getTEIP(TEIP__FIRMNESS)==item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(0, 2);
		if (item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__FIRMNESS) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__FIRMNESS);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__FIRMNESS, item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__FIRMNESS, item.getTEIP(TEIP__FIRMNESS) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_FIRMNESS_UP + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__FIRMNESS)==item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
		    controller.decreaseNumber(1);
	}
}

quest
qUseItem1000105()				// ∞Ê»≠¡¶(¡ﬂ) - ºˆ¡§
{
	object item;
	integer randomValue;
	integer randcnt;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);

	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__FIRMNESS)) return;

		if(item.getTEIP(TEIP__FIRMNESS)==item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		randomValue = Util.random(1, 3);
		if (item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__FIRMNESS) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__FIRMNESS);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__FIRMNESS, item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__FIRMNESS, item.getTEIP(TEIP__FIRMNESS) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);

		trigger.message(TEXT_USABLEITEM_FIRMNESS_UP + randomValue + TEXT_USABLEITEM_MANUFACTURE , MSG_TYPE__SYSTEM);

		randcnt = Util.random(0, 99);
		if (randcnt > 50) ;
		else if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -randomValue)) ;

		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - randomValue);
		trigger.message(TEXT_USABLEITEM_MAX_ENDURANCE2 + randomValue + TEXT_USABLEITEM_MESSAGE1_1 , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__FIRMNESS)==item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
		    controller.decreaseNumber(1);
	}
}

quest
qUseItem1000106()				// ∞Ê»≠¡¶(¥Î) - ºˆ¡§
{
	object item;
	integer randomValue;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);

	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (!checkManufactureCnt(item)) return;
		if (!checkMinMax(item, TEIP__FIRMNESS)) return;
		if (!checkMinMaxOfMax(item, TEIP__ENDURANCE, -1)) return;

		if(item.getTEIP(TEIP__FIRMNESS)==item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT))
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_UPGRADE_ITEM, MSG_TYPE__SYSTEM);
			return;
		}

		if (!checkBreak(item)) return;

		randomValue = Util.random(2, 4);
		if (item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT) < item.getTEIP(TEIP__FIRMNESS) + randomValue)	//∞·∞˙∞™¿Ã √÷¥Îƒ°∫∏¥Ÿ ≥Ù¿ª∞ÊøÏ √÷¥Îƒ°∑Œ ∫∏¡§
		{
			randomValue = item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT) - item.getMaxTEIP(TEIP__FIRMNESS);
			if (randomValue < 1) randomValue = 0;
			item.setTEIP(TEIP__FIRMNESS, item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT));
		}
		else item.setTEIP(TEIP__FIRMNESS, item.getTEIP(TEIP__FIRMNESS) + randomValue); // setTEIP and setMaxTEIP in Item class have already included update func
		item.setManufactureCnt(item.getManufactureCnt() + 1);
		item.setMaxTEIP(TEIP__ENDURANCE, item.getMaxTEIP(TEIP__ENDURANCE) - 1);

		trigger.message(TEXT_USABLEITEM_FIRMNESS_UP + randomValue + TEXT_USABLEITEM_MANUFACTURE_UP , MSG_TYPE__SYSTEM);

		if(item.getTEIP(TEIP__FIRMNESS)==item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__MAX_LIMIT))
			trigger.message(TEXT_USABLEITEM_CANT_UPGRADE_OVER_LIMIT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
		    controller.decreaseNumber(1);
	}
}


quest
qUseItem1001808()				// ¿Œ≈©∏≥∆Æ Ω∫≈©∑—
{
	object item;
	integer prob = 10;

	if (!NormalItemCanBeUsed()) return;

	item = controller.getObjectArgumentAt(0);

	// ¿Ø∑·æ∆¿Ã≈€ø° ªÁøÎ∫“∞°
	if (item.isCashItem())
	{
		trigger.message(TEXT_CASHITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		if (item.getTEIP(TEIP__ENDURANCE) <= 1) {
			trigger.message(TEXT_USABLEITEM_CANT_ENDURANCE, MSG_TYPE__SYSTEM);
			return;
		} else if (item.getManufactureCnt() <= 1) {
			trigger.message(TEXT_USABLEITEM_CANT_DECOUNT, MSG_TYPE__SYSTEM);
			return;
		}
		if (!checkDeCount(item, prob)) return;

		item.setManufactureCnt(item.getManufactureCnt() - 1);

		trigger.message(TEXT_USABLEITEM_DECOUNT, MSG_TYPE__SYSTEM);

		// send using effect
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
	    	controller.decreaseNumber(1);
	}
}


quest
qUseItem1002008()				// Ω≈∫Ò«— ¡§∑…ºÆ : ∫∏ªÛøÎ æ∆¿Ã≈€
{
	object item, clubObject;
	integer nowTime;
	integer bType;

	if (!NormalItemCanBeUsed()) return;

	// ±‚∞£ √º≈©. ±‚∞£ √º≈©«ÿº≠ ±‚∞£ ∞Ê∞˙«ﬂ¿ª ∞ÊøÏ πŸ∑Œ º“∏Ω√ƒ— πˆ∏∞¥Ÿ.
	nowTime = Util.getTick();

	clubObject = trigger.getGuild(GD_TYPE_NORMAL);

	// øÓøµ∆¿ ø‰√ªø° µ˚∂Û æ∆¿Ã≈€ ªÁøÎΩ√ øÓøµ¿⁄∞° ªÁøÎ«œ∏È ªÁøÎ¿œ¿⁄ø° ∞¸∞Ëæ¯¿Ã ªÁøÎ ∞°¥…«œµµ∑œ ºˆ¡§.
	bType = trigger.getBuilderType();

	if (bType != 1 && bType != 2 && bType != 3 && bType != 5) {
/*
   //vahma - disable expiration

		// 2005≥‚ 10ø˘17¿œ ∫Œ≈Õ 10ø˘24¿œ µøæ»ø°∏∏ ƒ˘Ω∫∆Æ ºˆ«‡
		if (Util.getYear(nowTime) != 2005 && Util.getMonth(nowTime) != 10) {
			trigger.message("éáêã àüä?âÇà??à??fè??éáêãîq é?è?_ä??", MSG_TYPE__SYSTEM);
			if (controller.canBeExhausted())
			    controller.decreaseNumber(1);
			return;
		}
		else if (Util.getDay(nowTime) > 24)
		{
			trigger.message("éáêã àüä?âÇà??à??fè??éáêãîq é?è?_ä??", MSG_TYPE__SYSTEM);
			if (controller.canBeExhausted())
			    controller.decreaseNumber(1);
			return;
		}
*/
		if(clubObject == null) {
			trigger.message("ÉNÉâÉuÇï(ë2?ã!íÄá!èÄä!ÅB", MSG_TYPE__SYSTEM);	// vahma - translate here
/*
   //vahma - disable expiration
			// 2005≥‚ 10ø˘17¿œ ∫Œ≈Õ 10ø˘24¿œ µøæ»ø°∏∏ ƒ˘Ω∫∆Æ ºˆ«‡
			if (Util.getYear(nowTime) != 2005 && Util.getMonth(nowTime) != 10) {
				if (controller.canBeExhausted())
				    controller.decreaseNumber(1);
				return;
			}
			else if (Util.getDay(nowTime) > 24)
			{
				if (controller.canBeExhausted())
				    controller.decreaseNumber(1);
				return;
			}
*/
			return;
		}
		if (clubObject.getMemberType(trigger.getName()) != GM_TYPE_MASTER &&
			clubObject.getMemberType(trigger.getName()) != GM_TYPE_SUBMASTER) {
			trigger.message("ÉNÉâÉuÉ}ÉXÉ^Å[Ç?TÉuÉ}ÉXÉ^Å[ÇñÄü-gÇÉÄûÄå B", MSG_TYPE__SYSTEM);	// vahma - translate here
/*
   //vahma - disable expiration
			// 2005≥‚ 10ø˘17¿œ ∫Œ≈Õ 10ø˘24¿œ µøæ»ø°∏∏ ƒ˘Ω∫∆Æ ºˆ«‡
			if (Util.getYear(nowTime) != 2005 && Util.getMonth(nowTime) != 10) {
				if (controller.canBeExhausted())
				    controller.decreaseNumber(1);
				return;
			}
			else if (Util.getDay(nowTime) > 24)
			{
				if (controller.canBeExhausted())
				    controller.decreaseNumber(1);
				return;
			}
*/
			return;
		}
	}

	item = controller.getObjectArgumentAt(0);

	// ¿Ø∑·æ∆¿Ã≈€ø° ªÁøÎ∫“∞°
	if (item.isCashItem())
	{
		trigger.message(TEXT_CASHITEM_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isMonster() && item && item.isEquippable()) {
		// if (!checkMinMax(item, TEIP__HACK)) return;

		if (item.getTEIP(TEIP__FIRMNESS) <= item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__UPPER))
		{
			item.setTEIP(TEIP__FIRMNESS, item.getLowerOrUpperTEIP(TEIP__FIRMNESS, TEIP__UPPER));
		}
		// ¿ÃπÃ ø√∏Æ¥¬ æ∆¿Ã≈€ ∞∞¿∫ ∞… ªÁøÎ«ﬂ¿ª ∞ÊøÏ∞° else∞° µ»¥Ÿ. ¿Ã ∞ÊøÏø£ ±¡¯ æ ¿∏π«∑Œ ª˝∑´«—¥Ÿ.
		if (item.getTEIP(TEIP__STAB) <= item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__UPPER))
		{
			item.setTEIP(TEIP__STAB, item.getLowerOrUpperTEIP(TEIP__STAB, TEIP__UPPER));
		}
		if (item.getTEIP(TEIP__HACK) <= item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__UPPER))
		{
			item.setTEIP(TEIP__HACK, item.getLowerOrUpperTEIP(TEIP__HACK, TEIP__UPPER));
		}
		if (item.getTEIP(TEIP__DEFENSE) <= item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__UPPER))
		{
			item.setTEIP(TEIP__DEFENSE, item.getLowerOrUpperTEIP(TEIP__DEFENSE, TEIP__UPPER));
		}
		if (item.getTEIP(TEIP__MAGIC_ATTACK) <= item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__UPPER))
		{
			item.setTEIP(TEIP__MAGIC_ATTACK, item.getLowerOrUpperTEIP(TEIP__MAGIC_ATTACK, TEIP__UPPER));
		}
		if (item.getTEIP(TEIP__MAGIC_DEFENSE) <= item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__UPPER))
		{
			item.setTEIP(TEIP__MAGIC_DEFENSE, item.getLowerOrUpperTEIP(TEIP__MAGIC_DEFENSE, TEIP__UPPER));
		}
		if (item.getTEIP(TEIP__HIT_ACCURACY) <= item.getLowerOrUpperTEIP(TEIP__HIT_ACCURACY, TEIP__UPPER))
		{
			item.setTEIP(TEIP__HIT_ACCURACY, item.getLowerOrUpperTEIP(TEIP__HIT_ACCURACY, TEIP__UPPER));
		}
		if (item.getTEIP(TEIP__CRITICAL) <= item.getLowerOrUpperTEIP(TEIP__CRITICAL, TEIP__UPPER))
		{
			item.setTEIP(TEIP__CRITICAL, item.getLowerOrUpperTEIP(TEIP__CRITICAL, TEIP__UPPER));
		}
		if (item.getTEIP(TEIP__AVOIDANCE) <= item.getLowerOrUpperTEIP(TEIP__AVOIDANCE, TEIP__UPPER))
		{
			item.setTEIP(TEIP__AVOIDANCE, item.getLowerOrUpperTEIP(TEIP__AVOIDANCE, TEIP__UPPER));
		}
		if (item.getTEIP(TEIP__AGILITY) <= item.getLowerOrUpperTEIP(TEIP__AGILITY, TEIP__UPPER))
		{
			item.setTEIP(TEIP__AGILITY, item.getLowerOrUpperTEIP(TEIP__AGILITY, TEIP__UPPER));
		}

		trigger.message(TEXT_USABLEITEM_ATTACK_ALL, MSG_TYPE__SYSTEM);
		controller.effectBy(trigger);

		if (controller.canBeExhausted())
		    controller.decreaseNumber(1);
    }
}


quest
qUseItem1000120()				// ¿Ã∏Æ¿« æÓ±›¥œ
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgStab(trigger.getOrgStab() + 1);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_ATTACK_STAB_UP1 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000121()				// ¥¡¥Î¿« æÓ±›¥œ
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgStab(trigger.getOrgStab() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_ATTACK_STAB_UP2, MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000122()				// ∏Õºˆ¿« æÓ±›¥œ
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgStab(trigger.getOrgStab() + 3);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_ATTACK_STAB_UP3 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000123()				// »˚¿« ƒ°¡Ó (¡∂∞¢)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgHack(trigger.getOrgHack() + 1);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_ATTACK_HACK_UP1 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000124()				// »˚¿« ƒ°¡Ó
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgHack(trigger.getOrgHack() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_ATTACK_HACK_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000125()				// »˚¿« ƒ°¡Ó (µ¢æÓ∏Æ)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgHack(trigger.getOrgHack() + 3);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_ATTACK_HACK_UP3 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000126()				// ¿ŒæÓ¿« ∫Ò¥√
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgDefence(trigger.getOrgDefence() + 1);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_DEFENSE_UP1 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000127()				// ¿ŒæÓ¿« ¥´π∞
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgDefence(trigger.getOrgDefence() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_DEFENSE_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000128()				// ¿ŒæÓ¿« ∞°»£
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgDefence(trigger.getOrgDefence() + 3);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_DEFENSE_UP3 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000129()				// »ØªÛ√ ¿« ¿Ÿ
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgInt(trigger.getOrgInt() + 1);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_MAGIC_ATTACK1 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000130()				// »ØªÛ√ ¿« ≤…
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgInt(trigger.getOrgInt() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_MAGIC_ATTACK2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000131()				// »ØªÛ√ 
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgInt(trigger.getOrgInt() + 3);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_MAGIC_ATTACK3 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000132()				// »Øøµ√ ¿« ¿Ÿ
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgMagicResist(trigger.getOrgMagicResist() + 1);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_MAGIC_DEFENSE1 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000133()				// »Øøµ√ ¿« ≤…
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgMagicResist(trigger.getOrgMagicResist() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_MAGIC_DEFENSE2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000134()				// »Øøµ√ 
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgMagicResist(trigger.getOrgMagicResist() + 3);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_MAGIC_DEFENSE3 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000135()				// ƒËº”¿« ƒ°¡Ó (¡∂∞¢)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgDex(trigger.getOrgDex() + 1);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_DEX_UP1 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000136()				// ƒËº”¿« ƒ°¡Ó
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgDex(trigger.getOrgDex() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_DEX_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000137()				// ƒËº”¿« ƒ°¡Ó (µ¢æÓ∏Æ)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgDex(trigger.getOrgDex() + 3);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_DEX_UP3 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000138()				// ±Ÿº∫¿« ∏ﬁ√ﬂ∏ÆæÀ
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 10);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_INVEN_MAX10 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000139()				// ±Ÿº∫¿« ¥ﬁ∞ø
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 20);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_INVEN_MAX20 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000140()				// ±Ÿº∫¿« ø¿∏ÆæÀ
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 30);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_INVEN_MAX30 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000141()				// ∞ÌæÁ¿Ã¿« ¥´
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgMaxHP(trigger.getOrgMaxHP() + 50);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_HP_MAX50 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000142()				// ¿⁄ø¨¿« ∞·¡§
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.setOrgMaxMP(trigger.getOrgMaxMP() + 10);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_HP_MAX10 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItemqUseItem1000143()				// º∫¿Â√À¡¯¡¶ (πÃ±∏«ˆ)
{
}

quest
qUseItem1000144()				// »∏√·¡¶
{
	integer UserLV;
	if (!NormalItemCanBeUsed()) return;

	UserLV = trigger.getLevel() -1;

	if (UserLV < 2) {
		trigger.message(TEXT_USABLEITEM_LOW_LEVEL1 , MSG_TYPE__SYSTEM);
		return;
	} else {
		trigger.setLevel(UserLV);
		trigger.updateAttr();
	}

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.message(TEXT_USABLEITEM_LOW_LEVEL2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000145()				// √º«Ë Ω∫≈©∑—
{
// ************ ∫∏ªÛ¿ª ¿ß«ÿ ¿”Ω√∑Œ ±‚¥… √ﬂ∞° Ω√¿€ ****************
	integer chkLV;
	integer repayEXP;
	integer tickTime;
// ************ ∫∏ªÛ¿ª ¿ß«ÿ ¿”Ω√∑Œ ±‚¥… √ﬂ∞° ¡æ∑· ****************

	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

// ************ ∫∏ªÛ¿ª ¿ß«ÿ ¿”Ω√∑Œ ±‚¥… √ﬂ∞° Ω√¿€ ****************
	// ªÁøÎ∞°¥… Ω√¡° √º≈©
	tickTime = Util.getTick();

	if (Util.getYear(tickTime) != 2003) {
		trigger.addExp(500);
		trigger.updateAttr();

        trigger.message("åoåâ1lÇÖ?0è?ÖÄ?ûÄã!è B", MSG_TYPE__SYSTEM);
		return;
	} else if (Util.getMonth(tickTime) != 10) {
		trigger.addExp(500);
		trigger.updateAttr();

        trigger.message("åoåâ1lÇÖ?0è?ÖÄ?ûÄã!è B", MSG_TYPE__SYSTEM);
		return;
	} else if (Util.getDay(tickTime) > 28) {
		trigger.addExp(500);
		trigger.updateAttr();

        trigger.message("åoåâ1lÇÖ?0è?ÖÄ?ûÄã!è B", MSG_TYPE__SYSTEM);
		return;
	}

	chkLV = trigger.getLevel();

	if (chkLV < 1) {
        trigger.message("gÇÇÄâ!ìÄñÄì!Ü!îÄÅÅåÉxÉãÇì!å B", MSG_TYPE__SYSTEM);
		return;
	} else if (chkLV < 10) {
		repayEXP = 5000;
	} else if (chkLV < 21) {
		repayEXP = 20000;
	} else if (chkLV < 33) {
		repayEXP = 40000;
	} else if (chkLV < 50) {
		repayEXP = 60000;
	} else if (chkLV < 60) {
		repayEXP = 80000;
	} else if (chkLV < 68) {
		repayEXP = 100000;
	} else if (chkLV < 75) {
		repayEXP = 120000;
	} else if (chkLV < 81) {
		repayEXP = 140000;
	} else if (chkLV < 87) {
		repayEXP = 160000;
	} else if (chkLV < 94) {
		repayEXP = 180000;
	} else if (chkLV < 110) {
		repayEXP = 190000;
	} else if (chkLV < 170) {
		repayEXP = 200000;
	} else if (chkLV < 210) {
		repayEXP = 210000;
	} else {
        trigger.message("gópÇå!?â!ìÄñÄì!Ü!îÄÅÅåÉxÉãÇì!å B", MSG_TYPE__SYSTEM);
		return;
	}

	trigger.addExp(repayEXP);
	trigger.updateAttr();

    trigger.message("ï?ûÉåÉxÉã [" + chkLV + "]", MSG_TYPE__SYSTEM);
    trigger.message("äÖÄÜ5?ã4?ûÇìÄã!íäoåâ1lÇÖû[" + repayEXP + "] è?ÖÄ?ûÄã!è B", MSG_TYPE__SYSTEM);

// ************ ∫∏ªÛ¿ª ¿ß«ÿ ¿”Ω√∑Œ ±‚¥… √ﬂ∞° ¡æ∑· ****************


// ************ ∫∏ªÛ¿ª ¿ß«ÿ ¿”Ω√∑Œ ±‚¥… ºˆ¡§ ****************
/*
	trigger.addExp(500);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_EXP_UP , MSG_TYPE__SYSTEM);
*/
// ************ ∫∏ªÛ¿ª ¿ß«ÿ ¿”Ω√∑Œ ±‚¥… ºˆ¡§ ****************

	// send using effect
	controller.effectBy(trigger);
}


quest
qUseItem1000146()				// ºˆºˆ≤≤≥¢ ªÛ¿⁄
{
	integer rval, iBirth;
	integer wNum;
	integer tickTime;
	integer mx, my;
	integer rCount;

	string userName, timestamp;
	string time_Info, world_Info, Item_Info;
	object rank;

	// ªÁøÎ ∫“∞°¥… ¡ˆø™ √≥∏Æ
	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(trigger.getWorld().canFight() == false)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
    		return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// √ ∫∏¿⁄ ¥¯¿¸ø°º≠ ªÁøÎ ∫“∞°¥…
	if (wNum == 422 || wNum == 423 || wNum == 424)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
    		return;
    	}

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
        	return;
    	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
        	return;
    	}

	// ±Ê¿Ã ¡º¿∫ ø¨∞·≈Î ∏ 
	if(wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
        	return;
    	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1)
	{
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
    	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 6)
	{
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
    	}

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	mx =  trigger.getX();
	my =  trigger.getY();

	rval = Util.random(0, 10000);

	iBirth = trigger.getBirthTime();

	// ¡÷∏ª ∫∏¡§ ±‚¥…
	if (Util.getWday(tickTime) == 0)	{
		if (rval > 4400)		rval = rval - 200;
	} else if (Util.getWday(tickTime) == 1)	{
		if (rval > 4400)		rval = rval - 100;
	}

	// 2100221	3%
	if(rval >= 9700)
	{
		trigger.getWorld().genMonster("2100221", 1, "twMechanic.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100221 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 2100026	3%
	else if(rval >= 9400)
	{
		trigger.getWorld().genMonster("2100026", 1, "twKnohen.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100026 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 2100119	5%
	else if(rval >= 8900)
	{
		trigger.getWorld().genMonster("2100119", 1, "twAzidahaka_J.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100119 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 2100123	5%
	else if(rval >= 8400)
	{
		trigger.getWorld().genMonster("2100123", 1, "twPumkinRot.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100123 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 2100193	5%
	else if(rval >= 7900)
	{
		trigger.getWorld().genMonster("2100193", 1, "twPoseidon.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100193 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 2100194	5%
	else if(rval >= 7400)
	{
		trigger.getWorld().genMonster("2100194", 1, "twDduKing.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100194 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 2100195	5%
	else if(rval >= 6900)
	{
		trigger.getWorld().genMonster("2100195", 1, "twDduQueen.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100195 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 2100338	8%
	else if(rval >= 6100)
	{
		trigger.getWorld().genMonster("2100338", 5, "twDuckWarriorF.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100338 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 2100339	8%
	else if(rval >= 5300)
	{
		trigger.getWorld().genMonster("2100339", 5, "twPumkin_Dandy.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100339 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 2100359	8%
	else if(rval >= 4500)
	{
		trigger.getWorld().genMonster("2100359", 5, "twDGeneral.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100359 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ***********************************************************************************************
	// ø©±‚º≠∫Œ≈Õ æ∆¿Ã≈€~
	// ***********************************************************************************************
	// 1000126	1%
	else if(rval >= 4400)
	{
		rank = Rank.select("NEWBIE_ITEM_1");
		rCount = rank.getCount();

		if(rCount < 5)
		{
			timestamp = Util.getYear(tickTime) + "/" + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime);
			Util.log("### 200408 Event Item UserName[" + userName + "] getItem [1000126] #" + rCount + "/5 On time = [" + timestamp + "] ###");
			rank.add(userName, 0, 0, 0, iBirth, "null");
			trigger.addItemClassNamed("1000126", 1);
			Item_Info = "From Present Box : +ITEM [ 1000123 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		} else {
			trigger.addItemClassNamed("1000022", 1);
			Item_Info = "From Present Box : +ITEM [ 1000022 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}
	}
	// 1000138	1%
	else if(rval >= 4300)
	{
		rank = Rank.select("NEWBIE_ITEM_2");
		rCount = rank.getCount();

		if(rCount < 8)
		{
			timestamp = Util.getYear(tickTime) + "/" + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime);
			Util.log("### 200408 Event Item UserName[" + userName + "] getItem [1000138] #" + rCount + "/8 On time = [" + timestamp + "] ###");
			rank.add(userName, 0, 0, 0, iBirth, "null");
			trigger.addItemClassNamed("1000138", 1);
			Item_Info = "From Present Box : +ITEM [ 1000138 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		} else {
			trigger.addItemClassNamed("1000033", 1);
			Item_Info = "From Present Box : +ITEM [ 1000033 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}
	}
	// 1000141	1%
	else if(rval >= 4200)
	{
		rank = Rank.select("NEWBIE_ITEM_3");
		rCount = rank.getCount();

		if(rCount < 5)
		{
			timestamp = Util.getYear(tickTime) + "/" + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime);
			Util.log("### 200408 Event Item UserName[" + userName + "] getItem [1000141] #" + rCount + "/5 On time = [" + timestamp + "] ###");
			rank.add(userName, 0, 0, 0, iBirth, "null");
			trigger.addItemClassNamed("1000141", 1);
			Item_Info = "From Present Box : +ITEM [ 1000141 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		} else {
			trigger.getWorld().genMonster("2100026", 1, "twKnohen.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From Present Box : MONSTER [ 2100026 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}
	}
	// 1000142	1%
	else if(rval >= 4100)
	{
		rank = Rank.select("NEWBIE_ITEM_4");
		rCount = rank.getCount();

		if(rCount < 5)
		{
			timestamp = Util.getYear(tickTime) + "/" + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime);
			Util.log("### 200408 Event Item UserName[" + userName + "] getItem [1000142] #" + rCount + "/5 On time = [" + timestamp + "] ###");
			rank.add(userName, 0, 0, 0, iBirth, "null");
			trigger.addItemClassNamed("1000142", 1);
			Item_Info = "From Present Box : +ITEM [ 1000142 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		} else {
			trigger.getWorld().genMonster("2100359", 5, "twDGeneral.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From Present Box : MONSTER [ 2100359 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}
	}
	// 1001808	1%
	else if(rval >= 4000)
	{
		trigger.addItemClassNamed("1001808", 1);
		Item_Info = "From Present Box : +ITEM [ 1001808 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
	}
	// 1001810	5%
	else if(rval >= 3500)
	{
		trigger.addItemClassNamed("1001810", 1);
		Item_Info = "From Present Box : +ITEM [ 1001810 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1003047	5%
	else if(rval >= 3000)
	{
		trigger.addItemClassNamed("1003047", 1);
		Item_Info = "From Present Box : +ITEM [ 1003047 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1000022	5%
	else if(rval >= 2500)
	{
		trigger.addItemClassNamed("1000022", 1);
		Item_Info = "From Present Box : +ITEM [ 1000022 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1000033	5%
	else if(rval >= 2000)
	{
		trigger.addItemClassNamed("1000033", 1);
		Item_Info = "From Present Box : +ITEM [ 1000033 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1001809	20%
	else if(rval)
	{
		trigger.addItemClassNamed("1001809", 1);
		Item_Info = "From Present Box : +ITEM [ 1001809 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	Util.log(time_Info + Item_Info + world_Info);
}


quest
qUseItem1000151()     //≈ı√¥ ¥‹∞À
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1000152()     //µπ∏Õ¿Ã
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1000153()     //≈ı√¢
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1000154()     //«•√¢
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1000155()      //ºˆ∏Æ∞À
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1000156()			//∆¯¡◊
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001002()				// Ω∫≈◊πÃ≥  ∆˜º« (º“)
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_SP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_SP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// sp 250 »∏∫π
	if (!ItemUpSP(trigger, 250)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001003()				// Ω∫≈◊πÃ≥  ∆˜º« (¡ﬂ)
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_SP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_SP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// sp 500 »∏∫π
	if (!ItemUpSP(trigger, 500)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001004()				// Ω∫≈◊πÃ≥  ∆˜º« (¥Î)
{
	if (!NormalItemCanBeUsed()) return;

/*	if (trigger.isState(CREATURE_STATE__LIMIT_RECOVER_SP)) {
		trigger.message(CANT_USE_FOR_LIMIT_RECOVER_SP_STATE, MSG_TYPE__SYSTEM);
		return;
	}*/

	// sp 1000 »∏∫π
	if (!ItemUpSP(trigger, 1000)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000055()				// ¡◊¿Ω¿« »£»Ì (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if (!target.getWorld().canFight() && target.isUser())
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD , MSG_TYPE__SYSTEM);
		return;
	}

	if(target.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkillByProb(target,"3000201",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_MESSAGE3, MSG_TYPE__SYSTEM);
	else trigger.message(TEXT_USABLEITEM_MESSAGE_FAIL, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000056()				// ¡ª∫Ò∆ƒøÏ¥ı (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if (!target.getWorld().canFight() && target.isUser())
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD , MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkill(target,"3000201",10)==true)
		trigger.message(TEXT_USABLEITEM_ZOMBIEFOUDER, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000057()				// ¿◊≈© (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(target.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkillByProb(target,"3000199",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_INK2, MSG_TYPE__SYSTEM);
	else trigger.message(TEXT_USABLEITEM_INK1, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000058()				// ∏‘π∞ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkill(target,"3000199",10)==true)
		trigger.message(TEXT_USABLEITEM_INK2_1, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000059()				// µ∂æ◊ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(target.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkillByProb(target,"3000198",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_POISON1_2, MSG_TYPE__SYSTEM);
	else trigger.message(TEXT_USABLEITEM_POISON1_1, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000060()				// µ∂æ‡ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkill(target,"3000198",10)==true)
		trigger.message(TEXT_USABLEITEM_POISON2, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000061()				// π–¬§¿Œ«¸ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(target.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkillByProb(target,"3000190",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_STRAWDOLL2, MSG_TYPE__SYSTEM);
	else trigger.message(TEXT_USABLEITEM_STRAWDOLL1, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000062()				// ∫ŒµŒ¿Œ«¸ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkill(target,"3000190",10)==true)
		trigger.message(TEXT_USABLEITEM_DOLL2, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000063()				// »Ø∞¢¡¶ (πÃ±∏«ˆ)
{
	
}

quest
qUseItem1000064()				// LSD (πÃ±∏«ˆ)
{
	
}

quest
qUseItem1000065()				// æ∆¿ÃΩ∫ πŸ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(target.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkillByProb(target,"3000195",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_ICE2, MSG_TYPE__SYSTEM);
	else trigger.message(TEXT_USABLEITEM_ICE1, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000066()				// ∫˘∞· ∫–π´±‚ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkill(target,"3000195",10)==true)
		trigger.message(TEXT_USABLEITEM_FREEZING, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000067()				// ºÆ≈∫ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(target.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkillByProb(target,"3000194",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_COAL2, MSG_TYPE__SYSTEM);
	else trigger.message(TEXT_USABLEITEM_COAL1, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000068()				// ºÆ¿Ø ∫–π´±‚ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkill(target,"3000194",10)==true)
		trigger.message(TEXT_USABLEITEM_OIL, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000069()				// «„Ω∫≈∞ ƒµµ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(target.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkillByProb(target,"3000188",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_HUSKY_CANDY2, MSG_TYPE__SYSTEM);
	else trigger.message(TEXT_USABLEITEM_HUSKY_CANDY1, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000070()				// π¨¿Ω ƒµµ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkill(target,"3000188",10)==true)
		trigger.message(TEXT_USABLEITEM_SILENT_CANDY, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000071()				// ºˆ∏È¡¶ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(target.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkillByProb(target,"3000182",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_SLEEP2, MSG_TYPE__SYSTEM);
	else trigger.message(TEXT_USABLEITEM_SLEEP1, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000072()				// ∏∂√Î¡¶ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkill(target,"3000182",10)==true)
		trigger.message(TEXT_USABLEITEM_COMA, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000073()				// ∏¡∞¢ ƒµµ (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(target.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkillByProb(target,"3000189",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_OBLIVION_CANDY2, MSG_TYPE__SYSTEM);
	else trigger.message(TEXT_USABLEITEM_OBLIVION_CANDY1, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000074()				// ∏¡∞¢ ∆ƒøÏ¥ı (ºˆ¡§)
{
	integer wNum;
	object target;
	target = controller.getObjectArgumentAt(0);

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (!target)	return;

	if (!target.isAlive())
	{
		trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if(UseSkill(target,"3000189",10)==true)
		trigger.message(TEXT_USABLEITEM_OBLIVIONFOUDER, MSG_TYPE__SYSTEM);
}

quest
qUseItem1000043()				// «ÿµ∂¡¶ (ºˆ¡§)
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.hasNamed("3000198")) {
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		// finalize
		castedSpellInven.finalizeNamed("3000198");

		// send using effect
		controller.effectBy(trigger);
	}
}

quest
qUseItem1000044()				// æ»æ‡ (ºˆ¡§)
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.getObjectCreatureStated(CREATURE_STATE__BLIND) || castedSpellInven.hasNamed("3000020") ||
		castedSpellInven.hasNamed("3000092") || castedSpellInven.hasNamed("3000896") ||
		castedSpellInven.hasNamed("3001616") || castedSpellInven.hasNamed("3001708"))
	{
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		// finalize
		if (castedSpellInven.getObjectCreatureStated(CREATURE_STATE__BLIND))
			castedSpellInven.getObjectCreatureStated(CREATURE_STATE__BLIND).finalize();
		if (castedSpellInven.hasNamed("3000020"))
			castedSpellInven.finalizeNamed("3000020");
		if (castedSpellInven.hasNamed("3000092"))
			castedSpellInven.finalizeNamed("3000092");
		if (castedSpellInven.hasNamed("3000896"))
			castedSpellInven.finalizeNamed("3000896");
		if (castedSpellInven.hasNamed("3001616"))
			castedSpellInven.finalizeNamed("3001616");
		if (castedSpellInven.hasNamed("3001708"))
			castedSpellInven.finalizeNamed("3001708");

		// send using effect
		controller.effectBy(trigger);
	}
}


quest
qUseItem1000045()				// ¡§Ω≈æ»¡§¡¶ (πÃ±∏«ˆ)
{
}

quest
qUseItem1000046()				// ∫Ω¿«πŸ∂˜ (ºˆ¡§)
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.hasNamed("3000195")) {
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		// finalize
		castedSpellInven.finalizeNamed("3000195");

		// send using effect
		controller.effectBy(trigger);
	}
}

quest
qUseItem1000047()				// ≥√∞¢ƒ∏Ω∂ (ºˆ¡§)
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.hasNamed("3000194")) {
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		// finalize
		castedSpellInven.finalizeNamed("3000194");

		// send using effect
		controller.effectBy(trigger);
	}
}

quest
qUseItem1000048()				// ∂Û¿” (ºˆ¡§)
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.hasNamed("3000189")) {
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		// finalize
		castedSpellInven.finalizeNamed("3000189");

		// send using effect
		controller.effectBy(trigger);
	}
}

quest
qUseItem1000049()				// ∏Òƒµµ (ºˆ¡§)
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.hasNamed("3000188")) {
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		// finalize
		castedSpellInven.finalizeNamed("3000188");

		// send using effect
		controller.effectBy(trigger);
	}
}

quest
qUseItem1000050()				// æÓø˛¿Ã≈´ ∆˜º« (ºˆ¡§)
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.hasNamed("3000182")) {
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		// finalize
		castedSpellInven.finalizeNamed("3000182");

		// send using effect
		controller.effectBy(trigger);
	}
}

quest
qUseItem1000051()				// º∫ºˆ (ºˆ¡§)
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.hasNamed("3000900")) {	// ∞Ê¡÷∞° 3000201 æµ•µÂ¥¬ ªÁøÎæ»«—¥Ÿ∞Ì «ﬂ¿Ω -_-;;
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		// finalize
		castedSpellInven.finalizeNamed("3000900");

		// send using effect
		controller.effectBy(trigger);
	}
}

quest
qUseItem1000052()				// ∏∏∫¥≈Îƒ°æ‡
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	// finalize
	castedSpellInven.finalizeAll();

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000053()				// √µªÁ¿«¥´π∞
{
	integer toUp;
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	// finalize
	castedSpellInven.finalizeAll();

	// hp, mp maxUp
	toUp = trigger.getMaxHP();
	HardCode.itemUpHP(trigger, toUp);
	toUp = trigger.getMaxMP();
	HardCode.itemUpMP(trigger, toUp);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001009()				// «œ¥œ∫£æÓ¿« ∞Ì±‚
{
	if (!NormalItemCanBeUsed()) return;

	// hp 60 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 60)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 60)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 60);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001010()				// ƒ´¥œ∫∏∑π¿« ≤…¿Ÿ
{
	if (!NormalItemCanBeUsed()) return;

	// mp 15 »∏∫π
	if (!HardCode.itemUpMP(trigger, 15)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 15);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001011()				// ¡©∏Æ ∏Æ«¡
{
	if (!NormalItemCanBeUsed()) return;

	// sp 20 »∏∫π
	if (!ItemUpSP(trigger, 20)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001012()				// ∆˜¿Ã¡¡©∏Æ
{
	if (!NormalItemCanBeUsed()) return;

	// hp 70 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 70)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 70)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 70);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001014()				// ªÛæÓ ¡ˆ¥¿∑ØπÃ
{
	if (!NormalItemCanBeUsed()) return;

	// hp 230 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 230)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 230)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 230);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001020()				// ∑Œ±€∫£±€¿« ¡∑πﬂ
{
	if (!NormalItemCanBeUsed()) return;

	// hp 150 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 150)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 150)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 150);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001023_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// πŒ√∏º∫ +1, π∞∏Æ πÊæÓ∑¬ -1
	trigger.addDex(1);
	trigger.subDefence(1);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// πŒ√∏º∫, πÊæÓ∑¬ »∏∫π
	trigger.subDex(1);
	trigger.addDefence(1);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001023()				// ∏∆¡÷
{
	integer downMP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001023_wait")) return;

	// 2 % mp ªÁøÎ
	downMP = trigger.getMP() * 2 / 100;
	if (downMP == 0) downMP = 1;
	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001023_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001024_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// πŒ√∏º∫ -2, π∞∏Æ πÊæÓ∑¬ +1
	trigger.subDex(2);
	trigger.addDefence(1);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// πŒ√∏º∫, πÊæÓ∑¬ »∏∫π
	trigger.addDex(2);
	trigger.subDefence(1);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001024()				// º“¡÷
{
	integer downMP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001024_wait")) return;

	// 2 % mp ªÁøÎ
	downMP = trigger.getMP() * 2 / 100;
	if (downMP == 0) downMP = 1;
	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001024_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001025_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// ¬Ó∏£±‚ ∞¯∞›∑¬ +1, πŒ√∏º∫ +1, ∏∂π˝ πÊæÓ∑¬ -1
	trigger.addStab(1);
	trigger.addDex(1);
	trigger.subMagicResist(1);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// »Øø¯
	trigger.subStab(1);
	trigger.subDex(1);
	trigger.addMagicResist(1);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001025()				// º§∆‰¿Œ
{
	integer downMP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001025_wait")) return;

	// 5 % mp ªÁøÎ
	downMP = trigger.getMP() * 5 / 100;
	if (downMP == 0) downMP = 1;
	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001025_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001026_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// ¬Ó∏£±‚ ∞¯∞›∑¬ +1, ∫£±‚ ∞¯∞›∑¬ +1, ∏∂π˝ ∞¯∞›∑¬ +1, πŒ√∏º∫ +2, π∞∏Æ πÊæÓ∑¬ -3
	trigger.addStab(1);
	trigger.addHack(1);
	trigger.addInt(1);
	trigger.addDex(2);
	trigger.subDefence(3);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// »Øø¯
	trigger.subStab(1);
	trigger.subHack(1);
	trigger.subInt(1);
	trigger.subDex(2);
	trigger.addDefence(3);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001026()				// ƒ¨≈◊¿œ
{
	integer downMP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001026_wait")) return;

	// 5 % mp ªÁøÎ
	downMP = trigger.getMP() * 5 / 100;
	if (downMP == 0) downMP = 1;
	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001026_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001027_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// ¬Ó∏£±‚ ∏∂π˝ ∞¯∞›∑¬ +1, πŒ√∏º∫ +1, π∞∏Æ πÊæÓ∑¬ -1
	trigger.addInt(1);
	trigger.addDex(1);
	trigger.subDefence(1);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// »Øø¯
	trigger.subInt(1);
	trigger.subDex(1);
	trigger.addDefence(1);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001027()				// øÕ¿Œ
{
	integer downMP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001027_wait")) return;

	// 8 % mp ªÁøÎ
	downMP = trigger.getMP() * 8 / 100;
	if (downMP == 0) downMP = 1;
	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001027_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001028_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// ¬Ó∏£±‚ ∏∂π˝ ∞¯∞›∑¬ +2, ∏∂π˝ πÊæÓ∑¬ +2, π∞∏Æ πÊæÓ∑¬ -2
	trigger.addInt(2);
	trigger.addMagicResist(2);
	trigger.subDefence(2);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// »Øø¯
	trigger.subInt(2);
	trigger.subMagicResist(2);
	trigger.addDefence(2);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001028()				// ∫∏µÂƒ´
{
	integer downMP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001028_wait")) return;

	// 8 % mp ªÁøÎ
	downMP = trigger.getMP() * 8 / 100;
	if (downMP == 0) downMP = 1;
	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001028_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001029_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// ∫£±‚ ∞¯∞›∑¬ +1, π∞∏Æ πÊæÓ∑¬ +3, πŒ√∏º∫ -2
	trigger.addHack(1);
	trigger.addDefence(3);
	trigger.subDex(2);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// »Øø¯
	trigger.subHack(1);
	trigger.subDefence(3);
	trigger.addDex(2);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001029()				// ∆¯≈∫¡÷
{
	integer downMP, downHP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001029_wait")) return;

	// 8 % mp ªÁøÎ
	downMP = trigger.getMP() * 8 / 100;
	if (downMP == 0) downMP = 1;
	// 8 % hp ªÁøÎ
	downHP = trigger.getHP() * 8 / 100;
	if (downHP == 0) downHP = 1;

	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getHP() < downHP) {
		trigger.message(CANT_USE_FOR_LOW_HP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;
	if (!HardCode.itemDownHP(trigger, downHP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001029_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001030_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// ∫£±‚ ∞¯∞›∑¬ +3, π∞∏Æ πÊæÓ∑¬ +1, πŒ√∏º∫ -3
	trigger.addHack(3);
	trigger.addDefence(1);
	trigger.subDex(3);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// »Øø¯
	trigger.subHack(3);
	trigger.subDefence(1);
	trigger.addDex(3);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001030()				// ∑≥¡÷
{
	integer downMP, downHP, downSP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001030_wait")) return;

	// 8 % mp ªÁøÎ
	downMP = trigger.getMP() * 8 / 100;
	if (downMP == 0) downMP = 1;
	// 8 % hp ªÁøÎ
	downHP = trigger.getHP() * 8 / 100;
	if (downHP == 0) downHP = 1;
	// 5 % sp ªÁøÎ
	downSP = trigger.getSP() * 5 / 100;
	if (downSP == 0) downSP = 1;

	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getHP() < downHP) {
		trigger.message(CANT_USE_FOR_LOW_HP, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getSP() < downSP) {
		trigger.message(CANT_USE_FOR_LOW_SP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;
	if (!HardCode.itemDownHP(trigger, downHP)) return;
	if (!ItemDownSP(trigger, downSP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001030_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001031_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// ¬Ó∏£±‚ ∞¯∞›∑¬ +1, ∫£±‚ ∞¯∞›∑¬ +1, π∞∏Æ πÊæÓ∑¬ +2, πŒ√∏º∫ +1, ∏∂π˝ πÊæÓ∑¬ -3
	trigger.addStab(1);
	trigger.addHack(1);
	trigger.addDefence(2);
	trigger.addDex(1);
	trigger.subMagicResist(3);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// »Øø¯
	trigger.subStab(1);
	trigger.subHack(1);
	trigger.subDefence(2);
	trigger.subDex(1);
	trigger.addMagicResist(3);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001031()				// πﬂ∑ª≈∏¿Œ 100 ≥‚ªÍ
{
	integer downMP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001031_wait")) return;

	// 10 % mp ªÁøÎ
	downMP = trigger.getMP() * 10 / 100;
	if (downMP == 0) downMP = 1;
	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001031_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001032()				// æÀ ºˆ æ¯¥¬ º˙
{
	integer selection = Util.random(0, 8);
	string effect;

	if (selection == 0) effect = "qUseItem1001023";
	else if (selection == 1) effect = "qUseItem1001024";
	else if (selection == 2) effect = "qUseItem1001025";
	else if (selection == 3) effect = "qUseItem1001026";
	else if (selection == 4) effect = "qUseItem1001027";
	else if (selection == 5) effect = "qUseItem1001028";
	else if (selection == 6) effect = "qUseItem1001029";
	else if (selection == 7) effect = "qUseItem1001030";
	else if (selection == 8) effect = "qUseItem1001031";

	controller.giveQuestTo(effect, trigger, null);
}

quest
qUseItem1001033_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// ∏∂π˝ ∞¯∑¬∑¬ +2, ∏∂π˝ πÊæÓ∑¬ +1, π∞∏Æ πÊæÓ∑¬ -1
	trigger.addInt(2);
	trigger.addMagicResist(1);
	trigger.subDefence(1);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// »Øø¯
	trigger.subInt(2);
	trigger.subMagicResist(1);
	trigger.addDefence(1);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1001033()				// ±§√µºˆ
{
	integer downMP, downHP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1001033_wait")) return;

	// 5 % mp ªÁøÎ
	downMP = trigger.getMP() * 8 / 100;
	if (downMP == 0) downMP = 1;
	// 5 % hp ªÁøÎ
	downHP = trigger.getHP() * 8 / 100;
	if (downHP == 0) downHP = 1;

	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getHP() < downHP) {
		trigger.message(CANT_USE_FOR_LOW_HP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1001033_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001034()				// øÏ¿Ø
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	if (trigger.getMP() < 5) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	// hp 300 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 300)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 300)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 300);
	}
	// sp 300 »∏∫π
	if (ItemUpSP(trigger, 300)) bUsed = true;

	if (bUsed == true) HardCode.itemDownMP(trigger, 5);
	else return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001035()				// ≥Ï¬˜
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	if (trigger.getMP() < 5) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	// hp 500 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 500)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 500)) bUsed = true;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 500);
	}

	if (bUsed == true) HardCode.itemDownMP(trigger, 5);
	else return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001036()				// »´¬˜
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	if (trigger.getHP() < 100) {
		trigger.message(CANT_USE_FOR_LOW_HP, MSG_TYPE__SYSTEM);
		return;
	}

	if (HardCode.itemUpMP(trigger, 10)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 10);

	if (bUsed == true) {
	// hp 100 º“∫Ò
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		HardCode.itemUpHP(trigger, 100);
	} else {
		HardCode.itemDownHP(trigger, 100);	}
	}
	else return;

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001037()				// ƒø««
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	if (trigger.getHP() < 50) {
		trigger.message(CANT_USE_FOR_LOW_HP, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getSP() < 50) {
		trigger.message(CANT_USE_FOR_LOW_SP, MSG_TYPE__SYSTEM);
		return;
	}

	if (HardCode.itemUpMP(trigger, 50)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 50);

	if (bUsed == true) {
		// hp 50 º“∫Ò
		if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
			HardCode.itemUpHP(trigger, 50);
		} else	HardCode.itemDownHP(trigger, 50);
		// sp 50 º“∫Ò
		ItemDownSP(trigger, 50);
	}
	else return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001038()				// ƒ⁄ƒ⁄æ∆
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	if (trigger.getMP() < 5) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	// sp 500 »∏∫π
	if (ItemUpSP(trigger, 500)) bUsed = true;

	if (bUsed == true) HardCode.itemDownMP(trigger, 5);
	else return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001039()				// æ∆¿ÃΩ∫≈©∏≤
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	if (trigger.getMP() < 10) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	// hp 500 »∏∫π
	if (HardCode.itemUpHP(trigger, 500)) bUsed = true;
	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
	ItemBalloonUpHP(trigger, 500);
	// sp 500 »∏∫π
	if (ItemUpSP(trigger, 500)) bUsed = true;

	if (bUsed == true) HardCode.itemDownMP(trigger, 10);
	else return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001041()				// ª˝µ∑¿∞
{
	if (!NormalItemCanBeUsed()) return;

	// hp 30 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 30)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 30)) return;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 30);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001044()				// »£π⁄ ¡∂∞¢
{
	if (!NormalItemCanBeUsed()) return;

	// hp 45 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 45)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 45)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 45);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001046()				// «ÿπ∞ º“Ω√¡ˆ
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 200 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 200)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 200)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 200);
	}

	// mp 20 »∏∫π
	if (HardCode.itemUpMP(trigger, 20)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 20);

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001047()				// ≈‰≥¢«Æ ≤…
{
	if (!NormalItemCanBeUsed()) return;

	// mp 10 »∏∫π
	if (!HardCode.itemUpMP(trigger, 10)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 10);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001048()				// µ•¿Ã¡ˆ ≤…
{
	if (!NormalItemCanBeUsed()) return;

	// sp 15 »∏∫π
	if (!ItemUpSP(trigger, 15)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001049()				// ∫Ì∑Á∫£∏Æ
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 30 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 30)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 30)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 30);
	}

	// mp 5 »∏∫π
	if (HardCode.itemUpMP(trigger, 5)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 5);

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001050()				// ∑πµÂ∫£∏Æ
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 60 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 60)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 60)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 60);
	}

	// mp 10 »∏∫π
	if (HardCode.itemUpMP(trigger, 10)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 10);

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001051()				// »≠¿Ã∆Æ∫£∏Æ
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 90 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 90)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 90)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 90);
	}

	// mp 15 »∏∫π
	if (HardCode.itemUpMP(trigger, 15)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 15);

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001053()				// ¥Ÿ¿ÃæÓ∆Ææ‡
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	if (trigger.getHP() < 5) {
		trigger.message(CANT_USE_FOR_LOW_HP, MSG_TYPE__SYSTEM);
		return;
	}

	// hp 5 º“∫Ò
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemUpHP(trigger, 5)) bUsed = true;
	} else {
		if (HardCode.itemDownHP(trigger, 5)) bUsed = true;
	}

	// mp 30 »∏∫π
	if (HardCode.itemUpMP(trigger, 30)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 30);

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001054()				// «œ¥œ∫Í∑πµÂ
{
	if (!NormalItemCanBeUsed()) return;

	// hp 70 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 70)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 70)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 70);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001057()				// «œ¥œ∫£æÓ ±∏¿Ã
{
	if (!NormalItemCanBeUsed()) return;

	// hp 120 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 120)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 120)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 120);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001058()				// π˙≤‹
{
	if (!NormalItemCanBeUsed()) return;

	// hp 200 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 200)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 200)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 200);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001059()				// ∑Œæ‚¡¶∏Æ
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	// sp 50% »∏∫π
	toUp = trigger.getMaxSP() * 50 / 100;
	if(!ItemUpSP(trigger, toUp)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001060()				// ªß
{
	if (!NormalItemCanBeUsed()) return;

	// hp 20 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 20)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 20)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 20);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001063()				// µ˛±‚∏¿ ∆ƒ∏£∆‰
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 10 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 10)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 10)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 10);
	}

	// mp 50 »∏∫π
	if (HardCode.itemUpMP(trigger, 50)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 50);

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001064()				// ≈◊Ω∫≈Õ¿« ªÛ¬°
{
	if (!NormalItemCanBeUsed()) return;

	// ∞Ê«Ëƒ° 500 ¡ı∞°
	trigger.addExp(500);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}


quest
qUseItem1001102()				// Ω∫∆‰º» æ∆¿Ã≈€ ªÛ¿⁄	(≥ªøÎ¿∫ ≈◊Ω∫≈Õ ªÛ¬°∞˙ µø¿œ. ¿œ∫ªø°º≠ æÀæ∆º≠ ºˆ¡§«ÿº≠ ªÁøÎ.)
{
	if (!NormalItemCanBeUsed()) return;

	// ∞Ê«Ëƒ° 500 ¡ı∞°
	trigger.addExp(500);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}


quest
qUseItem1001065()				// »£π⁄¡◊
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 300 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 300)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 300)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 300);
	}

	// sp 30 »∏∫π
	if (ItemUpSP(trigger, 30)) bUsed = true;

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001068()				// ¡©∏Æ ≈©∏≤
{
	if (!NormalItemCanBeUsed()) return;

	// hp 15 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 15)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 15)) return;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 15);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000230()				// ¡Ÿπ´¥Ã ªÁ≈¡
{
	integer	Up;
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 30% »∏∫π
	Up = trigger.getMaxHP() * 30 / 100;
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, Up)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, Up)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, Up);
	}

	// mp 30% »∏∫π
	Up = trigger.getMaxMP() * 30 / 100;
	if (HardCode.itemUpMP(trigger, Up)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, Up);

	// sp 30% »∏∫π
	Up = trigger.getMaxSP() * 30 / 100;
	if (ItemUpSP(trigger, Up)) bUsed = true;

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000231()				// ≈©∏ÆΩ∫∏∂Ω∫ º±π∞
{
	integer selection,number=1;
	string itemID;

	selection = Util.random(1, 20000);

	if (selection == 1) {			// 1µÓ 1/20000 ¥Ÿ≈©¿Æ
		itemID	= "1002675";
	} else if (selection == 20000) {	// 2µÓ 1/20000 »≠¿Ã∆Æ¿Æ
		itemID = "1002674";
	} else if (selection <= 11) {		// 3µÓ 1/1000 ∫£∑π∏
		itemID = "1002647";
	} else if (selection >= 19989) {	// 4µÓ 1/1000 ¿Øƒ°ø¯ ∞°πÊ
		itemID = "1002324";
	} else if (selection <= 21) {		// 5µÓ 1/1000 º¯∑œø 
		itemID = "1002697";
	} else if (selection <= 10000) {	// 6µÓ ¡˙«≥¿« æ‡√ (5∞≥)
		itemID = "1001890";
		number = 5;
	} else {				// 7µÓ Ω≈º”¿« ø≠∏≈(5∞≥)
		itemID = "1001889";
		number = 5;
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.addItemClassNamed(itemID, number);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1000233()				// Ω≈≥‚ º±π∞ (πÃ±∏«ˆ)
{
}


quest
qUseItem1000234()				// æÓ∏∞¿Ã≥Ø º±π∞
{
	integer selection;
//	integer giftchk;
	string itemID;

//	giftchk = Util.random(0, 10000);
	selection = Util.random(0, 100);

/*
	if (giftchk <= 11) {			// ∑πæÓ æ∆¿Ã≈€¿« √≥∏Æ
		if (selection >= 90) {
			itemID = "1000103";	// ø©Ω≈¿« ∞°»£ (¥Î)
		} else if (selection >= 80) {
			itemID = "1000085";	// ∏ÆΩ∫≈‰æÓ ºº∆Æ
		} else if (selection >= 70) {
			itemID = "1000093";	// º˝µπ (¡ﬂ)
		} else if (selection >= 60) {
			itemID = "1000102";	// √µªÁ¿« ∞°»£ (¡ﬂ)
		} else if (selection >= 50) {
			itemID = "1000099";	// ∏∂∑¬∞≠»≠¡¶ (¡ﬂ)
		} else if (selection >= 40) {
			itemID = "1000090";	// ≈∞¥◊≈∞∆Æ (¡ﬂ)
		} else if (selection >= 30) {
			itemID = "1000105";	// ∞Ê»≠¡¶ (¡ﬂ)
		} else if (selection >= 20) {
			itemID = "1000096";	// ≈∫º∫∑Œº« (¡ﬂ)
		} else {
			itemID = "1000087";	// ≥ª±∏º∫ Ω∫«¡∑π¿Ã(¡ﬂ)
}

	} else {		// ¡§ªÛ¿˚¿Œ √≥∏Æ¿« ∞ÊøÏ
*/
	if (selection >= 90) {
		itemID = "1000297";		// 10% ø°∆‰
	} else if (selection >= 80) {
		itemID = "1000276";		// 10% ¥Î∞≈
	} else if (selection >= 70) {
		itemID = "1000318";		// 10% Ω«µÂº“µÂ
	} else if (selection >= 60) {
		itemID = "1000339";		// 10% ∞≠√∂¥Î∞À
	} else if (selection >= 50) {
		itemID = "1000360";		// 10% ƒø≈Õ
	} else if (selection >= 40) {
		itemID = "1000381";		// 10% ≈∏µµ
	} else if (selection >= 30) {
		itemID = "1000402";		// 10% ≈¬µµ
	} else if (selection >= 20) {
		itemID = "1000423";		// 10% ¥Á∆ƒ√¢
	} else {
		itemID = "1000465";		// 10% ªÁΩΩ√§¬Ô
}
//	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001829()				// ∏¡µ’¿Ã¿« ∫Ò¥√
{
	if (!NormalItemCanBeUsed()) return;

	// sp 30 »∏∫π
	if(!ItemUpSP(trigger, 30)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001831()				// «√∂ÛπŸ¿« ≤…¿Ÿ
{
	if (!NormalItemCanBeUsed()) return;

	// mp 25 »∏∫π
	if (!HardCode.itemUpMP(trigger, 25)) return;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 25);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001835()				// πÆæÓ¥Ÿ∏Æ
{
	if (!NormalItemCanBeUsed()) return;

	// hp 40 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 40)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 40)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 40);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001877() 				// ∑ŒΩ¥ 1»£ ∆˜º«
{
	integer value;

	if (!NormalItemCanBeUsed()) return;

	// HP 140~240 ªÛΩ¬ (π¸¿ß ∞™)
	value = Util.random(140, 240);

	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, value)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, value)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, value);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);

}

quest
qUseItem1001878() 				// ∑ŒΩ¥ 3»£ ∆˜º«
{
	integer value;

	if (!NormalItemCanBeUsed()) return;

	// HP 270~410 ªÛΩ¬ (π¸¿ß ∞™)
	value = Util.random(270, 410);

	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, value)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, value)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			if (!ItemBalloonUpHP(trigger, value)) return;
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);

}

quest
qUseItem1001879() 				// ∑ŒΩ¥ 5»£ ∆˜º«
{
	integer value;

	if (!NormalItemCanBeUsed()) return;

	// HP 400~580 ªÛΩ¬ (π¸¿ß ∞™)
	value = Util.random(400, 580);

	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, value)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, value)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, value);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);

}

quest						// µŒ±‚ 1»£ ∆˜º«?
qUseItem1001880()
{
	integer value;

	if (!NormalItemCanBeUsed()) return;

	// MP 45~70 ªÛΩ¬ (π¸¿ß ∞™)
	value = Util.random(45, 70);
	if (!HardCode.itemUpMP(trigger, value)) return;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, value);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest						// µŒ±‚ 3»£ ∆˜º«?
qUseItem1001881()
{
	integer value;

	if (!NormalItemCanBeUsed()) return;

	// MP 70~110 ªÛΩ¬ (π¸¿ß ∞™
	value = Util.random(70, 110);
	if (!HardCode.itemUpMP(trigger, value)) return;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, value);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest						// µŒ±‚ 5»£ ∆˜º«?
qUseItem1001882()
{
	integer value;

	if (!NormalItemCanBeUsed()) return;

	// MP 95~150 ªÛΩ¬ (π¸¿ß ∞™)
	value = Util.random(95, 150);
	if (!HardCode.itemUpMP(trigger, value)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, value);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001234()				// ƒ≥∫ÒæÓ
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	// mp 50% »∏∫π
	toUp = trigger.getMaxMP() * 50 / 100;
	if (!HardCode.itemUpMP(trigger, toUp)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, toUp);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001240()				// ≈©∏ÆΩ∫∏∂Ω∫ æÁ∏ª
{
	integer	Up;
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 20% »∏∫π
	Up = trigger.getMaxHP() * 20 / 100;
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, Up)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, Up)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, Up);
	}

	// mp 20% »∏∫π
	Up = trigger.getMaxMP() * 20 / 100;
	if (HardCode.itemUpMP(trigger, Up)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, Up);

	// sp 20% »∏∫π
	Up = trigger.getMaxSP() * 20 / 100;
	if (ItemUpSP(trigger, Up)) bUsed = true;

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001241()				// ø’ ∫∞
{
	integer	Up;
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 10% »∏∫π
	Up = trigger.getMaxHP() * 10 / 100;
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, Up)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, Up)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, Up);
	}

	// mp 10% »∏∫π
	Up = trigger.getMaxMP() * 10 / 100;
	if (HardCode.itemUpMP(trigger, Up)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, Up);

	// sp 10% »∏∫π
	Up = trigger.getMaxSP() * 10 / 100;
	if (ItemUpSP(trigger, Up)) bUsed = true;

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001242()				// ∏ÆΩ∫
{
	integer	Up;
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 10% »∏∫π
	Up = trigger.getMaxHP() * 10 / 100;
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, Up)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, Up)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, Up);
	}

	// mp 10% »∏∫π
	Up = trigger.getMaxMP() * 10 / 100;
	if (HardCode.itemUpMP(trigger, Up)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, Up);

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002698()				// ƒ…¿Ã≈© ¡∂∞¢
{
	integer torchTime;
	object skill_Torch;
	integer	Up,UseCount=0;
	boolean bUsed = false;
	object castedSpellInven;

	castedSpellInven = trigger.getCastedSpellInventory();
	skill_Torch = castedSpellInven.getObjectCreatureStated(CREATURE_STATE__ILLUMINATE);

	if (!NormalItemCanBeUsed()) return;

	// hp øœ¿¸ »∏∫π
	Up = trigger.getMaxHP();
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
	    if (HardCode.itemDownHP(trigger, Up)) bUsed = true;
	} else {
	    if (HardCode.itemUpHP(trigger, Up)) bUsed = true;
	}

	// mp øœ¿¸ »∏∫π
	Up = trigger.getMaxMP();
	if (HardCode.itemUpMP(trigger, Up)) bUsed = true;

	// sp øœ¿¸ »∏∫π
	Up = trigger.getMaxSP();
	if (ItemUpSP(trigger, Up)) bUsed = true;

	if(trigger.isState(CREATURE_STATE__ILLUMINATE))
	{
		torchTime = skill_Torch.getDuration();
	}

	//castedSpellInven = trigger.getCastedSpellInventory();
	if(castedSpellInven.getCount() > 0)
	{
		castedSpellInven.finalizeAll();
		bUsed = true;
	}

	if(torchTime != 0)
	{
		trigger.castNamedWithDuration("3000253",torchTime);
		// send using effect
		controller.effectBy(trigger);
	}

	if (!bUsed) return;

	// decrease number
	if (controller.checkAttribute("UC") == true)
		UseCount = String.toInteger(controller.getAttribute("UC"));
	else
	{
		if (controller.checkAttribute("USE_COUNT") == true)
			UseCount = String.toInteger(controller.getAttribute("USE_COUNT"));
		controller.resetAttribute("USE_COUNT");
	}
	if (controller.canBeExhausted() && UseCount >= 9) {
		controller.decreaseNumber(1);
	}
	else controller.setAttribute("UC",Integer.toString(UseCount+1));

	//trigger.message(String.toString(UseCount+1), MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001244()				// ∏Æ«¡¡©∏Æ≈©∏≤
{
	if (!NormalItemCanBeUsed()) return;

	// hp 400 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 400)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 400)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 400);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001246()				// ¿Ã∆ƒ∏Æ∏«¿« ¿Ã∆ƒ∏Æ
{
	if (!NormalItemCanBeUsed()) return;

	// mp 200 »∏∫π
	if (!HardCode.itemUpMP(trigger, 200)) return;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 200);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001250()				// πˆº∏
{
	if (!NormalItemCanBeUsed()) return;

	// mp 20 »∏∫π
	if (!HardCode.itemUpMP(trigger, 20)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 20);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001251()				// ∞ı∆Œ¿Ã ∆˜¿⁄
{
	if (!NormalItemCanBeUsed()) return;

	// hp 500 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 500)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 500)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 500);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001252()				// 100≥‚ π¨¿∫ πˆº∏
{
	integer toUp;

	if (!NormalItemCanBeUsed()) return;

	// hp øœ¿¸»∏∫π
	toUp = trigger.getMaxHP();
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, toUp)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, toUp)) return;
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001806()				// ≈◊Ω∫≈Õ¿« »•. ¿Á∫–πË æ∆¿Ã≈€
{
//	integer InventorySlotCount = 0;
	integer EquipPartCount = 8;
	integer checkUserWeight;
	integer i;

	if (!NormalItemCanBeUsed())
		return;

	if (trigger.getWorld().canFight() || trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD , MSG_TYPE__SYSTEM);
		return;
	}

	checkUserWeight = trigger.getCarryingItemInventory().weight();

	if (checkUserWeight >= 750) {
        trigger.message("Please Keep Your Weight under 750.", MSG_TYPE__SYSTEM);
//        trigger.message(TEXT_NO_RESET_CAUSE_WEIGHT, MSG_TYPE__SYSTEM);	// vahma - japan setting
		return;
	}

//	InventorySlotCount = trigger.getEmptyInvenSlotCount();

	for (i=1;i<9;++i) {
		if (trigger.getDescAtPart(i) == null) {
			EquipPartCount = EquipPartCount - 1;
		}
	}

	if (EquipPartCount != 0) {
        trigger.message("Please Unequip All Items.", MSG_TYPE__SYSTEM);
//        trigger.message(TEXT_NO_RESET_CAUSE_EQUIP, MSG_TYPE__SYSTEM);	// vahma - japan setting
		trigger.updateEquipAt(EQUIP_PART__ALL);
		trigger.updateAttr();			// »§Ω√ ∏Ù∂Ûº≠ ªÛ≈¬ æ˜µ•¿Ã∆Æ
		return;
	}

	// √ ±‚»≠ «‘ºˆ∏¶ Ω««‡«—¥Ÿ.
	trigger.getExpFromAllAbilityLevel();		// Ω∫≈≥∞˙ ∑π∫ß¿ª ∞Ê«Ëƒ°∑Œ »Øø¯
	trigger.resetCharacter(RESET_CHAR_LEVEL + RESET_CHAR_ACTION);	// √ ±‚»≠ Ω∫∆Âø° ∏¬√ﬂæÓ ƒ≥∏Ø≈Õ∏¶ √ ±‚»≠
	trigger.getCastedSpellInventory().terminatePassiveAll();

	Setup_Skill();
    trigger.message("Character Status Reset Complete!!", MSG_TYPE__SYSTEM);
//    trigger.message(TEXT_REQUEST_SHARE_END, MSG_TYPE__SYSTEM);	// vahma - japan setting

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	trigger.updateAttr();				// »§Ω√ ∏Ù∂Ûº≠ ªÛ≈¬ æ˜µ•¿Ã∆Æ
	controller.effectBy(trigger);
}


quest
qUseItem1001876()				// ∫π¡÷∏”¥œ
{
	integer selection;
	string itemID;

	selection = Util.random(0, 100);

	if (!NormalItemCanBeUsed()) return;

	if (selection >= 80) {			// 20 %	πŸ¿Ãø√∑ø «œ∫Í
		itemID = "1000035";
	} else if (selection >= 60) {		// 20 % «ÿµ∂¡¶
		itemID = "1000043";
	} else if (selection >= 40) {		// 20 % ≈∞¿ß¡÷Ω∫
		itemID = "1000026";
	} else if (selection >= 25) {		// 15 % ∏ÆπŸ¿Ã∫Í ∆ƒøÏ¥ı
		itemID = "1000036";
	} else if (selection >= 15) {		// 10 % »˙∏µ ∆˜º« (¡ﬂ)
		itemID = "1000017";
	} else if (selection >= 10) {		// 5 % ∆ƒ¿Ã«¡ ∆˜º« (º“)
		itemID = "1000019";
	} else if (selection >= 5) {		// 5 % ∏∏∫¥ ≈Îƒ°æ‡
		itemID = "1000052";
	} else {				// 5 % ∏Æ¿˙∑∫º« ∆˜º« (º“)
		itemID = "1000038";
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001884()				// ∏∂π∞¿« ≥™ƒßπ›
{
	if (!NormalItemCanBeUsed())
		return;

	trigger.message(TEXT_USABLEITEM_COMPASS , MSG_TYPE__SYSTEM);

	controller.effectBy(trigger);
}

quest
qUseItem1001887()				// ∏¡∞¢√ 
{
	if (!NormalItemCanBeUsed())
		return;

	if (!controller.getObjectArgumentAt(0).isMerchant()) {
		trigger.message(TEXT_USABLEITEM_OBLIVION , MSG_TYPE__SYSTEM);
		return;
	}

	// »£∞®µµ √ ±‚»≠.
	trigger.setGoodwillFor(controller.getObjectArgumentAt(0), 10);
	trigger.message(USE_GOODWILL_RESET , MSG_TYPE__SYSTEM);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	controller.effectBy(trigger);
}

quest
qUseItem1001889()	//Ω≈º”¿« ø≠∏≈
{
	integer wNum;

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000202",60);
}

quest
qUseItem1001890()	//¡˙«≥¿« æ‡√ 
{
	integer wNum;

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if (trigger.isState(CREATURE_STATE__HIGH_SPEED) || trigger.isState(CREATURE_STATE__SYLPH_WIND)) return;

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000204",60);
}

quest
qUseItem1001891()	//∫Œ»∞¿« «‚ºˆ
{
	integer wNum;

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000207",120);
}

quest
qUseItem1001892()	//±´∑¬¿« «‹
{
	integer wNum;

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000209",60);
}

quest
qUseItem1001893()	//√‡∫π¿« º∫ºˆ
{
	integer wNum;

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.isState(CREATURE_STATE__BLESS))
	{
		trigger.message(TEXT_USABLEITEM_BLESSING, MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000210",60);
}

quest
qUseItem1001894()	//¿˚¡ﬂ¿« «™µ˘
{
	integer wNum;

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getDex()>=45)
	{
		trigger.message(TEXT_USABLEITEM_DEX_RATE, MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000211",60);
}

quest
qUseItem1001895()	//»∏««¿« ƒÌ≈∞
{
	integer wNum;

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
 	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000212",60);
}

quest
qUseItem1001896()	//øœ¿¸»∏««¿« π∞æ‡
{
	integer wNum;

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// PVP ¿Ã∫•∆Æ ¡ˆø™
	if (wNum == 565 || wNum == 566 || wNum == 567 || wNum == 568 || wNum == 569)
	{
		trigger.sayTo(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK, trigger);
		return;
	}

	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000213",30);
}

quest
qUseItem1001901()	// ∂Û¿Ãµæ∆ ∆ØªÍ¬˜
{
	integer Regen_chk = 0;

	if (!NormalItemCanBeUsed())
		return;

	if (trigger.isState(CREATURE_STATE__NO_HP_REGEN) || trigger.isState(CREATURE_STATE__NO_MP_REGEN)) {
		trigger.message(TEXT_USABLEITEM_TEA, MSG_TYPE__SYSTEM);
		return;
	}

	// HP 150 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 150));
	} else {
		if (!HardCode.itemUpHP(trigger, 150)) ++Regen_chk;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 150);
	}

	// MP 100 »∏∫π
	if (!HardCode.itemUpMP(trigger, 100)) ++Regen_chk;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 100);

	if (Regen_chk >= 2) return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	controller.effectBy(trigger);
}

quest
qUseItem1001907()	// ∂ÛπŸ¿« π¯µ•±‚
{
	integer Regen_chk = 0;

	if (!NormalItemCanBeUsed())
		return;

	if (trigger.isState(CREATURE_STATE__NO_HP_REGEN) || trigger.isState(CREATURE_STATE__NO_MP_REGEN)) {
		trigger.message(TEXT_USABLEITEM_RAVA, MSG_TYPE__SYSTEM);
		return;
	}

	// HP 500 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 500));
	} else {
		if (!HardCode.itemUpHP(trigger, 500)) ++Regen_chk;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 500);
	}

	// MP 60 »∏∫π
	if (!HardCode.itemUpMP(trigger, 50)) ++Regen_chk;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 50);

	if (Regen_chk >= 2) return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	controller.effectBy(trigger);
}

quest
qUseItem1001909()	// π›µ ºˆ¡§
{
	object target,castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	target = controller.getObjectArgumentAt(0);

	castedSpellInven = target.getCastedSpellInventory();
	if (castedSpellInven.getObjectCreatureStated(CREATURE_STATE__BLIND)) {
		// decrease number
		if (controller.canBeExhausted())
	 		controller.decreaseNumber(1);

		// finalize
		castedSpellInven.getObjectCreatureStated(CREATURE_STATE__BLIND).finalize();

		// send using effect
		controller.effectBy(target);
	}
}

quest
qUseItem1001954()	//	π∞¿« ¬°«•
{
	if (!NormalItemCanBeUsed()) return;

	// sp 150 »∏∫π
	if (!ItemUpSP(trigger, 150)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001955()	// øˆ≈Õ ¿Æ≈∞¿« ¿Â∞©
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1001956()	//	πŸ∂˜¿« ªÁ≈¡
{
	if (!NormalItemCanBeUsed()) return;

	// mp 150 »∏∫π
	if (!HardCode.itemUpMP(trigger, 150)) return;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 150);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1001957()	//	»• ø¿∫Í ¥ı µ•Ω∫
{
	if (!NormalItemCanBeUsed()) return;

	// hp 700 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 700)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 700)) return;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 700);
	}

	if(UseSkillByProb(trigger,"3000199",10,100,50)==true)
		trigger.message(TEXT_USABLEITEM_HORNOFDEATH, MSG_TYPE__SYSTEM);
}

quest
qUseItem1001961()	// ª˛««æÓ¿« »≠ø∞
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1001964()	// π´≈ıπÈ»£¿« ¿Ãª°
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1001966()	// ∫“±Ê¿« Ω«≈∏∑°
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1001968()	// ¿¸∞› ∂ÛπŸ π¯µ•±‚
{
	if (!NormalItemCanBeUsed())
		return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

function
boolean
ItemUseEnd()
{
	trigger.setState(USER_STATE__EVENT, false);
	trigger.setState(USER_STATE__NO_PORTAL, false);
	trigger.setState(CREATURE_STATE__NO_MOVE, false);
	return true;
}

function
boolean
NPCRangeCheck()
{
	integer defX, defY, startX, startY, endX, endY;
	object loc;

	startX = trigger.getX() - 4;
	startY = trigger.getY() - 4;
	endX = trigger.getX() + 4;
	endY = trigger.getY() + 4;

	for (defX = startX; defX < endX; ++defX) {
		for (defY = startY; defY < endY; ++defY) {
			loc = Visible.at(defX, defY);
			if (loc && loc.isMerchant()) {
				trigger.message(TEXT_USABLEITEM_CANT_NPC_POSITION, MSG_TYPE__SYSTEM);
				return false;
			}
		}
	}
	return true;
}

quest
qUseItem1001914()	// ªÛ¿Œ¿« ª‘««∏Æ
{
	// ¥Î∏∏µÓø° ¿˚øÎ«“ ∂© ª©º≠ ¿˚øÎ«ÿæﬂ «‘. isPaid
	
	if (trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD , MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getWorld().getNumber() == 30) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD , MSG_TYPE__SYSTEM);
		return;
	}

	if (!NPCRangeCheck()) {
		ItemUseEnd();
		return;
	}

	trigger.setState(USER_STATE__EVENT, true);
	trigger.setState(USER_STATE__NO_PORTAL, true);
	trigger.setState(CREATURE_STATE__NO_MOVE, true);

	if (!NormalItemCanBeUsed()) {
		ItemUseEnd();
		return;
	}

	// ∂Ù¿ª ∞…æÓ¡÷∞Ì..
	controller.setLocked(true);

	// ∏∏µÂ¥¬µ• Ω«∆–«ﬂ≥™? ±◊∑∏¥Ÿ∏È ∂Ù¿ª πŸ∑Œ «ÆæÓ¡÷¿⁄.
	if (!trigger.startTrade(false, 800)) {
//		if (!trigger.startTradeWith(controller, 800)) {
		controller.setLocked(false);
		ItemUseEnd();
		return;
	}

	// ¿Ø¿˙¿« ¿¿¥‰¿ª ±‚¥Ÿ∏∞ »ƒ
	Event.waitFor(EVENT_USER_MERCHANT);

	// ∂Ù¿ª «ÆæÓ¡ÿ¥Ÿ.
	controller.setLocked(false);

	// ∏∏µÈ¥Ÿ∞° ¡ﬂ∞£ø° ƒµΩΩ
	if (!Event.result(EVENT_USER_MERCHANT)) {
		ItemUseEnd();
		return;
	}

	controller.effectBy(trigger);

	// ¥Ÿ ∏∏µÈæ˙¿∏¥œ±Ó æ∆∑° √≥∏Æ
	// ¿Ã ∂ß ¡÷¿««“ ∞Õ¿∫ wait ø° µÈæÓ∞¨¥Ÿ∞° ≥™ø¬ ∞Õ¿Ã±‚ ∂ßπÆø°,
	// decrease number ∏¶ ∫“∑Øº≠¥¬ æ»µ»¥Ÿ.
	// π›µÂΩ√ sweepNumbered ∏¶ ∫Œ∏¶ ∞Õ!!
	// ±◊∏Æ∞Ì sweepNumbered ∏¶ ∫Œ∏£¥¬ ∞ÊøÏ¥¬ æ∆¿Ã≈€¿Ã πŸ∑Œ æ¯æÓ¡ˆ±‚ ∂ßπÆø°
	// effectBy ∏¶ æ’ø°º≠ ∫“∑Øæﬂ «—¥Ÿ.
	if (controller.canBeExhausted()) controller.sweepNumbered(1);
		ItemUseEnd();
}

quest
qUseItem1002853()	// ¿‚ªÛ¿Œ¿« ª‘««∏Æ
{
	integer MapNumber;

	trigger.setState(USER_STATE__EVENT, true);
	trigger.setState(USER_STATE__NO_PORTAL, true);
	trigger.setState(CREATURE_STATE__NO_MOVE, true);

	if (!NormalItemCanBeUsed()) {
		ItemUseEnd();
		return;
	}

	MapNumber = trigger.getWorld().getNumber();

	if (MapNumber != 303 && MapNumber != 317 && MapNumber != 562) {
		trigger.sayTo(TEXT_CANT_USE_EXCEPT_FLEAMARKET, trigger);
		ItemUseEnd();
		return;
	}

	if (!NPCRangeCheck()) {
		ItemUseEnd();
		return;
	}
	// ∂Ù¿ª ∞…æÓ¡÷∞Ì..
	controller.setLocked(true);

	// ∏∏µÂ¥¬µ• Ω«∆–«ﬂ≥™? ±◊∑∏¥Ÿ∏È ∂Ù¿ª πŸ∑Œ «ÆæÓ¡÷¿⁄.
	if (!trigger.startTrade(false, 180)) {
	// if (!trigger.startTradeWith(controller, 180)) {
		controller.setLocked(false);
		ItemUseEnd();
		return;
	}

	// ¿Ø¿˙¿« ¿¿¥‰¿ª ±‚¥Ÿ∏∞ »ƒ
	Event.waitFor(EVENT_USER_MERCHANT);

	// ∂Ù¿ª «ÆæÓ¡ÿ¥Ÿ.
	controller.setLocked(false);

	// ∏∏µÈ¥Ÿ∞° ¡ﬂ∞£ø° ƒµΩΩ
	if (!Event.result(EVENT_USER_MERCHANT)) {
		ItemUseEnd();
		return;
	}

	controller.effectBy(trigger);

	// ¥Ÿ ∏∏µÈæ˙¿∏¥œ±Ó æ∆∑° √≥∏Æ
	// ¿Ã ∂ß ¡÷¿««“ ∞Õ¿∫ wait ø° µÈæÓ∞¨¥Ÿ∞° ≥™ø¬ ∞Õ¿Ã±‚ ∂ßπÆø°,
	// decrease number ∏¶ ∫“∑Øº≠¥¬ æ»µ»¥Ÿ.
	// π›µÂΩ√ sweepNumbered ∏¶ ∫Œ∏¶ ∞Õ!!
	// ±◊∏Æ∞Ì sweepNumbered ∏¶ ∫Œ∏£¥¬ ∞ÊøÏ¥¬ æ∆¿Ã≈€¿Ã πŸ∑Œ æ¯æÓ¡ˆ±‚ ∂ßπÆø°
	// effectBy ∏¶ æ’ø°º≠ ∫“∑Øæﬂ «—¥Ÿ.
	if (controller.canBeExhausted()) controller.sweepNumbered(1);
		ItemUseEnd();
}


quest
qUseItem1002051_wait()
{
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	// ¬Ó∏£±‚ ∞¯∞›∑¬ +2, ∫£±‚ ∞¯∞›∑¬ +2, ∏∂π˝ ∞¯∞›∑¬ +2, πŒ√∏º∫ +4, π∞∏Æ πÊæÓ∑¬ -4
	trigger.addStab(2);
	trigger.addHack(2);
	trigger.addInt(2);
	trigger.addDex(4);
	trigger.subDefence(4);
	trigger.updateAttr();

	// 10 √ ∞£ ±‚¥Ÿ∏≤
	Util.sleep(10);

	// »Øø¯
	trigger.subStab(2);
	trigger.subHack(2);
	trigger.subInt(2);
	trigger.subDex(4);
	trigger.addDefence(4);
	trigger.updateAttr();

	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1002051()				// ∆‰∆€πŒ∆Æ ƒ¨≈◊¿œ
{
	integer downMP;

	if (!NormalItemCanBeUsed()) return;

	// ¿ÃπÃ ªÁøÎ ¡ﬂ?
	if (trigger.hasQuest("qUseItem1002051_wait")) return;

	// 10 % mp ªÁøÎ
	downMP = trigger.getMP() * 10 / 100;
	if (downMP == 0) downMP = 1;
	if (trigger.getMP() < downMP) {
		trigger.message(CANT_USE_FOR_LOW_MP, MSG_TYPE__SYSTEM);
		return;
	}

	if (!HardCode.itemDownMP(trigger, downMP)) return;

	// æ∆¿Ã≈€ »ø∞˙ ¡÷±‚.
	// org ∞™¿ª πŸ≤Ÿ¥¬ ∞Õ¿Ã æ∆¥œ∞Ì,
	// ¿Á¡¢»ƒø° ¥ŸΩ√ »ø∞˙∞° ≥™øÕæﬂ «œ¥¬ ∞Õ¿Ã æ∆¥œ±‚ ∂ßπÆø°,
	// terminator ∏¶ æ≤¡ˆ æ ∞Ì ±◊≥… Ω∫≈©∏≥∆Æ «œ≥™ µπ∑¡¡÷∞Ì ∂Ø..
	trigger.giveQuestTo("qUseItem1002051_wait", trigger, null);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}


quest
qUseItem1001803()				// ¡÷Ω√¿⁄¿« ¥´
{
	object target;
	string UserNamed;
	string TeamName;
	string LeaderNamed;
	string UserIpAdd;
	integer MemberType;
	integer GoodWillforUser;
	integer UserEXPValue;
	integer UserSEEDValue;
	integer UserBalanceValue;
	integer MonLevel;
	integer MonHP;
	integer MonMP;
	integer MonSP;
	integer MonMaxHP;
	integer MonMaxMP;
	integer MonMaxSP;
	integer MonSTAB;
	integer MonHACK;
	integer MonINT;
	integer MonDEX;
	integer MonDEF;
	integer MonMR;
	integer	MonAGI;

	target = controller.getObjectArgumentAt(0);

	if (target) {
		if (target.isUser()) {
			if (trigger.getBuilderType() == 1 || trigger.getBuilderType() == 2) {
				trigger.message(TEXT_USABLEITEM_TARGET_ADMIN1, MSG_TYPE__SYSTEM);
			} else {
				UserNamed = target.getName();
				UserIpAdd = target.getIpString();
				MonLevel = target.getLevel();

				UserEXPValue = target.getExp();
				UserSEEDValue = target.getGold();
				UserBalanceValue = target.getBalance();

				if (target.hasTeam()) {
					TeamName = target.getGroupName();
					LeaderNamed = target.getTeamChiefUser().getName();
					MemberType = target.getTeamMemberType();
				} else {
					TeamName = "None";
					LeaderNamed = "None";
					MemberType = 0;
				}

				trigger.message(TEXT_USABLEITEM_ADMINID + UserNamed+TEXT_USABLEITEM_ADMINLV + MonLevel + TEXT_USABLEITEM_ADMINIP + UserIpAdd, MSG_TYPE__SYSTEM);
				trigger.message(TEXT_USABLEITEM_ADMIN5 + UserSEEDValue + TEXT_USABLEITEM_ADMIN6 + UserBalanceValue + TEXT_USABLEITEM_ADMIN_EXP +UserEXPValue, MSG_TYPE__SYSTEM);
				trigger.message(TEXT_USABLEITEM_ADMIN_TEAM+TeamName+TEXT_USABLEITEM_ADMIN_LEADER+LeaderNamed+TEXT_USABLEITEM_ADMIN_TYPE+MemberType, MSG_TYPE__SYSTEM);
			}
		} else if (target.isMerchant()) {
			GoodWillforUser = target.getGoodwillFor(trigger);
			trigger.message(TEXT_USABLEITEM_ADMIN_GOODWILL1+GoodWillforUser+TEXT_USABLEITEM_ADMIN_GOODWILL2, MSG_TYPE__SYSTEM);
		} else if (target.isMonster()) {
			MonLevel = target.getLevel();
			MonHP = target.getHP();
			MonMP = target.getMP();
			MonSP = target.getSP();
			MonMaxHP = target.getMaxHP();
			MonMaxMP = target.getMaxMP();
			MonMaxSP = target.getMaxSP();
			MonSTAB = target.getInt();
			MonHACK = target.getHack();
			MonINT = target.getStab();
			MonDEX = target.getDex();
			MonDEF = target.getDefence();
			MonMR = target.getMagicResist();
			MonAGI = target.getAgi();

			trigger.message(TEXT_USABLEITEM_MESSAGE_TARGET_LV1+MonLevel+TEXT_USABLEITEM_MESSAGE_MON, MSG_TYPE__SYSTEM);
			trigger.message(TEXT_USABLEITEM_MESSAGE_HP+MonHP+TEXT_USABLEITEM_MESSAGE_SLASH+MonMaxHP+TEXT_USABLEITEM_MESSAGE_MP+MonMP+TEXT_USABLEITEM_MESSAGE_SLASH+MonMaxMP+TEXT_USABLEITEM_MESSAGE_SP+MonSP+TEXT_USABLEITEM_MESSAGE_SLASH+MonMaxSP, MSG_TYPE__SYSTEM);
			trigger.message(TEXT_USABLEITEM_MESSAGE_STAB+MonSTAB+TEXT_USABLEITEM_MESSAGE_HACK+MonHACK+TEXT_USABLEITEM_MESSAGE_INT+MonINT+TEXT_USABLEITEM_MESSAGE_DEX+MonDEX+TEXT_USABLEITEM_MESSAGE_DEF+MonDEF+TEXT_USABLEITEM_MESSAGE_MR+MonMR+TEXT_USABLEITEM_MESSAGE_AGI+MonAGI, MSG_TYPE__SYSTEM);
		} else {
			trigger.message(TEXT_USABLEITEM_MESSAGE_UNKNOWN, MSG_TYPE__SYSTEM);
			return;
		}

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		controller.effectBy(target);
	}
}

quest
qUseItem1002168()				// øÎ¿⁄¿« ∫∏π∞ªÛ¿⁄
{
	string itemID;
	integer selection;
	integer item_num = 1;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 50) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection = Util.random(0, 100);

	if (selection >= 80) {			// 20 %	∑πµÂ«„∫Í 50∞≥
		itemID = "1000013";
		item_num = 50;
	} else if (selection >= 62) {		// 18 % ±◊∏∞«„∫Í 50∞≥
		itemID = "1000026";
		item_num = 50;
	} else if (selection >= 47) {		// 15 % ∫Ì∑Á∫£∏Æ 4∞≥
		itemID = "1001049";
		item_num = 4;
	} else if (selection >= 37) {		// 10 % ∑πµÂ∫£∏Æ 3∞≥
		itemID = "1001050";
		item_num = 3;
	} else if (selection >= 27) {		// 10 % »≠¿Ã∆Æ∫£∏Æ 2∞≥
		itemID = "1001051";
		item_num = 2;
	} else if (selection >= 17) {		// 10 % ∏¡∞¢√ 
		itemID = "1001887";
	} else if (selection >= 12) {		// 5 % «™∏•¿ÂπÃ
		itemID = "1002032";
	} else if (selection >= 9) {		// 3 % Ω∫ƒÌ«¡ ∞Ì√∂
		itemID = "1001864";
	} else if (selection >= 8) {		// 1 % √µªÁ¿«∞°»£(º“)
		itemID = "1000102";
	} else if (selection >= 7) {		// 1 % ≈∞¥◊≈∞∆Æ
		itemID = "1000090";
	} else if (selection >= 6) {		// 1 % Ω∫∆Æ∑¶
		itemID = "1000092";
	} else if (selection >= 5) {		// 1 % ∏∂.∞≠(º“)
		itemID = "1000098";
	} else if (selection >= 4) {		// 1 % ≈∫º∫ (º“)
		itemID = "1000095";
	} else if (selection >= 3) {		// 1 % ª˛«¡≥ 
		itemID = "1000089";
	} else if (selection >= 2) {		// 1 % º˝µπ
		itemID = "1000093";
	} else if (selection >= 1) {		// 1 % ≈∫º∫ (¡ﬂ)
		itemID = "1000096";
	} else {				// 1 % ∏∂.∞≠(¡ﬂ)
		itemID = "1000099";
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.addItemClassNamed(itemID, item_num);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002169()				// √÷∞≠ ≈¨∑¥¿« ¡ı«•
{
	boolean	bUsed=false;

	if (!NormalItemCanBeUsed()) return;

	// hp 120 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 120)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 120)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 120);
	}

	// mp 20 »∏∫π
	if (HardCode.itemUpMP(trigger, 20)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 20);

	if(bUsed == false) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002170()				// µµ¿¸ ≈¨∑¥¿« ¡ı«•
{
	boolean	bUsed=false;

	if (!NormalItemCanBeUsed()) return;

	// hp 30 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 30)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 30)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 30);
	}

	// mp 10 »∏∫π
	if (HardCode.itemUpMP(trigger, 10)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 10);

	if(bUsed == false) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002329()				// πÈº∑ µÂ∂Û¿Ãπˆ
{
	if (!NormalItemCanBeUsed()) return;

	// hp 120 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 120)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 120)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 120);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002330()				// ¿€¿∫ π˙∑π
{
	if (!NormalItemCanBeUsed()) return;

	// hp 120 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 120)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 120)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 120);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002331()				// ∑∫ Ω∫≈Ê
{
	if (!NormalItemCanBeUsed()) return;

	// hp 120 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 120)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 120)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 120);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002332()				// øÓøµ ±≥∫ª
{
	if (!NormalItemCanBeUsed()) return;

	// mp 20 »∏∫π
	if (!HardCode.itemUpMP(trigger, 20)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 20);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002333()				// ∫Ò∏≈≥  ±≥∫ª
{
	if (!NormalItemCanBeUsed()) return;

	// mp 20 »∏∫π
	if (!HardCode.itemUpMP(trigger, 20)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 20);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002334()				// «ÿ≈∑ ±≥∫ª
{
	if (!NormalItemCanBeUsed()) return;

	// mp 20 »∏∫π
	if (!HardCode.itemUpMP(trigger, 20)) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 20);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002335()				// ∆ƒ∂ı º±π∞ ªÛ¿⁄
{
	string itemID;
	integer selection;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 3) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 65) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection = Util.random(1, 10000);

	if (selection == 1 || selection == 2) {
		if (trigger.getDBID()==2000000) itemID = "1000328";		//π∞∫π ∑ÁΩ√æ»
		else if (trigger.getDBID()==2000001) itemID = "1000412";	//π∞∫π ∫∏∏ÆΩ∫
		else if (trigger.getDBID()==2000002) itemID = "1000412";	//π∞∫π ∏∑Ω√πŒ
		else if (trigger.getDBID()==2000003) itemID = "1000433";	//Ω∫≈« Ω√∫ß∏∞
		else if (trigger.getDBID()==2000007) itemID = "1000475";	//«Ÿ π–∂Û
		else if (trigger.getDBID()==2000008) itemID = "1000664";	//∞¯∞›«¸ ∆ºƒ°ø§
		else if (trigger.getDBID()==2000009) itemID = "1000307";	//Ω∫≈« ¿ÃΩ∫«…
		else if (trigger.getDBID()==2000010) itemID = "1000286";	//Ω∫≈« ≥™æﬂ∆Æ∑π¿Ã
		else if (trigger.getDBID()==2000014) itemID = "1000391";	//«Ÿ ∑ÁΩ√æ»
		else if (trigger.getDBID()==2000015) itemID = "1000391";	//«Ÿ ∫∏∏ÆΩ∫
		else if (trigger.getDBID()==2000016) itemID = "1000391";	//«Ÿ ∏∑Ω√πŒ
		else if (trigger.getDBID()==2000017) itemID = "1000454";	//π∞∫π Ω√∫ß∏∞
		else if (trigger.getDBID()==2000021) itemID = "1000622";	//π∞∫π π–∂Û
		else if (trigger.getDBID()==2000022) itemID = "1000685";	//∫∏¡∂«¸ ∆ºƒ°ø§
		else if (trigger.getDBID()==2000023) itemID = "1000328";	//π∞∫π ¿ÃΩ∫«…
		else if (trigger.getDBID()==2000024) itemID = "1000370";	//π∞∫π ≥™æﬂ∆Æ∑π¿Ã
		else if (trigger.getDBID()==2000028) itemID = "1000307";	//Ω∫≈« ∑ÁΩ√æ»
		else if (trigger.getDBID()==2000029) itemID = "1000349";	//∏∂∞ÀªÁ ∫∏∏ÆΩ∫
		else if (trigger.getDBID()==2000030) itemID = "1000349";	//∏∂∞ÀªÁ ∏∑Ω√πŒ
		else if (trigger.getDBID()==2000031) itemID = "1000454";	//«Ÿ Ω√∫ß∏∞
		else if (trigger.getDBID()==2000035) itemID = "1000622";	//Ω∫≈« π–∂Û
		else if (trigger.getDBID()==2000036) itemID = "1000706";	//¿¸≈ı ∆ºƒ°ø§
		else if (trigger.getDBID()==2000037) itemID = "1000391";	//«Ÿ ¿ÃΩ∫«…
		else if (trigger.getDBID()==2000038) itemID = "1000643";	//«Ÿ ≥™æﬂ∆Æ∑π¿Ã

		// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
		trigger.addItemClassNamed(itemID, 1);
		trigger.addItemClassNamed("1000961", 1);

		if(selection == 1)	// ∑æ 75 π´±‚ + ««¥–Ω∫ ¿Æ + ¿Æ Ω¥¡Ó
			trigger.addItemClassNamed("1002658", 1);
		else if(selection ==2)	// ∑æ 75 π´±‚ + ≈©∑ŒøÏ ¿Æ + ¿ÆΩ¥¡Ó
			trigger.addItemClassNamed("1002659", 1);
	}

	//vahma - japan setting
	else if(selection == 3 || selection == 4)
		trigger.addItemClassNamed("1002660", 1);	//ódêåÄñïÉ
	else if(selection == 5 || selection == 6)
		trigger.addItemClassNamed("1002661", 1);	//íâ XÇñáH
	else if(selection == 7 || selection == 8)
		trigger.addItemClassNamed("1002693", 1);	//âHñXq
	else if(selection == 9 || selection == 10)
		trigger.addItemClassNamed("1002694", 1);	//âHÇÖ!óÄ?
	else if(selection == 11 || selection == 12)
		trigger.addItemClassNamed("1002690", 1);	//ïïà?ñäï
	else if(selection == 13 || selection == 14)
		trigger.addItemClassNamed("1002212", 1);	//çõ!?ñáH
	else if(selection == 15 || selection == 16)
		trigger.addItemClassNamed("1002213", 1);	//çõ!?ñàï
	else if(selection == 17 || selection == 18)
		trigger.addItemClassNamed("1002214", 1);	//çõ!?ñÅSÅ[ÉOÉã
	else if(selection == 19 || selection == 20)
		trigger.addItemClassNamed("1002215", 1);	//çõ!?ñå???
	else if(selection == 21 || selection == 22)
		trigger.addItemClassNamed("1002216", 1);	//çõ!?ñåwóõã
	else if(selection == 23 || selection == 24)
		trigger.addItemClassNamed("1002217", 1);	//çõ!?ññróõã
	else if(selection == 25 || selection == 26)
		trigger.addItemClassNamed("1002869", 1);	//â_
	else if(selection == 27 || selection == 28)
		trigger.addItemClassNamed("1003853", 1);	//ÉVÉãÉoÅ[ÉAÉçÅ[
	else if(selection == 29 || selection == 30)
		trigger.addItemClassNamed("1002922", 1);	//ÉWÉáÉAÉìÉoÉìÉh
	else if(selection == 31 || selection == 32)
		trigger.addItemClassNamed("1002923", 1);	//ÉVÉÉÉNÉoÉäÉoÉìÉh
	else if(selection == 33 || selection == 34)
		trigger.addItemClassNamed("1000947", 1);	//ÉzÉèÉCÉgÉEÉBÉìÉO(s)
	else if(selection == 35 || selection == 36)
		trigger.addItemClassNamed("1000948", 1);	//É_Å[ÉNÉEÉBÉìÉO(s)
	else trigger.addItemClassNamed("1000156", 1);		//ÉnÉYÉåÇñè???ï(öáóã

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002336()				// ≥Î∂ı º±π∞ ªÛ¿⁄
{
	string itemID = "";
	integer selection;

	if (!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection	= Util.random(1, 100);

	if (selection == 1) {			// ≈∫º∫∑Œº«(¥Î)
		itemID	= "1000097";
	} else if (selection == 2) {		// ¡¶∑√≈∞∆Æ
		itemID	= "1000091";
	} else if (selection == 3) {		// ±◊∂Û¿Œ¥ı
		itemID	= "1000094";
	} else if (selection == 4) {		// ∏∂∑¬∞≠»≠¡¶(¥Î)
		itemID	= "1000100";
	} else if (selection == 5) {		// ø©Ω≈¿« ∞°»£
		itemID	= "1000103";
	} else if (selection == 6) {		// ∞Ê»≠¡¶(¥Î)
		itemID	= "1000106";
	} else if (selection == 7) {		// ≥ª±∏º∫ Ω∫«¡∑π¿Ã(¥Î)
		itemID	= "1000088";
	} else if (selection == 8) {		// ª«±€∏”∏Æ
		itemID	= "1002649";
	} else if (selection == 9) {		// ∫∞∏∑° ∏”∏Æ«…
		itemID	= "1001205";
	} else if (selection == 10) {		// ∫∞∏æÁ ±Õ∞…¿Ã
		itemID	= "1002653";
    } else if (selection == 11) {		//vahma japan setting
	itemID	= "1000807";
    } else if (selection == 12) {	
	itemID	= "1002324";
    } else if (selection == 13) {	
	itemID	= "1002911";
    } else if (selection == 14) {	
	itemID	= "1002912";
    } else if (selection == 15) {	
	itemID	= "1002913";
    } else if (selection == 16) {	
	itemID	= "1002914";
    } else if (selection == 17) {	
	itemID	= "1002915";
    } else if (selection == 18) {	
	itemID	= "1002916";
    } else if (selection == 19) {	
	itemID	= "1002917";
    } else if (selection == 20) {	
	itemID	= "1002918";
    } else if (selection == 21) {	
	itemID	= "1002919";
    } else if (selection == 22) {	
	itemID	= "1002920";
    } else if (selection == 23) {	
	itemID	= "1002651";
    } else {
	itemID	= "1000156";
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	if (itemID != "") trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);

}

quest
qUseItem1002337()				// √ ∑œ º±π∞ ªÛ¿⁄
{
	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.addItemClassNamed("1000013", 999);		// ∑πµÂ«„∫Í 999∞≥
	trigger.addItemClassNamed("1000024", 999);		// ±◊∏∞«„∫Í 999∞≥

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002348()				// ∞≥πﬂ¿⁄¿« ¥´π∞
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 350 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 350)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 350)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 350);
	}

	// sp 250 »∏∫π
	if (ItemUpSP(trigger, 250)) bUsed = true;

	if (bUsed == false) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002349()				// øÓøµ¿⁄¿« ∏∂¿Ω
{
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// mp 60 »∏∫π
	if (HardCode.itemUpMP(trigger, 60)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 60);

	// sp 250 »∏∫π
	if (ItemUpSP(trigger, 250)) bUsed = true;

	if (bUsed == false) return;

	// decrease number
	if (controller.canBeExhausted()) {
	controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002350()				// ≈◊¿œ¡Ó¿ßπˆ Ω∫≈Ê
{
	boolean	bUsed = false;
	if (!NormalItemCanBeUsed()) return;

	// hp 350 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, 350)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, 350)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 350);
	}

	// mp 60 »∏∫π
	if (HardCode.itemUpMP(trigger, 60)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 60);

	// sp 250 »∏∫π
	if (ItemUpSP(trigger, 250)) bUsed = true;

	if (bUsed == false) return;

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002669()				// ƒ∏∆æ »£≈©¿« ±Ê¿‚¿Ã ¡ˆµµ
{
	if (!NormalItemCanBeUsed())
		return;

	trigger.message(TEXT_USABLEITEM_PATH_MAP_OF_CAPTAIN_HAWK1 , MSG_TYPE__SYSTEM);
	trigger.message(TEXT_USABLEITEM_PATH_MAP_OF_CAPTAIN_HAWK2 , MSG_TYPE__SYSTEM);
}

quest
qUseItem1002672()				// ƒ∏∆æ »£≈©¿« ∫∏π∞ ¡ˆµµ
{
	if (!NormalItemCanBeUsed())
		return;

	trigger.message(TEXT_USABLEITEM_TREASURE_MAP_OF_CAPTAIN_HAWK , MSG_TYPE__SYSTEM);
}

quest
qUseItem1002755()				// ¥´ ∆¯¡◊
{
	if (!NormalItemCanBeUsed()) return;

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002760()				// (º“) ººπÓµ∑
{
	integer number,gold;

	if (!NormalItemCanBeUsed()) return;

	gold = trigger.getGold();
	number	= Util.random(1, 300);

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.setGold(gold + number);

	trigger.message(TEXT_USABLEITEM_SEBAETDON , MSG_TYPE__SYSTEM);
	trigger.message(TEXT_USABLEITEM_SEBAETDON_MONEY1 + number + TEXT_USABLEITEM_SEBAETDON_MONEY2, MSG_TYPE__SYSTEM);

	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002761()				// (¥Î) ººπÓµ∑
{
	integer number,gold;

	if (!NormalItemCanBeUsed()) return;

	gold = trigger.getGold();
	number = Util.random(300, 1000);

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.setGold(gold + number);

	trigger.message(TEXT_USABLEITEM_SEBAETDON , MSG_TYPE__SYSTEM);
	trigger.message(TEXT_USABLEITEM_SEBAETDON_MONEY1 + number + TEXT_USABLEITEM_SEBAETDON_MONEY2, MSG_TYPE__SYSTEM);

	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002765()				// ±≥»Ø±« C
{
	if (!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.addItemClassNamed("1002212", 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002766()				// ±≥»Ø±« D
{
	if (!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.addItemClassNamed("1000961", 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002767()				// ±≥»Ø±« E
{
	if (!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	trigger.addItemClassNamed("1000095", 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}



quest
qUseItem1002777()				// √º«Ë Ω∫≈©∑— : ∞Ê«Ëƒ° 10000 ªÛΩ¬
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.addExp(10000);
	trigger.updateAttr();
}

quest
qUseItem1002778()				// √º«Ë Ω∫≈©∑— : ∞Ê«Ëƒ° 100000 ªÛΩ¬
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.addExp(100000);
	trigger.updateAttr();
}

quest
qUseItem1002779()				// √º«Ë Ω∫≈©∑— : ∞Ê«Ëƒ° 500000 ªÛΩ¬
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.addExp(500000);
	trigger.updateAttr();
}

quest
qUseItem1002780()				// √º«Ë Ω∫≈©∑— : ∞Ê«Ëƒ° 1000000 ªÛΩ¬
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.addExp(1000000);
	trigger.updateAttr();
}

quest
qUseItem1002781()				// √º«Ë Ω∫≈©∑— : ∞Ê«Ëƒ° 5000000 ªÛΩ¬
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.addExp(5000000);
	trigger.updateAttr();
}

quest
qUseItem1002782()				// √º«Ë Ω∫≈©∑— : ∞Ê«Ëƒ° 10000000 ªÛΩ¬
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.addExp(10000000);
	trigger.updateAttr();
}

quest
qUseItem1002784()				// √ ƒ⁄ ∞°∑Á
{
	if (!NormalItemCanBeUsed()) return;

	// hp 50 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, 50)) return;
	} else {
		if (!HardCode.itemUpHP(trigger, 50)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 50);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002785()				// ∞ÌπÈ √ ƒ›∑ø
{
	if (!NormalItemCanBeUsed()) return;

	if (controller.checkAttribute("LOVE_MESSAGE") == true)
//	¿©µµøÏ √‚∑¬πÊΩƒ ºˆ¡§ø° ∏¬√Á ¡∂¡§ by stsoul 2004.02.04
		trigger.message("<c1>" + TEXT_LOVE_CONFESSION_CHOCOLATE__TEST + "</n></c1><c8>" + controller.getAttribute("LOVE_MESSAGE"), MSG_TYPE__AUTOHIDE_WINDOW);
	else trigger.sendSelectQuestMessage(TEXT_LOVE_CONFESSION_USE, "LOVE_INPUT", "LOVE_CANCEL", controller);
}

quest
qUseItem1002786()				// ¡©∂Û∆æ
{
	if (!NormalItemCanBeUsed()) return;

	// mp 30 »∏∫π
	if (!HardCode.itemUpMP(trigger, 30)) return;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 30);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002787()				// ∞ÌπÈ ªÁ≈¡
{
	if (!NormalItemCanBeUsed()) return;

	if (controller.checkAttribute("LOVE_MESSAGE") == true)
//		trigger.message(TEXT_LOVE_CONFESSION_CANDY_PREFIX + controller.getAttribute("LOVE_MESSAGE") + TEXT_LOVE_CONFESSION_SUFFIX, MSG_TYPE__AUTOHIDE_WINDOW);
//	¿©µµøÏ √‚∑¬πÊΩƒ ºˆ¡§ø° ∏¬√Á ¡∂¡§ by stsoul 2004.02.04
		trigger.message("<c1>" + TEXT_LOVE_CONFESSION_CANDY__TEST + "</n></c1><c8>" + controller.getAttribute("LOVE_MESSAGE"), MSG_TYPE__AUTOHIDE_WINDOW);
	else trigger.sendSelectQuestMessage(TEXT_LOVE_CONFESSION_USE, "LOVE_INPUT", "LOVE_CANCEL", controller);
}


quest
WriteFMessage()
{
	if (trigger.getCarryingItemInventory().getCountClassNamed("1001809") < 1) {
		trigger.message(TEXT_USABLEITEM_CANT_EXHAUST, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getBuilderType() == 1 || trigger.getBuilderType() == 2) {
//	if (trigger.isBuilder()) {
		trigger.getWorld().broadcast("<c8>" + Util.filterCurse(trigger.getQuestArgument()), MSG_TYPE__AUTOHIDE_WINDOW);
	} else {
		trigger.getWorld().broadcast("<c8>" + Util.filterCurse(trigger.getQuestArgument()) + " </n></n><c9></r>[From " + trigger.getName() + "]", MSG_TYPE__AUTOHIDE_WINDOW);
	}
	trigger.removeItemClassNamed("1001809", 1);
}


quest
qUseItem1001809()				// « µÂ ∏ﬁΩ√¡ˆ Ω∫≈©∑—
{
	integer chkResult, bType;

	if (!NormalItemCanBeUsed()) return;
	chkResult = trigger.getWorld().getNumber();
	bType = trigger.getBuilderType();

	if (bType != 1 && bType != 2 && bType != 3 && bType != 5) {
		if (chkResult == 120 || chkResult == 324 || chkResult == 326) {
			trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
			return;
		}
	}

	trigger.sendDescribeQuestMessage(TEXT_USABLEITEM_GET_MESSAGE, "WriteFMessage", controller);
}


quest
WriteFMessage1()
{
	// trigger.setCookie("Item_Message", "<c8>" + Util.filterCurse(trigger.getQuestArgument()), 0);
	trigger.setStringValue(3, "<c8>" + Util.filterCurse(trigger.getQuestArgument()));
	trigger.sendDescribeQuestMessage(TEXT_USABLEITEM_GET_MESSAGE2, "WriteFMessage2", controller);
}

quest
WriteFMessage2()
{

	if (trigger.getCarryingItemInventory().getCountClassNamed("1001810") < 1) {
		trigger.message(TEXT_USABLEITEM_CANT_EXHAUST, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getBuilderType() == 1 || trigger.getBuilderType() == 2) {
//	if (trigger.isBuilder()) {
//		trigger.getWorld().broadcast("</n>" + trigger.getCookie("Item_Message") + "</n>" + Util.filterCurse(trigger.getQuestArgument()), MSG_TYPE__AUTOHIDE_WINDOW);
		trigger.getWorld().broadcast("</n>" + trigger.getStringValue(3) + "</n>" + Util.filterCurse(trigger.getQuestArgument()), MSG_TYPE__AUTOHIDE_WINDOW);

	} else {
//		trigger.getWorld().broadcast(trigger.getCookie("Item_Message") + "</n>" + Util.filterCurse(trigger.getQuestArgument()) + " </n><c9></r>[From " + trigger.getName() + "]", MSG_TYPE__AUTOHIDE_WINDOW);
		trigger.getWorld().broadcast(trigger.getStringValue(3) + "</n>" + Util.filterCurse(trigger.getQuestArgument()) + " </n><c9></r>[From " + trigger.getName() + "]", MSG_TYPE__AUTOHIDE_WINDOW);
	}
	trigger.resetStringValue(3);
	trigger.removeItemClassNamed("1001810", 1);
}


quest
qUseItem1001810()				// « µÂ ∏ﬁΩ√¡ˆ Ω∫≈©∑— 2¡Ÿ¬•∏Æ ≈◊Ω∫∆ÆøÎ
{
	integer chkResult, bType;

	if (!NormalItemCanBeUsed()) return;
	chkResult = trigger.getWorld().getNumber();
	bType = trigger.getBuilderType();

	if (bType != 1 && bType != 2 && bType != 3 && bType != 5) {
		if (chkResult == 120 || chkResult == 324 || chkResult == 326) {
			trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
			return;
		}
	}

	trigger.sendDescribeQuestMessage(TEXT_USABLEITEM_GET_MESSAGE1, "WriteFMessage1", controller);
}


quest
WriteConfession()
{
	controller.setAttribute("LOVE_MESSAGE", Util.filterCurse(trigger.getQuestArgument()) + " </n></n><c9></r>[From " + trigger.getName() + "]");
	trigger.message(TEXT_CONFESSION_CARD_INPUT, MSG_TYPE__SYSTEM);
}

quest
CARD_INPUT()					// ∞ÌπÈ æ≤±‚
{
	trigger.sendDescribeQuestMessage(TEXT_CONFESSION_INPUT, "WriteConfession", controller);
}

quest
qUseItem1001927()				// √‡∫π¿« ø±º≠
{
	if (!NormalItemCanBeUsed()) return;

	if (controller.checkAttribute("LOVE_MESSAGE") == true)
		trigger.message("<c1>" + TEXT_CONFESSION_CARD + "</n></c1><c8>" + controller.getAttribute("LOVE_MESSAGE"), MSG_TYPE__AUTOHIDE_WINDOW);
	else trigger.sendSelectQuestMessage(TEXT_LOVE_CONFESSION_USE, "CARD_INPUT", "null", controller);
}


quest
qUseItem1002788()				// ƒø«√ ≈Ω¡ˆ±‚?
{
	integer mapChk;

	if (!NormalItemCanBeUsed()) return;

	mapChk = trigger.getWorld().getNumber();

	if (mapChk == 21) {
		trigger.message(TEXT_COUPLE_CHECKTEXT1, MSG_TYPE__AUTOHIDE_WINDOW);
	} else if (mapChk == 91 || mapChk == 1) {
		trigger.message(TEXT_COUPLE_CHECKTEXT2, MSG_TYPE__AUTOHIDE_WINDOW);
	} else {
		trigger.message(TEXT_COUPLE_CHECKTEXT3, MSG_TYPE__AUTOHIDE_WINDOW);
	}
}

quest
qUseItem1002800()	//	∫Ò≥ Ω∫¿« ¥´π∞
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if(castedSpellInven.getCount()>0)
		castedSpellInven.finalizeAll();

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
}

quest
qUseItem1002801()	//	∫Ò≥ Ω∫¿« ∞°πﬂ
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if(castedSpellInven.getCount()>0)
		castedSpellInven.finalizeAll();

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
}

quest
qUseItem1002802()	//	∫Ò≥ Ω∫¿« «œ∆Æ
{
	object castedSpellInven;

	if (!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();
	if(castedSpellInven.getCount()>0)
		castedSpellInven.finalizeAll();

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
}

quest
qUseItem1002803()	//	ø˘«œ≥Î¿Œ¿« ∫”¿∫ Ω«
{
	if(trigger.getWorld().canPK())
	{
  		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
  		return;
	}

	if (trigger.isState(CREATURE_STATE__BLESS))
	{
		trigger.message(TEXT_USABLEITEM_BLESSING, MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000210",60);
}

quest
qUseItem1002804()	//	ø˘«œ≥Î¿Œ¿« πÈªˆ ∞°πﬂ
{
	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.isState(CREATURE_STATE__BLESS))
	{
		trigger.message(TEXT_USABLEITEM_BLESSING, MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000210",60);
}

quest
qUseItem1002805()	//	ø˘«œ≥Î¿Œ¿« «œ∆Æ
{
	if(trigger.getWorld().canPK())
	{
		trigger.message(TEXT_USABLEITEM_ENDURANCE_MESSAGE_PK , MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.isState(CREATURE_STATE__BLESS))
	{
		trigger.message(TEXT_USABLEITEM_BLESSING, MSG_TYPE__SYSTEM);
		return;
	}

	UseSkill(trigger,"3000210",60);
}

quest
qUseItem1002870()   // º≠ø’∏¿« π›µµ
{
	integer	Up;
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp øœ¿¸ »∏∫π
	Up = trigger.getMaxHP();
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, Up)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, Up)) bUsed = true;
	}

	// mp øœ¿¸ »∏∫π
	Up = trigger.getMaxMP();
	if (HardCode.itemUpMP(trigger, Up)) bUsed = true;

	// sp øœ¿¸ »∏∫π
	Up = trigger.getMaxSP();
	if (ItemUpSP(trigger, Up)) bUsed = true;

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002871()   // ≈¬¿ª¡¯¿Œ¿« º±¥‹
{
	integer	Up;
	boolean bUsed = false;

	if (!NormalItemCanBeUsed()) return;

	// hp 300 »∏∫π
	Up = 300;
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (HardCode.itemDownHP(trigger, Up)) bUsed = true;
	} else {
		if (HardCode.itemUpHP(trigger, Up)) bUsed = true;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, Up);
	}

	// mp 100 »∏∫π
	Up = 100;
	if (HardCode.itemUpMP(trigger, Up)) bUsed = true;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, Up);

	if (!bUsed) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002877()			// ∞Êº≠
{
	object rank;
	integer maxnum, Rvalue, tickTime, rCount, mType, iBirth;
	string cName, rName, timestamp;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	Rvalue = Util.random(1, 200);

	if (Rvalue <= 2) {			// 1002878		º∫±§¡ˆ»∏
		rName = "SEOYUKI_ITEM_1";
		rank = Rank.select(rName);
		maxnum = 5;	//«œ∑Áø° ≥™ø√ ºˆ ¿÷¥¬ √÷¥Î¿« æ∆¿Ã≈€ ºˆ
		mType = 1;
		rCount = rank.getCount();
	} else if (Rvalue <= 4) {		// 1002897		ªÁ¡ı ∏¿⁄
		rName = "SEOYUKI_ITEM_2";
		rank = Rank.select(rName);
		maxnum = 5;
		mType = 2;
		rCount = rank.getCount();
	} else if (Rvalue <= 6) {		// 1002864		ø©∑°¡ˆ¿Ã
		rName = "SEOYUKI_ITEM_3";
		rank = Rank.select(rName);
		maxnum = 5;
		mType = 3;
		rCount = rank.getCount();
	} else if (Rvalue <= 7) {		// 1002879		∞«∞Ô πË≥∂
		rName = "SEOYUKI_ITEM_4";
		rank = Rank.select(rName);
		maxnum = 20;
		mType = 4;
		rCount = rank.getCount();
	} else if (Rvalue <= 9) {		// 1002868		ø©∑°∫“¿« ¿ÂΩ…
		rName = "SEOYUKI_ITEM_5";
		rank = Rank.select(rName);
		maxnum = 20;
		mType = 5;
		rCount = rank.getCount();
	} else if (Rvalue <= 11) {		// 1002861		¡¶ªÁ¿Â¿« ≈ı±∏
		rName = "SEOYUKI_ITEM_6";
		rank = Rank.select(rName);
		maxnum = 5;
		mType = 6;
		rCount = rank.getCount();
	} else if (Rvalue <= 12) {		// 1002863		øÏ∏∂ø’¿« ª‘≈ı±∏
		rName = "SEOYUKI_ITEM_7";
		rank = Rank.select(rName);
		maxnum = 5;
		mType = 7;
		rCount = rank.getCount();
	} else if (Rvalue <= 14) {		// 1002865		√µ∫¿ƒ⁄
		rName = "SEOYUKI_ITEM_8";
		rank = Rank.select(rName);
		maxnum = 20;
		mType = 8;
		rCount = rank.getCount();
	} else if (Rvalue <= 15) {		// 1002866		øÏ∏∂ø’ √≥¿« ∆ƒ√ º±
		rName = "SEOYUKI_ITEM_9";
		rank = Rank.select(rName);
		maxnum = 5;
		mType = 9;
		rCount = rank.getCount();
	} else if (Rvalue <= 17) {		// 1002869		±ŸµŒøÓ
		rName = "SEOYUKI_ITEM_10";
		rank = Rank.select(rName);
		maxnum = 20;
		mType = 10;
		rCount = rank.getCount();
	} else if (Rvalue <= 19) {		// 1002862		±›ªˆ ≈ı±∏
		rName = "SEOYUKI_ITEM_11";
		rank = Rank.select(rName);
		maxnum = 5;
		mType = 11;
		rCount = rank.getCount();
	} else if (Rvalue <= 20) {		// 1002867		±›¿∫∞¢¿« »£∑Œ∫¥
		rName = "SEOYUKI_ITEM_12";
		rank = Rank.select(rName);
		maxnum = 3;
		mType = 12;
		rCount = rank.getCount();
	} else if (Rvalue <= 100) {		// 1002870		º≠ø’∏¿« π›µµ
		mType = 13;
	} else {				// 1002871		≈¬¿ª¡¯¿Œ¿« º±¥‹
		mType = 14;
	}

	// decrease number
	if (controller.canBeExhausted())
	      controller.decreaseNumber(1);

	cName = trigger.getName();
	tickTime = Util.getTick();

	iBirth = trigger.getBirthTime();

	if(rCount < maxnum)
	{
		timestamp = Util.getYear(tickTime) + "/" + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime);
		Util.log("### SeoYuKi Event Item UserName[" + cName + "] getItem #" + rCount + "/" + maxnum + " On time = [" + timestamp + "] [" + rName + " ###");
		rank.add(cName,0, 0, 0, iBirth, "null");

		if (mType == 1)
		{
			trigger.addItemClassNamed("1002878", 1); // º∫±§¡ˆ»∏
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM1, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 2)
		{
			trigger.addItemClassNamed("1002897", 1); // ªÁ¡ı∏¿⁄
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM2, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 3)
		{
			trigger.addItemClassNamed("1002864", 1); // ø©∑°¡ˆ¿Ã
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM3, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 4)
		{
			trigger.addItemClassNamed("1002879", 1); // ∞«∞ÔπË≥∂
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM4, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 5)
		{
			trigger.addItemClassNamed("1002868", 1); // ø©∑°∫“¿« ¿ÂΩ…
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM5, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 6)
		{
			trigger.addItemClassNamed("1002861", 1); // ¡¶ªÁ¿Â¿« ≈ı±∏
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM6, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 7)
		{
			trigger.addItemClassNamed("1002863", 1); // øÏ∏∂ø’ ª‘≈ı±∏
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM7, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 8)
		{
			trigger.addItemClassNamed("1002865", 1); // √µ∫¿ƒ⁄
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM8, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 9)
		{
			trigger.addItemClassNamed("1002866", 1); // øÏ∏∂ø’ √≥¿« ∆ƒ√ º±
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM9, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 10)
		{
			trigger.addItemClassNamed("1002869", 1); // ±ŸµŒøÓ
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM10, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 11)
		{
			trigger.addItemClassNamed("1002862", 1); // ±›ªˆ ≈ı±∏
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM11, MSG_TYPE__AUTOHIDE_WINDOW);
		}
		else if (mType == 12)
		{
			trigger.addItemClassNamed("1002867", 1); // ±›¿∫∞¢¿« »£∑Œ∫¥
			trigger.message("<c8>" + TEXT_SEOYUKI_ITEM12, MSG_TYPE__AUTOHIDE_WINDOW);
		}
	}
	if(mType==13)
	{
		trigger.addItemClassNamed("1002870", 5); // º≠ø’∏¿« π›µµ
		trigger.message("<c8>" + TEXT_SEOYUKI_ITEM13, MSG_TYPE__AUTOHIDE_WINDOW);
	}

	if(mType==14)
	{
		trigger.addItemClassNamed("1002871", 10); // ≈¬¿ª¡¯¿Œ¿« º±¥‹
		trigger.message("<c8>" + TEXT_SEOYUKI_ITEM14, MSG_TYPE__AUTOHIDE_WINDOW);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1002883()			// «ˆ∂ı«— ∫∏π∞ªÛ¿⁄
{
	integer slot, Rvalue, tickTime;
	string cName, rName, timestamp;
	object give_item;
	string itemID = "";

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	Rvalue = Util.random(1, 12);

	if (Rvalue == 1) {				// 1002884		ºÿ∫Í∑π∑Œ
		itemID = "1002884";
		rName = TEXT_TAIWAN_200404_NAME01;
	} else if (Rvalue == 2) {		// 1002885		ªﬂø°∑Œ ∏¿⁄
		itemID = "1002885";
		rName = TEXT_TAIWAN_200404_NAME02;
	} else if (Rvalue == 3) {		// 1002886		∫¿¿Œµ» ∞À
		itemID = "1002886";
		rName = TEXT_TAIWAN_200404_NAME03;
	} else if (Rvalue == 4) {		// 1002887		π´ªÁ ≈ı±∏
		itemID = "1002887";
		rName = TEXT_TAIWAN_200404_NAME04;
	} else if (Rvalue == 5) {		// 1002888		π∞µø¿Ã
		itemID = "1002888";
		rName = TEXT_TAIWAN_200404_NAME05;
	} else if (Rvalue == 6) {		// 1002889		≥Ø∞≥ ∏¿⁄
		itemID = "1002889";
		rName = TEXT_TAIWAN_200404_NAME06;
	} else if (Rvalue == 7) {		// 1002890		≥Ø∞≥ ∞°πÊ
		itemID = "1002890";
		rName = TEXT_TAIWAN_200404_NAME07;
	} else if (Rvalue == 8) {		// 1002891		ªÁ∂«∏¿⁄
		itemID = "1002891";
		rName = TEXT_TAIWAN_200404_NAME08;
	} else if (Rvalue == 9) {		// 1002892		∫“∏Í¿« ø’¿« ª‘
		itemID = "1002892";
		rName = TEXT_TAIWAN_200404_NAME09;
	} else if (Rvalue == 10) {		// 1002893		ø¨¿Œ∏¿⁄(∫”¿∫ªˆ)
		itemID = "1002893";
		rName = TEXT_TAIWAN_200404_NAME10;
	} else if (Rvalue == 11) {		// 1002894		ø¨¿Œ≥Ø∞≥(∫”¿∫ªˆ)
		itemID = "1002894";
		rName = TEXT_TAIWAN_200404_NAME11;
	} else if (Rvalue == 12) {		// 1002895		ø¨¿ŒΩ≈πﬂ(∫”¿∫ªˆ)
		itemID = "1002895";
		rName = TEXT_TAIWAN_200404_NAME12;
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	if (itemID != "") trigger.addItemClassNamed(itemID, 1);

	cName = trigger.getName();
	tickTime = Util.getTick();
	timestamp = Util.getYear(tickTime) + "/" + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime);
	Util.log("[" + timestamp + "] [GetFormActivity] + ITEM [" + itemID + "] TO [" + cName + "] [" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]");

	for (slot = trigger.getFirstItemSlot(); slot; slot = trigger.getNextItemSlot(slot)) {
		give_item = trigger.getCarryingItemInventory().at(slot);

		if (give_item.getClassName() == itemID) {
			give_item.setExpireTime(1209600);               // 14¿œ ∞£ «ÿ¥Á æ∆¿Ã≈€¿Ã ¿Ø¡ˆµ .
		}
	}
	// send using effect
	controller.effectBy(trigger);
}


quest
qUseItem1002957()		// ¬ß ∂±
{
	if (!NormalItemCanBeUsed()) return;

	// mp 150 »∏∫π
	if (!HardCode.itemUpMP(trigger, 150)) return;

	// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
	if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
		ItemBalloonUpMP(trigger, 150);

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003012()   // ≈¨∑¥ ∞Ê«Ëƒ° Ω∫≈©∑—
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.addGuildExp(100);		// guild exp 100 ¡ı∞°
	trigger.updateAttr();

	trigger.message("ÉNÉâÉuåoåâ1lÇÖû500 è?ÖÄ?ûÄã!è B", MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003013()   // ≈¨∑¥ ∞Ê«Ëƒ° Ω∫≈©∑—2 ; xyzin 2004.10.4
{
	// ±‚¡∏ ≈¨∑¥ ∞Ê«Ëƒ° Ω∫≈©∑— 1003012 ∞° ∞Êƒ°∏¶ ø√∑¡¡÷¥¬ æÁ¿Ã ≈Œæ¯¿Ã ∫Œ¡∑«œø© ¡¶¿€«‘.
	// ∂««— ¿ß¿« «‘ºˆ¥¬ ∏ﬁΩ√¡ˆæ»≥ªøÕ Ω«¡¶ ¡ı∞°∑Æ¿Ã 500∞˙ 100¿∏∑Œ º≠∑Œ ¥Ÿ∏•µ•, ∞¡ µ–¥Ÿ.

	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.addGuildExp(1000000);		// guild exp 1000000 ¡ı∞°
	trigger.updateAttr();

	trigger.message("ÉNÉâÉuåoåâ1lÇÖû1000000 è?ÖÄ?ûÄã!è B", MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003014()   // ≈¨∑¥ ∞Ê«Ëƒ° Ω∫≈©∑—3 ; xyzin 2004.10.4
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	trigger.addGuildExp(100000000);		// guild exp 100000000 ¡ı∞°
	trigger.updateAttr();

	trigger.message("ÉNÉâÉuåoåâ1lÇÖû100000000 è?ÖÄ?ûÄã!è B", MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003045()   // ∫Œ»≠ ¥‹√‡¿« Ω∫≈©∑—
{
	object	petInventory;

	petInventory = trigger.getPetInventory();

	if (!NormalItemCanBeUsed()) return;
	if (trigger.hasPet()) return;

	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	//petInventory.setRemainTime(petInventory.remainTime()-36000);
	petInventory.setRemainTime(10);

	//trigger.message("ç??éëñ äQê?èbà??10èbà?ä?Äãfè?_ä??", MSG_TYPE__SYSTEM);
	trigger.message(TEXT_PET_INCUBATION_SHORT_EXT1, MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003046()   // ∫Œ»≠ ¥‹√‡¿« Ω∫≈©∑—
{
	object	petInventory;

	if (!NormalItemCanBeUsed()) return;
	if (trigger.hasPet()) return;

	petInventory = trigger.getPetInventory();
	if(petInventory.remainTime()<=3600)
		return;


	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	petInventory.setRemainTime(petInventory.remainTime()-3600);

	trigger.message(TEXT_PET_INCUBATION_SHORT_EXT2, MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003047()   // ∫Œ»≠ ¥‹√‡¿« Ω∫≈©∑—
{
	object	petInventory;

	if (!NormalItemCanBeUsed()) return;
	if (trigger.hasPet()) return;

	petInventory = trigger.getPetInventory();
	if(petInventory.remainTime()<=600)
		return;


	// decrease number
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	petInventory.setRemainTime(petInventory.remainTime()-600);

	trigger.message(TEXT_PET_INCUBATION_SHORT_EXT3, MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

// qUseItem1003049()				// «√∏µ¿« ≤ﬁ ƒ˘Ω∫∆Æ ∆ƒ¿œø° ¿÷¿Ω. ≥ªøÎ ∞¸∏ÆªÛ æÓ¬ø ºˆ æ¯¿Ã ∫–∏Æ


quest
WritePUserID()
{
	string uID;
	uID = trigger.getQuestArgument();

	if (!trigger.hasTeam()) return;
	if (!trigger.isMemberNamedOfGroup(uID)) {
		trigger.message(uID + TEXT_RECALL_CANCEL, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getWorld().getNumber() < 391 || trigger.getWorld().getNumber() > 405) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getCarryingItemInventory().getCountClassNamed("1003050") < 1)
	{
		trigger.message(TEXT_DREAM_OF_PLING_NOT_USE, MSG_TYPE__SYSTEM);
		return;
	}
	else
	{
		// ¥Î±‚Ω«ø° ¡¯¿‘«— ¿Ø¿˙∏∏ »£√‚ ∞°¥…
		trigger.recallAt(uID, 5);
		trigger.message(uID + TEXT_RECALL_TARGET, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_RECALL_TARGET_HELP, MSG_TYPE__SYSTEM);
		if (controller.canBeExhausted())
			controller.sweepNumbered(1);
	}
}


quest
qUseItem1003050()				// »Ø∏˘ Ω∫≈©∑—
{
	if (!NormalItemCanBeUsed()) return;
	if (!trigger.isUser() || !trigger.isAlive())	return;

/*
	if (!trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}
*/
	if (trigger.getWorld().getNumber() < 391 || trigger.getWorld().getNumber() > 405) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.sendDescribeQuestMessage(TEXT_DREAM_OF_PLING_USE, "WritePUserID", controller);
}


quest
WriteUserID()
{
	string uID;
	uID = trigger.getQuestArgument();

	if (!trigger.hasTeam()) return;
	if (!trigger.isMemberNamedOfGroup(uID)) {
		trigger.message(uID + TEXT_RECALL_CANCEL, MSG_TYPE__SYSTEM);
		return;
	}
	trigger.recall(uID);
	trigger.message(uID + TEXT_RECALL_TARGET, MSG_TYPE__SYSTEM);
	trigger.message(CANT_USE_TELEPORT_ITEM_SHORT_LEVEL, MSG_TYPE__SYSTEM);
	trigger.removeItemClassNamed("1003051", 1);
}

quest
qUseItem1003051()				// ∆¿ø¯ º“»Ø Ω∫≈©∑— (πÃ±∏«ˆ)
{
	if (!NormalItemCanBeUsed()) return;
	if (!trigger.isUser() || !trigger.isAlive())	return;

	trigger.sendDescribeQuestMessage(TEXT_DREAM_OF_PLING_USE, "WriteUserID", controller);
}



quest
qUseItem1003052()				// ≈¨∑¥ø¯ º“»Ø Ω∫≈©∑— (πÃ±∏«ˆ)
{
	if (!NormalItemCanBeUsed()) return;
	if (!trigger.isUser() || !trigger.isAlive())	return;

	trigger.sendDescribeQuestMessage(TEXT_DREAM_OF_PLING_USE, "WriteUserID", controller);
}


quest
qUseItem1003053()				// æ∆πÃ∆ºΩ∫ ø‰ªı øˆ«¡ ƒ´µÂ
{
	string cName;
	object oUserClub, castle, loc;

	if (!NormalItemCanBeUsed()) return;
	if (!trigger.isUser() || !trigger.isAlive())	return;

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_NOT_GROUP, MSG_TYPE__SYSTEM);
		return;
	}

	oUserClub = trigger.getGuild(1);
	if (!oUserClub) return;

	cName = trigger.getName();
	if (oUserClub.getMemberType(cName) == GM_TYPE_VOLUNTEER) return;

//	castle = Castle.getNumbered(trigger.getWorld().getCastleNumber());
	castle = Castle.getNumbered(1);
	loc = Location.create();

	if (!castle) {
		return;
	}

	// 1π¯ ø‰ªı º“¡ˆ ªÛ≈¬¿Œ¡ˆ »Æ¿Œ. √ﬂ»ƒ ø‰ªı ∞≥ºˆ ¥√æÓ≥™∏È ºˆ¡§«œ∞≈≥™ ¥ŸΩ√ ∏∏µÈæÓæﬂ «—¥Ÿ.
	if (oUserClub.getName() != castle.getRulingGuildName()) {
//		trigger.message(CANT_GO_CASTLE_NO_HAVE, MSG_TYPE__SYSTEM);
		trigger.message(GO_CASTLE_1_FRONT, MSG_TYPE__SYSTEM);
		// 1π¯ ø‰ªı æ’¿∏∑Œ ¿Ãµø
		loc.set(20, 610, 116);
		trigger.teleportTo(loc);
		return;
	}
	trigger.message(GO_CASTLE_1, MSG_TYPE__SYSTEM);

	// 1π¯ ø‰ªı øˆ«¡¿« πÊ¿∏∑Œ ¿Ãµø
	loc.set(348, 120, 96);
	trigger.teleportTo(loc);
}

quest
qUseItem1003817()				// ƒÆµ•æ∆ ø‰ªı øˆ«¡ ƒ´µÂ
{
	string cName;
	object oUserClub, castle, loc;

	if (!NormalItemCanBeUsed()) return;
	if (!trigger.isUser() || !trigger.isAlive())	return;

	if (!trigger.getWorld().canUseCustomWarp())
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getWorld().allowedWarpGroup() == 1)
	{
		trigger.message(CANT_USE_TELEPORT_ITEM_NOT_GROUP, MSG_TYPE__SYSTEM);
		return;
	}

	oUserClub = trigger.getGuild(1);
	if (!oUserClub) return;

	cName = trigger.getName();
	if (oUserClub.getMemberType(cName) == GM_TYPE_VOLUNTEER) return;

//	castle = Castle.getNumbered(trigger.getWorld().getCastleNumber());
	castle = Castle.getNumbered(2);
	loc	= Location.create();

	if (!castle)
	{
		return;
	}

	// 2π¯ ø‰ªı º“¡ˆ ªÛ≈¬¿Œ¡ˆ »Æ¿Œ.
	if (oUserClub.getName() != castle.getRulingGuildName())
	{
//		trigger.message(CANT_GO_CASTLE_NO_HAVE, MSG_TYPE__SYSTEM);
		trigger.message(GO_CASTLE_1_FRONT, MSG_TYPE__SYSTEM);
		// 2π¯ ø‰ªı æ’¿∏∑Œ ¿Ãµø
		loc.set(17, 800, 708);
		trigger.teleportTo(loc);
		return;
	}
	trigger.message(GO_CASTLE_2, MSG_TYPE__SYSTEM);

	// 2π¯ ø‰ªı øˆ«¡¿« πÊ¿∏∑Œ ¿Ãµø
	loc.set(289, 120, 96);
	trigger.teleportTo(loc);
}


// ¥Î∏∏ 5ø˘ ¿Ã∫•∆Æ (2004)
// 2004. 4. 10, 11, 12
// Written by mssi

quest
qUseItem1002926()			// ª°∞£ º±π∞ªÛ¿⁄ (2004 ¥Î∏∏ 5ø˘)
{
	integer rval;
	integer wNum;
	integer tickTime;

	string userName;
	string time_Info, world_Info, Item_Info;

	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(trigger.getWorld().canFight() == false)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
    	return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1)
	{
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 100)
	{
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	rval = Util.random(0, 10000);

	// 1∏∏ SEED	5%
	if(rval >= 9500)
	{
		trigger.setGold(trigger.getGold() + 10000);

		Item_Info = "From Red Present Box : +SEED [ 10000 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "10000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 2∏∏ SEED	5%
	else if(rval >= 9000)
	{
		trigger.setGold(trigger.getGold() + 20000);

		Item_Info = "From Red Present Box : +SEED [ 20000 ] ";
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "20000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 3∏∏ SEED	5%
	else if(rval >= 8500)
	{
		trigger.setGold(trigger.getGold() + 30000);
		Item_Info = "From Red Present Box : +SEED [ 30000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "30000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 5∏∏ SEED	2%
	else if(rval >= 8300)
	{
		trigger.setGold(trigger.getGold() + 50000);
		Item_Info = "From Red Present Box : +SEED [ 50000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "50000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 8∏∏ SEED	2%
	else if(rval >= 8100)
	{
		trigger.setGold(trigger.getGold() + 80000);
		Item_Info = "From Red Present Box : +SEED [ 80000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "80000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 20∏∏ SEED	0.5%
	else if(rval >= 8050)
	{
		trigger.setGold(trigger.getGold() + 200000);
		Item_Info = "From Red Present Box : +SEED [ 200000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "200000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// »˙∏±∆˜º«(¥Î) 100∫¥	60%
	else if(rval >= 2050)
	{
		trigger.addItemClassNamed("1000018", 100);
		Item_Info = "From Red Present Box : +ITEM 100 [ 1000018 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∞ﬂΩ¿ªÁ ∑Œ∫Í	2.5%
	else if(rval >= 1800)
	{
		trigger.addItemClassNamed("1000844", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1000844 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¡ﬂ±ﬁ ¥—¿⁄∫π	2.5%
	else if(rval >= 1550)
	{
		trigger.addItemClassNamed("1002100", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1002100 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// «œ«¡ æ∆∏”	2.5%
	else if(rval >= 1300)
	{
		trigger.addItemClassNamed("1002080", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1002080 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// Ω∫≈Ê æ∆∏”	2.5%
	else if(rval >= 1050)
	{
		trigger.addItemClassNamed("1000823", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1000823 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ƒ⁄∆∞ ∑Œ∫Í	2.5%
	else if(rval >= 800)
	{
		trigger.addItemClassNamed("1000845", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1000845 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ªÛ±ﬁ ¥—¿⁄∫π	2.5%
	else if(rval >= 550)
	{
		trigger.addItemClassNamed("1002101", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1002101 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∂Û¿Ã∆Æ «√∑π¿Ã∆Æ	2.5%
	else if(rval >= 300)
	{
		trigger.addItemClassNamed("1002081", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1002081 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ƒ⁄¿Œ æ∆∏”	2.5%
	else if(rval >= 50)
	{
		trigger.addItemClassNamed("1000824", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1000824 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ªﬂø°∑Œ ∏¿⁄	0.5%
	else if(rval >= 0)
	{
		trigger.addItemClassNamed("1002689", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1002689 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	Util.log(time_Info + Item_Info + world_Info);
}


quest
qUseItem1002927()			// ¡÷»≤ªˆ º±π∞ªÛ¿⁄ (2004 ¥Î∏∏ 5ø˘)
{
	integer rval;
	integer wNum;
	integer tickTime;

	string userName;
	string time_Info, world_Info, Item_Info;

	// ªÁøÎ ∫“∞°¥… ¡ˆø™ √≥∏Æ
	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(trigger.getWorld().canFight() == false)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1)
	{
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 40)
	{
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	rval = Util.random(0, 10000);

	// 5∏∏	5%
	if(rval >= 9500)
	{
		trigger.setGold(trigger.getGold() + 50000);
		Item_Info = "From Orange Present Box : +SEED [ 50000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "50000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 10∏∏		5%
	else if(rval >= 9000)
	{
		trigger.setGold(trigger.getGold() + 100000);
		Item_Info = "From Orange Present Box : +SEED [ 100000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "100000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 15∏∏		5%
	else if(rval >= 8500)
	{
		trigger.setGold(trigger.getGold() + 150000);
		Item_Info = "From Orange Present Box : +SEED [ 150000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "150000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 20∏∏		1%
	else if(rval >= 8400)
	{
		trigger.setGold(trigger.getGold() + 200000);
		Item_Info = "From Orange Present Box : +SEED [ 200000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "200000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 40∏∏		1%
	else if(rval >= 8300)
	{
		trigger.setGold(trigger.getGold() + 400000);
		Item_Info = "From Orange Present Box : +SEED [ 400000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "400000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 60∏∏		0.5%
	else if(rval >= 8250)
	{
		trigger.setGold(trigger.getGold() + 600000);
		Item_Info = "From Orange Present Box : +SEED [ 600000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "600000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// ≈∞¥◊ ≈∞∆Æ	8%
	else if(rval >= 7450)
	{
		trigger.addItemClassNamed("1000090", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000090 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ª˛«¡≥ 	8%
	else if(rval >= 6650)
	{
		trigger.addItemClassNamed("1000089", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000089 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// Ω∫∆Æ∑¶	8%
	else if(rval >= 5850)
	{
		trigger.addItemClassNamed("1000092", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000092 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∞Ê»≠¡¶(º“)	8%
	else if(rval >= 5050)
	{
		trigger.addItemClassNamed("1000104", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000104 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∏∂∑¬∞≠»≠¡¶(º“)	8%
	else if(rval >= 4250)
	{
		trigger.addItemClassNamed("1000098", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000098 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈∫º∫ ∑Œº«(º“)	8%
	else if(rval >= 3450)
	{
		trigger.addItemClassNamed("1000095", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000095 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ø‰¡§¿« ∞°»£	8%
	else if(rval >= 2650)
	{
		trigger.addItemClassNamed("1000101", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000101 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∏Æ¿˙µÂ ∑Œ∫Í	2%
	else if(rval >= 2450)
	{
		trigger.addItemClassNamed("1000847", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000847 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// «œ¿Ã∆€ ∞Ì±‚µø Ω¥√˜	1%
	else if(rval >= 2350)
	{
		trigger.addItemClassNamed("1002103", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1002103 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ºº∂ÛπÕ æ∆∏”	1%
	else if(rval >= 2250)
	{
		trigger.addItemClassNamed("1002083", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1002083 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∫Í∏Æ∞£µÚ	1%
	else if(rval >= 2150)
	{
		trigger.addItemClassNamed("1000826", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000826 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∫Í∏Æ∆Æ∂Û	1%
	else if(rval >= 2050)
	{
		trigger.addItemClassNamed("1000386", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000386 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¥Ÿ∏∂Ω∫ƒøΩ∫	1%
	else if(rval >= 1950)
	{
		trigger.addItemClassNamed("1000365", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000365 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// æ∆∏£∏∂¥Ÿ	1%
	else if(rval >= 1850)
	{
		trigger.addItemClassNamed("1000344", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000344 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// æÓΩÿΩ≈ ¥Î∞≈	1%
	else if(rval >= 1750)
	{
		trigger.addItemClassNamed("1000281", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000281 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈©∏ÆªÁø¿∏£	1%
	else if(rval >= 1650)
	{
		trigger.addItemClassNamed("1000323", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000323 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ªÁ¿ÃµÂ øÕ¿Œ¥ı	1%
	else if(rval >= 1550)
	{
		trigger.addItemClassNamed("1000470", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000470 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿Â∫¿	1%
	else if(rval >= 1450)
	{
		trigger.addItemClassNamed("1000449", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000449 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// πÈø≠√¢	1%
	else if(rval >= 1350)
	{
		trigger.addItemClassNamed("1000428", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000428 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ø˘»≠µµ	1%
	else if(rval >= 1250)
	{
		trigger.addItemClassNamed("1000407", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000407 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ƒ´∫Ù∂Ûƒ´	1%
	else if(rval >= 1150)
	{
		trigger.addItemClassNamed("1000638", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000638 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// Ω∫ƒ›««æ ≈◊¿œ	1%
	else if(rval >= 1050)
	{
		trigger.addItemClassNamed("1000472", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000472 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿Ã≈Õ≥Œ Ω∫≈¬«¡	1%
	else if(rval >= 950)
	{
		trigger.addItemClassNamed("1000659", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000659 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// Ω«πˆ ∑ŒµÂ	1%
	else if(rval >= 850)
	{
		trigger.addItemClassNamed("1000680", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000680 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// æ∆≈© ∏ﬁ¿ÃΩ∫	1%
	else if(rval >= 750)
	{
		trigger.addItemClassNamed("1000701", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000701 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ƒ´ªÍµÂ∂Û	1%
	else if(rval >= 650)
	{
		trigger.addItemClassNamed("1000302", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000302 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¡ﬂ¿˝∏	2%
	else if(rval >= 450)
	{
		trigger.addItemClassNamed("1000800", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000800 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈ŒΩ√µµ ∏¿⁄	2%
	else if(rval >= 250)
	{
		trigger.addItemClassNamed("1000804", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000804 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// πÆæÓ∏¿⁄	2%
	else if(rval >= 50)
	{
		trigger.addItemClassNamed("1000808", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1000808 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≥Ø∞≥ ∏¿⁄	0.5%
	else if(rval >= 0)
	{
		trigger.addItemClassNamed("1002693", 1);
		Item_Info = "From Orange Present Box : +ITEM [ 1002693 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	Util.log(time_Info + Item_Info + world_Info);
}

quest
qUseItem1002928()			// ≥Î∂ıªˆ º±π∞ªÛ¿⁄ (2004 ¥Î∏∏ 5ø˘)
{
	integer rval;
	integer wNum;
	integer tickTime;
	integer mx, my;

	string userName;
	string time_Info, world_Info, Item_Info;

	// ªÁøÎ ∫“∞°¥… ¡ˆø™ √≥∏Æ
	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(trigger.getWorld().canFight() == false)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1)
	{
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 6)
	{
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	mx =  trigger.getX();
	my =  trigger.getY();

	rval = Util.random(0, 10000);

	// πÃΩ∫∆Ω Ω∫øˆµÂ	10%
	if(rval >= 9000)
	{
		trigger.getWorld().genMonster("2100097", 1, "twSword.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100097 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ≈©≥Î«Ó	7%
	else if(rval >= 8300)
	{
		trigger.getWorld().genMonster("2100026", 1, "twKnohen.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100026 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// µµ«√∞ªæÓ ∆ºƒ°ø§	10%
	else if(rval >= 7300)
	{
		trigger.getWorld().genMonster("2100050", 1, "twTichielD.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100050 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ∆˜øÓ	10%
	else if(rval >= 6300)
	{
		trigger.getWorld().genMonster("2100213", 1, "twFaun.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100213 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ∆ƒ¿ÃæÓ ø§∏Æ∏‡≈ª	10%
	else if(rval >= 5300)
	{
		trigger.getWorld().genMonster("2100096", 1, "twElemental.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100096 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ¿Ã∏”¿¸Ω√ æ∆∑π≥◊	10%
	else if(rval >= 4300)
	{
		trigger.getWorld().genMonster("2100126", 1, "twEAraene.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100126 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// Ω∫ø˙«¡ ∆Æ∑≥«¡ µπ	10%
	else if(rval >= 3300)
	{
		trigger.getWorld().genMonster("2100125", 1, "twDollSwamp.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100125 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// π´≈ıπÈ»£	10%
	else if(rval >= 2300)
	{
		trigger.getWorld().genMonster("2100124", 1, "twMutuhoWhite.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100124 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ±◊∏Æ∆˘	10%
	else if(rval >= 1300)
	{
		trigger.getWorld().genMonster("2100211", 1, "twGriffon.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100211 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ««ƒ€	10%
	else if(rval >= 300)
	{
		trigger.getWorld().genMonster("2100093", 1, "twPicok.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Yellow Present Box : MONSTER [ 2100093 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ∫¿¿Œµ» ∞À	0.1%
	else if(rval >= 290)
	{
		trigger.addItemClassNamed("1002690", 1);
		Item_Info = "From Yellow Present Box : +ITEM [ 1002690 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// π´ªÁ ≈ı±∏	2.5%
	else if(rval >= 40)
	{
		trigger.addItemClassNamed("1002691", 1);
		Item_Info = "From Yellow Present Box : +ITEM [ 1002691 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿Æ Ω¥¡Ó	0.4%
	else if(rval >= 0)
	{
		trigger.addItemClassNamed("1000961", 1);
		Item_Info = "From Yellow Present Box : +ITEM [ 1000961 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	Util.log(time_Info + Item_Info + world_Info);
}

quest
qUseItem1002929()			// »Úªˆ º±π∞ªÛ¿⁄ (2004 ¥Î∏∏ 5ø˘)
{
	integer rval;
	integer wNum;
	integer tickTime;
	integer mx, my;

	string userName;
	string time_Info, world_Info, Item_Info;

	// ªÁøÎ ∫“∞°¥… ¡ˆø™ √≥∏Æ
	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(trigger.getWorld().canFight() == false)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1)
	{
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 6)
	{
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	mx =  trigger.getX();
	my =  trigger.getY();

	rval = Util.random(0, 10000);

	// ¡©∏Æªﬂ	10%
	if(rval >= 9000)
	{
		trigger.getWorld().genMonster("2100009", 1, "twJellypi.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From White Present Box : MONSTER [ 2100009 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// πÃ∂Û≤‹	10%
	else if(rval >= 8000)
	{
		trigger.getWorld().genMonster("2100069", 1, "twBearPig.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From White Present Box : MONSTER [ 2100069 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// «„¥œ∫£æÓ	10%
	else if(rval >= 7000)
	{
		trigger.getWorld().genMonster("2100004", 1, "twHoneyBear.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From White Present Box : MONSTER [ 2100004 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ≈©∑ππÃ≥Î	10%
	else if(rval >= 6000)
	{
		trigger.getWorld().genMonster("2100042", 1, "twCramino.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From White Present Box : MONSTER [ 2100042 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}

	// ∆˜¿Ã¡ Ω∫ƒ›««≥Î	10%
	else if(rval >= 5000)
	{
		trigger.getWorld().genMonster("2100061", 1, "twGrScorpion.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From White Present Box : MONSTER [ 2100061 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ª˛««æÓ	10%
	else if(rval >= 4000)
	{
		trigger.getWorld().genMonster("2100141", 1, "twSyaPeer.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From White Present Box : MONSTER [ 2100141 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ∑πµÂ ¿ß≈∞µÂ	10%
	else if(rval >= 3000)
	{
		trigger.getWorld().genMonster("2100089", 1, "twRedWiKid.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From White Present Box : MONSTER [ 2100089 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// π´Ω∫√≠∆ƒ	10%
	else if(rval >= 2000)
	{
		trigger.getWorld().genMonster("2100156", 1, "twStelmeto.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From White Present Box : MONSTER [ 2100156 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 1∏∏	10%
	else if(rval >= 1000)
	{
		trigger.setGold(trigger.getGold() + 10000);
		Item_Info = "From White Present Box : +SEED [ 10000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "10000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 2∏∏	5%
	else if(rval >= 500)
	{
		trigger.setGold(trigger.getGold() + 20000);
		Item_Info = "From White Present Box : +SEED [ 20000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "20000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 3∏∏	3%
	else if(rval >= 200)
	{
		trigger.setGold(trigger.getGold() + 30000);
		Item_Info = "From White Present Box : +SEED [ 30000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "30000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 5∏∏	1.9%
	else if(rval >= 10)
	{
		trigger.setGold(trigger.getGold() + 50000);
		Item_Info = "From White Present Box : +SEED [ 50000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "50000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// ¿Æ Ω¥¡Ó	0.1%
	else if(rval >= 0)
	{
		trigger.addItemClassNamed("1000961", 1);
		Item_Info = "From White Present Box : +ITEM [ 1000961 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	Util.log(time_Info + Item_Info + world_Info);
}

quest
qUseItem1002930()			// ∆ƒ∂ıªˆ º±π∞ªÛ¿⁄ (2004 ¥Î∏∏ 5ø˘)
{
	integer rval;
	integer wNum;
	integer tickTime;

	string userName;
	string time_Info, world_Info, Item_Info;

	// ªÁøÎ ∫“∞°¥… ¡ˆø™ √≥∏Æ
	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(trigger.getWorld().canFight() == false)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1)
	{
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 42)
	{
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	rval = Util.random(0, 10000);

	// 20∏∏ Ω√µÂ	40%
	if(rval >= 6000)
	{
		trigger.setGold(trigger.getGold() + 200000);
		Item_Info = "From Blue Present Box : +SEED [ 200000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "200000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 30∏∏	30%
	else if(rval >= 3000)
	{
		trigger.setGold(trigger.getGold() + 300000);
		Item_Info = "From Blue Present Box : +SEED [ 300000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "300000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 50∏∏	10%
	else if(rval >= 2000)
	{
		trigger.setGold(trigger.getGold() + 500000);
		Item_Info = "From Blue Present Box : +SEED [ 500000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "500000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// ∞ÌΩ∫∆Æ ∑Œ∫Í	2%
	else if(rval >= 1800)
	{
		trigger.addItemClassNamed("1000850", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000850 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// πÃ∂Û¡Í Ω¥√˜	1%
	else if(rval >= 1700)
	{
		trigger.addItemClassNamed("1002106", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1002106 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// Ω∫«√∏∞∆Æ ∏ﬁ¿œ	2%
	else if(rval >= 1500)
	{
		trigger.addItemClassNamed("1000829", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000829 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿œ¡¯πÆ¿⁄	1%
	else if(rval >= 1400)
	{
		trigger.addItemClassNamed("1000389", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000389 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ƒÌªÁ¿Ã	1%
	else if(rval >= 1300)
	{
		trigger.addItemClassNamed("1000368", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000368 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// Ω√ø£ ∫Í∑π¿Ãƒø	1%
	else if(rval >= 1200)
	{
		trigger.addItemClassNamed("1000347", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000347 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∆√ ø°µæ∆	1%
	else if(rval >= 1100)
	{
		trigger.addItemClassNamed("1000284", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000284 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∫Ì∑ØµÂ º“µÂ	1%
	else if(rval >= 1000)
	{
		trigger.addItemClassNamed("1000326", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000326 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¥Ÿ¿Ãæ∆ »˜∆Æ	1%
	else if(rval >= 900)
	{
		trigger.addItemClassNamed("1000473", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000473 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// πÆ ∂Û¿Ã∆Æ Ω∫∆Ω	1%
	else if(rval >= 800)
	{
		trigger.addItemClassNamed("1000452", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000452 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∂ÛπŸ Ω∫««æÓ	1%
	else if(rval >= 700)
	{
		trigger.addItemClassNamed("1000431", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000431 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// µµº∫µµ	1%
	else if(rval >= 600)
	{
		trigger.addItemClassNamed("1000410", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000410 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∏Æπˆ æ◊Ω∫	1%
	else if(rval >= 500)
	{
		trigger.addItemClassNamed("1000641", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000641 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∆ƒ¿ÃæÓ ºÓ≈©	1%
	else if(rval >= 400)
	{
		trigger.addItemClassNamed("1000620", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000620 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// æ»ƒÃ∑ŒΩ√≥™ ∆ºæÓ	1%
	else if(rval >= 300)
	{
		trigger.addItemClassNamed("1000662", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000662 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// «¡∏∞ººΩ∫ ∑ŒµÂ	1%
	else if(rval >= 200)
	{
		trigger.addItemClassNamed("1000683", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000683 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∑π¿Œ∫∏øÏ	1%
	else if(rval >= 100)
	{
		trigger.addItemClassNamed("1000704", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000704 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∫ß∏æÓ	1%
	else if(rval >= 0)
	{
		trigger.addItemClassNamed("1000305", 1);
		Item_Info = "From Blue Present Box : +ITEM [ 1000305 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	Util.log(time_Info + Item_Info + world_Info);
}

quest
qUseItem1002931()			// ≥Ïªˆ º±π∞ªÛ¿⁄ (2004 ¥Î∏∏ 5ø˘)
{
	integer rval;
	integer wNum;
	integer tickTime;
	integer mx, my;

	string userName;
	string time_Info, world_Info, Item_Info;

	// ªÁøÎ ∫“∞°¥… ¡ˆø™ √≥∏Æ
	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(trigger.getWorld().canFight() == false)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1)
	{
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 43)
	{
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	mx =  trigger.getX();
	my =  trigger.getY();

	rval = Util.random(0, 10000);

	// 30∏∏ Ω√µÂ	20%
	if(rval >= 8000)
	{
		trigger.setGold(trigger.getGold() + 300000);
		Item_Info = "From Green Present Box : +SEED [ 300000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "300000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 50∏∏	5%
	else if(rval >= 7500)
	{
		trigger.setGold(trigger.getGold() + 500000);
		Item_Info = "From Green Present Box : +SEED [ 500000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "500000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 70∏∏	5%
	else if(rval >= 7000)
	{
		trigger.setGold(trigger.getGold() + 700000);
		Item_Info = "From Green Present Box : +SEED [ 700000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "700000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 80∏∏	5%
	else if(rval >= 6500)
	{
		trigger.setGold(trigger.getGold() + 800000);
		Item_Info = "From Green Present Box : +SEED [ 800000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "800000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 90∏∏	5%
	else if(rval >= 6000)
	{
		trigger.setGold(trigger.getGold() + 900000);
		Item_Info = "From Green Present Box : +SEED [ 900000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "900000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 100∏∏	5%
	else if(rval >= 5500)
	{
		trigger.setGold(trigger.getGold() + 1000000);
		Item_Info = "From Green Present Box : +SEED [ 1000000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "1000000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// ≈©≥Î«Ó	0.8%
	else if(rval >= 5420)
	{
		trigger.getWorld().genMonster("2100026", 1, "twKnohen.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Green Present Box : MONSTER [ 2100026 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ¿Æ ø¿∫Í ««¥–Ω∫	0.1%
	else if(rval >= 5410)
	{
		trigger.addItemClassNamed("1002658", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1002658 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿Æ ø¿∫Í ≈©∑ŒøÏ	0.1%
	else if(rval >= 5400)
	{
		trigger.addItemClassNamed("1002659", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1002659 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// √º«Ë Ω∫≈©∑— (10000∞Ê«Ëƒ°) 9%
	else if(rval >= 4500)
	{
		trigger.addItemClassNamed("100277", 1);
		Item_Info = "From Green Present Box : +ITEM [ 100277 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ø£¡©∏Ø ¿ÃæÓ∏µ	5%
	else if(rval >= 4000)
	{
		trigger.addItemClassNamed("1000901", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000901 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∞ÌæÁ¿Ã ∞°∏È	5%
	else if(rval >= 3500)
	{
		trigger.addItemClassNamed("1002164", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1002164 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ø©øÏ ∞°∏È	5%
	else if(rval >= 3000)
	{
		trigger.addItemClassNamed("1002165", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1002165 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¥¡¥Î ∞°∏È	5%
	else if(rval >= 2500)
	{
		trigger.addItemClassNamed("1002166", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1002166 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// æ«∏∂¿« ª‘	5%
	else if(rval >= 2000)
	{
		trigger.addItemClassNamed("1001204", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1001204 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// «¡∑Œ≈ÿ≈Õ	2%
	else if(rval >= 1800)
	{
		trigger.addItemClassNamed("1000851", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000851 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// «œ¿Ã∆€ πÃ∂Û¡Í Ω¥√˜	2%
	else if(rval >= 1600)
	{
		trigger.addItemClassNamed("1002107", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1002107 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// πÍµµÂ ∏ﬁ¿œ	1%
	else if(rval >= 1500)
	{
		trigger.addItemClassNamed("1000830", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000830 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∫”¿∫ πŸ∂˜	1%
	else if(rval >= 1400)
	{
		trigger.addItemClassNamed("1000390", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000390 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// æ÷√Îº≥	1%
	else if(rval >= 1300)
	{
		trigger.addItemClassNamed("1000369", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000369 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≥Î≈‰Ω∫	1%
	else if(rval >= 1200)
	{
		trigger.addItemClassNamed("1000348", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000348 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ø¿∆»	1%
	else if(rval >= 1100)
	{
		trigger.addItemClassNamed("1000285", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000285 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∑ππ¯≈◊¿Œ	1%
	else if(rval >= 1000)
	{
		trigger.addItemClassNamed("1000327", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000327 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// º®µµøÏ ¥Ìº≠	1%
	else if(rval >= 900)
	{
		trigger.addItemClassNamed("1000474", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000474 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// Ω«πˆ ∂Û¿Ã∆√	1%
	else if(rval >= 800)
	{
		trigger.addItemClassNamed("1000453", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000453 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∫ºƒ…¿Ã≈‰Ω∫	1%
	else if(rval >= 700)
	{
		trigger.addItemClassNamed("1000432", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000432 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∆ƒ»≠µµ	1%
	else if(rval >= 600)
	{
		trigger.addItemClassNamed("1000411", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000411 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∫Œ∑ŒπŸ	1%
	else if(rval >= 500)
	{
		trigger.addItemClassNamed("1000642", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000642 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿È	1%
	else if(rval >= 400)
	{
		trigger.addItemClassNamed("1000621", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000621 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ø¯¥ı¿©µÂ Ω∫≈¬«¡	1%
	else if(rval >= 300)
	{
		trigger.addItemClassNamed("1000663", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000663 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∏∂µµªÁ¿« ∑ŒµÂ	1%
	else if(rval >= 200)
	{
		trigger.addItemClassNamed("1000684", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000684 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∆€¥œΩ¨∏’∆Æ	1%
	else if(rval >= 100)
	{
		trigger.addItemClassNamed("1000705", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000705 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿◊ƒ´∑Œ¡Ó	1%
	else if(rval >= 0)
	{
		trigger.addItemClassNamed("1000306", 1);
		Item_Info = "From Green Present Box : +ITEM [ 1000306 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	Util.log(time_Info + Item_Info + world_Info);
}

quest
qUseItem1002932()			// π´¡ˆ∞≥ªˆ º±π∞ªÛ¿⁄ (2004 ¥Î∏∏ 5ø˘)
{
	integer rval;
	integer wNum;
	integer tickTime;
	integer mx, my;

	string userName;
	string time_Info, world_Info, Item_Info;

	// ªÁøÎ ∫“∞°¥… ¡ˆø™ √≥∏Æ
	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(trigger.getWorld().canFight() == false)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1)
	{
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 6)
	{
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	mx =  trigger.getX();
	my =  trigger.getY();

	rval = Util.random(0, 10000);

	// ¿Æ ø¿∫Í ««¥–Ω∫	0.1%
	if(rval >= 9990)
	{
		trigger.addItemClassNamed("1002658", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002658 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿Æ ø¿∫Í ≈©∑ŒøÏ	0.1%
	else if(rval >= 9980)
	{
		trigger.addItemClassNamed("1002659", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002659 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿Øƒ°ø¯ ∞°πÊ	4%
	else if(rval >= 9580)
	{
		trigger.addItemClassNamed("1002324", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002324 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 5∏∏	15%
	else if(rval >= 8080)
	{
		trigger.setGold(trigger.getGold() + 50000);
		Item_Info = "From Rainbow Present Box : +SEED [ 50000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "50000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// 10∏∏	7%
	else if(rval >= 7380)
	{
		trigger.setGold(trigger.getGold() + 100000);
		Item_Info = "From Rainbow Present Box : +SEED [ 100000 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "100000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	// ∏Æ«¡ ∏”∏Æ∂Ï	15%
	else if(rval >= 5880)
	{
		trigger.addItemClassNamed("1000907", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1000907 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∞ÌæÁ¿Ã ±Õ	10%
	else if(rval >= 4880)
	{
		trigger.addItemClassNamed("1000908", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1000908 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∂—∂— ¥ıµÎ¿Ã ∏”∏Æ∂Ï	10%
	else if(rval >= 3880)
	{
		trigger.addItemClassNamed("1000909", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1000909 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≥Ø∞≥ ∞°πÊ	0.8%
	else if(rval >= 3800)
	{
		trigger.addItemClassNamed("1002694", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002694 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈‰≥¢ «Æ≤… »≠∞¸	10%
	else if(rval >= 2800)
	{
		trigger.addItemClassNamed("1002161", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002161 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∞À≈ıªÁ ≈ı±∏	2%
	else if(rval >= 2600)
	{
		trigger.addItemClassNamed("1002223", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002223 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ±´µµ ª˛∏£ ∞°∏È	2%
	else if(rval >= 2400)
	{
		trigger.addItemClassNamed("1002233", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002233 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ππ æ»∞Ê	4%
	else if(rval >= 2000)
	{
		trigger.addItemClassNamed("1002235", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002235 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ª°∞£ ƒ⁄	4%
	else if(rval >= 1600)
	{
		trigger.addItemClassNamed("1002656", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002656 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ª«±€∏”∏Æ	4%
	else if(rval >= 1200)
	{
		trigger.addItemClassNamed("1002649", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002649 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¿¿∞° ∏¿⁄	4%
	else if(rval >= 800)
	{
		trigger.addItemClassNamed("1002226", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002226 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// «–ªÁ∏	4%
	else if(rval >= 400)
	{
		trigger.addItemClassNamed("1002227", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002227 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ±∫π„∏¿⁄	4%
	else if(rval >= 0)
	{
		trigger.addItemClassNamed("1002228", 1);
		Item_Info = "From Rainbow Present Box : +ITEM [ 1002228 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	Util.log(time_Info + Item_Info + world_Info);
}


quest
qUseItem1002171()			// √‡∫ππﬁ¿∫ º±π∞ªÛ¿⁄ (2004 5ø˘ øÓøµ ¿Ã∫•∆Æ by stsoul)
{
	object rank;
	integer rval, mx, my;
	integer tickTime;
	integer wNum, rCount, wDay, rType, iBirth;

	string userName;
	string time_Info, world_Info, Item_Info;

	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(!trigger.getWorld().canFight()) {
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// √ ∫∏¿⁄ ¥¯¿¸ø°º≠ ªÁøÎ ∫“∞°¥…
	if (wNum == 422 || wNum == 423 || wNum == 424)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ±Ê¿Ã ¡º¿∫ ø¨∞·≈Î ∏ 
	if(wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 90) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	tickTime = Util.getTick();
	wDay = Util.getWday(tickTime);

	// ¡ﬂ±π ¥Î¿¿ √ﬂ∞° ¿€æ˜. ∞¯øÎ ªÁøÎ«“ ºˆ ¿÷∞‘ ±∏¡∂ ∫Ø∞Ê
	rType = Util.getRealNationType();

	if (rType == KOREA || rType == JAPAN)
	{
		// Log Info
	
		userName = trigger.getName();

		time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
		world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

		mx =  trigger.getX();
		my =  trigger.getY();

		rval = Util.random(0, 100);

		// 1∏∏ SEED		5%
		if(rval >= 95) {
			trigger.setGold(trigger.getGold() + 10000);

			Item_Info = "From Red Present Box : +SEED [ 10000 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "10000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
		}

		// 2∏∏ SEED		4%
		else if(rval >= 91) {
			trigger.setGold(trigger.getGold() + 20000);

			Item_Info = "From Red Present Box : +SEED [ 20000 ] ";
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "20000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
		}

		// 4∏∏ SEED		3%
		else if(rval >= 88) {
			trigger.setGold(trigger.getGold() + 40000);
			Item_Info = "From Red Present Box : +SEED [ 40000 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "40000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
		}

		// 8∏∏ SEED		2%
		else if(rval >= 86) {
			trigger.setGold(trigger.getGold() + 80000);
			Item_Info = "From Red Present Box : +SEED [ 80000 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "80000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
		}

		// 10∏∏ SEED	1%
		else if(rval >= 85) {
			trigger.setGold(trigger.getGold() + 100000);
			Item_Info = "From Red Present Box : +SEED [ 100000 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "100000" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
		}

		// ∫Ì∑Øµ µπ	3%
		else if(rval >= 82) {
			trigger.getWorld().genMonster("2100221", 1, "twMechanic.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From White Present Box : MONSTER [ 2100221 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}

		// ≈©≥Î«Ó		3%
		else if(rval >= 79) {
			trigger.getWorld().genMonster("2100026", 1, "twKnohen.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From White Present Box : MONSTER [ 2100026 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}

		// ¡¯æ∆¡ˆ¥Ÿ«œƒ´	5%
		else if(rval >= 74) {
			trigger.getWorld().genMonster("2100119", 1, "twAzidahaka_J.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From White Present Box : MONSTER [ 2100119 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}

		// µ•Ω∫«¡∑π≈∏	5%
		else if(rval >= 69) {
			trigger.getWorld().genMonster("2100118", 1, "twFretaDeath.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From White Present Box : MONSTER [ 2100118 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}

		// ¡©∏Æ≈∑	7%
		else if(rval >= 62) {
			trigger.getWorld().genMonster("2100239", 1, "twJellyKing_Dark.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From White Present Box : MONSTER [ 2100239 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}

		// ∂—∂—ƒ˝	7%
		else if(rval >= 55) {
			trigger.getWorld().genMonster("2100195", 1, "twDduQueen.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From White Present Box : MONSTER [ 2100195 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}

		// ∂—∂—≈∑	7%
		else if(rval >= 48) {
			trigger.getWorld().genMonster("2100194", 1, "twDduKing.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From White Present Box : MONSTER [ 2100195 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}

		// ø£««¥œø¬	7%
		else if(rval >= 41) {
			trigger.getWorld().genMonster("2100109", 1, "twEnvinion.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From White Present Box : MONSTER [ 2100109 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}

		// ∆˜ºº¿Ã∏•	8%
		else if(rval >= 33) {
			trigger.getWorld().genMonster("2100193", 1, "twPoseidon.ptn", 1, mx-10, my-10, mx+10, my+10);
			Item_Info = "From White Present Box : MONSTER [ 2100193 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}

		// ±´µµ ª˛∏• ∞°∏È	1%
		else if(rval >= 32) {
			trigger.addItemClassNamed("1002233", 1);
			Item_Info = "From Rainbow Present Box : +ITEM [ 1002233 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}

		// ¡¶∑√≈∞∆Æ	4%
		else if(rval >= 28) {
			trigger.addItemClassNamed("1000091", 1);
			Item_Info = "From Red Present Box : +ITEM 1 [ 1000091 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}

		// ±◊∂Û¿Œ¥ı	4%
		else if(rval >= 24) {
			trigger.addItemClassNamed("1000094", 1);
			Item_Info = "From Red Present Box : +ITEM [ 1000094 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}

		// ∏∂∑¬∞≠»≠¡¶(¥Î)	4%
		else if(rval >= 20) {
			trigger.addItemClassNamed("1000100", 1);
			Item_Info = "From Red Present Box : +ITEM [ 1000100 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}

		// ø©Ω≈¿«∞°»£	4%
		else if(rval >= 16) {
			trigger.addItemClassNamed("1000103", 1);
			Item_Info = "From Red Present Box : +ITEM [ 1000103 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}

		// ≈∫º∫∑Œº«(¥Î)	4%
		else if(rval >= 12) {
			trigger.addItemClassNamed("1000097", 1);
			Item_Info = "From Red Present Box : +ITEM [ 1000097 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}

		// ¿Æ Ω¥¡Ó	2%
		else if(rval >= 10) {
			trigger.addItemClassNamed("1000961", 1);
			Item_Info = "From Red Present Box : +ITEM [ 1000961 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}

		// √º«Ë Ω∫≈©∑—	10% 1∏∏¬•∏Æ...
		else {
			trigger.addItemClassNamed("1002777", 1);
			Item_Info = "From Red Present Box : +ITEM [ 1002777 ] ";

			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}

		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		Util.log(time_Info + Item_Info + world_Info);
		controller.effectBy(trigger);
	}
	else if (rType == CHINA)
	{
		// Log Info
		tickTime = Util.getTick();
		userName = trigger.getName();

		mx =  trigger.getX();
		my =  trigger.getY();

		rval = Util.random(0, 10000);

		iBirth = trigger.getBirthTime();

		// ¡÷∏ª ∫∏¡§ ±‚¥…
		if (Util.getWday(tickTime) == 0)	{
			if (rval > 4400)		rval = rval - 200;
		} else if (Util.getWday(tickTime) == 1)	{
			if (rval > 4400)		rval = rval - 100;
		}

		// 5%	≈©≥Î«Ó(»•∂ıµø±º9√˛)
		if(rval >= 9500)
		{
			trigger.getWorld().genMonster("2100026", 1, "twKnohen.ptn", 1, mx-10, my-10, mx+10, my+10);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}
		// 5%	¡¯ æ∆¡ˆ¥Ÿ«œƒ´
		else if(rval >= 9000)
		{
			trigger.getWorld().genMonster("2100119", 1, "twAzidahaka_J.ptn", 1, mx-10, my-10, mx+10, my+10);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}
		// 5%	µ•Ω∫ «¡∑π≈∏
		else if(rval >= 8500)
		{
			trigger.getWorld().genMonster("2100118", 1, "twFretaDeath.ptn", 1, mx-10, my-10, mx+10, my+10);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}
		// 5%	∂—∂—≈∑
		else if(rval >= 8000)
		{
			trigger.getWorld().genMonster("2100194", 1, "twDduKing.ptn", 1, mx-10, my-10, mx+10, my+10);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}
		// 5%	»£∞À»Ò
		else if(rval >= 7500)
		{
			trigger.getWorld().genMonster("2100557", 1, "twFeb22_SwordShaman.ptn", 1, mx-10, my-10, mx+10, my+10);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}
		// 5%	Ω∫æÓªﬂ
		else if(rval >= 7000)
		{
			trigger.getWorld().genMonster("2100499", 1, "twNov04_Saerpi.ptn", 1, mx-10, my-10, mx+10, my+10);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
		}
		// ***********************************************************************************************
		// ø©±‚º≠∫Œ≈Õ æ∆¿Ã≈€~
		// ***********************************************************************************************
		// 3%	ª˛≈©πŸ∏ÆµŒ∞«
		else if(rval >= 6700)
		{
			trigger.addItemClassNamed("1002923", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}
		// 3%	¡“æ»µŒ∞«
		else if(rval >= 6400)
		{
			trigger.addItemClassNamed("1002922", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}
		// 3%	π÷π÷
		else if(rval >= 6100)
		{
			trigger.addItemClassNamed("1002924", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}
		// 1%	∏∂µµªÁ ∏Æ∫ª
		else if(rval >= 6000)
		{
			rank = Rank.select("CHI_EVENT1_ITEM");
			rCount = rank.getCount();

			if(rCount < 1)
		   	{
		   	    rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1002908", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			} else {
				trigger.addItemClassNamed("1000033", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
			}
		}
		// 1%	»´ø∞¿« ∞©ø 
		else if(rval >= 5900)
		{
			rank = Rank.select("CHI_EVENT2_ITEM");
			rCount = rank.getCount();

			if(rCount < 1)
		   	{
		   	    rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1000989", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			} else {
				trigger.addItemClassNamed("1000033", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
			}
		}
		// 1%	»´ø∞¿« ≥Ø∞≥
		else if(rval >= 5800)
		{
		    rank = Rank.select("CHI_EVENT3_ITEM");
			rCount = rank.getCount();

			if(rCount < 1)
		   	{
		   	    rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1000988", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			} else {
				trigger.addItemClassNamed("1000033", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
			}
		}
		// 1%	»´ø∞¿« ∆»¬Ó
		else if(rval >= 5700)
		{
		    trigger.addItemClassNamed("1000990", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		}
		// 1%	»´ø∞¿« ≈ı±∏
		else if(rval >= 5600)
		{
		    trigger.addItemClassNamed("1000987", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		}
		// 1%	»´ø∞¿« Ω¥¡Ó
		else if(rval >= 5500)
		{
			trigger.addItemClassNamed("1000991", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		}
		// 1%	∫˘«—¿« ∞©ø 
		else if(rval >= 5400)
		{
			rank = Rank.select("CHI_EVENT4_ITEM");
			rCount = rank.getCount();

			if(rCount < 1)
		   	{
		   	    rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1000994", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			} else {
				trigger.addItemClassNamed("1000033", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
			}
		}
		// 1%	∫˘«—¿« ≥Ø∞≥
		else if(rval >= 5300)
		{
			rank = Rank.select("CHI_EVENT5_ITEM");
			rCount = rank.getCount();

			if(rCount < 1)
		   	{
		   	    rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1000993", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			} else {
				trigger.addItemClassNamed("1000033", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
			}
		}
		// 1%	∫˘«—¿« ∆»¬Ó
		else if(rval >= 5200)
		{
			trigger.addItemClassNamed("1000995", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		}
		// 1%	∫˘«—¿« ≈ı±∏
		else if(rval >= 5100)
		{
			trigger.addItemClassNamed("1000992", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		}
		// 1001809	1%	∫˘«—¿« Ω¥¡Ó
		else if(rval >= 5000)
		{
			trigger.addItemClassNamed("1000996", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
		}
		//	25%	6001 SEED
		else if(rval >= 2500)
		{
			trigger.setGold(trigger.getGold() + 6001);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + "6001" + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
		}
		// 1001808	25%	¿Œ≈©∏≥∆Æ Ω∫≈©∑—
		else
		{
			trigger.addItemClassNamed("1001808", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
}


quest
qUseItem1002953()				// OX ¿Ã∫•∆Æ ¡¶æÓ ªÛ¿⁄
{
	// ªÁøÎΩ√ ≈¨∑¥¿Â OX∏  ¥Î±‚Ω«∑Œ ¿Ãµø √≥∏Æ. ≤Ù∞Ì≥™º≠ ¿Ãµø«“ ºˆ ¿÷¥Ÿ.
	object loc;

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	loc = Location.create();
	loc.set(340, 110, 150);
	trigger.teleportTo(loc);
}


quest
qUseItem1003021()			// ≈•««∆Æ¿« º±π∞ (2004 6ø˘ øÓøµ ¿Ã∫•∆Æ by stsoul)
{
	integer rval, mx, my;
	integer tickTime;

	string userName;
	string time_Info, world_Info, Item_Info;

	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©
	if(!trigger.getWorld().canFight()) {
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ΩΩ∑‘ √º≈©
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
	if (trigger.getAvailInvenWeight() < 90) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	mx =  trigger.getX();
	my =  trigger.getY();

	rval = Util.random(0, 100);

	// ¿Œ≈©∏≥∆Æ Ω∫≈©∑—	3%
	if(rval >= 97) {
		trigger.addItemClassNamed("1001808", 1);
		Item_Info = "From Present Box : +ITEM 1 [ 1001808 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ¡¶∑√≈∞∆Æ	5%
	else if(rval >= 92) {
		trigger.addItemClassNamed("1000091", 1);
		Item_Info = "From Present Box : +ITEM 1 [ 1000091 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ±◊∂Û¿Œ¥ı	5%
	else if(rval >= 87) {
		trigger.addItemClassNamed("1000094", 1);
		Item_Info = "From Present Box : +ITEM [ 1000094 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ∏∂∑¬∞≠»≠¡¶(¥Î)	5%
	else if(rval >= 82) {
		trigger.addItemClassNamed("1000100", 1);
		Item_Info = "From Present Box : +ITEM [ 1000100 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈©≥Î«Ó		3%
	else if(rval >= 79) {
		trigger.getWorld().genMonster("2100026", 1, "twKnohen.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100026 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ¡¯æ∆¡ˆ¥Ÿ«œƒ´	5%
	else if(rval >= 74) {
		trigger.getWorld().genMonster("2100119", 1, "twAzidahaka_J.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100119 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// µ•Ω∫«¡∑π≈∏	5%
	else if(rval >= 69) {
		trigger.getWorld().genMonster("2100118", 1, "twFretaDeath.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100118 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ¡©∏Æ≈∑	6%
	else if(rval >= 63) {
		trigger.getWorld().genMonster("2100239", 1, "twJellyKing_Dark.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100239 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ∂—∂—ƒ˝	6%
	else if(rval >= 57) {
		trigger.getWorld().genMonster("2100195", 1, "twDduQueen.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100195 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ∂—∂—≈∑	6%
	else if(rval >= 51) {
		trigger.getWorld().genMonster("2100194", 1, "twDduKing.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100195 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ø£««¥œø¬	6%
	else if(rval >= 45) {
		trigger.getWorld().genMonster("2100109", 1, "twEnvinion.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100109 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ∆˜ºº¿Ã∏•	6%
	else if(rval >= 39) {
		trigger.getWorld().genMonster("2100193", 1, "twPoseidon.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100193 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ∫Ì∑Øµ µπ	3%
	else if(rval >= 36) {
		trigger.getWorld().genMonster("2100221", 1, "twMechanic.ptn", 1, mx-10, my-10, mx+10, my+10);
		Item_Info = "From Present Box : MONSTER [ 2100221 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ø©Ω≈¿«∞°»£	5%
	else if(rval >= 31) {
		trigger.addItemClassNamed("1000103", 1);
		Item_Info = "From Present Box : +ITEM [ 1000103 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈∫º∫∑Œº«(¥Î)	5%
	else if(rval >= 26) {
		trigger.addItemClassNamed("1000097", 1);
		Item_Info = "From Present Box : +ITEM [ 1000097 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈•««∆Æ ≈ı±∏	3%
	else if(rval >= 23) {
		trigger.addItemClassNamed("1003265", 1);
		Item_Info = "From Present Box : +ITEM 1 [ 1002793 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈•««∆Æ πÊ∆–	3%
	else if(rval >= 20) {
		trigger.addItemClassNamed("1003266", 1);
		Item_Info = "From Present Box : +ITEM [ 1002794 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈•««∆Æ ∫Ò≥‡	3%
	else if(rval >= 17) {
		trigger.addItemClassNamed("1003267", 1);
		Item_Info = "From Present Box : +ITEM [ 1002795 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈•««∆Æ ≥Ø∞≥	3%
	else if(rval >= 14) {
		trigger.addItemClassNamed("1003268", 1);
		Item_Info = "From Present Box : +ITEM [ 1002796 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈•««∆Æ ∞©ø 	3%
	else if(rval >= 11) {
		trigger.addItemClassNamed("1003269", 1);
		Item_Info = "From Present Box : +ITEM [ 1002797 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈•««∆Æ Ω¥¡Ó	3%
	else if(rval >= 8) {
		trigger.addItemClassNamed("1003270", 1);
		Item_Info = "From Present Box : +ITEM [ 1002798 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// ≈•««∆Æ ¿Â∞©	3%
	else if(rval >= 5) {
		trigger.addItemClassNamed("1003271", 1);
		Item_Info = "From Present Box : +ITEM [ 1002799 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// √º«Ë Ω∫≈©∑—	5% 1∏∏¬•∏Æ...
	else {
		trigger.addItemClassNamed("1002777", 1);
		Item_Info = "From Red Present Box : +ITEM [ 1002777 ] ";

		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	Util.log(time_Info + Item_Info + world_Info);
	controller.effectBy(trigger);
}


quest
qPickItemTimer()							// æ∆¿Ã≈€ ¡˝æ˙¿ª ∂ß º“∏Í Ω√∞£ º≥¡§«œ¥¬ æ∆¿Ã≈€.
{
	controller.setExpireTime(86400);				// 24Ω√∞£ µøæ» «ÿ¥Á æ∆¿Ã≈€¿Ã ¿Ø¡ˆµ .
	trigger.message(TEXT_EXPIRE_START, MSG_TYPE__SYSTEM);
}


quest
qDropItemLost()								// ∏ÛΩ∫≈Õ∞° æ∆¿Ã≈€ ∂≥±∏∏È º“∏Í √≥∏Æ.
{
	controller.sweep();
}


quest
qCanDropItemLost()							// ¿Ø¿˙∞° æ∆¿Ã≈€ ∂≥±∏±‚∏∏ ±›¡ˆ.
{
	if (trigger.isUser())
		Machine.setBooleanReturn(false);
	else
		Machine.setBooleanReturn(true);
}


/* ≥ π´≥ π´ ∫Ò»ø¿≤¿˚¿Œ πÊΩƒ¿Ã∂Ûº≠ ªÁøÎ«œ¡ˆ æ ±‚∑Œ «ﬂ¥Ÿ -_- by stsoul
function
boolean
fOXAuto(object targetMap, object TelLoc)
{
	integer endX, endY;
	integer countX, countY;
	object loc;

	endX = targetMap.getXSize();
	endY = targetMap.getYSize();

	for (countX = 0; countX < endX; ++countX) {
	    for (countY = 0; countY < endY; ++countY) {
		    loc = Visible.at(countX, countY);
			// º”µµ πÆ¡¶∞° ¿÷¡ˆ∏∏ ¿Ø¿˙ ∏˘∂• ≥ª∫∏≥ª±‚ ¿ß«ÿº≠...
			if (loc && loc.isPortal()) continue;
			while (loc && loc.isUser() && loc != trigger) {
				// loc.teleportTo(loc.lastVisitedVillageLoc());
				loc.teleportTo(TelLoc);
			    loc = Visible.at(countX, countY);
			}
		}
	}
	return true;
}
*/


quest
qUseItem1003054()				// ¡§¥‰ √≥∏Æ æ∆¿Ã≈€ (O)
{
	integer bType, mType;
	object targetMap;

	bType = trigger.getBuilderType();
	mType = trigger.getWorld().getNumber();

	if (bType == 1 || bType == 2 || bType == 3 || bType == 5) {
		if (mType == 120 || mType == 324 || mType == 326) {
			// ¥Î±‚Ω« ¿Ø¿˙ ≥ª¬—±‚
			targetMap = World.getNumbered(326);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_O + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_SORRY, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(1, 300, 300);
			// X∏ ¿« ø¿¥‰ ¿Ø¿˙ ≥ª¬—±‚
			targetMap = World.getNumbered(324);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_O + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_SORRY, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(1, 300, 300);
//			targetMap.moveAllUserTo(82, 190, 190);
			// O∏ ¿« ¡§¥‰ ¿Ø¿˙ ¥Î±‚Ω«∑Œ ¿Ãµø
			targetMap = World.getNumbered(120);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_O + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_GOOD, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(326, 110, 150);
		} else {
			trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
			return;
		}
	} else if (trigger.getCarryingItemInventory().getCountClassNamed("1002953") >= 1) {
		if (mType == 336 || mType == 339 || mType == 340) {
			// ¥Î±‚Ω« ¿Ø¿˙ ≥ª¬—±‚
			targetMap = World.getNumbered(340);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_O + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_SORRY, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(1, 300, 300);
			// X∏ ¿« ø¿¥‰ ¿Ø¿˙ ≥ª¬—±‚
			targetMap = World.getNumbered(339);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_O + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_SORRY, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(1, 300, 300);
//			targetMap.moveAllUserTo(82, 190, 190);
			// O∏ ¿« ¡§¥‰ ¿Ø¿˙ ¥Î±‚Ω«∑Œ ¿Ãµø
			targetMap = World.getNumbered(336);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_O + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_GOOD, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(340, 110, 150);
		} else {
			trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
			return;
		}
	}
}


quest
qUseItem1003055()				// ¡§¥‰ √≥∏Æ æ∆¿Ã≈€ (X)
{
	integer bType, mType;
	object targetMap;

	bType = trigger.getBuilderType();
	mType = trigger.getWorld().getNumber();

	if (bType == 1 || bType == 2 || bType == 3 || bType == 5) {
		if (mType == 120 || mType == 324 || mType == 326) {
			// ¥Î±‚Ω« ¿Ø¿˙ ≥ª¬—±‚
			targetMap = World.getNumbered(326);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_X + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_SORRY, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(1, 300, 300);
			// O∏ ¿« ø¿¥‰ ¿Ø¿˙ ≥ª¬—±‚
			targetMap = World.getNumbered(120);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_X + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_SORRY, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(1, 300, 300);
//			targetMap.moveAllUserTo(82, 190, 190);
			// X∏ ¿« ¡§¥‰ ¿Ø¿˙ ¥Î±‚Ω«∑Œ ¿Ãµø
			targetMap = World.getNumbered(324);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_X + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_GOOD, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(326, 110, 150);
		} else {
			trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
			return;
		}
	} else if (trigger.getCarryingItemInventory().getCountClassNamed("1002953") >= 1) {
		if (mType == 336 || mType == 339 || mType == 340) {
			// ¥Î±‚Ω« ¿Ø¿˙ ≥ª¬—±‚
			targetMap = World.getNumbered(340);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_X + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_SORRY, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(1, 300, 300);
			// O∏ ¿« ø¿¥‰ ¿Ø¿˙ ≥ª¬—±‚
			targetMap = World.getNumbered(336);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_X + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_SORRY, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(1, 300, 300);
//			targetMap.moveAllUserTo(82, 190, 190);
			// X∏ ¿« ¡§¥‰ ¿Ø¿˙ ¥Î±‚Ω«∑Œ ¿Ãµø
			targetMap = World.getNumbered(339);
			targetMap.broadcast("<c8>" + TEXT_USABLEITEM_OX_ANSWER_X + "</n></n>" + TEXT_USABLEITEM_OX_ANSWER_GOOD, MSG_TYPE__AUTOHIDE_WINDOW);
			Util.sleep(1);
			targetMap.moveAllUserTo(340, 110, 150);
		} else {
			trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
			return;
		}
	}
}


quest
qUseItem1003056()				// OX √ﬂπÊ æ∆¿Ã≈€
{
	object target;
	object loc;

	target = controller.getObjectArgumentAt(0);

	if (!target)	return;

	if (!target.isAlive()) {
	    trigger.message(GHOST_CANT_USE, MSG_TYPE__SYSTEM);
	    return;
	}

	if(target.getWorld().getNumber() == 336 || target.getWorld().getNumber() == 339 || target.getWorld().getNumber() == 340) {
		loc = Location.create();
		loc.set(82, 190, 190);
		target.teleportTo(loc);
	} else {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}
}


//*********************************************************************************
// ¿Ã æ∆∑°∑Œ ¿ﬂ∂Ûº≠ ∏Ææ◊≈Õ ø¨µø æ∆¿Ã≈€.
//*********************************************************************************
// ¥¯¡ˆ¥¬ ¿Ã∆Â∆Æ¥¬ æ∆¿Ã≈€ ªÁøÎ ¿Ã∆Â∆Æ∑Œ... º≠πˆø°º≠ ¡¬«•∞° ø¿¡ˆ æ ¿∏∏È ≈¨∂Û¿Ãæ∆Æ∞° æ∆¥¬ µ•¿Ã≈Õ∑Œ √≥∏Æ


quest
qUseItem1001991()				// ¡ˆ∑⁄¡¶∞≈±‚. ¡ˆ∑⁄ ¡æ∑˘ √ﬂ∞° µ«∏È ø©±‚º≠ √º≈©«œ¥¬ ∏ÆΩ∫∆Æ∏¶ »Æ¿Â«ÿæﬂ «‘.
{
	integer	indexnumber, tile, dnd;
	integer startX, startY, endX, endY;
	integer defX, defY, countX, countY, cntChk;
	object loc;

	if (!NormalItemCanBeUsed()) return;

	loc = Visible.at(trigger.getX(), trigger.getY());

	startX = trigger.getX() - 2;
	startY = trigger.getY() - 2;
	endX = trigger.getX() + 2;
	endY = trigger.getY() + 2;
	defX = startX;
	defY = startY;
	cntChk = 3;
	dnd = 0;

	for (countX = 0; countX < cntChk; ++countX) {
		for (countY = 0; countY < cntChk; ++countY) {
			loc = Visible.at(defX, defY);
			if (loc && loc.isReactor()) {
				tile = loc.getTile();
				if (tile >= 9000274 && tile <= 9000287) {
					if (dnd == 0) {
						trigger.message(TEXT_USABLEITEM_DEL_BOMB, MSG_TYPE__SYSTEM);
						indexnumber = loc.getIndexNumber();
						trigger.getWorld().setReactorDuration(indexnumber, 0);
						dnd = 99;
					}
				}
			}
			defY = defY + 1;
		}
		defY = startY;
		defX = defX + 1;
	}

	if (dnd != 99) {
		trigger.message(TEXT_USABLEITEM_CANT_DEL_BOMB, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	controller.effectBy(trigger);
}


function
boolean
qFireItem(string PKR, string NPKR, integer S_LV, integer cntChk)
{
	integer	duration;
	integer startX, startY, endX, endY;
	integer defX, defY, countX, countY, DMG;
	object target, loc;

	target = controller.getPointArgumentAt(0);
	if (!target) return false;

	// 3*3, 2*2 ∑Œ ∑π∫ß¥Á ¡ı∞°
	startX = target.getX() - S_LV;
	startY = target.getY() - S_LV;
	endX = target.getX() + S_LV;
	endY = target.getY() + S_LV;
	defX = startX;
	defY = startY;

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	for (countX = 0; countX < cntChk; ++countX) {
		for (countY = 0; countY < cntChk; ++countY) {
			loc = Visible.at(defX, defY);
			if (loc && loc.isPortal()) {
				trigger.message(TEXT_USABLEITEM_CANT_SKILL_REACTOR, MSG_TYPE__SYSTEM);
				return false;								// ∆˜≈ªø°¥¬ ∏Ææ◊≈Õ∏¶ ª˝º∫«“ ºˆ æ¯¥Ÿ.
			}
			if (loc && loc.isReactor()) {
				trigger.message(TEXT_USABLEITEM_CANT_SKILL_REACTOR, MSG_TYPE__SYSTEM);
				return false;								// ∏Ææ◊≈Õø°¥¬ ∏Ææ◊≈Õ∏¶ ª˝º∫«“ ºˆ æ¯¥Ÿ.
			}
			if (loc && loc.isMonster() && !loc.isPet()) {
				// »≠¿ÃæÓ «√∂ÛΩ∫≈© π´Ω√ √º≈©
				if (loc.getCarryingItemInventory().getCountClassNamed("1001995") < 1) {
					DMG = (S_LV * 100 - loc.getDefence()) * 5;
					if (DMG < 1) DMG = 1;
					loc.setHP(loc.getHP() - DMG);
					// πﬂ»≠ º≥¡§«ÿ¡÷±‚. πﬂ»≠ Ω√∞£¿∫ 10√ 
					if (loc.canBeCasted(CREATURE_STATE__FIRE))
						loc.castNamedWithDuration("3000194",10);
					loc.updateAttr();
					loc.updateShape();
					loc.broadcastDamage(DMG);
				}
			}
			defY = defY + 1;
		}
		defY = startY;
		defX = defX + 1;
	}

	duration = (6 - S_LV) * 5 + 5;

	if (trigger.getWorld().canPK()) {
		// PK « µÂøÎ »≠ø∞∫¥ º≥ƒ°
		trigger.getWorld().createReactor(PKR, startX, startY, endX, endY, trigger, cntChk, duration);
	} else {
		// ¿œπ› « µÂøÎ »≠ø∞∫¥ º≥ƒ°
		trigger.getWorld().createReactor(NPKR, startX, startY, endX, endY, trigger, cntChk, duration);
	}

	controller.effectBy(trigger);
	return true;
}

quest
qUseItem1002934()				// ∆ƒ¿ÃæÓ «√∂ÛΩ∫≈© (≥™æﬂ∆Æ∑π¿Ã ¿Œº˙ ≈ı∆¯)
{
	integer	S_LV, cntChk;
	object skill_obj;

	if (!trigger.getWorld().canFight()) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL_TOWN, MSG_TYPE__SYSTEM);
		return;
	}
	if (!NormalItemCanBeUsed()) return;

	if (trigger.getCharacterType() != CHAR_TYPE10) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL_NAYA, MSG_TYPE__SYSTEM);
		return;
	}

	skill_obj = trigger.getSkillActionInventory().getNamed("3001009");
	if (skill_obj == null) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL2_NAYA, MSG_TYPE__SYSTEM);
		return;								// ¿Œº˙ ≈ı∆¯ Ω¿µÊ ø©∫Œ √º≈©
	}
	S_LV = skill_obj.getLevel();
	cntChk = S_LV * 2 + 1;

	if (cntChk == 3) {
		// 3X3 PK & NPK
		qFireItem("9000236", "9000235", S_LV, cntChk);
	} else if (cntChk == 5) {
		// 5X5 PK & NPK
		qFireItem("9000307", "9000306", S_LV, cntChk);
	} else if (cntChk == 7) {
		// 7X7 PK & NPK
		qFireItem("9000309", "9000308", S_LV, cntChk);
	} else if (cntChk == 9) {
		// 9X9 PK & NPK
		qFireItem("9000311", "9000310", S_LV, cntChk);
	} else {
		// 11X11 PK & NPK
		qFireItem("9000313", "9000312", S_LV, cntChk);
	}
}


function
boolean
qMineItem(string PKR, string NPKR)
{
	integer	S_LV;
	integer startX, startY, endX, endY;
	integer defX, defY, countX, countY, cntChk;
	object skill_obj;
	object loc;

	if (!trigger.getWorld().canFight()) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL_TOWN, MSG_TYPE__SYSTEM);
		return false;
	}
	if (!NormalItemCanBeUsed()) return false;
	if (trigger.getCharacterType() != CHAR_TYPE10) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL_NAYA, MSG_TYPE__SYSTEM);
		return false;
	}

	skill_obj = trigger.getSkillActionInventory().getNamed("3001008");
	if (skill_obj == null) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL1_NAYA, MSG_TYPE__SYSTEM);
		return false;									// ¿Œº˙ ¿∫∆¯ Ω¿µÊ ø©∫Œ √º≈©
	}
	S_LV = skill_obj.getLevel();
	startX = trigger.getX() - 2;
	startY = trigger.getY() - 2;
	endX = trigger.getX() + 2;
	endY = trigger.getY() + 2;
	defX = startX;
	defY = startY;
	cntChk = 3;

	for (countX = 0; countX < cntChk; ++countX) {
		for (countY = 0; countY < cntChk; ++countY) {
			loc = Visible.at(defX, defY);
			if (loc && loc.isPortal()) {
				trigger.message(TEXT_USABLEITEM_CANT_SKILL_REACTOR, MSG_TYPE__SYSTEM);
				return false;								// ∆˜≈ªø°¥¬ ∏Ææ◊≈Õ∏¶ ª˝º∫«“ ºˆ æ¯¥Ÿ.
			}
			if (loc && loc.isReactor()) {
				trigger.message(TEXT_USABLEITEM_CANT_SKILL_REACTOR, MSG_TYPE__SYSTEM);
				return false;								// ∏Ææ◊≈Õø°¥¬ ∏Ææ◊≈Õ∏¶ ª˝º∫«“ ºˆ æ¯¥Ÿ.
				/*
				for (rcount = 9000274; rcount < 9000287; ++rcount) {
					if (loc.getTile() == rcount) {
						trigger.message(TEXT_USABLEITEM_CANT_SKILL_REACTOR2, MSG_TYPE__SYSTEM);
						return;						// ∏Ææ◊≈Õø°¥¬ µø¿œ∞Ëø≠ ∏Ææ◊≈Õ∏¶ ¡ﬂ∫π«“ ºˆ æ¯¥Ÿ.
					}
				}
				*/
			}
			defY = defY + 1;
		}
		defY = startY;
		defX = defX + 1;
	}

	if (trigger.getWorld().canPK()) {
		// PK « µÂ¿¸øÎ ¡ˆ∑⁄ º≥ƒ° -> PK ¿Âº“ø°º≠¿« ¡ˆ∑⁄ ¿Ø¡ˆΩ√∞£ 60√ ø°º≠ 55√ ∑Œ «œ«‚
		trigger.getWorld().createReactor(PKR, startX, startY, endX, endY, trigger, S_LV, 55);
	} else {
		// ¿œπ› « µÂøÎ ¡ˆ∑⁄ º≥ƒ° -> ¿œπ› « µÂ¥¬ ±◊¥Î∑Œ ¿Ø¡ˆ
		trigger.getWorld().createReactor(NPKR, startX, startY, endX, endY, trigger, S_LV, 60);
	}

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	controller.effectBy(trigger);
	return true;
}

quest
qUseItem1002935()				// ±‚∫ª ¡ˆ∑⁄ (≥™æﬂ∆Æ∑π¿Ã ¿Œº˙ ¿∫∆¯)
{
	qMineItem("9000275", "9000274");
}


quest
qUseItem1002936()				// ∞®¿¸ ¡ˆ∑⁄ (≥™æﬂ∆Æ∑π¿Ã ¿Œº˙ ¿∫∆¯)
{
	qMineItem("9000277", "9000276");
}

quest
qUseItem1002937()				// πﬂ»≠ ¡ˆ∑⁄ (≥™æﬂ∆Æ∑π¿Ã ¿Œº˙ ¿∫∆¯)
{
	qMineItem("9000279", "9000278");
}

quest
qUseItem1002938()				// ¡ﬂµ∂ ¡ˆ∑⁄ (≥™æﬂ∆Æ∑π¿Ã ¿Œº˙ ¿∫∆¯)
{
	qMineItem("9000281", "9000280");
}

quest
qUseItem1002939()				// ∫˘∞· ¡ˆ∑⁄ (≥™æﬂ∆Æ∑π¿Ã ¿Œº˙ ¿∫∆¯)
{
	qMineItem("9000283", "9000282");
}

quest
qUseItem1002940()				// æœ»Ê ¡ˆ∑⁄ (≥™æﬂ∆Æ∑π¿Ã ¿Œº˙ ¿∫∆¯)
{
	qMineItem("9000285", "9000284");
}

quest
qUseItem1002941()				// ∏∂∫Ò ¡ˆ∑⁄ (≥™æﬂ∆Æ∑π¿Ã ¿Œº˙ ¿∫∆¯)
{
	qMineItem("9000287", "9000286");
}


quest
UseBinding()				// πŸ¿Œµ˘ Ω∫≈Ê ªÁøÎ √≥∏Æ
{
	integer cMap, cX, cY, useCnt;
	string binding, temp, temp2;
	object loc, itemObj;

	itemObj = trigger.getCarryingItemInventory().at(trigger.getIntValue(3));
	binding	= trigger.getStringValue(1);

	cMap = String.toInteger(String.split(" ", 0, binding));
	temp = String.split(" ", 1, binding);
	cX = String.toInteger(String.split(" ", 0, temp));
	temp2 = String.split(" ", 1, temp);
	cY = String.toInteger(String.split("*", 0, temp2));
	useCnt = String.toInteger(String.split("*", 1, temp2));

	// ¿”Ω√∑Œ ø‰ªı æ»ø°º± ∞¢¿Œ ∏¯«œ∞‘ πÊ¡ˆ«‘. 2004.10.18 stsoul
	if (World.getNumbered(cMap).getCastleNumber() != 0) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

//	∑Œƒ√ º≠πˆ ¥Ÿ∏¶ ∞ÊøÏ πÆ¡¶µ«¥¬ ∞≈ ∏∑¥¬ ∂´ªß. æ∆πÃ∆ºΩ∫∏∏ ∏∑¥¬¥Ÿ. by stsoul
	if (cMap == 46 || cMap == 53 || cMap == 59 || cMap == 93 || cMap == 98
	 || cMap == 115 || cMap == 116 || cMap == 348 || cMap == 387 || cMap == 388
	 || cMap == 389 || cMap == 390 || cMap == 417) {
		trigger.message(TEXT_CANT_WARP_NOWARP, MSG_TYPE__SYSTEM);
		return;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (cMap == 609 || cMap == 627 || cMap == 644) {
		trigger.message(TEXT_CANT_WARP_NOWARP, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getLevel() < 45) {
		if (cMap == 42 || cMap == 43 || cMap == 209 || cMap == 215) {
			trigger.message(CANT_USE_TELEPORT_ITEM_SHORT_LEVEL, MSG_TYPE__SYSTEM);
			return;
		}
	}

	// ¿”Ω√ ¡÷ºÆ. ¿Ã∫•∆Æ ±‚∞£ µøæ»ø£ ¿Ã « µÂ∑Œ ∞• ºˆ æ¯¥Ÿ.
	if (cMap == 176 || cMap == 189 || cMap == 418) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SHORT_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}



	useCnt = useCnt - 1;
	trigger.message("[" + trigger.getStringValue(2) + TEXT_WARP_TARGET_SUFFIX, MSG_TYPE__SYSTEM);
	if (useCnt < 1) {
		itemObj.sweep();
		trigger.message(TEXT_USABLEITEM_CANT_EXHAUST, MSG_TYPE__SYSTEM);
	} else {
		trigger.message(TEXT_USECOUNT_PREFIX + useCnt + TEXT_USECOUNT_SUFFIX, MSG_TYPE__SYSTEM);
		binding = cMap + " " + cX + " " + cY + "*" + useCnt;
		itemObj.setAttribute("BINDING", binding);

		temp = trigger.getStringValue(2) + " / " + useCnt + TEXT_USABLEITEM_COUNT;
//		Util.log("*** ¿Ã∏ß ¿Áº≥¡§ ***");
	   	itemObj.setUserDefinedName(temp);
	}
//	Util.log("*** ¿Ã∏ß ¿Áº≥¡§ øœ∑· ***");
	trigger.resetStringValue(1);
	trigger.resetStringValue(2);
	trigger.setIntValue(3, 0);

	loc = Location.create();

	//jaewook if you try to go to castle, the scroll doesn:t work and disappear
	if (cMap == 46 || cMap == 53 || cMap == 59 || cMap == 93 || cMap == 98 || cMap == 115 ||
		cMap == 116 || cMap == 348 || cMap == 387 || cMap == 388 || cMap == 389 ||
		cMap == 390 || cMap == 417) {
			trigger.message("óvçî2?ï!ó'ùëáÄì!Ü!ûÄç!?BÉoÉCÉìÉhÉXÉgÅ[ÉìÇÖÄîÄá!îÄ?ûÄã!è B", MSG_TYPE__SYSTEM);
		itemObj.sweep();
		return;
	}	//
	loc.set(cMap, cX, cY);
	trigger.teleportTo(loc);
}

quest
NoUseBinding()
{
	trigger.message(TEXT_USABLEITEM_CANCEL_USE, MSG_TYPE__SYSTEM);
}

function
boolean
fBinding(string cValue)
{
	integer slot, cMap;
	string binding, temp;
	object skill_obj, chk_obj;
	integer testvalue;

//	√º≈©øÎ. ∞À¡ı«ÿ∫∏∞Ì ¡§∏Æ«œ±‚. ¿œ¥‹¿∫ ¿˚øÎ«œ¡ˆ ∏ª±‚.
//	trigger.suspend();
//	trigger.resume();

	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return false;
	}
	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return false;
	}
	if (!trigger.getWorld().canUseMeet()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return false;
	}
	if (trigger.getWorld().canPK()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return false;
	}
	if (!trigger.isAlive()) return false;
	if (!NormalItemCanBeUsed()) return false;

//	πˆ±◊ ∂´ªßøÎ¿∏∑Œ √ﬂ∞° ¿€æ˜ ¡¯«‡«œ±‚. ¿ÃπÃ ∏ﬁ∏∂Û¿Ã¡Ó «— ∞ÊøÏø° ¥Î∫Ò... by stsoul
	cMap = trigger.getWorld().getNumber();
	if (cMap == 409 || cMap == 410 || cMap == 415 || cMap == 416 || cMap == 103 || cMap == 120
//	 || cMap == 324 || cMap == 326 || cMap == 336 || cMap == 339 || cMap == 340) {
	// √ ∫∏¿⁄ πÆ¡¶ ∂ßπÆø° ¿”Ω√∑Œ √ﬂ∞° by stsoul
	 || cMap == 324 || cMap == 326 || cMap == 336 || cMap == 339 || cMap == 340
	 || cMap == 421 || cMap == 422 || cMap == 423 || cMap == 424) {
		trigger.message(TEXT_CANT_WARP_NOWARP, MSG_TYPE__SYSTEM);
		return false;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (cMap == 609 || cMap == 627 || cMap == 644) {
		trigger.message(TEXT_CANT_WARP_NOWARP, MSG_TYPE__SYSTEM);
		return false;
	}

	if (controller.checkAttribute("BINDING") == true) {
		binding	= controller.getAttribute("BINDING");
		temp = controller.getAttribute("BINDUSER") + TEXT_USABLEITEM_USE_BINDING1 + controller.getAttribute("BINDMAP") + TEXT_USABLEITEM_USE_BINDING2 + String.toInteger(String.split("*", 1, binding)) + TEXT_USABLEITEM_USE_BINDING3;

		// User StringValue 1 = πŸ¿Œµ˘ Ω∫≈Êø° ±‚∑œµ» ¡¬«• ¡§∫∏ π◊ ªÁøÎ »∏ºˆ µ•¿Ã≈Õ
		// User StringValue 2 = πŸ¿Œµ˘ Ω∫≈Êø° ±‚∑œµ» ¿Ãµø ¡¬«• ∏Ìƒ™
		trigger.setStringValue(1, binding);
		trigger.setStringValue(2, controller.getAttribute("BINDMAP"));

		for (slot = trigger.getFirstItemSlot(); slot; slot = trigger.getNextItemSlot(slot)) {
			chk_obj = trigger.getCarryingItemInventory().at(slot);
			if (chk_obj == controller) {
				// User intValue 3 = «⁄µÈ∏µ«“ æ∆¿Ã≈€¿« ΩΩ∑‘ π¯»£
				trigger.setIntValue(3, slot);
				testvalue = testvalue + 1;
			}
		}

		if (testvalue == 0) {
			trigger.message(TEXT_USABLEITEM_EXT_MSG1, MSG_TYPE__SYSTEM);
		}

		trigger.sendSelectQuestMessage(temp, "UseBinding", "NoUseBinding", controller);
		return true;
	} else if (trigger.getCharacterType() != CHAR_TYPE8) {
		trigger.message(TEXT_USABLEITEM_CANT_BINDING, MSG_TYPE__SYSTEM);
		return false;
	} else {
		// ∆ºƒ°ø§¿« æ∆¿Ã≈€ µÓ∑œ √≥∏Æ
		skill_obj = trigger.getSkillActionInventory().getNamed("3000275");
		if (skill_obj == null) {
			trigger.message(TEXT_USABLEITEM_CANT_SKILL1_TICH, MSG_TYPE__SYSTEM);
			return false;
		}

		if (trigger.getWorld().getCastleNumber() != 0) {
			trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
			return false;
		}

		chk_obj = Visible.at(trigger.getX(), trigger.getY());
		if (chk_obj && chk_obj.isPortal()) {
			trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
			return false;
		}
		if (chk_obj && chk_obj.isReactor()) {
			trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
			return false;
		}

		if (skill_obj.getLevel() == 15) {
			binding = trigger.getWorld().getNumber() + " " + trigger.getX() + " " + trigger.getY() + "*" + cValue;
			controller.setAttribute("BINDING", binding);
			controller.setAttribute("BINDMAP", trigger.getWorld().getName());
			controller.setAttribute("BINDUSER", trigger.getName());
//			temp = trigger.getWorld().getName() + " " + controller.getDescClassNamed(controller.getName());
//			temp = trigger.getWorld().getName() + " " + String.split(" ", 0, controller.getDescClassNamed(controller.getName()));
//			binding = String.split(" ", 0, controller.getDescClassNamed(controller.getName()));
//			temp = trigger.getWorld().getName() + " " + binding;
			temp = trigger.getWorld().getName() + " / " + cValue + TEXT_USABLEITEM_COUNT;
	    	controller.setUserDefinedName(temp);
			trigger.message("[" + trigger.getWorld().getName() + TEXT_WARP_SETUP_SUFFIX, MSG_TYPE__SYSTEM);
			return true;
		} else {
			trigger.message(TEXT_CANT_USE_LOW_LEVEL, MSG_TYPE__SYSTEM);
			return false;
		}
	}
	return false;
}

quest
qUseItem1002952()				// πŸ¿Œµ˘ Ω∫≈Ê : ∆ºƒ°ø§ ∞¢¿Œ »ƒ ¥©±∏≥™ ªÁøÎ ∞°¥… (5»∏)
{
	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	fBinding("5");
}

quest
qUseItem1002991()				// πŸ¿Œµ˘ Ω∫≈Ê : ∆ºƒ°ø§ ∞¢¿Œ »ƒ ¥©±∏≥™ ªÁøÎ ∞°¥… (10»∏)
{
	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	fBinding("10");
}

quest
qUseItem1002992()				// πŸ¿Œµ˘ Ω∫≈Ê : ∆ºƒ°ø§ ∞¢¿Œ »ƒ ¥©±∏≥™ ªÁøÎ ∞°¥… (15»∏)
{
	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	fBinding("15");
}

quest
qUseItem1002993()				// πŸ¿Œµ˘ Ω∫≈Ê : ∆ºƒ°ø§ ∞¢¿Œ »ƒ ¥©±∏≥™ ªÁøÎ ∞°¥… (20»∏)
{
	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	fBinding("20");
}

quest
qUseItem1002994()				// πŸ¿Œµ˘ Ω∫≈Ê : ∆ºƒ°ø§ ∞¢¿Œ »ƒ ¥©±∏≥™ ªÁøÎ ∞°¥… (25»∏)
{
	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	fBinding("25");
}

quest
qUseItem1002995()				// πŸ¿Œµ˘ Ω∫≈Ê : ∆ºƒ°ø§ ∞¢¿Œ »ƒ ¥©±∏≥™ ªÁøÎ ∞°¥… (30»∏)
{
	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	fBinding("30");
}

quest
qUseItem1002996()				// πŸ¿Œµ˘ Ω∫≈Ê : ∆ºƒ°ø§ ∞¢¿Œ »ƒ ¥©±∏≥™ ªÁøÎ ∞°¥… (40»∏)
{
	if (trigger.isLimited())
	{
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_EKION_NEW_CHAR_NOT_MOVE2, MSG_TYPE__SYSTEM);
		return;
	}

	fBinding("40");
}


quest
qUseItem1002954()				// ¿ÃΩ∫ƒ…¿Ã«¡ ƒ´µÂ : ∑ÁΩ√æ» ¿¸øÎ Ω∫≈≥ æ∆¿Ã≈€
{
	integer	S_LV;
	integer startX, startY, endX, endY;
	integer defX, defY, count, retry;
	object skill_obj;
	object loc;

	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isAlive()) return;

	if (!NormalItemCanBeUsed()) return;

	if (trigger.getCharacterType() != CHAR_TYPE0) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL_RUCI, MSG_TYPE__SYSTEM);
		return;
	}

	// ∑£¥˝ øˆ«¡ Ω¿µÊ ø©∫Œ √º≈©
	skill_obj = trigger.getSkillActionInventory().getNamed("3000539");
	if (skill_obj == null) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL1_RUCI, MSG_TYPE__SYSTEM);
		return;
	}
	S_LV = skill_obj.getLevel();

	if (S_LV >= 1 && S_LV <= 9) {
		startX = trigger.getX() - (13 * S_LV + 20);
		startY = trigger.getY() - (11 * S_LV + 24);
		endX = trigger.getX() + (11 * S_LV + 24);
		endY = trigger.getY() + (13 * S_LV + 20);
		retry = S_LV / 2 + 2;
	} else if (S_LV == 10) {
		startX = 42;
		startY = 42;
		endX = trigger.getWorld().getXSize() - 42;
		endY = trigger.getWorld().getYSize() - 42;
		retry = 7;
	}

	if (endX >= trigger.getWorld().getXSize() - 41) {
		endX = trigger.getWorld().getXSize() -42;
	} else if (startX < 41) {
		startX = 42;
	}

	if (endY >= trigger.getWorld().getYSize() - 41) {
		endY = trigger.getWorld().getYSize() -42;
	} else if (startY < 41) {
		startY = 42;
	}

	if (startX >= endX || startY >= endY) {
		// ∏ ¿Ã ªÁ±‚¿˚¿∏∑Œ ¿˚æÓ Ω«∆–
		trigger.message(TEXT_USABLEITEM_CANT_MAPSIZE, MSG_TYPE__SYSTEM);
		// ∏¯«œ∞‘ «œ¥¬∞‘ ≥¥∞⁄¡ˆ?
		return;
	}

	loc = Location.create();
	for (count = 0; count < retry; ++count) {
		defX = Util.random(startX, endX);
		defY = Util.random(startY, endY);
		if (trigger.getWorld().canPutObject(defX, defY)) {
			controller.decreaseNumber(1);
			controller.effectBy(trigger);
			loc.set(trigger.getWorld().getNumber(), defX, defY);
			trigger.teleportTo(loc);
			return;
		}
	}
	controller.decreaseNumber(1);
	controller.effectBy(trigger);

	loc.set(trigger.getWorld().getNumber(), trigger.getX(), trigger.getY());
	trigger.teleportTo(loc);
}


function
boolean
TeleportationInput(string RID)				// ∆ºƒ°ø§ ¿¸øÎ Ω∫≈≥ æ∆¿Ã≈€
{
	integer	S_LV;
	integer startX, startY, endX, endY;
	integer defX, defY, count, cntChk;
	integer rTimer, rCount;
	object skill_obj;
	object target;
	object loc;

	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return false;
	}

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return false;
	}

	if (!trigger.isAlive()) return false;

	if (!NormalItemCanBeUsed()) return false;

	if (trigger.getCharacterType() != CHAR_TYPE8) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL_TICH, MSG_TYPE__SYSTEM);
		return false;
	}

	// øˆ«¡ Ω¿µÊ ø©∫Œ √º≈©
	skill_obj = trigger.getSkillActionInventory().getNamed("3000275");
	if (skill_obj == null) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL1_TICH, MSG_TYPE__SYSTEM);
		return false;
	}

	S_LV = skill_obj.getLevel();

	if (S_LV == 1) {
		rTimer = 3;
		rCount = 1;
	} else if (S_LV == 2) {
		rTimer = 4;
		rCount = 2;
	} else if (S_LV == 3) {
		rTimer = 4;
		rCount = 3;
	} else if (S_LV == 4) {
		rTimer = 5;
		rCount = 4;
	} else if (S_LV == 5) {
		rTimer = 5;
		rCount = 5;
	} else if (S_LV == 6) {
		rTimer = 6;
		rCount = 6;
	} else if (S_LV == 7) {
		rTimer = 6;
		rCount = 7;
	} else if (S_LV == 8) {
		rTimer = 7;
		rCount = 8;
	} else if (S_LV == 9) {
		rTimer = 7;
		rCount = 9;
	} else if (S_LV == 10) {
		rTimer = 8;
		rCount = 10;
	} else if (S_LV == 11) {
		rTimer = 8;
		rCount = 11;
	} else if (S_LV == 12) {
		rTimer = 9;
		rCount = 12;
	} else if (S_LV == 13) {
		rTimer = 9;
		rCount = 13;
	} else if (S_LV == 14) {
		rTimer = 10;
		rCount = 14;
	} else if (S_LV == 15) {
		rTimer = 10;
		rCount = 15;
	}

	target = controller.getPointArgumentAt(0);
	if (!target) return false;

	startX = target.getX() - 5;
	startY = target.getY() - 5;
	endX = target.getX() + 4;
	endY = target.getY() + 4;
	defX = startX;
	defY = startY;
	cntChk = 10;

	for (count = 0; count < cntChk; ++count) {
		loc = Visible.at(defX, defY);
		if (loc && loc.isPortal()) {
			trigger.message(TEXT_USABLEITEM_CANT_SKILL_REACTOR, MSG_TYPE__SYSTEM);
			return false;							// ∆˜≈ªø°¥¬ ∏Ææ◊≈Õ∏¶ ª˝º∫«“ ºˆ æ¯¥Ÿ.
		}
		if (loc && loc.isReactor()) {
			trigger.message(TEXT_USABLEITEM_CANT_SKILL_REACTOR2, MSG_TYPE__SYSTEM);
			return false;							// ∏Ææ◊≈Õø°¥¬ µø¿œ ∏Ææ◊≈Õ∏¶ ¡ﬂ∫π«“ ºˆ æ¯¥Ÿ.
		}
		defX = defX + 1;
		defY = defY + 1;
	}

	trigger.getWorld().createReactor(RID, startX, startY, endX, endY, trigger, rCount + 10, rTimer);
	return true;
}


quest
qUseItem1002972()				// ≈¨∂ÛµÂ ≈⁄∑π∆˜∆Æ Ω∫≈©∑— : ∆ºƒ°ø§ ¿¸øÎ Ω∫≈≥ æ∆¿Ã≈€
{
	integer cMap;

	cMap = trigger.getWorld().getNumber();

	// ¿”Ω√∑Œ ø‰ªı æ»ø°º± ∞¢¿Œ ∏¯«œ∞‘ πÊ¡ˆ«‘. 2004.08.18 stsoul
	if (trigger.getWorld().getCastleNumber() != 0) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (cMap == 609 || cMap == 627 || cMap == 644) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	if (!TeleportationInput("9000260")) return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	controller.effectBy(trigger);
}

quest
qUseItem1002973()				// ≥™∏£∫Ò≈© ≈⁄∑π∆˜∆Æ Ω∫≈©∑— : ∆ºƒ°ø§ ¿¸øÎ Ω∫≈≥ æ∆¿Ã≈€
{
	integer cMap;

	cMap = trigger.getWorld().getNumber();

	if (trigger.getWorld().getCastleNumber() != 0) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (cMap == 609 || cMap == 627 || cMap == 644) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	if (!TeleportationInput("9000261")) return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	controller.effectBy(trigger);
}

quest
qUseItem1002974()				// ∂Û¿Ãµæ∆ ≈⁄∑π∆˜∆Æ Ω∫≈©∑— : ∆ºƒ°ø§ ¿¸øÎ Ω∫≈≥ æ∆¿Ã≈€
{
	integer cMap;

	cMap = trigger.getWorld().getNumber();

	if (trigger.getWorld().getCastleNumber() != 0) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (cMap == 609 || cMap == 627 || cMap == 644) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	if (!TeleportationInput("9000262")) return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	controller.effectBy(trigger);
}

quest
qUseItem1002975()				// ƒ´øÔ ≈⁄∑π∆˜∆Æ Ω∫≈©∑— : ∆ºƒ°ø§ ¿¸øÎ Ω∫≈≥ æ∆¿Ã≈€
{
	integer cMap;

	cMap = trigger.getWorld().getNumber();

	if (trigger.getWorld().getCastleNumber() != 0) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (cMap == 609 || cMap == 627 || cMap == 644) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	if (!TeleportationInput("9000263")) return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	controller.effectBy(trigger);
}

quest
qUseItem1002976()				// æ∆µÂºø ≈⁄∑π∆˜∆Æ Ω∫≈©∑— : ∆ºƒ°ø§ ¿¸øÎ Ω∫≈≥ æ∆¿Ã≈€
{
	integer cMap;

	cMap = trigger.getWorld().getNumber();

	if (trigger.getLevel() < 45) return;

	if (trigger.getWorld().getCastleNumber() != 0) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (cMap == 609 || cMap == 627 || cMap == 644) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	if (!TeleportationInput("9000264")) return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	controller.effectBy(trigger);
}

quest
qUseItem1002977()				// ≈∏øÓ ≈⁄∑π∆˜∆Æ Ω∫≈©∑— : ∆ºƒ°ø§ ¿¸øÎ Ω∫≈≥ æ∆¿Ã≈€
{
	integer cMap;

	cMap = trigger.getWorld().getNumber();

	if (trigger.getWorld().getCastleNumber() != 0) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (cMap == 609 || cMap == 627 || cMap == 644) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	if (!TeleportationInput("9000265")) return;

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);

	controller.effectBy(trigger);
}


quest
qUseItem1001804()		// ∏ﬁ∏∂Û¿Ã¡Ó Ω∫≈©∑— (∆ºƒ°ø§ ¿¸øÎ, ¡¬«• ±‚æÔ π◊ √º≈©øÎ)
{
	integer S_LV;
	integer rTime;
	string memorize;
	object skill_obj;

	integer cMap;

	cMap = trigger.getWorld().getNumber();

	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.getWorld().canUseMeet()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getWorld().canPK()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.isAlive()) return;
	if (!NormalItemCanBeUsed()) return;

	if (trigger.getCharacterType() != CHAR_TYPE8) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL_TICH, MSG_TYPE__SYSTEM);
		return;
	}

	// øˆ«¡ Ω¿µÊ ø©∫Œ √º≈©
	skill_obj = trigger.getSkillActionInventory().getNamed("3000275");
	if (skill_obj == null) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL1_TICH, MSG_TYPE__SYSTEM);
		return;
	}
	S_LV = skill_obj.getLevel();

	if (S_LV < 10) {
		trigger.message(TEXT_CANT_USE_LOW_LEVEL, MSG_TYPE__SYSTEM);
		return;
	} else if (S_LV == 10) {
		rTime = 86400;
	} else if (S_LV == 11) {
		rTime = 259200;
	} else if (S_LV == 12) {
		rTime = 432000;
	} else if (S_LV == 13) {
		rTime = 604800;
	} else if (S_LV == 14 || S_LV == 15) {
		rTime = 0;
	}

	// ¿”Ω√∑Œ ø‰ªı æ»ø°º± ∞¢¿Œ ∏¯«œ∞‘ πÊ¡ˆ«‘. 2004.07.21 stsoul
	if (trigger.getWorld().getCastleNumber() != 0) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (cMap == 609 || cMap == 627 || cMap == 644) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

/*
	} else {
		trigger.message("ÉåÉxÉãêü1?ÖàöÜ?ë!íÄÅÄûÄå B", MSG_TYPE__SYSTEM);
		return;
	}
*/
	if (trigger.getCookie("Teleport1") != null) {
		trigger.message("["+ trigger.getCookie("Teleport_Name") + TEXT_WARP_RECORD_SUFFIX, MSG_TYPE__SYSTEM);
	}

	memorize = trigger.getWorld().getNumber() + " " + trigger.getX() + " " + trigger.getY();
	trigger.setCookie("Teleport1", memorize, rTime);
	trigger.setCookie("Teleport1_Name", trigger.getWorld().getName(), rTime);

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	trigger.message(TEXT_WARP_SETUP_COMPLETE, MSG_TYPE__SYSTEM);
	controller.effectBy(trigger);
	// ∆˜≈ª Ω∫≈©∑—¿Ã≥™ ∆˜≈ª ª˝º∫ Ω∫≈≥ ªÁøÎΩ√ ¿Ãµøµ… ¿Âº“∏¶ º≥¡§«œ¥¬ æ∆¿Ã≈€
}


quest
qUseItem1001805()		// ≈⁄∑π∆˜∆Æ Ω∫≈©∑— (∆ºƒ°ø§ ¿¸øÎ)
{
	integer cMap, cX, cY, S_LV, clubCnt, chker;
	integer prob, rValue, tmpCnt, Item_Check1;
	string memorize, temp;
	object target, clubObject;
	object loc, skill_obj, castedSpellInven;

	integer chkMap;

	chkMap = trigger.getWorld().getNumber();

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.hasNamed("3000259")) {
		trigger.message(TEXT_USABLEITEM_CANT_USE_HIDE + TEXT_USABLEITEM_CANT_MSG, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getWorld().isEventWorld()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}
	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!trigger.isAlive()) return;
	if (!NormalItemCanBeUsed()) return;

	if (trigger.getCharacterType() != CHAR_TYPE8) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL_TICH, MSG_TYPE__SYSTEM);
		return;
	}

	// øˆ«¡ Ω¿µÊ ø©∫Œ √º≈©
	skill_obj = trigger.getSkillActionInventory().getNamed("3000275");
	if (skill_obj == null) {
		trigger.message(TEXT_USABLEITEM_CANT_SKILL1_TICH, MSG_TYPE__SYSTEM);
		return;
	}
	S_LV = skill_obj.getLevel();

	if (S_LV < 10) {
		trigger.message(TEXT_CANT_USE_LOW_LEVEL, MSG_TYPE__SYSTEM);
		return;
	}
/*
	} else if (S_LV > 15) {
		trigger.message("∑π∫ß º≥¡§ø° ø¿∑˘∞° ¿÷Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		return;
	}
*/
	memorize = trigger.getCookie("Teleport1");
	if (memorize == null) {
		trigger.message(TEXT_CANT_WARP_NO_POINT1, MSG_TYPE__SYSTEM);
		trigger.message(TEXT_CANT_WARP_NO_POINT2, MSG_TYPE__SYSTEM);
		return;
	}

	target = controller.getObjectArgumentAt(0);
	if (!target) return;

	rValue = 0;
	cMap = String.toInteger(String.split(" ", 0, memorize));
	temp = String.split(" ", 1, memorize);
	cX = String.toInteger(String.split(" ", 0, temp));
	cY = String.toInteger(String.split(" ", 1, temp));

	// ¿”Ω√∑Œ ø‰ªı æ»ø°º± ∞¢¿Œ ∏¯«œ∞‘ πÊ¡ˆ«‘. 2004.10.18 stsoul
	if (World.getNumbered(cMap).getCastleNumber() != 0) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}

	// ≈Î∞Ó¿« ≈æ ¥Î±‚Ω« ªÁøÎ∫“∞°
	if (chkMap == 609 || chkMap == 627 || chkMap == 644) {
		trigger.message(TEXT_USABLEITEM_CANT_BIND_CASTLE, MSG_TYPE__SYSTEM);
		return;
	}
/*
	if (target.isMonster())
	{
		if (trigger.getWorld().getMonsterCountClassNamed("2100094") >= 1 ||
			trigger.getWorld().getMonsterCountClassNamed("2100373") >= 1 ||
			trigger.getWorld().getMonsterCountClassNamed("2100374") >= 1 ||
			trigger.getWorld().getMonsterCountClassNamed("2100375") >= 1)
		{
			trigger.message(TEXT_CANT_WARP_MONSTER_BLOCK, MSG_TYPE__SYSTEM);
			return;
		}
	}
*/
	if (target.isUser()) {
		if (target.getLevel() < 45) {
			if (cMap == 42 || cMap == 43 || cMap == 209 || cMap == 215) {
				trigger.message(CANT_USE_TELEPORT_ITEM_SHORT_LEVEL, MSG_TYPE__SYSTEM);
				return;
			}
		}
		clubObject = trigger.getGuild(GD_TYPE_NORMAL);

		if (target != trigger && !target.isMemberOfGroup(trigger)) {
			if (clubObject != null) {
				if (trigger.getMemberType(target.getName()) == 4) {
					trigger.message(target.getName() + TEXT_RECALL_CANCEL, MSG_TYPE__SYSTEM);
					return;
				}

				clubCnt = clubObject.getMemberType(target.getName());
				if (clubCnt == 0 || clubCnt == 4) {
					trigger.message(TEXT_CANT_WARP_NOWARP, MSG_TYPE__SYSTEM);
					return;
				}
			} else if (target != trigger) {
				trigger.message(TEXT_CANT_WARP_NOWARP, MSG_TYPE__SYSTEM);
				return;
			}
		}

		if (trigger.getWorld().canPK()) {
			tmpCnt = trigger.getWorld().getNumber();
			if (tmpCnt == 331 || tmpCnt == 332 || tmpCnt != 333) {
				trigger.message(TEXT_CANT_WARP_NOWARP, MSG_TYPE__SYSTEM);
				return;
			}
		}
		trigger.message("["+ target.getName() + TEXT_TARGET_WARP_USER_PREFIX + trigger.getCookie("Teleport1_Name") +TEXT_TARGET_WARP_USER_SUFFIX, MSG_TYPE__SYSTEM);
		target.message("["+ trigger.getName() + TEXT_OBJECT_WARP_USER_PREFIX + trigger.getCookie("Teleport1_Name") + TEXT_OBJECT_WARP_USER_SUFFIX, MSG_TYPE__SYSTEM);
	}
	else if (target.isMonster())
	{
		if (trigger.getWorld().getNumber() != cMap)
		{
			if (controller.canBeExhausted())
			{
				controller.decreaseNumber(1);
			}
			trigger.message(TEXT_CANT_WARP_MONSTER, MSG_TYPE__SYSTEM);
			return;
		}
		else
		{
			// º∫∞¯∑¸ = ∏ÛΩ∫≈Õ ∑π∫ß - ¿Ø¿˙ ∑π∫ß + 80
			prob = target.getLevel() - trigger.getLevel() + 80;
			if (prob < 1 || prob < Util.random(1,99))
			{
				if (controller.canBeExhausted())
				{
					controller.decreaseNumber(1);
				}
				trigger.message(TEXT_CANT_WARP_MONSTER_LV, MSG_TYPE__SYSTEM);
				return;
			}
		}
		chker = trigger.getIntValue(9);
		if (chker >= Util.getTick())
		{
			trigger.message(TEXT_USABLEITEM_CANT_USE_DELAY + TEXT_USABLEITEM_CANT_MSG, MSG_TYPE__SYSTEM);
			return;
		}
		Item_Check1 = target.getCarryingItemInventory().getCountClassNamed("1001993");  // ≈⁄∑π∆˜∆Æ ±›¡ˆ
		chker = Util.getTick() + 22;	// 8.3 * 22 = æ‡ 3∫–
		trigger.setIntValue(9, chker);

		if (Item_Check1 >= 1)
		{
			if (controller.canBeExhausted())
			{
				controller.decreaseNumber(1);
			}
			trigger.message(TEXT_CANT_WARP_MONSTER_BLOCK, MSG_TYPE__SYSTEM);
			return;
		}
		trigger.message("["+ target.getName() + TEXT_WARP_COMPLETE, MSG_TYPE__SYSTEM);
	} else return;

	// πˆ±◊ ∂´ªßøÎ¿∏∑Œ √ﬂ∞° ¿€æ˜ ¡¯«‡«œ±‚. ¿ÃπÃ ∏ﬁ∏∂Û¿Ã¡Ó «— ∞ÊøÏø° ¥Î∫Ò... by stsoul
	if (cMap == 409 || cMap == 410 || cMap == 415 || cMap == 416 || cMap == 103 || cMap == 120
//	 || cMap == 324 || cMap == 326 || cMap == 336 || cMap == 339 || cMap == 340) {
	// √ ∫∏¿⁄ πÆ¡¶ ∂ßπÆø° ¿”Ω√∑Œ √ﬂ∞° by stsoul
	 || cMap == 324 || cMap == 326 || cMap == 336 || cMap == 339 || cMap == 340
	 || cMap == 421 || cMap == 422 || cMap == 423 || cMap == 424) {
		trigger.message(TEXT_CANT_WARP_NOWARP, MSG_TYPE__SYSTEM);
		return;
	}

	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	loc = Location.create();
	loc.set(cMap, cX, cY);
	target.teleportTo(loc);
	// controller.effectBy(trigger);
	// ∏ﬁ∏∂Û¿Ã¡Ó Ω∫≈©∑—∑Œ º≥¡§µ» ¿Âº“∑Œ ¿Ãµø ∞°¥…«— ∆˜≈ª¿ª ª˝º∫«œ¥¬ æ∆¿Ã≈€. ∏ﬁ∏∂Û¿Ã¡Ó æ»«œ∏È ªÁøÎ ∫“∞°.
}


function boolean
ItemUpMPMaster(object target, integer value)
{
	integer oldValue;
	integer newValue;

	if (target.isState(CREATURE_STATE__NO_MP_REGEN)) {
		target.message(CANT_USE_FOR_NO_MP_REGEN_STATE, MSG_TYPE__SYSTEM);
		return false;
	}

	value = value + value * target.getMagicResist() / 4 / 100;

	if (value <= 0) {
		Util.log("! invalid mp value " + value + " in ItemUpMP()");
		return false;
	} else if (target.getMaxMP() == target.getMP()) {
		target.message(MP_UP_MESSAGE_PREFIX + FULL_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return false;
	} else {
		oldValue = target.getMP();

		if (target.getMaxMP() < oldValue + value) target.setMP(target.getMaxMP());
		else target.setMP(oldValue + value);

		newValue = target.getMP();

		target.updateAttr();

		// send message
		target.message(MP_UP_MESSAGE_PREFIX + (newValue - oldValue) + MP_UP_MESSAGE_SUFFIX, MSG_TYPE__SYSTEM);
		return true;
	}
}

quest						// ≈◊Ω∫∆ÆøÎ ∏∂≥™ ∆˜º« (¥Î)
qUseItem1002988()
{
	trigger.setLimited(true);
/*
// ≈∏∞Ÿ HP 1∏∏µÈ±‚ -_-

	integer	duration;
	object target;

	target = controller.getObjectArgumentAt(0);
	if (!target) return;

	duration = target.getHP();
	target.setHP(1);
	target.updateAttr();
	//target.updateShape();
	target.broadcastDamage(duration);

	// send using effect
	controller.effectBy(trigger);
*/

/*
	integer endX, endY;
	integer countX, countY;
	object loc;

	endX = trigger.getWorld().getXSize();
	endY = trigger.getWorld().getYSize();

	for (countX = 0; countX < endX; ++countX) {
		for (countY = 0; countY < endY; ++countY) {
			loc = Visible.at(countX, countY);
			if (loc && loc.isMerchant()) {
				loc.hide();
			}
		}
	}
*/
}



quest						// ø‰ªı ¿Ô≈ª¿¸ ∞≠¡¶ Ω√¿€
qUseItem1002942()
{
	object castle;
	castle = Castle.getNumbered(trigger.getWorld().getCastleNumber());
    	if(castle) castle.setState(1);
    	Util.log("######castle State End= ["+castle.getState()+"]");
    	return;
}
quest						// ø‰ªı ¿Ô≈ª¿¸ ∞≠¡¶ ¡æ∑·
qUseItem1002943()
{
	// end
	object castle;
	castle = Castle.getNumbered(trigger.getWorld().getCastleNumber());
	if(castle) castle.setState(3);
	Util.log("######castle State End= ["+castle.getState()+"]");
	return;
}
quest						// ø‰ªı ¡§∫∏ √ ±‚»≠
qUseItem1003354()
{
	object castle;

	castle = Castle.getNumbered(trigger.getWorld().getCastleNumber());

	castle.reset(1);

	return;
}

quest						// ≈◊∂Û≥Î º“»Ø ¡÷πÆº≠
qUseItem1003289()
{
        object guardian;
        string Ruling;
        object castle;
        string GuildName;
        object guild;
        string challenging;
	string cName;
	object world;
	integer mapcheck;
	string sValue;
	//integer xPoint = 0;
	//integer yPoint = 0;

        integer x = trigger.getX();
        integer y = trigger.getY();

	cName = trigger.getName();
	guild = trigger.getGuild(GD_TYPE_NORMAL);
    	GuildName = guild.getName();
        castle = Castle.getNumbered(1);
        Ruling = castle.getRulingGuildName();
        challenging = castle.getChallengingGuildName();
	world = trigger.getWorld();
	mapcheck = world.getNumber();
	sValue = trigger.getCookie("Guardian_R");

	if (!NormalItemCanBeUsed()) return;

	if (!guild.hasGuardian()) {
		// Ω≈ºˆ∏¶ º“¿Ø«œ∞Ì ¿÷¡ˆ æ ¿∫ ∞ÊøÏ
		Util.log("## " + GuildName + " doesn`t have Guardian_R.");
		//∏ﬁΩ√¡ˆ∏¶ ª—∑¡¡÷∞Ì
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN1, MSG_TYPE__SYSTEM);
		//æ∆¿Ã≈€¿ª ∆ƒ±´«—¥Ÿ.
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	}
	if(!castle.isInSiegeWar()) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_IS_INSIEGEWAR, MSG_TYPE__SYSTEM);
		return;
     	}
	if(guild.getMemberType(cName) != 1) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_MEMBER_TYPE, MSG_TYPE__SYSTEM);
		return;
       	}
       	if(mapcheck != 53) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_MAP_CHECK, MSG_TYPE__SYSTEM);
		return;
	}
	if(sValue == "R_Success") {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_COOKIE, MSG_TYPE__SYSTEM);
		if (controller.canBeExhausted())
	    	controller.decreaseNumber(1);
		return;
	}
	/*
	if (!(x > 300 && x < 350 && y > 300 && y < 350)) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN2, MSG_TYPE__SYSTEM);
		Util.log("## can`t Put Guardian_R");
		return;
	}
	*/
	if(GuildName == challenging) {
		guardian = Guardian.summonByNumber(GuildName, 1, 53, x+5, y+5, x+5, y+5, GDN_PTN_DEFAULT);
      	} else if(GuildName == Ruling){
		guardian = Guardian.summonByNumber(GuildName, 1, 53, x+5, y+5, x+5, y+5, GDN_PTN_DEFAULT);
      	} else {
		// µµ¿¸±ÊµÂµµ ºˆº∫±ÊµÂµµ æ∆¥— ∞ÊøÏ
		Util.log("## " + GuildName + " doesn`t related with castle.");
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN2, MSG_TYPE__SYSTEM);
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	}

	if (guardian) {
		// Ω≈ºˆ∞° ¡¶¥Î∑Œ ª˝º∫ µ» ∞ÊøÏ
		Util.log("## Guardian_R Summon Success");
		trigger.setCookie("Guardian_R","R_Success", 3600);
		if (controller.canBeExhausted())
		controller.decreaseNumber(1);
		return;
	} else{
		// ª˝º∫¿Ã ¡¶¥Î∑Œ µ«¡ˆ æ ¿∫ ∞ÊøÏ
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN1, MSG_TYPE__SYSTEM);
		Util.log("## Guardian_R Summon Fail");
		return;
      	}
}
quest						// ∫£∑πΩ√Ω∫ º“»Ø ¡÷πÆº≠
qUseItem1003288()
{
        object guardian;
        string Ruling;
        object castle;
        string GuildName;
        object guild;
        string challenging;
	object world;
        integer mapcheck;
	string cName;
	string sValue;
	//integer xPoint = 0;
	//integer yPoint = 0;

        integer x = trigger.getX();
        integer y = trigger.getY();

	cName = trigger.getName();
	guild = trigger.getGuild(GD_TYPE_NORMAL);
    	GuildName = guild.getName();
        castle = Castle.getNumbered(1);
        Ruling = castle.getRulingGuildName();
        challenging = castle.getChallengingGuildName();
	world = trigger.getWorld();
	mapcheck = world.getNumber();
	sValue = trigger.getCookie("Guardian_B");

	if (!NormalItemCanBeUsed()) return;

	if (!guild.hasGuardian()) {
		// Ω≈ºˆ∏¶ º“¿Ø«œ∞Ì ¿÷¡ˆ æ ¿∫ ∞ÊøÏ
		Util.log("## " + GuildName + " doesn`t have Guardian_B.");
		//∏ﬁΩ√¡ˆ∏¶ ª—∑¡¡÷∞Ì
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN1, MSG_TYPE__SYSTEM);
		//æ∆¿Ã≈€¿ª ∆ƒ±´«—¥Ÿ.
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	}
	if(!castle.isInSiegeWar()){
		trigger.message(TEXT_USABLEITEM_GUARDIAN_IS_INSIEGEWAR, MSG_TYPE__SYSTEM);
		return;
    	}
	if(guild.getMemberType(cName) != 1){
		trigger.message(TEXT_USABLEITEM_GUARDIAN_MEMBER_TYPE, MSG_TYPE__SYSTEM);
		return;
       	}
       	if(mapcheck != 53){
		trigger.message(TEXT_USABLEITEM_GUARDIAN_MAP_CHECK, MSG_TYPE__SYSTEM);
		return;
	}
	if(sValue == "B_Success"){
		trigger.message(TEXT_USABLEITEM_GUARDIAN_COOKIE, MSG_TYPE__SYSTEM);
		if (controller.canBeExhausted())
	    	controller.decreaseNumber(1);
		return;
	}
/*
	if (!(x > 300 && x < 350 && y > 300 && y < 350)) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN2, MSG_TYPE__SYSTEM);
		Util.log("## can`t Put Guardian_B");
		return;
	}
*/
	if(GuildName == challenging){
		guardian = Guardian.summonByNumber(GuildName, 2, 53, x+5, y+5, x+5, y+5, GDN_PTN_DEFAULT);
      	} else if(GuildName == Ruling){
		guardian = Guardian.summonByNumber(GuildName, 2, 53, x+5, y+5, x+5, y+5, GDN_PTN_DEFAULT);
	} else {
		// µµ¿¸±ÊµÂµµ ºˆº∫±ÊµÂµµ æ∆¥— ∞ÊøÏ
		Util.log("## " + GuildName + " doesn`t related with castle.");
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN1, MSG_TYPE__SYSTEM);
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	}

	if (guardian) {
		// Ω≈ºˆ∞° ¡¶¥Î∑Œ ª˝º∫ µ» ∞ÊøÏ
		Util.log("## Guardian_B Summon Success");
		trigger.setCookie("Guardian_B","B_Success", 3600);
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	} else {
		// ª˝º∫¿Ã ¡¶¥Î∑Œ µ«¡ˆ æ ¿∫ ∞ÊøÏ
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN2, MSG_TYPE__SYSTEM);
		Util.log("## Guardian_B Summon Fail");
		return;
	}
}

quest						// ±‚∞°Ω∫ º“»Ø ¡÷πÆº≠
qUseItem1003352()
{
        object guardian;
        string Ruling;
        object castle;
        string GuildName;
        object guild;
        string challenging;
	string cName;
	object world;
	integer mapcheck;
	string sValue;
	//integer xPoint = 0;
	//integer yPoint = 0;

        integer x = trigger.getX();
        integer y = trigger.getY();

	cName = trigger.getName();
	guild = trigger.getGuild(GD_TYPE_NORMAL);
    	GuildName = guild.getName();
        castle = Castle.getNumbered(2);
        Ruling = castle.getRulingGuildName();
        challenging = castle.getChallengingGuildName();
	world = trigger.getWorld();
	mapcheck = world.getNumber();
	sValue = trigger.getCookie("Guardian_G");

	if (!NormalItemCanBeUsed()) return;

	if (!guild.hasGuardian()) {
		// Ω≈ºˆ∏¶ º“¿Ø«œ∞Ì ¿÷¡ˆ æ ¿∫ ∞ÊøÏ
		Util.log("## " + GuildName + " doesn`t have Guardian_G.");
		//∏ﬁΩ√¡ˆ∏¶ ª—∑¡¡÷∞Ì
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN1, MSG_TYPE__SYSTEM);
		//æ∆¿Ã≈€¿ª ∆ƒ±´«—¥Ÿ.
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	}
	if(!castle.isInSiegeWar()) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_IS_INSIEGEWAR, MSG_TYPE__SYSTEM);
		return;
     	}
	if(guild.getMemberType(cName) != 1) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_MEMBER_TYPE, MSG_TYPE__SYSTEM);
		return;
       	}
       	if(mapcheck != 283) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_MAP_CHECK, MSG_TYPE__SYSTEM);
		return;
	}
	if(sValue == "G_Success") {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_COOKIE, MSG_TYPE__SYSTEM);
		if (controller.canBeExhausted())
	    	controller.decreaseNumber(1);
		return;
	}
	/*
	if (!(x > 300 && x < 350 && y > 300 && y < 350)) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN2, MSG_TYPE__SYSTEM);
		Util.log("## can`t Put Guardian_R");
		return;
	}
	*/
	if(GuildName == challenging) {
		guardian = Guardian.summonByNumber(GuildName, 3, 283, x+5, y+5, x+5, y+5, GDN_PTN_DEFAULT);
      	} else if(GuildName == Ruling){
		guardian = Guardian.summonByNumber(GuildName, 3, 283, x+5, y+5, x+5, y+5, GDN_PTN_DEFAULT);
      	} else {
		// µµ¿¸±ÊµÂµµ ºˆº∫±ÊµÂµµ æ∆¥— ∞ÊøÏ
		Util.log("## " + GuildName + " doesn`t related with castle.");
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN2, MSG_TYPE__SYSTEM);
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	}

	if (guardian) {
		// Ω≈ºˆ∞° ¡¶¥Î∑Œ ª˝º∫ µ» ∞ÊøÏ
		Util.log("## Guardian_G Summon Success");
		trigger.setCookie("Guardian_G","G_Success", 3600);
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	} else{
		// ª˝º∫¿Ã ¡¶¥Î∑Œ µ«¡ˆ æ ¿∫ ∞ÊøÏ
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN1, MSG_TYPE__SYSTEM);
		Util.log("## Guardian_G Summon Fail");
		return;
      	}
}
quest						// ƒÌΩ∫≈‰ º“»Ø ¡÷πÆº≠
qUseItem1003353()
{
        object guardian;
        string Ruling;
        object castle;
        string GuildName;
        object guild;
        string challenging;
	object world;
        integer mapcheck;
	string cName;
	string sValue;
	//integer xPoint = 0;
	//integer yPoint = 0;

        integer x = trigger.getX();
        integer y = trigger.getY();

	cName = trigger.getName();
	guild = trigger.getGuild(GD_TYPE_NORMAL);
    	GuildName = guild.getName();
        castle = Castle.getNumbered(2);
        Ruling = castle.getRulingGuildName();
        challenging = castle.getChallengingGuildName();
	world = trigger.getWorld();
	mapcheck = world.getNumber();
	sValue = trigger.getCookie("Guardian_C");

	if (!NormalItemCanBeUsed()) return;

	if (!guild.hasGuardian()) {
		// Ω≈ºˆ∏¶ º“¿Ø«œ∞Ì ¿÷¡ˆ æ ¿∫ ∞ÊøÏ
		Util.log("## " + GuildName + " doesn`t have Guardian_C.");
		//∏ﬁΩ√¡ˆ∏¶ ª—∑¡¡÷∞Ì
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN1, MSG_TYPE__SYSTEM);
		//æ∆¿Ã≈€¿ª ∆ƒ±´«—¥Ÿ.
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	}
	if(!castle.isInSiegeWar()){
		trigger.message(TEXT_USABLEITEM_GUARDIAN_IS_INSIEGEWAR, MSG_TYPE__SYSTEM);
		return;
    	}
	if(guild.getMemberType(cName) != 1){
		trigger.message(TEXT_USABLEITEM_GUARDIAN_MEMBER_TYPE, MSG_TYPE__SYSTEM);
		return;
       	}
       	if(mapcheck != 283){
		trigger.message(TEXT_USABLEITEM_GUARDIAN_MAP_CHECK, MSG_TYPE__SYSTEM);
		return;
	}
	if(sValue == "C_Success"){
		trigger.message(TEXT_USABLEITEM_GUARDIAN_COOKIE, MSG_TYPE__SYSTEM);
		if (controller.canBeExhausted())
	    	controller.decreaseNumber(1);
		return;
	}
/*
	if (!(x > 300 && x < 350 && y > 300 && y < 350)) {
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN2, MSG_TYPE__SYSTEM);
		Util.log("## can`t Put Guardian_B");
		return;
	}
*/
	if(GuildName == challenging){
		guardian = Guardian.summonByNumber(GuildName, 4, 283, x+5, y+5, x+5, y+5, GDN_PTN_DEFAULT);
      	} else if(GuildName == Ruling){
		guardian = Guardian.summonByNumber(GuildName, 4, 283, x+5, y+5, x+5, y+5, GDN_PTN_DEFAULT);
	} else {
		// µµ¿¸±ÊµÂµµ ºˆº∫±ÊµÂµµ æ∆¥— ∞ÊøÏ
		Util.log("## " + GuildName + " doesn`t related with castle.");
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN1, MSG_TYPE__SYSTEM);
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	}

	if (guardian) {
		// Ω≈ºˆ∞° ¡¶¥Î∑Œ ª˝º∫ µ» ∞ÊøÏ
		Util.log("## Guardian_C Summon Success");
		trigger.setCookie("Guardian_C","C_Success", 3600);
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
		return;
	} else {
		// ª˝º∫¿Ã ¡¶¥Î∑Œ µ«¡ˆ æ ¿∫ ∞ÊøÏ
		trigger.message(TEXT_USABLEITEM_GUARDIAN_HASGUARDIAN2, MSG_TYPE__SYSTEM);
		Util.log("## Guardian_C Summon Fail");
		return;
	}
}

// 2004. 08. 26 Written by Han
// √ﬂºÆ ¿Ã∫•∆Æ æ∆¿Ã≈€

quest
qUseItem1003513()				// µ≈¡ˆ∞Ì±‚ ªÍ¿˚
{
	if (!NormalItemCanBeUsed()) return;

	// hp 50 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 250)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 250)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 250);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003514()				// π∞∞Ì±‚ ªÍ¿˚
{
	if (!NormalItemCanBeUsed()) return;

	// hp 50 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 250)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 250)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 250);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003515()				// ∂±
{
	if (!NormalItemCanBeUsed()) return;

	// hp 50 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 250)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 250)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 250);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003516()				// ø˘∫¥
{
	if (!NormalItemCanBeUsed()) return;

	// hp 50 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 250)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 250)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 250);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003517()				// µ≈¡ˆ∞Ì±‚
{
	if (!NormalItemCanBeUsed()) return;

	// hp 50 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 50)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 50)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 50);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003518()				// π∞∞Ì±‚
{
	if (!NormalItemCanBeUsed()) return;

	// hp 50 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 50)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 50)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 50);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003519()				// Ω“∞°∑Á
{
	if (!NormalItemCanBeUsed()) return;

	// hp 50 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 50)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 50)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 50);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003520()				// π–∞°∑Á
{
	if (!NormalItemCanBeUsed()) return;

	// hp 50 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 50)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 50)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 50);
	}

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}


quest
qUseItem1003671()		// »•∂ı¿« ±Í≈–
{
	object target;
	target = controller.getPointArgumentAt(0);
	if (!target) return;

	target.changePattern("twEventPig.ptn");
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1003672()		// »•µ∑¿« ±Í≈–
{
	object target;
	target = controller.getPointArgumentAt(0);
	if (!target) return;

	target.changePattern("twEventChicken.ptn");
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

//===================================
// 2004. 09. 22 Written by Han
//===================================
quest
qUseItem1002986()		// ≥∞¿∫ ªÛ¿⁄ (1~5ø˘¿« ≈∫ª˝ºÆ)
{
	trigger.message("<c8>" + TEXT_USABLEITEM_BIRTH_STONE_BOX1, MSG_TYPE__AUTOHIDE_WINDOW);
}

quest
qUseItem1003285()		// ≥∞¿∫ ªÛ¿⁄ (1~6ø˘¿« ≈∫ª˝ºÆ)
{
	trigger.message("<c8>" + TEXT_USABLEITEM_BIRTH_STONE_BOX2, MSG_TYPE__AUTOHIDE_WINDOW);
}

quest
qUseItem1003660()		// ≥∞¿∫ ªÛ¿⁄ (1~7ø˘¿« ≈∫ª˝ºÆ)
{
	trigger.message("<c8>" + TEXT_USABLEITEM_BIRTH_STONE_BOX3, MSG_TYPE__AUTOHIDE_WINDOW);
}

quest
qUseItem1003751()		// ≥∞¿∫ ªÛ¿⁄ (1~8ø˘¿« ≈∫ª˝ºÆ)
{
	integer nValue1, nValue2, nValue3;

	integer episode		= 1;
	integer gSwitch1	= 20;	// √©≈Õ10 ±€∑Œπ˙ Ω∫¿ßƒ°
	integer gSwitch2	= 21;	// √©≈Õ11 ±€∑Œπ˙ Ω∫¿ßƒ°
	integer gSwitch3	= 22;	// √©≈Õ12 ±€∑Œπ˙ Ω∫¿ßƒ°

	nValue1 = trigger.getGlobalSwitch(episode, gSwitch1);
	nValue2 = trigger.getGlobalSwitch(episode, gSwitch2);
	nValue3 = trigger.getGlobalSwitch(episode, gSwitch3);

	if(nValue3 >= 30)
	{
		trigger.message("<c8>" + TEXT_USABLEITEM_BIRTH_STONE_BOX8, MSG_TYPE__AUTOHIDE_WINDOW);
		return;
	}
	else if(nValue2 >= 37)
	{
		trigger.message("<c8>" + TEXT_USABLEITEM_BIRTH_STONE_BOX7, MSG_TYPE__AUTOHIDE_WINDOW);
		return;
	}
	else
	{
		if(nValue1 >= 31)
		{
			trigger.message("<c8>" + TEXT_USABLEITEM_BIRTH_STONE_BOX6, MSG_TYPE__AUTOHIDE_WINDOW);
			return;
		}
		else if(nValue1 == 30)
		{
			trigger.message("<c8>" + TEXT_USABLEITEM_BIRTH_STONE_BOX5, MSG_TYPE__AUTOHIDE_WINDOW);
			return;
		}
		else
		{
			trigger.message("<c8>" + TEXT_USABLEITEM_BIRTH_STONE_BOX4, MSG_TYPE__AUTOHIDE_WINDOW);
			return;
		}
	}
}

//======================================
// √©≈Õ7 ∫∏ªÛ æ∆¿Ã≈€
// 2004. 10.01 Written by Han
//======================================
quest
qUseItem1003715()				// µµ«√∞ªæÓ »•¿« ¡∂∞¢(STAB + 2)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
	controller.decreaseNumber(1);

	trigger.setOrgStab(trigger.getOrgStab() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_ATTACK_STAB_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003716()				// µµ«√∞ªæÓ »•¿« ¡∂∞¢(HACK + 2)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
	controller.decreaseNumber(1);

	trigger.setOrgHack(trigger.getOrgHack() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_ATTACK_HACK_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003717()				// µµ«√∞ªæÓ »•¿« ¡∂∞¢(DEF + 2)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
	controller.decreaseNumber(1);

	trigger.setOrgDefence(trigger.getOrgDefence() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_DEFENSE_DEF_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003718()				// µµ«√∞ªæÓ »•¿« ¡∂∞¢(INT + 2)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
	controller.decreaseNumber(1);

	trigger.setOrgInt(trigger.getOrgInt() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_ATTACK_INT_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003719()				// µµ«√∞ªæÓ »•¿« ¡∂∞¢(MR + 2)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
	controller.decreaseNumber(1);

	trigger.setOrgMagicResist(trigger.getOrgMagicResist() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_DEFENSE_MR_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003720()				// µµ«√∞ªæÓ »•¿« ¡∂∞¢(DEX + 2)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
	controller.decreaseNumber(1);

	trigger.setOrgDex(trigger.getOrgDex() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_DEX_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003721()				// µµ«√∞ªæÓ »•¿« ¡∂∞¢(AGI + 2)
{
	if (!NormalItemCanBeUsed()) return;

	// decrease number
	if (controller.canBeExhausted())
	controller.decreaseNumber(1);

	trigger.setOrgAgi(trigger.getOrgAgi() + 2);
	trigger.updateAttr();

	trigger.message(TEXT_USABLEITEM_AGI_UP2 , MSG_TYPE__SYSTEM);

	// send using effect
	controller.effectBy(trigger);
}


quest
qUseItem1003859()				// ≈©∏ÆΩ∫∏∂Ω∫ º±π∞ªÛ¿⁄
{
	object rank;
	integer iMaxNum, iCount, iRandom;
	string strRankName, strUserName;

	if (!NormalItemCanBeUsed())	return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 25) {		// jaewook japan setting
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	//jaewooks japan version
/*	iRandom = Util.random(1, 50000);
	
	if	(iRandom <= 24455) trigger.addItemClassNamed("1000013", 1);
	else if	(iRandom <= 26455) trigger.addItemClassNamed("1002755", 1);
	else if	(iRandom <= 28455) trigger.addItemClassNamed("1000014", 1);
	else if	(iRandom <= 30455) trigger.addItemClassNamed("1000015", 1);
	else if	(iRandom <= 32455) trigger.addItemClassNamed("1000024", 1);
	else if	(iRandom <= 34455) trigger.addItemClassNamed("1000025", 1);
	else if	(iRandom <= 36455) trigger.addItemClassNamed("1000026", 1);
	else if	(iRandom <= 38455) trigger.addItemClassNamed("1000035", 1);
	else if	(iRandom <= 40455) trigger.addItemClassNamed("1000036", 1);
	else if	(iRandom <= 42455) trigger.addItemClassNamed("1000037", 1);
	else if	(iRandom <= 43455) trigger.addItemClassNamed("1001060", 1);
	else if	(iRandom <= 44155) trigger.addItemClassNamed("1000097", 1);
	else if	(iRandom <= 44855) trigger.addItemClassNamed("1000100", 1);
	else if	(iRandom <= 45555) trigger.addItemClassNamed("1000103", 1);
	else if	(iRandom <= 46055) trigger.addItemClassNamed("1000052", 1);
	else if	(iRandom <= 46555) trigger.addItemClassNamed("1001808", 1);
	else if	(iRandom <= 47055) trigger.addItemClassNamed("1002031", 1);
	else if	(iRandom <= 47555) trigger.addItemClassNamed("1000934", 1);
	else if	(iRandom <= 47955) trigger.addItemClassNamed("1002655", 1);
	else if	(iRandom <= 48355) trigger.addItemClassNamed("1002656", 1);
	else if	(iRandom <= 48755) trigger.addItemClassNamed("1002677", 1);
	else if	(iRandom <= 49155) trigger.addItemClassNamed("1002321", 1);
	else if	(iRandom <= 49555) trigger.addItemClassNamed("1002157", 1);
	else if	(iRandom <= 49955) trigger.addItemClassNamed("1002697", 1);
	else if	(iRandom <= 49965) trigger.addItemClassNamed("1003040", 1);
	else if	(iRandom <= 49975) trigger.addItemClassNamed("1003041", 1);
	else if	(iRandom <= 49985) trigger.addItemClassNamed("1003042", 1);
	else if	(iRandom <= 49995) trigger.addItemClassNamed("1003043", 1);
	else if	(iRandom <= 49996) trigger.addItemClassNamed("1000987", 1);
	else if	(iRandom <= 49997) trigger.addItemClassNamed("1000988", 1);
	else if	(iRandom <= 49998) trigger.addItemClassNamed("1000989", 1);
	else if	(iRandom <= 49999) trigger.addItemClassNamed("1000990", 1);
	else if	(iRandom <= 50000) trigger.addItemClassNamed("1000991", 1); */


	iRandom = Util.random(1, 999);		//jaewook korean version


	strUserName = trigger.getName();

	if(iRandom <= 2) //1004388	Ω≈∫Ò«— ¡§∑…ºÆ 2/1000
	{
		strRankName = "XMAXS_EVENT1_ITEM";
		rank = Rank.select(strRankName);
		iCount = rank.getCount();
		iMaxNum = 2;

		if(iMaxNum > iCount) //¡ˆ±ﬁ ∞°¥… ¿œ∂ß
		{
			trigger.addItemClassNamed("1004388", 1);
			rank.add(strUserName,0, 0, 0, trigger.getBirthTime(), "null");
		}
		else //≤Œ¿∫ ¡∏¿Á«œ¡ˆ æ ¿∏π«∑Œ ∞°¿Â ∏π¿Ã ≥™ø¿¥¬ 1000022	ª˝∏Ì¿« ¡∂∞¢ ¡ˆ±ﬁ
		{
			trigger.addItemClassNamed("1000022", 1);
		}
	}
	else if(iRandom <= 4) //1004390	ø°¿Ãº«∆Æ æ∆∏” 2/1000
	{
		strRankName = "XMAXS_EVENT2_ITEM";
		rank = Rank.select(strRankName);
		iCount = rank.getCount();
		iMaxNum = 2;

		if(iMaxNum > iCount) //¡ˆ±ﬁ ∞°¥… ¿œ∂ß
		{
			trigger.addItemClassNamed("1004390", 1);
			rank.add(strUserName,0, 0, 0, trigger.getBirthTime(), "null");
		}
		else //≤Œ¿∫ ¡∏¿Á«œ¡ˆ æ ¿∏π«∑Œ ∞°¿Â ∏π¿Ã ≥™ø¿¥¬ 1000022	ª˝∏Ì¿« ¡∂∞¢ ¡ˆ±ﬁ
		{
			trigger.addItemClassNamed("1000022", 1);
		}
	}
	else if(iRandom <= 6) //1004392	º¯∑œø  2/1000
	{
		strRankName = "XMAXS_EVENT3_ITEM";
		rank = Rank.select(strRankName);
		iCount = rank.getCount();
		iMaxNum = 2;

		if(iMaxNum > iCount) //¡ˆ±ﬁ ∞°¥… ¿œ∂ß
		{
			trigger.addItemClassNamed("1004392", 1);
			rank.add(strUserName,0, 0, 0, trigger.getBirthTime(), "null");
		}
		else //≤Œ¿∫ ¡∏¿Á«œ¡ˆ æ ¿∏π«∑Œ ∞°¿Â ∏π¿Ã ≥™ø¿¥¬ 1000022	ª˝∏Ì¿« ¡∂∞¢ ¡ˆ±ﬁ
		{
			trigger.addItemClassNamed("1000022", 1);
		}
	}
	else if(iRandom <= 14) //1004338	∫∏∂Ûªˆ ª«±€∏”∏Æ 8/1000
	{
		trigger.addItemClassNamed("1004338", 1);
	}
	else if(iRandom <= 22) //1004339	¡÷»≤ªˆ ª«±€∏”∏Æ 8/1000
	{
		trigger.addItemClassNamed("1004339", 1);
	}
	else if(iRandom <= 30) //1000968	ø¨µŒªˆ ª«±€∏”∏Æ 8/1000
	{
		trigger.addItemClassNamed("1000968", 1);
	}
	else if(iRandom <= 38) //1005008	»≤±›ªˆ ª«±€∏”∏Æ 8/1000
	{
		trigger.addItemClassNamed("1005008", 1);
	}
	else if(iRandom <= 48) //1002008	¿Œ≈©∏≥∆Æ Ω∫≈©∑— 10/1000
	{
		trigger.addItemClassNamed("1002008", 1);
	}
	else if(iRandom <= 62) //1000665	º˝µπ 14/1000
	{
		trigger.addItemClassNamed("1000665", 1);
	}
	else if(iRandom <= 76) //1000392	±◊∂Û¿Œ¥ı 14/1000
	{
		trigger.addItemClassNamed("1000392", 1);
	}
	else if(iRandom <= 90) //1000350	≈∫º∫ ∑Œº«(¥Î) 14/1000
	{
		trigger.addItemClassNamed("1000350", 1);
	}
	else if(iRandom <= 104) //1000329	∏∂∑¬∞≠»≠¡¶(¥Î) 14/1000
	{
		trigger.addItemClassNamed("1000329", 1);
	}
	else if(iRandom <= 118) //1000686	ø©Ω≈¿« ∞°»£ 14/1000
	{
		trigger.addItemClassNamed("1000686", 1);
	}
	else if(iRandom <= 484) //1001808	∏∂≥™¿« ∞·¡§ 370/100
	{
		trigger.addItemClassNamed("1001808", 1);
	}
	else if(iRandom <= 999) //1000022	ª˝∏Ì¿« ¡∂∞¢ ≥™∏”¡ˆ/1000
	{
		trigger.addItemClassNamed("1000022", 1);
	}				//jaewook korean version

	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	controller.effectBy(trigger);
}


quest
ShoutMessage()
{
	if (trigger.getCarryingItemInventory().getCountClassNamed("1003873") < 1) {
		trigger.message(TEXT_USABLEITEM_CANT_EXHAUST, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getBuilderType() == 1 || trigger.getBuilderType() == 2) {
		trigger.getWorld().broadcast("<c8>" + Util.filterCurse(trigger.getQuestArgument()), MSG_TYPE__AUTOHIDE_WINDOW);
	} else {
		trigger.getWorld().broadcast("<c8>" + Util.filterCurse(trigger.getQuestArgument()) + " </n></n><c9></r>[From " + trigger.getName() + "]", MSG_TYPE__AUTOHIDE_WINDOW);
	}
	trigger.removeItemClassNamed("1003873", 1);
}


quest
qUseItem1003873()				// ø‹ƒ°±‚ Ω∫≈©∑—
{
	if (!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_USABLEITEM_GET_MESSAGE, "ShoutMessage", controller);
}


quest
ShoutMessage1()
{
//	trigger.setCookie("S_M", "<c8>" + Util.filterCurse(trigger.getQuestArgument()), 0);
	trigger.setStringValue(3, "<c8>" + Util.filterCurse(trigger.getQuestArgument()));
	trigger.sendDescribeQuestMessage(TEXT_USABLEITEM_GET_MESSAGE2, "ShoutMessage2", controller);
}

quest
ShoutMessage2()
{

	if (trigger.getCarryingItemInventory().getCountClassNamed("1003874") < 1) {
		trigger.message(TEXT_USABLEITEM_CANT_EXHAUST, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getBuilderType() == 1 || trigger.getBuilderType() == 2) {
//		trigger.getWorld().broadcast("</n>" + trigger.getCookie("Item_Message") + "</n>" + Util.filterCurse(trigger.getQuestArgument()), MSG_TYPE__AUTOHIDE_WINDOW);
		trigger.getWorld().broadcast("</n>" + trigger.getStringValue(3) + "</n>" + Util.filterCurse(trigger.getQuestArgument()), MSG_TYPE__AUTOHIDE_WINDOW);
	} else {
//		trigger.getWorld().broadcast(trigger.getCookie("S_M") + "</n>" + Util.filterCurse(trigger.getQuestArgument()) + " </n><c9></r>[From " + trigger.getName() + "]", MSG_TYPE__AUTOHIDE_WINDOW);
		trigger.getWorld().broadcast(trigger.getStringValue(3) + "</n>" + Util.filterCurse(trigger.getQuestArgument()) + " </n><c9></r>[From " + trigger.getName() + "]", MSG_TYPE__AUTOHIDE_WINDOW);
	}
	trigger.resetStringValue(3);
	trigger.removeItemClassNamed("1003874", 1);
}

quest
qUseItem1003874()				// ø‹ƒ°±‚ Ω∫≈©∑— 2¡Ÿ¬•∏Æ
{
	if (!NormalItemCanBeUsed()) return;
	trigger.sendDescribeQuestMessage(TEXT_USABLEITEM_GET_MESSAGE1, "ShoutMessage1", controller);
}



quest
qUseItem1003872()			// ¡ﬂ±πøÎ ¡ÔºÆ∫π±«
{
/*		vahma - for japan setting
	integer rval, tickTime, iBirth;
	integer rCount, cnt, remain;
	string userName, sValue;
	object rank;

	// ∫π±« 1¿œ ªÁøÎ »∏ºˆ ¡¶«— -> Cookie ∑Œ ∫Ø∞Ê
	sValue = trigger.getCookie("LOTTERY");
	cnt = String.toInteger(sValue) + 1;
	// cnt = trigger.getIntValue(2) + 1;
	if (cnt > 10) {
		trigger.message(TEXT_LOTTERY_CANT, MSG_TYPE__AUTOHIDE_WINDOW);
		return;
	}

	trigger.setCookie("LOTTERY", Integer.toString(cnt), 86400);
	// trigger.setIntValue(2, cnt);

	rval = Util.random(0, 50000);

	// Log Info
	tickTime = Util.getTick();
	userName = trigger.getName();
	iBirth = trigger.getBirthTime();

	// ±›¡÷ ∫π±« ¥Á√∑ øœ∑· ø©∫Œ √º≈©
	rank = Rank.select("LOTTERY_5TH");
	rCount = rank.getCount();
	if (rCount >= 111) {
		rank = Rank.select("LOTTERY_4TH");
		rCount = rank.getCount();

		if (rCount >= 10) {
			rank = Rank.select("LOTTERY_3RD");
			rCount = rank.getCount();

			if (rCount >= 4) {
				rank = Rank.select("LOTTERY_2ND");
				rCount = rank.getCount();

				if (rCount >= 2) {
					rank = Rank.select("LOTTERY_1ST");
					rCount = rank.getCount();

					if (rCount >= 1) {
						trigger.message(TEXT_LOTTERY_NULL, MSG_TYPE__AUTOHIDE_WINDOW);
						trigger.message(TEXT_LOTTERY_NULL2, MSG_TYPE__AUTOHIDE_WINDOW);
						return;
					}
				}
			}
		}
	}

	if (rval >= 10000) {	// ≤Œ
		trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
//		trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__SYSTEM);
	} else if (rval >= 9889) {	// 5µÓ 111∏Ì -> 50∏Ì¿∏∑Œ ºˆ¡§
		rank = Rank.select("LOTTERY_5TH");
		rCount = rank.getCount();

		if(rCount < 50) {
			// trigger.setGold(trigger.getGold() + 5000);	//∞°∞›¿∫ ¿œ¥‹ 5000 SEED∑Œ «œ¿⁄.
			Util.log("### LOTTERY UserName[" + userName + "] 5TH " + rCount + " On time = [" + Util.getTimeString("%A %b %d %T") + "] ###");
			if (!Rewards("LOTTERY05")) {
				trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
			} else {
				remain = 49 - rCount;
				rank.add(userName, 0, 0, 0, iBirth, "null");
				// Util.notifyToAllUser(TEXT_LOTTERY_CONG + trigger.getName() + TEXT_LOTTERY_NAME + "5" + TEXT_LOTTERY_CNT);
				Util.notifyToAllUser(TEXT_LOTTERY_CONG);
				Util.notifyToAllUser(trigger.getName() + TEXT_LOTTERY_NAME + "5" + TEXT_LOTTERY_CNT + TEXT_LOTTERY_COUNT + remain + ")");
				if (remain == 0)
					Util.notifyToAllUser(TEXT_LOTTERY_END + "5" + TEXT_LOTTERY_END2);
			}
		} else {
			trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
		}

	} else if (rval >= 9879) {	// 4µÓ 10∏Ì
		rank = Rank.select("LOTTERY_4TH");
		rCount = rank.getCount();

		if(rCount < 10) {
			Util.log("### LOTTERY UserName[" + userName + "] 4TH " + rCount + " On time = [" + Util.getTimeString("%A %b %d %T") + "] ###");
			if (!Rewards("LOTTERY04")) {
				trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
			} else {
				remain = 9 - rCount;
				rank.add(userName, 0, 0, 0, iBirth, "null");
				Util.notifyToAllUser(TEXT_LOTTERY_CONG);
				Util.notifyToAllUser(trigger.getName() + TEXT_LOTTERY_NAME + "4" + TEXT_LOTTERY_CNT + TEXT_LOTTERY_COUNT + remain + ")");
				// Util.notifyToAllUser(TEXT_LOTTERY_CONG + trigger.getName() + TEXT_LOTTERY_NAME + "4" + TEXT_LOTTERY_CNT);
				if (remain == 0)
					Util.notifyToAllUser(TEXT_LOTTERY_END + "4" + TEXT_LOTTERY_END2);
			}
		} else {
			trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
		}
	} else if (rval >= 9875) {	// 3µÓ 4∏Ì
		rank = Rank.select("LOTTERY_3RD");
		rCount = rank.getCount();

		if(rCount < 4) {
			Util.log("### LOTTERY UserName[" + userName + "] 3RD " + rCount + " On time = [" + Util.getTimeString("%A %b %d %T") + "] ###");
			if (!Rewards("LOTTERY03")) {
				trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
			} else {
				remain = 3 - rCount;
				rank.add(userName, 0, 0, 0, iBirth, "null");
				Util.notifyToAllUser(TEXT_LOTTERY_CONG);
				Util.notifyToAllUser(trigger.getName() + TEXT_LOTTERY_NAME + "3" + TEXT_LOTTERY_CNT + TEXT_LOTTERY_COUNT + remain + ")");
				// Util.notifyToAllUser(TEXT_LOTTERY_CONG + trigger.getName() + TEXT_LOTTERY_NAME + "3" + TEXT_LOTTERY_CNT);
				if (remain == 0)
					Util.notifyToAllUser(TEXT_LOTTERY_END + "3" + TEXT_LOTTERY_END2);
			}
		} else {
			trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
		}
	} else if (rval >= 9873) {	// 2µÓ 2∏Ì
		rank = Rank.select("LOTTERY_2ND");
		rCount = rank.getCount();

		if(rCount < 2) {
			// trigger.addItemClassNamed("1000022", 1);
			// trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
			Util.log("### LOTTERY UserName[" + userName + "] 2ND " + rCount + " On time = [" + Util.getTimeString("%A %b %d %T") + "] ###");
			if (!Rewards("LOTTERY02")) {
				trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
			} else {
				remain = 1 - rCount;
				rank.add(userName, 0, 0, 0, iBirth, "null");
				Util.notifyToAllUser(TEXT_LOTTERY_CONG);
				Util.notifyToAllUser(trigger.getName() + TEXT_LOTTERY_NAME + "2" + TEXT_LOTTERY_CNT + TEXT_LOTTERY_COUNT + remain + ")");
				// Util.notifyToAllUser(TEXT_LOTTERY_CONG + trigger.getName() + TEXT_LOTTERY_NAME + "2" + TEXT_LOTTERY_CNT);
				if (remain == 0)
					Util.notifyToAllUser(TEXT_LOTTERY_END + "2" + TEXT_LOTTERY_END2);
			}
		} else {
			trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
		}
	} else if (rval >= 9872) {	// 1µÓ 1∏Ì
		rank = Rank.select("LOTTERY_1ST");
		rCount = rank.getCount();

		if(rCount < 1) {
			Util.log("### LOTTERY UserName[" + userName + "] 1ST " + rCount + " On time = [" + Util.getTimeString("%A %b %d %T") + "] ###");
			// æ∆¿Ã≈€ ¡÷¥¬ ∫Œ∫– ≈◊¿Ã∫ÌøÎ¿∏∑Œ ºˆ¡§«œ±‚«ÿæﬂ «‘.
			// trigger.addItemClassNamed("1000126", 1);
			if (!Rewards("LOTTERY01")) {
				trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
			} else {
				remain = 1 - rCount;
				rank.add(userName, 0, 0, 0, iBirth, "null");
				Util.notifyToAllUser(TEXT_LOTTERY_CONG);
				Util.notifyToAllUser(trigger.getName() + TEXT_LOTTERY_NAME + "1" + TEXT_LOTTERY_CNT);
				// Util.notifyToAllUser(TEXT_LOTTERY_CONG + trigger.getName() + TEXT_LOTTERY_NAME + "1" + TEXT_LOTTERY_CNT);
				// trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
				Util.notifyToAllUser(TEXT_LOTTERY_END + "1" + TEXT_LOTTERY_END2);
			}
		} else {
			// 5µÓ¿∏∑Œ √≥∏Æ«“¡ˆ ≤Œ¿∏∑Œ √≥∏Æ«“¡ˆ ∞ÌπŒ « ø‰. ¿œ¥‹ ≤Œ.
			trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
		}
	} else {	// ≤Œ
		trigger.message(TEXT_LOTTERY_FAIL, MSG_TYPE__AUTOHIDE_WINDOW);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
*/	// vahma - japan setting
}


quest
qUseItem1003886()		// »∂∫“
{
	UseSkill(trigger,"3000253",1800);
}


quest
qUseItem1003890()	// ø©∏ß πÊ«– æ∆¿Ã≈€ ªÁøÎΩ√ ºˆ¡˝ ªÛ»≤¿ª ∫∏ø©¡÷¥¬ ∏ﬁΩ√¡ˆ π⁄Ω∫.
{
	integer slot, cAll;
	object chk_obj, item2;

	for (slot = trigger.getFirstItemSlot(); slot; slot = trigger.getNextItemSlot(slot)) {
		chk_obj = trigger.getCarryingItemInventory().at(slot);
		if (chk_obj.getClassName() == "1003890") {
			item2 = chk_obj;
			break;
		}
	}
	if (item2.checkAttribute("S3") == true)
		cAll = String.toInteger(item2.getAttribute("S3"));
	else
		cAll = 0;

	trigger.message(SUMMER2005_MSG1 + cAll + SUMMER2005_MSG2, MSG_TYPE__AUTOHIDE_WINDOW);
}

quest
qCanUseRecipe()		// ø‰∏Æ ∑πΩ√«« æ∆¿Ã≈€ º≥¡§ (ªÁøÎ«“ ºˆ ¿÷¥¬¡ˆ)
{
	object skill_Cook;
	object skill_Hurb;
	boolean result = true;
	string recipe = Machine.getArgAt(0);
	string recipeLevel = Machine.getArgAt(1);
	integer recipeType = String.toInteger(Machine.getArgAt(2));

	skill_Cook = trigger.getSkillActionInventory().getNamed("3001731");
	skill_Hurb = trigger.getSkillActionInventory().getNamed("3001751");

	if(recipeType == 1)
	{
		if(skill_Cook == null)
		{
			trigger.message(TEXT_USABLEITEM_COOK_NOT2, MSG_TYPE__SYSTEM);
			result = false;
		}
		if(skill_Cook.getLevel() < String.toInteger(recipeLevel))
		{
			trigger.message(TEXT_USABLEITEM_COOK_NOT, MSG_TYPE__SYSTEM);
			result = false;
		}

		if (trigger.hasRecipe(recipe, recipeType))
		{
			trigger.message(TEXT_USABLEITEM_CAN_RECIPE, MSG_TYPE__SYSTEM);
			result = false;
		}
		else if (!trigger.canAddRecipe(recipe, recipeType))
		{
			trigger.message(TEXT_USABLEITEM_RECIPE, MSG_TYPE__SYSTEM);
			result = false;
		}
	}
	else if(recipeType == 2)
	{
		if(skill_Hurb == null)
		{
			trigger.message(TEXT_USABLEITEM_HURB_NOT2, MSG_TYPE__SYSTEM);
			result = false;
		}
		if(skill_Hurb.getLevel() < String.toInteger(recipeLevel))
		{
			trigger.message(TEXT_USABLEITEM_HURB_NOT, MSG_TYPE__SYSTEM);
			result = false;
		}

		if (trigger.hasRecipe(recipe, recipeType))
		{
			trigger.message(TEXT_USABLEITEM_CAN_RECIPE2, MSG_TYPE__SYSTEM);
			result = false;
		}
		else if (!trigger.canAddRecipe(recipe, recipeType))
		{
			trigger.message(TEXT_USABLEITEM_RECIPE2, MSG_TYPE__SYSTEM);
			result = false;
		}
	}
	Machine.setBooleanReturn(result);
	return;
}

quest
qUseRecipe()		// ø‰∏Æ ∑πΩ√«« æ∆¿Ã≈€ º≥¡§ (ªÁøÎ«“ ºˆ ¿÷¥Ÿ∏È Ω««‡)
{
	string recipe = Machine.getArgAt(0);
	string cookName = Machine.getArgAt(1);
	integer recipeType = String.toInteger(Machine.getArgAt(2));

	trigger.addRecipe(recipe, recipeType);

	if(recipeType == 1)
		trigger.message(TEXT_USABLEITEM_COOK_LEARN + cookName, MSG_TYPE__SYSTEM);
	else if(recipeType == 2)
		trigger.message(TEXT_USABLEITEM_HURB_LEARN + cookName, MSG_TYPE__SYSTEM);

	controller.decreaseNumber(1);
	return;
}

quest
qUseItem1003925()				// ≥ÏΩº ªÛ¿⁄
{
	string itemID = "";
	integer selection;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection = Util.random(1, 100);

	if (selection <= 1) {			// ¥Ÿ¿Ãæ∆∏ÛµÂ
		itemID	= "1000256";
	} else if (selection <= 10) {		// «ÿ∞Òπ›¡ˆ
		itemID	= "1001867";
	} else if (selection <= 20) {		// ≥™∏∑Ω≈
		itemID	= "1000957";
	} else if (selection <= 40) {		// π›√¢∞Ì
		itemID	= "1000903";
	} else if (selection <= 100) {		// ∞°µÂ
		itemID	= "1000861";
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	if (itemID != "") trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003926()				// ≥∞¿∫ ªÛ¿⁄
{
	string itemID = "";
	integer selection;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection = Util.random(1, 100);

	if (selection <= 1) {			// 100≥‚ π¨¿∫ πˆº∏
		itemID	= "1001252";
	} else if (selection <= 8) {		// ∫Œ»∞¿« «‚ºˆ
		itemID	= "1001891";
	} else if (selection <= 17) {		// ƒ¨≈◊¿œ
		itemID	= "1001026";
	} else if (selection <= 35) {		// ∞°¡◊¿Â∞©
		itemID	= "1000914";
	} else if (selection <= 100) {		// ∞ÌæÁ¿Ã¿« πﬂ≈È
		itemID	= "1001875";
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	if (itemID != "") trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003927()				// ≥™π´ ªÛ¿⁄
{
	string itemID = "";
	integer selection;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection = Util.random(1, 100);

	if (selection <= 1) {			// øÕ¿Œ
		itemID	= "1001027";
	} else if (selection <= 6) {		// ªÁ∞¢ ±Íπﬂ
		itemID	= "1000883";
	} else if (selection <= 14) {		// ≤…¿Ÿ ∏”∏Æ«…
		itemID	= "1000902";
	} else if (selection <= 30) {		// ¡§∑…√ 
		itemID	= "1001827";
	} else if (selection <= 100) {		// ºˆº± µµ±∏
		itemID	= "1000076";
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	if (itemID != "") trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003928()				// √ªµø ªÛ¿⁄
{
	string itemID = "";
	integer selection;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection = Util.random(1, 100);

	if (selection <= 1) {			// ±Ÿº∫¿« ∏ﬁ√ﬂ∏ÆæÀ
		itemID	= "1000138";
	} else if (selection <= 10) {		// ∆¯≈∫¡÷
		itemID	= "1001029";
	} else if (selection <= 20) {		// 5±ﬁ πŸ¿Œµ˘ Ω∫≈Ê
		itemID	= "1002992";
	} else if (selection <= 40) {		// ∏‡µ˘ ≈∞∆Æ(º“)
		itemID	= "1000079";
	} else if (selection <= 100) {		// »˙∏µ ∆˜º«(¥Î)
		itemID	= "1000018";
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	if (itemID != "") trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003929()				// √∂¡¶ ªÛ¿⁄
{
	string itemID = "";
	integer selection;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection = Util.random(1, 50000);					//vahma

	if (selection <= 1) {			// ê???ç??		//vahma
		itemID	= "1000126";						//vahma
	} else if (selection <= 2) {		// î≠êTíiê?ê?		//vahma
		itemID	= "1000132";						//vahma
	} else if (selection <= 20000) {		// çJìïîñî??ê?@	//vahma
		itemID	= "1001890";						//vahma
	} else if (selection <= 30000) {		// èYí¯‚`ê?à¯‡U	//vahma
		itemID	= "1001864";						//vahma
	} else if (selection <= 40000) {		// ëöîRê?è?i		//vahma
		itemID	= "1000022";						//vahma
	} else if (selection <= 45000) {		// ëöîRê?è?i		//vahma
		itemID	= "1003504";						//vahma
	} else if (selection <= 50000) {		// ëöîRê?è?i		//vahma
		itemID	= "1000041";						//vahma
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	if (itemID != "") trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003930()	// ∞¢¡¯ π∞∞Ì±‚ (≥ÏΩºªÛ¿⁄)
{
	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ. (≥ÏΩºªÛ¿⁄)
	trigger.addItemClassNamed("1003925", 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003931()	// ∞¢¡¯ π∞∞Ì±‚ (≥∞¿∫ªÛ¿⁄)
{
	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ. (≥∞¿∫ªÛ¿⁄)
	trigger.addItemClassNamed("1003926", 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003932()	// ∞¢¡¯ π∞∞Ì±‚ (≥™π´ªÛ¿⁄)
{
	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ. (≥™π´ªÛ¿⁄)
	trigger.addItemClassNamed("1003927", 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003933()	// ∞¢¡¯ π∞∞Ì±‚ (√ªµøªÛ¿⁄)
{
	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ. (√ªµøªÛ¿⁄)
	trigger.addItemClassNamed("1003928", 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1003934()	// ∞¢¡¯ π∞∞Ì±‚ (√∂¡¶ªÛ¿⁄)
{
	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ. (√∂¡¶ªÛ¿⁄)
	trigger.addItemClassNamed("1003929", 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qCookUseItem()		// ø‰∏Æ »∏∫π æ∆¿Ã≈€ ªÁøÎ
{

	object castedSpellInven;

	string Type = Machine.getArgAt(0);

	castedSpellInven = trigger.getCastedSpellInventory();
	if (castedSpellInven.hasNamed("3001835") || castedSpellInven.hasNamed("3001836")
	 || castedSpellInven.hasNamed("3001837") || castedSpellInven.hasNamed("3001838") 
	 || castedSpellInven.hasNamed("3001839") || castedSpellInven.hasNamed("3001840")
	 || castedSpellInven.hasNamed("3001841") || castedSpellInven.hasNamed("3001842")
	 || castedSpellInven.hasNamed("3001843") || castedSpellInven.hasNamed("3001844")
	 || castedSpellInven.hasNamed("3001845") || castedSpellInven.hasNamed("3001846")
	 || castedSpellInven.hasNamed("3001847") || castedSpellInven.hasNamed("3001848")
	 || castedSpellInven.hasNamed("3001849") || castedSpellInven.hasNamed("3001850")
	 || castedSpellInven.hasNamed("3001851") || castedSpellInven.hasNamed("3001852")
	 || castedSpellInven.hasNamed("3001853") || castedSpellInven.hasNamed("3001854")
	 || castedSpellInven.hasNamed("3001855") || castedSpellInven.hasNamed("3001856")
	 || castedSpellInven.hasNamed("3001857") || castedSpellInven.hasNamed("3001858")
	 || castedSpellInven.hasNamed("3001859") || castedSpellInven.hasNamed("3001860")
	 || castedSpellInven.hasNamed("3001861") || castedSpellInven.hasNamed("3001862")
	 || castedSpellInven.hasNamed("3001863") || castedSpellInven.hasNamed("3001864")
	 || castedSpellInven.hasNamed("3001865") || castedSpellInven.hasNamed("3001866")
	 || castedSpellInven.hasNamed("3001894"))
	{
		trigger.message(TEXT_USABLEITEM_COOKS_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	if(Type == "1")
	{
		UseSkill(trigger,"3001835", 300);
	}
	else if(Type == "2")
	{
		UseSkill(trigger,"3001836", 300);
	}
	else if(Type == "3")
	{
		UseSkill(trigger,"3001837", 300);
	}
	else if(Type == "4")
	{
		UseSkill(trigger,"3001838", 300);
	}
	else if(Type == "5")
	{
		UseSkill(trigger,"3001839", 300);
	}
	else if(Type == "6")
	{
		UseSkill(trigger,"3001840", 300);
	}
	else if(Type == "7")
	{
		UseSkill(trigger,"3001841", 300);
	}
	else if(Type == "8")
	{
		UseSkill(trigger,"3001842", 300);
	}
	else if(Type == "9")
	{
		UseSkill(trigger,"3001843", 300);
	}
	else if(Type == "10")
	{
		UseSkill(trigger,"3001844", 300);
	}
	else if(Type == "11")
	{
		UseSkill(trigger,"3001845", 300);
	}
	else if(Type == "12")
	{
		UseSkill(trigger,"3001846", 300);
	}
	else if(Type == "13")
	{
		UseSkill(trigger,"3001847", 300);
	}
	else if(Type == "14")
	{
		UseSkill(trigger,"3001848", 300);
	}
	else if(Type == "15")
	{
		UseSkill(trigger,"3001849", 300);
	}
	else if(Type == "16")
	{
		UseSkill(trigger,"3001850", 300);
	}
	else if(Type == "17")
	{
		UseSkill(trigger,"3001851", 300);
	}
	else if(Type == "18")
	{
		UseSkill(trigger,"3001852", 300);
	}
	else if(Type == "19")
	{
		UseSkill(trigger,"3001853", 300);
	}
	else if(Type == "20")
	{
		UseSkill(trigger,"3001854", 300);
	}
	else if(Type == "21")
	{
		UseSkill(trigger,"3001855", 300);
	}
	else if(Type == "22")
	{
		UseSkill(trigger,"3001856", 300);
	}
	else if(Type == "23")
	{
		UseSkill(trigger,"3001857", 300);
	}
	else if(Type == "24")
	{
		UseSkill(trigger,"3001858", 300);
	}
	else if(Type == "25")
	{
		UseSkill(trigger,"3001859", 300);
	}
	else if(Type == "26")
	{
		UseSkill(trigger,"3001860", 300);
	}
	else if(Type == "27")
	{
		UseSkill(trigger,"3001861", 300);
	}
	else if(Type == "28")
	{
		UseSkill(trigger,"3001862", 300);
	}
	else if(Type == "29")
	{
		UseSkill(trigger,"3001863", 300);
	}
	else if(Type == "30")
	{
		UseSkill(trigger,"3001864", 300);
	}
	else if(Type == "31")
	{
		UseSkill(trigger,"3001865", 300);
	}
	else if(Type == "32")
	{
		UseSkill(trigger,"3001866", 300);
	}
	else if(Type == "33")
	{
		UseSkill(trigger,"3001867", 300);
	}
	return;
}

quest
qUseItem1003902()		// ∫π¡÷∏”¥œ (¡ﬂ±π º≥≥Ø ¿Ã∫•∆ÆøÎ)
{
	object rank;
	integer iMaxNum, iCount, iRandom;
	string strRankName, strUserName;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}
	if(Util.getRealNationType() == KOREA)
	{
		return;
	}

	iRandom = Util.random(1, 1000);

	strUserName = trigger.getName();

	if(iRandom == 1)	 // 1000991	»´ø∞Ω¥¡Ó 1/1000
	{
		strRankName = "NEWYEAR_EVENT1_ITEM";
		rank = Rank.select(strRankName);
		iCount = rank.getCount();
		iMaxNum = 1;

		if(iMaxNum > iCount) //¡ˆ±ﬁ ∞°¥… ¿œ∂ß
		{
			trigger.addItemClassNamed("1000991", 1);
			rank.add(strUserName,0, 0, 0, trigger.getBirthTime(), "null");
		}
		else	// ≤Œ¿∫ ¡∏¿Á«œ¡ˆ æ ¿∏π«∑Œ ∞°¿Â ∏π¿Ã ≥™ø¿¥¬ 1001808 ¿Œ≈©∏≥∆Æ Ω∫≈©∑— ¡ˆ±ﬁ
		{
			trigger.addItemClassNamed("1001808", 1);
		}
	}
	else if(iRandom <= 2)	// 1000990	»´ø∞∆»¬Ó 1/1000
	{
		strRankName = "NEWYEAR_EVENT2_ITEM";
		rank = Rank.select(strRankName);
		iCount = rank.getCount();
		iMaxNum = 3;

		if(iMaxNum > iCount) // ¡ˆ±ﬁ ∞°¥… ¿œ∂ß
		{
			trigger.addItemClassNamed("1000990", 1);
			rank.add(strUserName,0, 0, 0, trigger.getBirthTime(), "null");
		}
		else	// ≤Œ¿∫ ¡∏¿Á«œ¡ˆ æ ¿∏π«∑Œ 1001808 ¿Œ≈©∏≥∆Æ Ω∫≈©∑— ¡ˆ±ﬁ
		{
			trigger.addItemClassNamed("1001808", 1);
		}
	}
	else if(iRandom <= 3)	// 1000988	»´ø∞≥Ø∞≥ 1/1000
	{
		strRankName = "NEWYEAR_EVENT3_ITEM";
		rank = Rank.select(strRankName);
		iCount = rank.getCount();
		iMaxNum = 1;

		if(iMaxNum > iCount) // ¡ˆ±ﬁ ∞°¥… ¿œ∂ß
		{
			trigger.addItemClassNamed("1000988", 1);
			rank.add(strUserName,0, 0, 0, trigger.getBirthTime(), "null");
		}
		else	// ≤Œ¿∫ ¡∏¿Á«œ¡ˆ æ ¿∏π«∑Œ 1001808 ¿Œ≈©∏≥∆Æ Ω∫≈©∑— ¡ˆ±ﬁ
		{
			trigger.addItemClassNamed("1001808", 1);
		}
	}
	else if(iRandom <= 4)	// 1000989	»´ø∞∞©ø  1/1000
	{
		strRankName = "NEWYEAR_EVENT4_ITEM";
		rank = Rank.select(strRankName);
		iCount = rank.getCount();
		iMaxNum = 3;

		if(iMaxNum > iCount) // ¡ˆ±ﬁ ∞°¥… ¿œ∂ß
		{
			trigger.addItemClassNamed("1000989", 1);
			rank.add(strUserName,0, 0, 0, trigger.getBirthTime(), "null");
		}
		else	// ≤Œ¿∫ ¡∏¿Á«œ¡ˆ æ ¿∏π«∑Œ 1001808 ¿Œ≈©∏≥∆Æ Ω∫≈©∑— ¡ˆ±ﬁ
		{
			trigger.addItemClassNamed("1001808", 1);
		}
	}
	else if(iRandom <= 5)	// 1000987	»´ø∞≈ı±∏ 1/1000
	{
		strRankName = "NEWYEAR_EVENT5_ITEM";
		rank = Rank.select(strRankName);
		iCount = rank.getCount();
		iMaxNum = 3;

		if(iMaxNum > iCount) // ¡ˆ±ﬁ ∞°¥… ¿œ∂ß
		{
			trigger.addItemClassNamed("1000987", 1);
			rank.add(strUserName,0, 0, 0, trigger.getBirthTime(), "null");
		}
		else	// ≤Œ¿∫ ¡∏¿Á«œ¡ˆ æ ¿∏π«∑Œ 1001808 ¿Œ≈©∏≥∆Æ Ω∫≈©∑— ¡ˆ±ﬁ
		{
			trigger.addItemClassNamed("1001808", 1);
		}
	}
	else if(iRandom <= 30)	// 1000115	≥◊¿Ÿ ≈©∑Œπˆ 25/1000
	{
		trigger.addItemClassNamed("1000115", 1);
	}
	else if(iRandom <= 50)	// 1001807	øµ»• ¡§»≠ºÆ 20/1000
	{
		trigger.addItemClassNamed("1001807", 1);
	}
	else if(iRandom <= 100)	// 1000093	º˝µπ 50/1000
	{
		trigger.addItemClassNamed("1000093", 1);
	}
	else if(iRandom <= 150)	// 1000094	±◊∂Û¿Œ¥ı 50/1000
	{
		trigger.addItemClassNamed("1000094", 1);
	}
	else if(iRandom <= 200)	// 1000097	≈∫º∫ ∑Œº«(¥Î) 50/1000
	{
		trigger.addItemClassNamed("1000097", 1);
	}
	else if(iRandom <= 250)	// 1000100	∏∂∑¬∞≠»≠¡¶(¥Î) 50/1000
	{
		trigger.addItemClassNamed("1000100", 1);
	}
	else if(iRandom <= 300)	// 1000103	ø©Ω≈¿« ∞°»£ 50/1000
	{
		trigger.addItemClassNamed("1000103", 1);
	}
	else if(iRandom <= 600)	// 1001808	¿Œ≈©∏≥∆Æ Ω∫≈©∑— 300/1000
	{
		trigger.addItemClassNamed("1001808", 1);
	}
	else if(iRandom <= 1000)// 1000033	888 SEED 400/1000
	{
		trigger.setBalance(trigger.getBalance() + 888);
	}

	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	controller.effectBy(trigger);
}

quest
qUseItem1004270()		// ¿€¿∫ ∫π¡÷∏”¥œ (º≥≥Ø ¿Ã∫•∆ÆøÎ)
{
	integer iRandom;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	iRandom = Util.random(1, 1000);

	if(iRandom <= 50)	// 1000038	∏Æ¿˙∑∫º« ∆˜º«(º“) 5/100
	{
		trigger.addItemClassNamed("1000038", 1);
	}
	else if(iRandom <= 100)	// 1000052	∏∏∫¥ ≈Îƒ°æ‡ 5/100
	{
		trigger.addItemClassNamed("1000052", 1);
	}
	else if(iRandom <= 150)	// 1000019	∂Û¿Ã«¡ ∆˜º«(º“) 5/100
	{
		trigger.addItemClassNamed("1000019", 1);
	}
	else if(iRandom <= 250)	// 1000017	»˙∏µ∆˜º«(¡ﬂ) 10/100
	{
		trigger.addItemClassNamed("1000017", 1);
	}
	else if(iRandom <= 400)	// 1000036	∏ÆπŸ¿Ã∫Í ∆ƒøÏ¥ı 15/100
	{
		trigger.addItemClassNamed("1000036", 1);
	}
	else if(iRandom <= 600)	// 1000026	≈∞¿ß¡÷Ω∫ 20/100
	{
		trigger.addItemClassNamed("1000026", 1);
	}
	else if(iRandom <= 800)	// 1000043	«ÿµ∂¡¶ 20/100
	{
		trigger.addItemClassNamed("1000043", 1);
	}
	else if(iRandom <= 1000)// 1000035	πŸ¿Ãø√∑ø «„∫Í 20/100
	{
		trigger.addItemClassNamed("1000035", 1);
	}

	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	controller.effectBy(trigger);
}

quest
qUseItem1004269()		// ≈´ ∫π¡÷∏”¥œ (º≥≥Ø ¿Ã∫•∆ÆøÎ)
{
	integer iRandom;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	iRandom = Util.random(1, 1000);

	if(iRandom <= 10)	// 1001808	¿Œ≈©∏≥∆Æ Ω∫≈©∑— 1/100
	{
		trigger.addItemClassNamed("1001808", 1);
	}
	else if(iRandom <= 100)	// 1001894	¿˚¡ﬂ¿« «™µ˘ 9/100
	{
		trigger.addItemClassNamed("1001894", 1);
	}
	else if(iRandom <= 190)	// 1001893	√‡∫π¿« º∫ºˆ 9/100
	{
		trigger.addItemClassNamed("1001893", 1);
	}
	else if(iRandom <= 280)	// 1001890	¡˙«≥¿« æ‡√  9/100
	{
		trigger.addItemClassNamed("1001890", 1);
	}
	else if(iRandom <= 370)	// 1001889	Ω≈º”¿« ø≠∏≈ 9/100
	{
		trigger.addItemClassNamed("1001889", 1);
	}
	else if(iRandom <= 580)	// 1000028	∏∂≥™ ∆˜º«(¡ﬂ) 21/100
	{
		trigger.addItemClassNamed("1000028", 5);
	}
	else if(iRandom <= 790)	// 1000017	»˙∏µ ∆˜º«(¡ﬂ) 21/100
	{
		trigger.addItemClassNamed("1000017", 5);
	}
	else if(iRandom <= 1000)// 1001003	Ω∫≈◊πÃ≥  ∆˜º«(¡ﬂ) 21/100
	{
		trigger.addItemClassNamed("1001003", 5);
	}

	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	controller.effectBy(trigger);
}

quest
qUseItem1004289()	// ∑Á∏∏Æ ∆ØªÍ ∆˜º«(º“)
{
	if (!NormalItemCanBeUsed()) return;

	// hp 250 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 250)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 250)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 250);
	}

	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1004290()	// ∑Á∏∏Æ ∆ØªÍ ∆˜º«(¡ﬂ)
{
	if (!NormalItemCanBeUsed()) return;

	// hp 400 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 400)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 400)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 400);
	}
	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1004291()	// ∑Á∏∏Æ ∆ØªÍ ∆˜º«(¥Î)
{
	if (!NormalItemCanBeUsed()) return;

	// hp 600 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 600)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 600)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 600);
	}

	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1004292()	// ∑Á∏∏Æ ∆ØªÍ ∆˜º«(∆Ø)
{
	if (!NormalItemCanBeUsed()) return;

	// hp 1000 »∏∫π
	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING))
	{
		if (!HardCode.itemDownHP(trigger, 1000)) return;
	}
	else
	{
		if (!HardCode.itemUpHP(trigger, 1000)) return;

		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, 1000);
	}

	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1004293()	// »∞∑¬ ∆˜º« (º“)
{
	integer maxSP;
	if (!NormalItemCanBeUsed()) return;

	maxSP = trigger.getMaxSP();
	maxSP = (maxSP / 100) * 10;

	// SP 10% »∏∫π
	if (!ItemUpSP(trigger, maxSP)) return;

	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1004294()	// »∞∑¬ ∆˜º« (¡ﬂ)
{
	integer maxSP;
	if (!NormalItemCanBeUsed()) return;

	maxSP = trigger.getMaxSP();
	maxSP = (maxSP / 100) * 20;

	// SP 20% »∏∫π
	if (!ItemUpSP(trigger, maxSP)) return;

	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

quest
qUseItem1004295()	// »∞∑¬ ∆˜º« (¥Î)
{
	integer maxSP;
	if (!NormalItemCanBeUsed()) return;

	maxSP = trigger.getMaxSP();
	maxSP = (maxSP / 100) * 30;

	// SP 30% »∏∫π
	if (!ItemUpSP(trigger, maxSP)) return;

	// decrease number
	if (controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}


quest
qUseItemFLAG() 				// ∑ŒΩ¥ 1»£ ∆˜º« ±ÍπﬂªØ±‚ ¿¸øÎ ø∞∞°∆«
{
	integer value;

	if (!FlagCastle.getObject(trigger.getWorld().getCastleNumber())) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	if (!NormalItemCanBeUsed()) return;

	// HP 140~240 ªÛΩ¬ (π¸¿ß ∞™)
	value = Util.random(140, 240);

	if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
		if (!HardCode.itemDownHP(trigger, value)) return;
	} else if (!HardCode.itemUpHP(trigger, value)) {
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
			ItemBalloonUpHP(trigger, value);
	}
	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	controller.effectBy(trigger);
}

// 2005. 04. 19 ¡∂¡¶ æ∆¿Ã≈€ by Han

quest
qUseItem1004455()		// æœ»Ê∏∂π˝ ¡ﬂ»≠¡¶ (¿˙¡÷, ¡ﬂµ∂, æœ»Ê, æµ•µÂ, π∞∏ÆπÊæÓ æ‡»≠)
{
	object castedSpellInven;

	if(!NormalItemCanBeUsed()) return;

	castedSpellInven = trigger.getCastedSpellInventory();

	if(castedSpellInven.hasNamed("3000190") || castedSpellInven.hasNamed("3000198") || castedSpellInven.hasNamed("3000199") ||
	   castedSpellInven.hasNamed("3000201") || castedSpellInven.hasNamed("3000233") || castedSpellInven.hasNamed("3000898") ||
	   castedSpellInven.hasNamed("3000899") || castedSpellInven.hasNamed("3000896") || castedSpellInven.hasNamed("3000900") ||
	   castedSpellInven.hasNamed("3000903"))
	{
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

		// finalize
		if(castedSpellInven.hasNamed("3000190"))
			castedSpellInven.finalizeNamed("3000190");
		if(castedSpellInven.hasNamed("3000198"))
			castedSpellInven.finalizeNamed("3000198");
		if(castedSpellInven.hasNamed("3000199"))
			castedSpellInven.finalizeNamed("3000199");
		if(castedSpellInven.hasNamed("3000201"))
			castedSpellInven.finalizeNamed("3000201");
		if(castedSpellInven.hasNamed("3000233"))
			castedSpellInven.finalizeNamed("3000233");
		if(castedSpellInven.hasNamed("3000898"))
			castedSpellInven.finalizeNamed("3000898");
		if(castedSpellInven.hasNamed("3000899"))
			castedSpellInven.finalizeNamed("3000899");
		if(castedSpellInven.hasNamed("3000896"))
			castedSpellInven.finalizeNamed("3000896");
		if(castedSpellInven.hasNamed("3000900"))
			castedSpellInven.finalizeNamed("3000900");
		if(castedSpellInven.hasNamed("3000903"))
			castedSpellInven.finalizeNamed("3000903");

		// send using effect
		controller.effectBy(trigger);
	}
}

quest
qUseItem1006424()		// ¡§»≠¿« ∆˜º«(º“)
{
	object castedSpellInven;

	castedSpellInven = trigger.getCastedSpellInventory();

	if(!NormalItemCanBeUsed()) return;

	if(castedSpellInven.hasNamed("3000072") || castedSpellInven.hasNamed("3000899") || castedSpellInven.hasNamed("3001106") ||
	   castedSpellInven.hasNamed("3001604") || castedSpellInven.hasNamed("3000198") )
	{
		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);

			// finalize
			if(castedSpellInven.hasNamed("3000072"))
				castedSpellInven.finalizeNamed("3000072");
			if(castedSpellInven.hasNamed("3000899"))
				castedSpellInven.finalizeNamed("3000899");
			if(castedSpellInven.hasNamed("3001106"))
				castedSpellInven.finalizeNamed("3001106");
			if(castedSpellInven.hasNamed("3001604"))
				castedSpellInven.finalizeNamed("3001604");
			if(castedSpellInven.hasNamed("3000198"))
				castedSpellInven.finalizeNamed("3000198");
		

		// send using effect
		controller.effectBy(trigger);
	}
	else
	{
		trigger.message(TEXT_UNUSABLEITEM_CLEANUP_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
}



quest
qUseItem1004462_wait()
{
	trigger.message(TEXT_USABLEITEM_CANT_TIMEPA + "20" + TEXT_USABLEITEM_CANT_TIMEPB, MSG_TYPE__SYSTEM);
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	Machine.setSavable();

	// 20∫–∞£ ±‚¥Ÿ∏≤
   	// Event.timedWaitFor(EVENT_GET, 1200);
	Util.sleep(1200);
	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qUseItem1004462()		// ∞¢º∫¿« ∫Òæ‡ (πˆº≠≈© ªÛ≈¬ 5∫–∞£ ¡ˆº”)
{
	if(!NormalItemCanBeUsed()) return;

	if (trigger.hasQuest("qUseItem1004462_wait")) {
		trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
		return;
	}

	if (UseSkill(trigger,"3000990",300))
		trigger.giveQuestTo("qUseItem1004462_wait", trigger, null);
}


quest
qUseItem1004473()				// æ∆¿Ã≈€ ¡¶∞≈øÎ. »ﬁ¡ˆ≈Î.
{
    /*
	object item;
	string iName;

	if (!NormalItemCanBeUsed()) return;
	return;					// vahma - disable waste tray for japan setting

	trigger.message(TEXT_USABLEITEM_WILL_BREAK, MSG_TYPE__SYSTEM);
	item = controller.getObjectArgumentAt(0);
	// ¿Ø¿˙ªÛ¡° ø√∂Û∞£ æ∆¿Ã≈€¿Œ¡ˆ √º≈©
	if (item == null) return;

	if (item.isLocked()) {
		trigger.message(TEXT_USABLEITEM_CANT_LOCKED, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getBuilderType() >= 1 && trigger.getBuilderType() <=5) {
		iName = Item.getDescClassNamed(item.getClassName());
		item.sweepNumbered(1);
		trigger.message(TEXT_USABLEITEM_BREAK_CPL + iName, MSG_TYPE__SYSTEM);
		controller.effectBy(trigger);

	} else {
		if (item.isCashItem()) {
			trigger.message(TEXT_CASHITEM_NOT_USE, MSG_TYPE__SYSTEM);
			return;
		}

		iName = Item.getDescClassNamed(item.getClassName());
		item.sweepNumbered(1);	// π¯µÈ ø©∫Œ √º≈© « ø‰... ¿œ¥‹ ≥Ø∏Æ¿⁄.

		trigger.message(TEXT_USABLEITEM_BREAK_CPL + iName, MSG_TYPE__SYSTEM);
		controller.effectBy(trigger);

		// decrease number
		if (controller.canBeExhausted())
			controller.decreaseNumber(1);
	}
    */		// vahma - japan setting
}

quest
qUseItem1003887()		// vahma - for pet test
{
    object a;

    a = trigger.getPetInventory();
    a.setSanitation(100);
    trigger.message("Set Sanitation : 1%", MSG_TYPE__SYSTEM);
    a.setNutrition(100);
    trigger.message("Set Nutrition : 1%", MSG_TYPE__SYSTEM);
}

quest
qUseItem1004509()			// »Ò∏¡ ªÛ¿⁄ (2005 6ø˘ ¿Ã∫•∆Æ by Han)
{
	object rank;
	integer rval, mx, my;
//	integer tickTime;
	integer wNum, rCount, iBirth, rand;

	string userName;

//	tickTime = Util.getTick();
	userName = trigger.getName();

	mx =  trigger.getX();
	my =  trigger.getY();

/*
	// 2005≥‚ 6ø˘ 3¿œ ~ 6ø˘ 10¿œ±Ó¡ˆ ¡¯«‡ ∞°¥…
	if (Util.getYear(tickTime) != 2005)	{
		trigger.message(TEXT_JUNE_EVENT_END, MSG_TYPE__SYSTEM);
		return;
	} else if (Util.getMonth(tickTime) != 6) {
		trigger.message(TEXT_JUNE_EVENT_END, MSG_TYPE__SYSTEM);
		return;
	} else if (Util.getDay(tickTime) > 10) {
		trigger.message(TEXT_JUNE_EVENT_END, MSG_TYPE__SYSTEM);
		return;
	}
*/

	// ΩŒøÚ ∞°¥… ¡ˆø™¿Ã æ∆¥— ∞ÊøÏ √º≈©¡Ó
	if(!trigger.getWorld().canFight()) {
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
    	return;
	}

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// √ ∫∏¿⁄ ¥¯¿¸ø°º≠ ªÁøÎ ∫“∞°¥…
	if (wNum == 422 || wNum == 423 || wNum == 424)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ≈©∂Û¿Ãµß 1, 7, ∆‰≥™¿Œ Ω£ 4
	if(wNum == 4 || wNum == 10 || wNum == 85)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ºøπŸΩ∫ ∆Úø¯ 1, 6, 7, 8
	if(wNum == 67 || wNum == 19 || wNum == 20 || wNum == 21)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ±Ê¿Ã ¡º¿∫ ø¨∞·≈Î ∏ 
	if(wNum == 91 || wNum == 92 || wNum == 48 || wNum == 51 || wNum == 114 || wNum == 124)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return;
	}

	// ΩΩ∑‘ √º≈©
    if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
    }

	// π´∞‘ √º≈©
	// ¡¶∞¯ æ∆¿Ã≈€¿« √÷¥Î π´∞‘∑Œ º≥¡§
    if (trigger.getAvailInvenWeight() < 100) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
    }

	rval = Util.random(1, 1000);

	iBirth = trigger.getBirthTime();

	// 5%	≈©≥Î«Ó(»•∂ıµø±º9√˛)
	if(rval >= 950)
	{
		trigger.getWorld().genMonster("2100026", 1, "twKnohen.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 5%	æ÷ΩØ∆Æ
	else if(rval >= 900)
	{
		trigger.getWorld().genMonster("2100588", 1, "twCH10_EChimera.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 12%	∫Ì∑Øµµπ
	else if(rval >= 780)
	{
		trigger.getWorld().genMonster("2100221", 1, "twMechanic.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 12%	»Ê∂˚
	else if(rval >= 660)
	{
		trigger.getWorld().genMonster("2100578", 1, "twApr14_HadesEnvoy.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 12%	µ∂∞¢±Õ
	else if(rval >= 540)
	{
		trigger.getWorld().genMonster("2100593", 1, "twMay18_DoggaebiBoss.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// 12%	±›∑…Ω√
	else if(rval >= 420)
	{
		trigger.getWorld().genMonster("2100596", 1, "twMay23_KangSheeBoss.ptn", 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}
	// ***********************************************************************************************
	// ø©±‚º≠∫Œ≈Õ æ∆¿Ã≈€~
	// ***********************************************************************************************
	// 5%	∫˘«—ºº∆Æ
	else if(rval >= 370)
	{
		rank = Rank.select("KOR_JUNE_ITEM1");
		rCount = rank.getCount();

		rand = Util.random(0,4);

		if(rCount < 5)
	   	{
	   		if(rand == 0)			// 1%	∫˘«—¿« ≈ı±∏
	   		{
				rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1000992", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			}
			else if (rand == 1)		// 1%	∫˘«—¿« ≥Ø∞≥
			{
				rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1000993", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			}
			else if (rand == 2)		// 1%	∫˘«—¿« ∞©ø 
			{
				rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1000994", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			}
			else if (rand == 3)		// 1%	∫˘«—¿« ∆»¬Ó
			{
				rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1000995", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			}
			else					// 1%	∫˘«—¿« Ω¥¡Ó
			{
				rank.add(userName, 0, 0, 0, iBirth, "null");
				trigger.addItemClassNamed("1000996", 1);
				trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
			}
		}
		else
		{
			trigger.addItemClassNamed("1000033", 1);
			trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
		}
	}
	// 1%	∏ﬁƒ´±Õ
	else if(rval >= 360)
	{
		trigger.addItemClassNamed("1002903", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
	}
	// 1%	ª°∞≠º±±€∂ÛΩ∫
	else if(rval >= 350)
	{
		trigger.addItemClassNamed("1002904", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
	}
	// 1%	ƒ⁄∞…¿Ãæ»∞Ê
	else if(rval >= 340)
	{
		trigger.addItemClassNamed("1002905", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM_COOL, trigger);
	}
	// 1%	æ»¥Î
	else if(rval >= 330)
	{
		trigger.addItemClassNamed("1002906", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1%	±´µµZ∞°∏È
	else if(rval >= 320)
	{
		trigger.addItemClassNamed("1002907", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1%	∏∂µµªÁ¿« ∏Æ∫ª
	else if(rval >= 310)
	{
		trigger.addItemClassNamed("1002908", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1%	¿ÂΩƒøÎ ≥™πµ∞°¡ˆ
	else if(rval >= 300)
	{
		trigger.addItemClassNamed("1002909", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1%	ª°∞£∏”«√∑Ø
	else if(rval >= 290)
	{
		trigger.addItemClassNamed("1002910", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1%	≥Ø∞≥±Õ
	else if(rval >= 280)
	{
		trigger.addItemClassNamed("1002921", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1%	¡“æ»µŒ∞«
	else if(rval >= 270)
	{
		trigger.addItemClassNamed("1002922", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1%	ª˛≈©πŸ∏ÆµŒ∞«
	else if(rval >= 260)
	{
		trigger.addItemClassNamed("1002923", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 1%	π÷π÷
	else if(rval >= 250)
	{
		trigger.addItemClassNamed("1002924", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	
	// 5%	ª˝∏Ì¿« ¡∂∞¢ 5∞≥
	else if(rval >= 200)
	{
		trigger.addItemClassNamed("1000022", 5);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 5%	∏∂≥™¿« ∞·¡§ 5∞≥
	else if(rval >= 150)
	{
		trigger.addItemClassNamed("1000033", 5);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 5%	±´∑¬¿« «‹
	else if(rval >= 100)
	{
		trigger.addItemClassNamed("1001892", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 5%	√‡∫π¿« º∫ºˆ
	else if(rval >= 50)
	{
		trigger.addItemClassNamed("1001893", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	// 5%	∏ÆΩ∫≈‰æÓºº∆Æ
	else
	{
		trigger.addItemClassNamed("1000085", 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
}

quest
qUseItem1004622()				// ¥Î∏∏ πﬂ∑ª≈∏¿Œ ¿Ã∫•∆Æ ªÛ¿⁄ (2005.07.20 by Han)
{
	string itemID = "";
	integer selection;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection = Util.random(1, 99);

	if (selection <= 33) {			// Caribou hat
		itemID	= "1004623";
	} else if (selection <= 66) {		// Whale hat
		itemID	= "1004624";
	} else if (selection <= 99) {		// Shark hat
		itemID	= "1004625";
	}

	// æ∆¿Ã≈€¿ª ¡ÿ¥Ÿ.
	if (itemID != "") trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}


// 2005.12.07 ≈©∏ÆΩ∫∏∂Ω∫ ¿Ã∫•∆Æ ¡ˆ±ﬁ º∫≥…
quest qUseItem1004771()
{
	if (!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 50) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getRandomItem(13))		// vahma - japan setting
	{
		// decrease number
		if (controller.canBeExhausted()) {
			controller.decreaseNumber(1);
		}

		// send using effect
		controller.effectBy(trigger);
	}
	else
	{
		trigger.message(TEXT_USABLEITEM_NOT_GET, MSG_TYPE__SYSTEM);
		return;
	}
}

quest qUseItem1004781()		// æÀ ºˆ æ¯¥¬ æææ— (∆Æ∏Æ ¿Ã∫•∆ÆøÎ)
{
	integer randValue;

	randValue = Util.random(0,9);

	if (!NormalItemCanBeUsed()) return;

	if (randValue >= 7)
	{
		// HP 300 »∏∫π
		if (trigger.isState(CREATURE_STATE__UNDEAD) || trigger.isState(CREATURE_STATE__FOOD_POISONING)) {
			if (!HardCode.itemDownHP(trigger, 300)) return;
		} else {
			if (!HardCode.itemUpHP(trigger, 300)) return;

			// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
			if (trigger.getClassNameAtPart(EQUIP_PART__HELMET) == "1004870")
				ItemBalloonUpHP(trigger, 300);
		}
	}
	else if (randValue >= 4)
	{
		// MP 200 »∏∫π
		if (!HardCode.itemUpMP(trigger, 200)) return;
		// ≈¬±ÿ±‚ »∏∫π √≥∏Æ. ¿”Ω√
		if (trigger.getClassNameAtPart(EQUIP_PART__AACCESSORY) == "1004466")		// vahma - japan setting
			ItemBalloonUpMP(trigger, 200);
	}
	else
	{
		// SP 100 »∏∫π
		ItemUpSP(trigger, 100);
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
	// send using effect
	controller.effectBy(trigger);
}


//***************************************************************************************************

quest
qUseItem1004798()		// ∑Ø∫Í∑Ø∫Í º±π∞ºº∆Æ (πﬂ∑ª≈∏¿Œ ¿Ã∫•∆ÆøÎ)
{
	integer iRandom;
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.

	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 100) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	userName = trigger.getName();
	tickTime = Util.getTick();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	iRandom = Util.random(1, 10000);

	if(iRandom <= 10)		// 1004384	∑Ø∫Í »´ø∞¿« ≈ı±∏ 0.1%
	{
		trigger.addItemClassNamed("1004384", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004384 ] ";
	}
	else if(iRandom <= 20)		// 1004385	∑Ø∫Í »´ø∞¿« ≥Ø∞≥ 0.1%
	{
		trigger.addItemClassNamed("1004385", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004385 ] ";
	}
	else if(iRandom <= 30)		// 1004387	∑Ø∫Í »´ø∞¿« ∞©ø  0.1%
	{
		trigger.addItemClassNamed("1004387", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004387 ] ";
	}
	else if(iRandom <= 40)		// 1004389	∑Ø∫Í »´ø∞¿« ∆»¬Ó 0.1%
	{
		trigger.addItemClassNamed("1004389", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004389 ] ";
	}
	else if(iRandom <= 90)		// 1004646	∑Ø∫Í »´ø∞¿« Ω¥¡Ó 0.5%
	{
		trigger.addItemClassNamed("1004646", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004646 ] ";
	}
	else if(iRandom <= 2115)	// 1001808	Ω≈º”¿« ø≠∏≈ 20.25%
	{
		trigger.addItemClassNamed("1001808", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1001808 ] ";
	}
	else if(iRandom <= 2715)	// 1003017	∑Ø∫Í »£∂˚¿Ã ∏¿⁄ 6%
	{
		trigger.addItemClassNamed("1003017", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1003017 ] ";
	}
	else if(iRandom <= 4715)	// 1000223	¡˙«≥¿« æ‡√  20%
	{
		trigger.addItemClassNamed("1000223", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1000223 ] ";
	}
	else if(iRandom <= 5220)	// 1000144	∑Ø∫Í ≥ ±∏∏Æ ∏¿⁄ 5.05%
	{
		trigger.addItemClassNamed("1000144", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1000144 ] ";
	}
	else if(iRandom <= 7220)	// 1000222	√‡∫π¿« º∫ºˆ 20%
	{
		trigger.addItemClassNamed("1000222", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1000222 ] ";
	}
	else if(iRandom <= 7820)	// 1005062	∑Ø∫Í ≥ ±∏∏Æ ∏Òµµ∏Æ 6%
	{
		trigger.addItemClassNamed("1005062", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1005062 ] ";
	}
	else if(iRandom <= 9820)	// 1000022	¿˚¡ﬂ¿« «™µ˘ 20%
	{
		trigger.addItemClassNamed("1000022", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1000022 ] ";
	}
	else if(iRandom <= 9840)	// 1004390	∑Ø∫Í ≈•««∆Æ ≈ı±∏ 0.2%
	{
		trigger.addItemClassNamed("1004390", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004390 ] ";
	}
	else if(iRandom <= 9850)	// 1004393	∑Ø∫Í ≈•««∆Æ πÊ∆– 0.1%
	{
		trigger.addItemClassNamed("1004393", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004393 ] ";
	}
	else if(iRandom <= 9870)	// 1004388	∑Ø∫Í ≈•««∆Æ ∫Ò≥‡ 0.2%
	{
		trigger.addItemClassNamed("1004388", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004388 ] ";
	}
	else if(iRandom <= 9880)	// 1004391	∑Ø∫Í ≈•««∆Æ ≥Ø∞≥ 0.1%
	{
		trigger.addItemClassNamed("1004391", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004391 ] ";
	}
	else if(iRandom <= 9900)	// 1004386	∑Ø∫Í ≈•««∆Æ ∞©ø  0.2%
	{
		trigger.addItemClassNamed("1004386", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004386 ] ";
	}
	else if(iRandom <= 9950)	// 1004444	∑Ø∫Í ≈•««∆Æ Ω¥¡Ó 0.5%
	{
		trigger.addItemClassNamed("1004444", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1004444 ] ";
	}
	else				// 1002008	∑Ø∫Í ≈•««∆Æ ¿Â∞© 0.5%
	{
		trigger.addItemClassNamed("1002008", 1);
		Item_Info = "From Gift Certificate : +ITEM [ 1002008 ] ";
	}

	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	Util.log(time_Info + Item_Info + world_Info);

	controller.effectBy(trigger);
}

quest
qUseItem1004871()		// ∏≈≈©∑Œ ∞®¡ˆ æ∆¿Ã≈€
{
	integer wNum;

	object target;
	integer bType;

	target = controller.getObjectArgumentAt(0);

	bType = target.getBuilderType();

	if(!NormalItemCanBeUsed()) return;

	// ªÁøÎ ∫“∞°¥… ∆Ø¡§ ¡ˆø™ √º≈©
	wNum = trigger.getWorld().getNumber();

	// ΩŒøÚ∞°¥… ¡ˆø™, ¿Ã∫•∆Æø˘µÂ ªÁøÎ±›¡ˆ
	if(!trigger.getWorld().canFight() || trigger.getWorld().isEventWorld()) {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// √ ∫∏¿⁄ ¥¯¿¸ π◊ ∆©≈‰∏ÆæÛ ¥Î±‚Ω«, µµ«√∞ªæÓ Ω£ ¥Î±‚Ω«ø°º≠ ªÁøÎ ∫“∞°¥…
	if (wNum == 421 || wNum == 203 || wNum == 178 || wNum == 179 || wNum == 180)
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if (target.macroTest()) {
		// øÓøµ¿⁄ø°∞‘ ªÁøÎ±›¡ˆ
		if (bType == 1 || bType == 2 || bType == 3 || bType == 5)
			return;
		else
		{
			// decrease item
			if (controller.canBeExhausted())
				controller.decreaseNumber(1);
		}
	}
	else
	{
		trigger.message(MACRO_TEST_DISABLE, MSG_TYPE__SYSTEM);
		return;
	}
	return;
}

quest qUseItem1004970()		// ∫•æﬂπÊ ¿Ãµø æ∆¿Ã≈€
{
	object loc;

	if(!NormalItemCanBeUsed()) return;

	// ΩŒøÚ∞°¥… ¡ˆø™, ¿Ã∫•∆Æø˘µÂ ªÁøÎ±›¡ˆ
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld()) {
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	if (!trigger.getWorld().canUseCustomWarp()) {
		trigger.message(CANT_USE_TELEPORT_ITEM_SINCE_EVENTWORLD, MSG_TYPE__SYSTEM);
		return;
	}

	// controller.decreaseNumber(1);
	controller.sweepNumbered(1);

	loc = Location.create();
	loc.set(666,100,100);

	trigger.teleportTo(loc);
}

quest qUseItem1004954()		// √ ∫∏¿⁄¿« ∞°πÊ
{
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	if(!NormalItemCanBeUsed()) return;

	// ΩŒøÚ∞°¥… ¡ˆø™, ¿Ã∫•∆Æø˘µÂ ªÁøÎ±›¡ˆ
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ¿Œ∫•≈‰∏Æ π◊ π´∞‘∞° ≤À¬˚∞ÊøÏ
	if (trigger.getCarryingItemInventory().availCount() < 3 || trigger.getCarryingItemInventory().availWeight() < 300)
	{
		trigger.message(TEXT_CLAD_AVAILCOUNUT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	// øˆ«¡ µÓ∑œ±‚
	trigger.addItemClassNamed("1002814", 1);

	// ª˛≈©πŸ∏Æ Ω¥¡Ó
	trigger.addItemClassNamed("1003374", 1);
	ExpireItem("1003374", 60*60*24*30);

	// √∂∞°∏È
	trigger.addItemClassNamed("1003375", 1);
	ExpireItem("1003375", 60*60*24*30);

	Item_Info = "From Gift Certificate : +ITEM [ 1002814, 1003374, 1003375 ] ";

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	Util.log(time_Info + Item_Info + world_Info);
}

quest qUseItem1006056()			// »≠¿Ã∆√ ªÛ¿⁄ (2006 ø˘µÂƒ≈ ¿Ã∫•∆ÆøÎ)
{
	integer iRandom;
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 100) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	userName = trigger.getName();
	tickTime = Util.getTick();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	iRandom = Util.random(1, 10000);

	if(iRandom <= 10)		// 1004981	ø°««º“µÂ1 ±‚≥‰ ¿Æ 0.1%
	{
		trigger.addItemClassNamed("1004981", 1);
		trigger.message(TEXT_EXT_BOX_MSG1, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004981 ] ";
	}
	else if(iRandom <= 110)		// 1001808	¿Œ≈©∏≥∆Æ Ω∫≈©∑— 1%
	{
		trigger.addItemClassNamed("1001808", 1);
		trigger.message(TEXT_EXT_BOX_MSG2, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001808 ] ";
	}
	else if(iRandom <= 310)		// 1004056	√µªÁ 2%
	{
		trigger.addItemClassNamed("1004056", 1);

		// 7¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004056", 60*60*24*7);
		trigger.message(TEXT_EXT_BOX_MSG3, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004056 ] ";
	}
	else if(iRandom <= 510)		// 1004057	æ«∏∂ 2%
	{
		trigger.addItemClassNamed("1004057", 1);

		// 7¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004057", 60*60*24*7);
		trigger.message(TEXT_EXT_BOX_MSG4, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004057 ] ";
	}
	else if(iRandom <= 710)		// 1004059	ø‰¡§ 2%
	{
		trigger.addItemClassNamed("1004059", 1);

		// 7¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004059", 60*60*24*7);
		trigger.message(TEXT_EXT_BOX_MSG5, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004059 ] ";
	}
	else if(iRandom <= 910)		// 1004060	≈‰≥¢±Õ π–¬§ ∏¿⁄ 2%
	{
		trigger.addItemClassNamed("1004060", 1);

		// 7¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004060", 60*60*24*7);
		trigger.message(TEXT_EXT_BOX_MSG6, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004060 ] ";
	}
	else if(iRandom <= 1110)	// 1004068	∏ﬁ¿ÃµÂ 2%
	{
		trigger.addItemClassNamed("1004068", 1);

		// 7¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004068", 60*60*24*7);
		trigger.message(TEXT_EXT_BOX_MSG7, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004068 ] ";
	}
	else if(iRandom <= 1410)	// 1004079	∆ƒ∆º ∆¯¡◊ 3%
	{
		trigger.addItemClassNamed("1004079", 5);
		trigger.message(TEXT_EXT_BOX_MSG8, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004079 ] ";
	}
	else if(iRandom <= 2910)	// 1001895	»∏««¿« ƒÌ≈∞ 15%
	{
		trigger.addItemClassNamed("1001895", 1);
		trigger.message(TEXT_EXT_BOX_MSG9, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001895 ] ";
	}
	else if(iRandom <= 4410)	// 1001894	¿˚¡ﬂ¿« «™µ˘ 15%
	{
		trigger.addItemClassNamed("1001894", 1);
		trigger.message(TEXT_EXT_BOX_MSG10, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001894 ] ";
	}
	else if(iRandom <= 5910)	// 1001890	¡˙«≥¿« æ‡√  15%
	{
		trigger.addItemClassNamed("1001890", 1);
		trigger.message(TEXT_EXT_BOX_MSG11, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001890 ] ";
	}
	else if(iRandom <= 7410)	// 1000022	ª˝∏Ì¿« ∫∏ºÆ 15%
	{
		trigger.addItemClassNamed("1000022", 1);
		trigger.message(TEXT_EXT_BOX_MSG12, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000022 ] ";
	}
	else if(iRandom <= 8910)	// 1000033	∏∂≥™¿« ∞·¡§ 15%
	{
		trigger.addItemClassNamed("1000033", 1);
		trigger.message(TEXT_EXT_BOX_MSG13, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000033 ] ";
	}
	else if(iRandom <= 8960)	// 1004955	May ≥™∫Ò ∏Æ∫ª 0.5%
	{
		trigger.addItemClassNamed("1004955", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004955", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG14, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004955 ] ";
	}
	else if(iRandom <= 9010)	// 1004956	May ø§«¡ ±Õ 0.5%
	{
		trigger.addItemClassNamed("1004956", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004956", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG15, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004956 ] ";
	}
	else if(iRandom <= 9150)	// 1004957	May ±Õ∏∂∞≥ 1.4%
	{
		trigger.addItemClassNamed("1004957", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004957", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG16, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004957 ] ";
	}
	else if(iRandom <= 9250)	// 1004958	May Ω∫ƒ´øÏ≈Õ 1%
	{
		trigger.addItemClassNamed("1004958", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004958", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG17, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004958 ] ";
	}
	else if(iRandom <= 9300)	// 1004959	May ∫Ò≥‡ 0.5%
	{
		trigger.addItemClassNamed("1004959", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004959", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG18, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004959 ] ";
	}
	else if(iRandom <= 9400)	// 1004960	May ∏ﬁƒ´±Õ 1%
	{
		trigger.addItemClassNamed("1004960", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004960", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG19, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004960 ] ";
	}
	else if(iRandom <= 9450)	// 1004961	May ∏∂µµªÁ ∏Æ∫ª 0.5%
	{
		trigger.addItemClassNamed("1004961", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004961", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG20, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004961 ] ";
	}
	else if(iRandom <= 9500)	// 1004962	May ≥Ø∞≥ ±Õ 0.5%
	{
		trigger.addItemClassNamed("1004962", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004962", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG21, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004962 ] ";
	}
	else if(iRandom <= 9600)	// 1004963	May ≈Õπ¯ 1%
	{
		trigger.addItemClassNamed("1004963", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004963", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG22, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004963 ] ";
	}
	else if(iRandom <= 9800)	// 1004964	May ºÿ∫Í∑π∑Œ 2%
	{
		trigger.addItemClassNamed("1004964", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004964", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG23, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004964 ] ";
	}
	else if(iRandom <= 9850)	// 1004966	May ¡“æ»µŒ∞« 0.5%
	{
		trigger.addItemClassNamed("1004966", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004966", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG24, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004966 ] ";
	}
	else if(iRandom <= 9900)	// 1004967	May ª˛≈©πŸ∏ÆµŒ∞« 0.5%
	{
		trigger.addItemClassNamed("1004967", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004967", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG25, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004967 ] ";
	}
	else				// 1004968	May π÷π÷ 1%
	{
		trigger.addItemClassNamed("1004968", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004968", 60*60*24*30);
		trigger.message(TEXT_EXT_BOX_MSG26, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004968 ] ";
	}

	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	Util.log(time_Info + Item_Info + world_Info);
}


quest qUseItem1006081()		// «œ¥√ªˆ ªÛ¿⁄ (»ﬁ∏È¿Ø¿˙ ∫π±Õ ¿Øµµ æ∆¿Ã≈€ 2006.6.15)
{
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	if(!NormalItemCanBeUsed()) return;

	// ΩŒøÚ∞°¥… ¡ˆø™, ¿Ã∫•∆Æø˘µÂ ªÁøÎ±›¡ˆ
	if(trigger.getWorld().canFight() || trigger.getWorld().isEventWorld())
	{
		trigger.sayTo(TEXT_CASHITEM_NOT_USE_FIELD, trigger);
		return;
	}

	// ¿Œ∫•≈‰∏Æ π◊ π´∞‘∞° ≤À¬˚∞ÊøÏ
	if (trigger.getCarryingItemInventory().availCount() < 2 || trigger.getCarryingItemInventory().availWeight() < 100)
	{
		trigger.message(TEXT_CLAD_AVAILCOUNUT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	userName = trigger.getName();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	// ªß «Ô∏ß
	trigger.addItemClassNamed("1006079", 1);

	// Ω∫≈» ¿Á∫–πË Ω∫≈©∑—
	trigger.addItemClassNamed("1004510", 1);

	// º˜∑√¿« ¡ı«• (∆–Ω√∫Í æ∆¿Ã≈€ ∞Ê«Ëƒ° 1.2πË / ∑πæÓµÂ∑”∑¸ 1.1πË)
	trigger.addItemClassNamed("1006080", 1);
	ExpireItem("1006080", 60*60*24*30);

	Item_Info = "From Gift Certificate : +ITEM [ 1006079, 1006080 ] ";

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	Util.log(time_Info + Item_Info + world_Info);
}

quest qUseItem1006082()			// «Œ≈© ªÛ¿⁄ (»ﬁ∏È¿Ø¿˙ ∫π±Õ ¿Ã∫•∆ÆøÎ)
{
	integer iRandom;
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 2) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 100) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	userName = trigger.getName();
	tickTime = Util.getTick();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	iRandom = Util.random(1, 1300);

	trigger.addItemClassNamed("1004041", 1);
	trigger.message("ø‹ƒ°±‚ ª‘««∏Æ «œ¥√ªˆ 1∞≥∏¶ ¡ˆ±ﬁ«’¥œ¥Ÿ.", MSG_TYPE__SYSTEM);

	if(iRandom <= 100)		// 1006091	≈¨∑°Ωƒ ≥™∫Ò ∏Æ∫ª
	{
		trigger.addItemClassNamed("1006091", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006091", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ≥™∫Ò ∏Æ∫ª¿Ã ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006091 : ≈¨∑°Ωƒ ≥™∫Ò ∏Æ∫ª ] ";
	}
	else if(iRandom <= 200)		// 1006092	≈¨∑°Ωƒ ø§«¡ ±Õ
	{
		trigger.addItemClassNamed("1006092", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006092", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ø§«¡ ±Õ∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006092 : ≈¨∑°Ωƒ ø§«¡ ±Õ ] ";
	}
	else if(iRandom <= 300)		// 1006093	≈¨∑°Ωƒ ±Õ∏∂∞≥
	{
		trigger.addItemClassNamed("1006093", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006093", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ±Õ∏∂∞≥∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006093 : ≈¨∑°Ωƒ ±Õ∏∂∞≥ ] ";
	}
	else if(iRandom <= 400)		// 1006094	≈¨∑°Ωƒ Ω∫ƒ´øÏ≈Õ
	{
		trigger.addItemClassNamed("1006094", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006094", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ Ω∫ƒ´øÏ≈Õ∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006094 : ≈¨∑°Ωƒ Ω∫ƒ´øÏ≈Õ ] ";
	}
	else if(iRandom <= 500)		// 1006095	≈¨∑°Ωƒ ∫Ò≥‡
	{
		trigger.addItemClassNamed("1006095", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006095", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ∫Ò≥‡∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006095 : ≈¨∑°Ωƒ ∫Ò≥‡ ] ";
	}
	else if(iRandom <= 600)		// 1006096	≈¨∑°Ωƒ ∏ﬁƒ´±Õ
	{
		trigger.addItemClassNamed("1006096", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006096", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ∏ﬁƒ´±Õ∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006096 : ≈¨∑°Ωƒ ∏ﬁƒ´±Õ ] ";
	}
	else if(iRandom <= 700)		// 1006097	≈¨∑°Ωƒ ∏∂µµªÁ ∏Æ∫ª
	{
		trigger.addItemClassNamed("1006097", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006097", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ∏∂µµªÁ ∏Æ∫ª¿Ã ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006097 : ≈¨∑°Ωƒ ∏∂µµªÁ ∏Æ∫ª ] ";
	}
	else if(iRandom <= 800)		// 1006098	≈¨∑°Ωƒ ≥Ø∞≥±Õ
	{
		trigger.addItemClassNamed("1006098", 5);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006098", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ≥Ø∞≥±Õ∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006098 : ≈¨∑°Ωƒ ≥Ø∞≥±Õ ] ";
	}
	else if(iRandom <= 900)		// 1006099	≈¨∑°Ωƒ ≈Õπ¯
	{
		trigger.addItemClassNamed("1006099", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006099", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ≈Õπ¯¿Ã ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006099 : ≈¨∑°Ωƒ ≈Õπ¯ ] ";
	}
	else if(iRandom <= 1000)	// 1006100	≈¨∑°Ωƒ ºÿ∫Í∑π∑Œ
	{
		trigger.addItemClassNamed("1006100", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006100", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ºÿ∫Í∑π∑Œ∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006100 : ≈¨∑°Ωƒ ºÿ∫Í∑π∑Œ ] ";
	}
	else if(iRandom <= 1100)	// 1006101	≈¨∑°Ωƒ ¡“æ»µŒ∞«
	{
		trigger.addItemClassNamed("1006101", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006101", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ¡“æ»µŒ∞«¿Ã ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006101 : ≈¨∑°Ωƒ ¡“æ»µŒ∞« ] ";
	}
	else if(iRandom <= 1200)	// 1006102	≈¨∑°Ωƒ ª˛≈©πŸ∏ÆµŒ∞«
	{
		trigger.addItemClassNamed("1006102", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006102", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ ª˛≈©πŸ∏ÆµŒ∞«¿Ã ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006102 : ≈¨∑°Ωƒ ª˛≈©πŸ∏ÆµŒ∞« ] ";
	}
	else				// 1006103	≈¨∑°Ωƒ π÷π÷
	{
		trigger.addItemClassNamed("1006103", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006103", 60*60*24*30);
		trigger.message("«œ¥√ªˆ ªÛ¿⁄ø°º≠ ≈¨∑°Ωƒ π÷π÷¿Ã ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006103 : ≈¨∑°Ωƒ π÷π÷ ] ";
	}

	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	Util.log(time_Info + Item_Info + world_Info);
}


//***********************************************
//*** ¿€æ˜¿⁄   : stunlee                  *******
//*** ≥ªøÎ     : π∞≥Ó¿ÃøÎ«∞ªÛ¿⁄           *******
//*** ¿€º∫¿œΩ√ : 2006/07/12               *******
//***********************************************
quest qUseItem1006162()			// π∞≥Ó¿ÃøÎ«∞ªÛ¿⁄(ø©∏ß ¿Ã∫•∆ÆøÎ)
{
	integer iRandom;
	integer iRandom2;
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 2) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 200) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	userName = trigger.getName();
	tickTime = Util.getTick();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	iRandom = Util.random(1, 10000);
	iRandom2 = Util.random(1, 4400);

	if(iRandom <= 990)			// 1004978 ≤…ºˆøµ∏¿⁄ 9.9%
	{
		trigger.addItemClassNamed("1004978", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004978", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004978 : ≤…ºˆøµ∏¿⁄ ] ";
	}
	else if(iRandom <= 1980)		// 1006163 ∫Úº±±€∂ÛΩ∫ 9.9%
	{
		trigger.addItemClassNamed("1006163", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006163", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006163 : ∫Úº±±€∂ÛΩ∫ ] ";
	}
	else if(iRandom <= 2870)		// 1004980 ∑ÁΩ√æ» ∆©∫Í 8.9%
	{
		trigger.addItemClassNamed("1004980", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1004980", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∑ÁΩ√æ» ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1004980 : ∑ÁΩ√æ» ∆©∫Í ] ";
	}
	else if(iRandom <= 3760)		// 1006058 ∫∏∏ÆΩ∫ ∆©∫Í 8.9%
	{
		trigger.addItemClassNamed("1006058", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006058", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006058 : ∫∏∏ÆΩ∫ ∆©∫Í ] ";
	}
	else if(iRandom <= 4650)		// 1006059 ∏∑Ω√πŒ ∆©∫Í 8.9%
	{
		trigger.addItemClassNamed("1006059", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006059", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∏∑Ω√πŒ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006059 : ∏∑Ω√πŒ ∆©∫Í ] ";
	}
	else if(iRandom <= 5540)		// 1006060 Ω√∫ß∏∞ ∆©∫Í 8.9%
	{
		trigger.addItemClassNamed("1006060", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006060", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ Ω√∫ß∏∞ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006060 : Ω√∫ß∏∞ ∆©∫Í ] ";
	}
	else if(iRandom <= 6430)		// 1006061 ¿ÃΩ∫«… ∆©∫Í 8.9%
	{
		trigger.addItemClassNamed("1006061", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006061", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ¿ÃΩ∫«… ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006061 : ¿ÃΩ∫«… ∆©∫Í ] ";
	}
	else if(iRandom <= 7320)		// 1006062 π–∂Û ∆©∫Í 8.9%
	{
		trigger.addItemClassNamed("1006062", 5);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006062", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006062 : π–∂Û ∆©∫Í ] ";
	}
	else if(iRandom <= 8210)		// 1006063 ∆ºƒ°ø§ ∆©∫Í 8.9%
	{
		trigger.addItemClassNamed("1006063", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006063", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∆ºƒ°ø§ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006063 : ∆ºƒ°ø§ ∆©∫Í ] ";
	}
	else if(iRandom <= 9100)		// 1006064 ≥™æﬂ ∆©∫Í 8.9%
	{
		trigger.addItemClassNamed("1006064", 1);

		// 30¿œ∏∏ ªÁøÎ∞°¥…
		ExpireItem("1006064", 60*60*24*30);
		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≥™æﬂ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006064 : ≥™æﬂ ∆©∫Í ] ";
	}
	else if(iRandom <= 9110)		// 1006180 ≤…ºˆøµ∏¿⁄ 0.1%
	{
		trigger.addItemClassNamed("1006180", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006180 : ≤…ºˆøµ∏¿⁄ ] ";
	}
	else if(iRandom <= 9120)		// 1006181 ∫Úº±±€∂ÛΩ∫ 0.1%
	{
		trigger.addItemClassNamed("1006181", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006181 : ∫Úº±±€∂ÛΩ∫ ] ";
	}
	else if(iRandom <= 9130)		// 1006182 ∑˘Ω√æ» ∆©∫Í 0.1%
	{
		trigger.addItemClassNamed("1006182", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∑˘Ω√æ» ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006182 : ∑˘Ω√æ» ∆©∫Í ] ";
	}
	else if(iRandom <= 9140)		// 1006183 ∫∏∏ÆΩ∫ ∆©∫Í 0.1%
	{
		trigger.addItemClassNamed("1006183", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006183 : ∫∏∏ÆΩ∫ ∆©∫Í ] ";
	}
	else if(iRandom <= 9150)		// 1006184 ∏∑Ω√πŒ ∆©∫Í 0.1%
	{
		trigger.addItemClassNamed("1006184", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∏∑Ω√πŒ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006184 : ∏∑Ω√πŒ ∆©∫Í ] ";
	}
	else if(iRandom <= 9160)		// 1006185 Ω√∫ß∏∞ ∆©∫Í 0.1%
	{
		trigger.addItemClassNamed("1006185", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ Ω√∫ß∏∞ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006185 : Ω√∫ß∏∞ ∆©∫Í ] ";
	}
	else if(iRandom <= 9170)		// 1006186 ¿ÃΩ∫«… ∆©∫Í 0.1%
	{
		trigger.addItemClassNamed("1006186", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ¿ÃΩ∫«… ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006186 : ¿ÃΩ∫«… ∆©∫Í ] ";
	}
	else if(iRandom <= 9180)		// 1006187 π–∂Û ∆©∫Í 0.1%
	{
		trigger.addItemClassNamed("1006187", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006187 : π–∂Û ∆©∫Í ] ";
	}
	else if(iRandom <= 9190)		// 1006188 ∆ºƒ°ø§ ∆©∫Í 0.1%
	{
		trigger.addItemClassNamed("1006188", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∆ºƒ°ø§ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006188 : ∆ºƒ°ø§ ∆©∫Í ] ";
	}
	else if(iRandom <= 9200)		// 1006189 ≥™æﬂ ∆©∫Í 0.1%
	{
		trigger.addItemClassNamed("1006189", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≥™æﬂ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006189 : ≥™æﬂ ∆©∫Í ] ";
	}
	else if(iRandom <= 9300)		// 1002697 º¯∑œø  1%
	{
		trigger.addItemClassNamed("1002697", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ º¯∑œø ¿Ã ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1002697 : º¯∑œø  ] ";
	}
	else if(iRandom <= 9800)		// 1001602 ∞£∆« ø∞ªˆæ‡(≈©∏ÆΩ∫∏∂Ω∫ ∆Æ∏Æ)
	{
		trigger.addItemClassNamed("1001602", 1);

		trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∞£∆« ø∞ªˆæ‡(≈©∏ÆΩ∫∏∂Ω∫ ∆Æ∏Æ)∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001602 : ∞£∆« ø∞ªˆæ‡(≈©∏ÆΩ∫∏∂Ω∫ ∆Æ∏Æ) ] ";
	}
	else                    		// ∑£¥˝ : π∞≥Ó¿Ã øÎ«∞¡ﬂ 2∞≥
	{
		if(iRandom2 <= 100)		// ≤…ºˆøµ∏¿⁄(1004978), ∫Úº±±€∂ÛΩ∫(1006163)
		{
			trigger.addItemClassNamed("1004978", 1);
			trigger.addItemClassNamed("1006163", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004978", 60*60*24*30);
			ExpireItem("1006163", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄øÕ ∫Úº±±€∂ÛΩ∫∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004978,  1006163] ";
		}
		else if(iRandom2 <= 200)	// ≤…ºˆøµ∏¿⁄(1004978),∑ÁΩ√æ» ∆©∫Í(1004980)
		{
			trigger.addItemClassNamed("1004978", 1);
			trigger.addItemClassNamed("1004980", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004978", 60*60*24*30);
			ExpireItem("1004980", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄øÕ ∑ÁΩ√æ» ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004978, 1004980] ";
		}
		else if(iRandom2 <= 300)	// ≤…ºˆøµ∏¿⁄(1004978), ∫∏∏ÆΩ∫ ∆©∫Í(1006058)
		{
			trigger.addItemClassNamed("1004978", 1);
			trigger.addItemClassNamed("1006058", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004978", 60*60*24*30);
			ExpireItem("1006058", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄øÕ ∫∏∏ÆΩ∫ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004978, 1006058] ";
		}
		else if(iRandom2 <= 400)	// ≤…ºˆøµ∏¿⁄(1004978), ∏∑Ω√πŒ ∆©∫Í(1006059)
		{
			trigger.addItemClassNamed("1004978", 1);
			trigger.addItemClassNamed("1006059", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004978", 60*60*24*30);
			ExpireItem("1006059", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄øÕ ∏∑Ω√πŒ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004978, 1006059] ";
		}
		else if(iRandom2 <= 500)	// ≤…ºˆøµ∏¿⁄(1004978),Ω√∫ß∏∞ ∆©∫Í(1006060)
		{
			trigger.addItemClassNamed("1004978", 1);
			trigger.addItemClassNamed("1006060", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004978", 60*60*24*30);
			ExpireItem("1006060", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄øÕ Ω√∫ß∏∞ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004978, 1006060] ";
		}
		else if(iRandom2 <= 600)	// ≤…ºˆøµ∏¿⁄(1004978), ¿ÃΩ∫«… ∆©∫Í(1006061)
		{
			trigger.addItemClassNamed("1004978", 1);
			trigger.addItemClassNamed("1006061", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004978", 60*60*24*30);
			ExpireItem("1006061", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄øÕ ¿ÃΩ∫«… ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004978, 1006061] ";
		}
		else if(iRandom2 <= 700)	// ≤…ºˆøµ∏¿⁄(1004978), π–∂Û ∆©∫Í(1006062)
		{
			trigger.addItemClassNamed("1004978", 1);
			trigger.addItemClassNamed("1006062", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004978", 60*60*24*30);
			ExpireItem("1006062", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄øÕ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004978, 1006062] ";
		}
		else if(iRandom2 <= 800)	// ≤…ºˆøµ∏¿⁄(1004978), ∆ºƒ°ø§ ∆©∫Í(1006063)
		{
			trigger.addItemClassNamed("1004978", 1);
			trigger.addItemClassNamed("1006063", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004978", 60*60*24*30);
			ExpireItem("1006063", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄øÕ ∆ºƒ°ø§ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004978, 1006063] ";
		}
		else if(iRandom2 <= 900)	// ≤…ºˆøµ∏¿⁄(1004978), ≥™æﬂ ∆©∫Í(1006064)
		{
			trigger.addItemClassNamed("1004978", 1);
			trigger.addItemClassNamed("1006064", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004978", 60*60*24*30);
			ExpireItem("1006064", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ≤…ºˆøµ∏¿⁄øÕ ≥™æﬂ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004978, 1006064] ";
		}
		else if(iRandom2 <= 1000)	// ∫Úº±±€∂ÛΩ∫(1006163), ∑ÁΩ√æ» ∆©∫Í(1004980)
		{
			trigger.addItemClassNamed("1006163", 1);
			trigger.addItemClassNamed("1004980", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006163", 60*60*24*30);
			ExpireItem("1004980", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫øÕ ∑ÁΩ√æ» ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006163, 1004980] ";
		}
		else if(iRandom2 <= 1100)	// ∫Úº±±€∂ÛΩ∫(1006163), ∫∏∏ÆΩ∫ ∆©∫Í(1006058)
		{
			trigger.addItemClassNamed("1006163", 1);
			trigger.addItemClassNamed("1006058", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006163", 60*60*24*30);
			ExpireItem("1006058", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫øÕ ∫∏∏ÆΩ∫ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006163, 1006058] ";
		}
		else if(iRandom2 <= 1200)	// ∫Úº±±€∂ÛΩ∫(1006163), ∏∑Ω√πŒ ∆©∫Í(1006059)
		{
			trigger.addItemClassNamed("1006163", 1);
			trigger.addItemClassNamed("1006059", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006163", 60*60*24*30);
			ExpireItem("1006059", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫øÕ ∏∑Ω√πŒ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006163, 1006059] ";
		}
		else if(iRandom2 <= 1300)	// ∫Úº±±€∂ÛΩ∫(1006163), Ω√∫ß∏∞ ∆©∫Í(1006060)
		{
			trigger.addItemClassNamed("1006163", 1);
			trigger.addItemClassNamed("1006060", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006163", 60*60*24*30);
			ExpireItem("1006060", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫øÕ Ω√∫ß∏∞ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006163, 1006060] ";
		}
		else if(iRandom2 <= 1400)	// ∫Úº±±€∂ÛΩ∫(1006163), ¿ÃΩ∫«… ∆©∫Í(1006061)
		{
			trigger.addItemClassNamed("1006163", 1);
			trigger.addItemClassNamed("1006061", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006163", 60*60*24*30);
			ExpireItem("1006061", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫øÕ ¿ÃΩ∫«… ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006163, 1006061] ";
		}
		else if(iRandom2 <= 1500)	// ∫Úº±±€∂ÛΩ∫(1006163), π–∂Û ∆©∫Í(1006062)
		{
			trigger.addItemClassNamed("1006163", 1);
			trigger.addItemClassNamed("1006062", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006163", 60*60*24*30);
			ExpireItem("1006062", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫øÕ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006163, 1006062] ";
		}
		else if(iRandom2 <= 1600)	// ∫Úº±±€∂ÛΩ∫(1006163), ∆ºƒ°ø§ ∆©∫Í(1006063)
		{
			trigger.addItemClassNamed("1006163", 1);
			trigger.addItemClassNamed("1006063", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006163", 60*60*24*30);
			ExpireItem("1006063", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫øÕ ∆ºƒ°ø§ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006163, 1006063] ";
		}
		else if(iRandom2 <= 1700)	// ∫Úº±±€∂ÛΩ∫(1006163), ≥™æﬂ ∆©∫Í(1006064)
		{
			trigger.addItemClassNamed("1006163", 1);
			trigger.addItemClassNamed("1006064", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006163", 60*60*24*30);
			ExpireItem("1006064", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫Úº±±€∂ÛΩ∫øÕ ≥™æﬂ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006163, 1006064] ";
		}
		else if(iRandom2 <= 1800)	// ∑ÁΩ√æ» ∆©∫Í(1004980), ∫∏∏ÆΩ∫ ∆©∫Í(1006058)
		{
			trigger.addItemClassNamed("1004980", 1);
			trigger.addItemClassNamed("1006058", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004980", 60*60*24*30);
			ExpireItem("1006058", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∑ÁΩ√æ» ∆©∫ÍøÕ ∫∏∏ÆΩ∫ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004980, 1006058] ";
		}
		else if(iRandom2 <= 1900)	// ∑ÁΩ√æ» ∆©∫Í(1004980), ∏∑Ω√πŒ ∆©∫Í(1006059)
		{
			trigger.addItemClassNamed("1004980", 1);
			trigger.addItemClassNamed("1006059", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004980", 60*60*24*30);
			ExpireItem("1006059", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∑ÁΩ√æ» ∆©∫ÍøÕ ∏∑Ω√πŒ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004980, 1006059] ";
		}
		else if(iRandom2 <= 2000)	// ∑ÁΩ√æ» ∆©∫Í(1004980), Ω√∫ß∏∞ ∆©∫Í(1006060)
		{
			trigger.addItemClassNamed("1004980", 1);
			trigger.addItemClassNamed("1006060", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004980", 60*60*24*30);
			ExpireItem("1006060", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∑ÁΩ√æ» ∆©∫ÍøÕ Ω√∫ß∏∞ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004980, 1006060] ";
		}
		else if(iRandom2 <= 2100)	// ∑ÁΩ√æ» ∆©∫Í(1004980), ¿ÃΩ∫«… ∆©∫Í(1006061)
		{
			trigger.addItemClassNamed("1004980", 1);
			trigger.addItemClassNamed("1006061", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004980", 60*60*24*30);
			ExpireItem("1006061", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∑ÁΩ√æ» ∆©∫ÍøÕ ¿ÃΩ∫«… ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004980, 1006061] ";
		}
		else if(iRandom2 <= 2200)	// ∑ÁΩ√æ» ∆©∫Í(1004980), π–∂Û ∆©∫Í(1006062)
		{
			trigger.addItemClassNamed("1004980", 1);
			trigger.addItemClassNamed("1006062", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004980", 60*60*24*30);
			ExpireItem("1006062", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∑ÁΩ√æ» ∆©∫ÍøÕ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004980, 1006062] ";
		}
		else if(iRandom2 <= 2300)	// ∑ÁΩ√æ» ∆©∫Í(1004980), ∆ºƒ°ø§ ∆©∫Í(1006063)
		{
			trigger.addItemClassNamed("1004980", 1);
			trigger.addItemClassNamed("1006063", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004980", 60*60*24*30);
			ExpireItem("1006063", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∑ÁΩ√æ» ∆©∫ÍøÕ ∆ºƒ°ø§ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004980, 1006063] ";
		}
		else if(iRandom2 <= 2400)	// ∑ÁΩ√æ» ∆©∫Í(1004980), ≥™æﬂ ∆©∫Í(1006064)
		{
			trigger.addItemClassNamed("1004980", 1);
			trigger.addItemClassNamed("1006064", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1004980", 60*60*24*30);
			ExpireItem("1006064", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∑ÁΩ√æ» ∆©∫ÍøÕ ≥™æﬂ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1004980, 1006064] ";
		}
		else if(iRandom2 <= 2500)	// ∫∏∏ÆΩ∫ ∆©∫Í(1006058), ∏∑Ω√πŒ ∆©∫Í(1006059)
		{
			trigger.addItemClassNamed("1006058", 1);
			trigger.addItemClassNamed("1006059", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006058", 60*60*24*30);
			ExpireItem("1006059", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ ∏∑Ω√πŒ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006058, 1006059] ";
		}
		else if(iRandom2 <= 2600)	// ∫∏∏ÆΩ∫ ∆©∫Í(1006058), Ω√∫ß∏∞ ∆©∫Í(1006060)
		{
			trigger.addItemClassNamed("1006058", 1);
			trigger.addItemClassNamed("1006060", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006058", 60*60*24*30);
			ExpireItem("1006060", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ Ω√∫ß∏∞ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006058, 1006060] ";
		}
		else if(iRandom2 <= 2700)	// ∫∏∏ÆΩ∫ ∆©∫Í(1006058), ¿ÃΩ∫«… ∆©∫Í(1006061)
		{
			trigger.addItemClassNamed("1006058", 1);
			trigger.addItemClassNamed("1006061", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006058", 60*60*24*30);
			ExpireItem("1006061", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ ¿ÃΩ∫«… ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006058, 1006061] ";
		}
		else if(iRandom2 <= 2800)	// ∫∏∏ÆΩ∫ ∆©∫Í(1006058), π–∂Û ∆©∫Í(1006062)
		{
			trigger.addItemClassNamed("1006058", 1);
			trigger.addItemClassNamed("1006062", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006058", 60*60*24*30);
			ExpireItem("1006062", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006058, 1006062] ";
		}
		else if(iRandom2 <= 2900)	// ∫∏∏ÆΩ∫ ∆©∫Í(1006058), ∆ºƒ°ø§ ∆©∫Í(1006063)
		{
			trigger.addItemClassNamed("1006058", 1);
			trigger.addItemClassNamed("1006063", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006058", 60*60*24*30);
			ExpireItem("1006063", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ ∆ºƒ°ø§ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006058, 1006063] ";
		}
		else if(iRandom2 <= 3000)	// ∫∏∏ÆΩ∫ ∆©∫Í(1006058), ≥™æﬂ ∆©∫Í(1006064)
		{
			trigger.addItemClassNamed("1006058", 1);
			trigger.addItemClassNamed("1006064", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006058", 60*60*24*30);
			ExpireItem("1006064", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ ≥™æﬂ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006058, 1006064] ";
		}
		else if(iRandom2 <= 3100)	// ∏∑Ω√πŒ ∆©∫Í(1006059), Ω√∫ß∏∞ ∆©∫Í(1006060)
		{
			trigger.addItemClassNamed("1006059", 1);
			trigger.addItemClassNamed("1006060", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006059", 60*60*24*30);
			ExpireItem("1006060", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ Ω√∫ß∏∞ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006059, 1006060] ";
		}
		else if(iRandom2 <= 3100)	// ∏∑Ω√πŒ ∆©∫Í(1006059), ¿ÃΩ∫«… ∆©∫Í(1006061)
		{
			trigger.addItemClassNamed("1006059", 1);
			trigger.addItemClassNamed("1006061", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006059", 60*60*24*30);
			ExpireItem("1006061", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ ¿ÃΩ∫«… ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006059, 1006061] ";
		}
		else if(iRandom2 <= 3100)	// ∏∑Ω√πŒ ∆©∫Í(1006059), π–∂Û ∆©∫Í(1006062)
		{
			trigger.addItemClassNamed("1006059", 1);
			trigger.addItemClassNamed("1006062", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006059", 60*60*24*30);
			ExpireItem("1006062", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006059, 1006062] ";
		}
		else if(iRandom2 <= 3100)	// ∏∑Ω√πŒ ∆©∫Í(1006059), ∆ºƒ°ø§ ∆©∫Í(1006063)
		{
			trigger.addItemClassNamed("1006059", 1);
			trigger.addItemClassNamed("1006063", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006059", 60*60*24*30);
			ExpireItem("1006063", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ ∆ºƒ°ø§ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006059, 1006063] ";
		}
		else if(iRandom2 <= 3100)	// ∏∑Ω√πŒ ∆©∫Í(1006059), ≥™æﬂ ∆©∫Í(1006064)
		{
			trigger.addItemClassNamed("1006059", 1);
			trigger.addItemClassNamed("1006064", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006059", 60*60*24*30);
			ExpireItem("1006064", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ∫∏∏ÆΩ∫ ∆©∫ÍøÕ Ω√∫ß∏∞ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006059, 1006064] ";
		}
		else if(iRandom2 <= 3600)	// Ω√∫ß∏∞ ∆©∫Í(1006060), ¿ÃΩ∫«… ∆©∫Í(1006061)
		{
			trigger.addItemClassNamed("1006060", 1);
			trigger.addItemClassNamed("1006061", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006060", 60*60*24*30);
			ExpireItem("1006061", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ Ω√∫ß∏∞ ∆©∫ÍøÕ ¿ÃΩ∫«… ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006060, 1006061] ";
		}
		else if(iRandom2 <= 3700)	// Ω√∫ß∏∞ ∆©∫Í(1006060), π–∂Û ∆©∫Í(1006062)
		{
			trigger.addItemClassNamed("1006060", 1);
			trigger.addItemClassNamed("1006062", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006060", 60*60*24*30);
			ExpireItem("1006062", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ Ω√∫ß∏∞ ∆©∫ÍøÕ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006060, 1006062] ";
		}
		else if(iRandom2 <= 3800)	// Ω√∫ß∏∞ ∆©∫Í(1006060), ∆ºƒ°ø§ ∆©∫Í(1006063)
		{
			trigger.addItemClassNamed("1006060", 1);
			trigger.addItemClassNamed("1006063", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006060", 60*60*24*30);
			ExpireItem("1006063", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ Ω√∫ß∏∞ ∆©∫ÍøÕ ∆ºƒ°ø§ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006060, 1006063] ";
		}
		else if(iRandom2 <= 3900)	// Ω√∫ß∏∞ ∆©∫Í(1006060), ≥™æﬂ ∆©∫Í(1006064)
		{
			trigger.addItemClassNamed("1006060", 1);
			trigger.addItemClassNamed("1006064", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006060", 60*60*24*30);
			ExpireItem("1006064", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ Ω√∫ß∏∞ ∆©∫ÍøÕ ≥™æﬂ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006060, 1006064] ";
		}
		else if(iRandom2 <= 4000)	// ¿ÃΩ∫«… ∆©∫Í(1006061), π–∂Û ∆©∫Í(1006062)
		{
			trigger.addItemClassNamed("1006061", 1);
			trigger.addItemClassNamed("1006062", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006061", 60*60*24*30);
			ExpireItem("1006062", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ¿ÃΩ∫«… ∆©∫ÍøÕ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006061, 1006062] ";
		}
		else if(iRandom2 <= 4100)	// ¿ÃΩ∫«… ∆©∫Í(1006061), ∆ºƒ°ø§ ∆©∫Í(1006063)
		{
			trigger.addItemClassNamed("1006061", 1);
			trigger.addItemClassNamed("1006063", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006061", 60*60*24*30);
			ExpireItem("1006063", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ¿ÃΩ∫«… ∆©∫ÍøÕ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006061, 1006063] ";
		}
		else if(iRandom2 <= 4200)	// ¿ÃΩ∫«… ∆©∫Í(1006061), ≥™æﬂ ∆©∫Í(1006064)
		{
			trigger.addItemClassNamed("1006061", 1);
			trigger.addItemClassNamed("1006064", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006061", 60*60*24*30);
			ExpireItem("1006064", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ ¿ÃΩ∫«… ∆©∫ÍøÕ π–∂Û ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006061, 1006064] ";
		}
		else if(iRandom2 <= 4300)	// π–∂Û ∆©∫Í(1006062), ∆ºƒ°ø§ ∆©∫Í(1006063)
		{
			trigger.addItemClassNamed("1006062", 1);
			trigger.addItemClassNamed("1006063", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006062", 60*60*24*30);
			ExpireItem("1006063", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ π–∂Û ∆©∫ÍøÕ ∆ºƒ°ø§ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006062, 1006063] ";
		}
		else				// π–∂Û ∆©∫Í(1006062), ≥™æﬂ ∆©∫Í(1006064)
		{
			trigger.addItemClassNamed("1006062", 1);
			trigger.addItemClassNamed("1006064", 1);
			// 30¿œ∏∏ ªÁøÎ∞°¥…
			ExpireItem("1006062", 60*60*24*30);
			ExpireItem("1006064", 60*60*24*30);
			trigger.message("π∞≥Ó¿Ã øÎ«∞ ªÛ¿⁄ø°º≠ π–∂Û ∆©∫ÍøÕ ≥™æﬂ ∆©∫Í∞° ≥™ø‘Ω¿¥œ¥Ÿ.", MSG_TYPE__SYSTEM);
			Item_Info = "From Gift Certificate : +ITEM [ 1006062, 1006064] ";
		}
	}

	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	Util.log(time_Info + Item_Info + world_Info);
}

//***********************************************
//*** ¿€æ˜¿⁄   : stunlee                  *******
//*** ≥ªøÎ     : ≈©∏ÆΩ∫∏∂Ω∫º±π∞           *******
//*** ¿€º∫¿œΩ√ : 2006/07/12               *******
//***********************************************
quest qUseItem1006123()			// ≈©∏ÆΩ∫∏∂Ω∫º±π∞
{
	integer iRandom;
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 50) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Log Info
	userName = trigger.getName();
	tickTime = Util.getTick();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	iRandom = Util.random(1, 10000);

	if(iRandom <= 25)		// ∫Ì∑ØµÂ æœ∏¥ 1003393
	{
		trigger.addItemClassNamed("1003393", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG1, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1003393 ] ";
	}
	else if(iRandom <= 50)		// ªÁøÔæ∆∫Ò πÍµÂ 1002187
	{
		trigger.addItemClassNamed("1002187", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG2, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1002187 ] ";
	}
	else if(iRandom <= 75)		// ∂Û±◊∂˚¡Ó ∆»¬Ó 1002203
	{
		trigger.addItemClassNamed("1002203", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG3, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1002203 ] ";
	}
	else if(iRandom <= 100)		// Ω∫≈©∆Æπ´ Ω«µÂ 1003025
	{
		trigger.addItemClassNamed("1003025", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG4, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1003025 ] ";
	}
	else if(iRandom <= 125)		// ∫˘«—¿« ≈ı±∏ 1000992
	{
		trigger.addItemClassNamed("1000992", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG5, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000992 ] ";
	}
	else if(iRandom <= 150)		// ∫˘«—¿« ≥Ø∞≥ 1000993
	{
		trigger.addItemClassNamed("1000993", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG6, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000993 ] ";
	}
	else if(iRandom <= 175)		// ∫˘«—¿« ∞©ø  1000994
	{
		trigger.addItemClassNamed("1000994", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG7, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000994 ] ";
	}
	else if(iRandom <= 200)		// ∫˘«—¿« ∆»¬Ó 1000995
	{
		trigger.addItemClassNamed("1000995", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG8, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000995 ] ";
	}
	else if(iRandom <= 225)		// ∫˘«—¿« Ω¥¡Ó 1000996
	{
		trigger.addItemClassNamed("1000996", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG9, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000996 ] ";
	}
	else if(iRandom <= 1000)	// ¡˙«≥¿« æ‡√  1001890
	{
		trigger.addItemClassNamed("1001890", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG10, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001890 ] ";
	}
	else if(iRandom <= 3000)	// ∏Æ¿˙∑∫º« ∆˜º«(¥Î) 1000040
	{
		trigger.addItemClassNamed("1000040", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG11, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000040 ] ";
	}
	else if(iRandom <= 6000)	// ∏∂≥™¿« ∞·¡§ 1000033
	{
		trigger.addItemClassNamed("1000033", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG12, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000033 ] ";
	}
	else if(iRandom <= 9000)	// ª˝∏Ì¿« ¡∂∞¢ 1000022
	{
		trigger.addItemClassNamed("1000022", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG13, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000022 ] ";
	}
	else				// √µªÁ¿« ¥´π∞ 1000053
	{
		trigger.addItemClassNamed("1000053", 1);
		trigger.message(TEXT_CHRISTMAS_BOX_MSG14, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000053 ] ";
	}
	trigger.updateAttr();

	if(controller.canBeExhausted())
	{
		controller.decreaseNumber(1);
	}

	Util.log(time_Info + Item_Info + world_Info);
}

//******************************************************
// √ﬂºÆ ¿Ã∫•∆Æ ∑£¥˝ æ∆¿Ã≈€
// 2006.10.02 written by Han
//******************************************************
quest qUseItem1002339()
{
	if (!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 100) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getRandomItem(14))		// vahma - japan setting
	{
		// decrease number
		if (controller.canBeExhausted()) {
			controller.decreaseNumber(1);
		}

		// send using effect
		controller.effectBy(trigger);
	}
	else
	{
		trigger.message(TEXT_USABLEITEM_NOT_GET, MSG_TYPE__SYSTEM);
		return;
	}
}


//******************************************************
// Ω≈±‘ ¡∂¡¶ æ∆¿Ã≈€
// 2006.10.26 written by Stunlee
//******************************************************
//¡∂¡¶ 1¥‹∞Ë
quest
qMedicineUseItem1_wait()
{
	trigger.message(TEXT_USABLEITEM_CANT_TIMEPA + "3" + TEXT_USABLEITEM_CANT_TIMEPB, MSG_TYPE__SYSTEM);
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	Machine.setSavable();

	// 3∫–∞£ ±‚¥Ÿ∏≤
   	//Event.timedWaitFor(EVENT_GET, 1200);
	Util.sleep(180);
	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qMedicineUseItem2_wait()
{
	trigger.message(TEXT_USABLEITEM_CANT_TIMEPA + "4" + TEXT_USABLEITEM_CANT_TIMEPB, MSG_TYPE__SYSTEM);
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	Machine.setSavable();

	// 4∫–∞£ ±‚¥Ÿ∏≤
   	//Event.timedWaitFor(EVENT_GET, 1200);
	Util.sleep(240);
	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qMedicineUseItem3_wait()
{
	trigger.message(TEXT_USABLEITEM_CANT_TIMEPA + "5" + TEXT_USABLEITEM_CANT_TIMEPB, MSG_TYPE__SYSTEM);
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	Machine.setSavable();

	// 5∫–∞£ ±‚¥Ÿ∏≤
   	//Event.timedWaitFor(EVENT_GET, 1200);
	Util.sleep(300);
	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qMedicineUseItem4_wait()
{
	trigger.message(TEXT_USABLEITEM_CANT_TIMEPA + "5" + TEXT_USABLEITEM_CANT_TIMEPB, MSG_TYPE__SYSTEM);
	trigger.setState(CREATURE_STATE__ITEM_USE, true);

	Machine.setSavable();

	// 5∫–∞£ ±‚¥Ÿ∏≤
   	//Event.timedWaitFor(EVENT_GET, 1200);
	Util.sleep(600);
	trigger.setState(CREATURE_STATE__ITEM_USE, false);
}

quest
qMedicineUseItem()			// ¡∂¡¶ æ∆¿Ã≈€ ªÁøÎ
{
	object castedSpellInven;

	string Type = Machine.getArgAt(0);

	castedSpellInven = trigger.getCastedSpellInventory();

	if(!NormalItemCanBeUsed()) return;

	// ∫Ì∑πΩ∫ ªÁøÎ¡ﬂ¿œ ∂ß¥¬ æ∆¿Ã≈€ ªÁøÎ ∫“∞°
	if (castedSpellInven.hasNamed("3000210") || castedSpellInven.hasNamed("3000862")
	 || castedSpellInven.hasNamed("3000807") || castedSpellInven.hasNamed("3000806"))
	{
		trigger.message(TEXT_USABLEITEM_BLESSING_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (Type == "1")		// øÏ»≤ : Def¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001872")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879")
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001889") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		UseSkill(trigger,"3001868",600);
	}
	else if (Type == "2")		// »≠øÎ¥‹ : Dex¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001869") || castedSpellInven.hasNamed("3001873")
		 || castedSpellInven.hasNamed("3001876") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001891") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}
		UseSkill(trigger,"3001869",600);

	}
	else if (Type == "3")		// ∑Œæ‚ «„¥œ : MR¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001874")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001882")
		 || castedSpellInven.hasNamed("3001883") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		UseSkill(trigger,"3001870",600);

	}
	else if (Type == "4")		// Ω∫ƒÌæÀ∑ª : Stab, Hack¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001871") || castedSpellInven.hasNamed("3001875")
		 || castedSpellInven.hasNamed("3001877") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001886") || castedSpellInven.hasNamed("3001887")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		UseSkill(trigger,"3001871",600);

	}
	else if (Type == "5")		// øÏ»≤¡§¥‹ : Def¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001872")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001889") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}
		UseSkill(trigger,"3001872",600);


	}
	else if (Type == "6")		// »≠øÎ¡§¥‹ : Dex¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001869") || castedSpellInven.hasNamed("3001873")
		 || castedSpellInven.hasNamed("3001876") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001891") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}
		UseSkill(trigger,"3001873",600);

	}
	else if (Type == "7")		// ¿⁄æÁ∞≠¿Â¡¶(º“) : MR¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001874")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001882")
		 || castedSpellInven.hasNamed("3001883") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		UseSkill(trigger,"3001874",600);

	}
	else if (Type == "8")		// Ω∫ƒÌæÀ∑ª(¡§) :  Stab, Hack¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001871") || castedSpellInven.hasNamed("3001875")
		 || castedSpellInven.hasNamed("3001877") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001886") || castedSpellInven.hasNamed("3001887")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		UseSkill(trigger,"3001875",600);

	}
	else if (Type == "9")		// «≥¡§¥‹ : Dex¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001869") || castedSpellInven.hasNamed("3001873")
		 || castedSpellInven.hasNamed("3001876") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001891") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem1_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001876",600))
			trigger.giveQuestTo("qMedicineUseItem1_wait", trigger, null);

	}
	else if (Type == "10")		// »≠øÎ¥Î¥‹ : Stab, Hack¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001871") || castedSpellInven.hasNamed("3001875")
		 || castedSpellInven.hasNamed("3001877") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001886") || castedSpellInven.hasNamed("3001887")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem1_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001877",600))
			trigger.giveQuestTo("qMedicineUseItem1_wait", trigger, null);

	}
	else if (Type == "11")		// πÊæÓ¿« ∆˜º« : Def, MR¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001872")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001889")
		 || castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001874")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001881") || castedSpellInven.hasNamed("3001883")
		 || castedSpellInven.hasNamed("3001885") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem1_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001878",600))
			trigger.giveQuestTo("qMedicineUseItem1_wait", trigger, null);

	}
	else if (Type == "12")		// √Ê¿¸¿« ∆˜º«(º“) : ∏µÁ ¥…∑¬ƒ° ¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001869")
		 || castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001871")
		 || castedSpellInven.hasNamed("3001872") || castedSpellInven.hasNamed("3001873")
		 || castedSpellInven.hasNamed("3001874") || castedSpellInven.hasNamed("3001875")
		 || castedSpellInven.hasNamed("3001876") || castedSpellInven.hasNamed("3001877") 
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879")
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001882") || castedSpellInven.hasNamed("3001883")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001886") || castedSpellInven.hasNamed("3001887")
		 || castedSpellInven.hasNamed("3001888") || castedSpellInven.hasNamed("3001889") 
		 || castedSpellInven.hasNamed("3001890") || castedSpellInven.hasNamed("3001891")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem1_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001879",600))
			trigger.giveQuestTo("qMedicineUseItem1_wait", trigger, null);

	}
	else if (Type == "13")		// √Ê¿¸¿« ∆˜º«(¡ﬂ) : ∏µÁ ¥…∑¬ƒ° ¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001869")
		 || castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001871")
		 || castedSpellInven.hasNamed("3001872") || castedSpellInven.hasNamed("3001873")
		 || castedSpellInven.hasNamed("3001874") || castedSpellInven.hasNamed("3001875")
		 || castedSpellInven.hasNamed("3001876") || castedSpellInven.hasNamed("3001877") 
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879")
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001882") || castedSpellInven.hasNamed("3001883")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001886") || castedSpellInven.hasNamed("3001887")
		 || castedSpellInven.hasNamed("3001888") || castedSpellInven.hasNamed("3001889") 
		 || castedSpellInven.hasNamed("3001890") || castedSpellInven.hasNamed("3001891")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem2_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001880",600))
			trigger.giveQuestTo("qMedicineUseItem2_wait", trigger, null);

	}
	else if (Type == "14")		// πÊæÓ¿« ∆˜º« : Def¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001872")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879")
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001889") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem2_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001881",600))
			trigger.giveQuestTo("qMedicineUseItem2_wait", trigger, null);

	}
	else if (Type == "15")		// »≠øÎ¥Î»Ø¥‹ : MR¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001874")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001882")
		 || castedSpellInven.hasNamed("3001883") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem2_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001882",600))
			trigger.giveQuestTo("qMedicineUseItem2_wait", trigger, null);

	}
	else if (Type == "16")		// ∑π¡ˆΩ∫∆Æ¿« ∆˜º« : MR¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001874")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001882")
		 || castedSpellInven.hasNamed("3001883") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem3_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001883",600))
			trigger.giveQuestTo("qMedicineUseItem3_wait", trigger, null);

	}
	else if (Type == "17")		// πÊæÓ¿« ∆˜º« : Def¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001872")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879")
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001889") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem3_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001884",600))
			trigger.giveQuestTo("qMedicineUseItem3_wait", trigger, null);

	}
	else if (Type == "18")		// √Ê¿¸¿« ∆˜º« : ∏µÁ¥…∑¬ƒ° ¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001869")
		 || castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001871")
		 || castedSpellInven.hasNamed("3001872") || castedSpellInven.hasNamed("3001873")
		 || castedSpellInven.hasNamed("3001874") || castedSpellInven.hasNamed("3001875")
		 || castedSpellInven.hasNamed("3001876") || castedSpellInven.hasNamed("3001877") 
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879")
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001882") || castedSpellInven.hasNamed("3001883")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001886") || castedSpellInven.hasNamed("3001887")
		 || castedSpellInven.hasNamed("3001888") || castedSpellInven.hasNamed("3001889") 
		 || castedSpellInven.hasNamed("3001890") || castedSpellInven.hasNamed("3001891")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem3_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001885",600))
			trigger.giveQuestTo("qMedicineUseItem3_wait", trigger, null);

	}
	else if (Type == "19")		// ∞Àº˙¿« ∫Òæ‡ : Stab ¡ı∞°
	{
		// ¿ÃπÃ ªÁøÎ ¡ﬂ
		if (castedSpellInven.hasNamed("3001871") || castedSpellInven.hasNamed("3001875")
		 || castedSpellInven.hasNamed("3001877") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001886") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}
/*
		if (trigger.hasQuest("qMedicineUseItem_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001886",600))
			trigger.giveQuestTo("qMedicineUseItem_wait", trigger, null);
*/
		UseSkill(trigger,"3001886",1800);
	}
	else if (Type == "20")		// µµπ˝¿« ∫Òæ‡ : Hack ¡ı∞°
	{
		if (castedSpellInven.hasNamed("3001871") || castedSpellInven.hasNamed("3001875")
		 || castedSpellInven.hasNamed("3001877") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001887") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}
/*
		if (trigger.hasQuest("qMedicineUseItem_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001887",600))
			trigger.giveQuestTo("qMedicineUseItem_wait", trigger, null);
*/
		UseSkill(trigger,"3001887",1800);
	}
	else if (Type == "21")		// ¡ˆΩƒ¿« ∫Òæ‡ : Int ¡ı∞°
	{
		if (castedSpellInven.hasNamed("3001879") || castedSpellInven.hasNamed("3001880")
		 || castedSpellInven.hasNamed("3001885")|| castedSpellInven.hasNamed("3001888")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}
/*
		if (trigger.hasQuest("qMedicineUseItem_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001888",600))
			trigger.giveQuestTo("qMedicineUseItem_wait", trigger, null);
*/
		UseSkill(trigger,"3001888",1800);
	}
	else if (Type == "22")		// ∫∏»£¿« ∫Òæ‡ :  Def ¡ı∞°
	{
		if (castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001872")
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879")
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001889") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}
/*
		if (trigger.hasQuest("qMedicineUseItem_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001889",600))
			trigger.giveQuestTo("qMedicineUseItem_wait", trigger, null);
*/
		UseSkill(trigger,"3001889",1800);
	}
	else if (Type == "23")		// πŒ√∏¿« ∫Òæ‡ : Agi ¡ı∞°
	{
		if (castedSpellInven.hasNamed("3001879") || castedSpellInven.hasNamed("3001880")
		 || castedSpellInven.hasNamed("3001885")|| castedSpellInven.hasNamed("3001890")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}
/*
		if (trigger.hasQuest("qMedicineUseItem_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001890",600))
			trigger.giveQuestTo("qMedicineUseItem_wait", trigger, null);
*/
		UseSkill(trigger,"3001890",1800);
	}
	else if (Type == "24")		// ≈Î¬˚¿« ∫Òæ‡ : Dex ¡ı∞°
	{
		if (castedSpellInven.hasNamed("3001869") || castedSpellInven.hasNamed("3001873")
		 || castedSpellInven.hasNamed("3001876") || castedSpellInven.hasNamed("3001879") 
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001891") || castedSpellInven.hasNamed("3001893")
		 || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}
/*
		if (trigger.hasQuest("qMedicineUseItem_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001891",600))
			trigger.giveQuestTo("qMedicineUseItem_wait", trigger, null);
*/
		UseSkill(trigger,"3001891",1800);
	}
	else if (Type == "25")		// ªÁπÃº±∑…¡ˆ√º : ø√Ω∫≈› ¡ı∞°
	{
		if (castedSpellInven.hasNamed("3001835") || castedSpellInven.hasNamed("3001836")
		 || castedSpellInven.hasNamed("3001837") || castedSpellInven.hasNamed("3001838") 
		 || castedSpellInven.hasNamed("3001839") || castedSpellInven.hasNamed("3001840")
		 || castedSpellInven.hasNamed("3001841") || castedSpellInven.hasNamed("3001842")
		 || castedSpellInven.hasNamed("3001843") || castedSpellInven.hasNamed("3001844")
		 || castedSpellInven.hasNamed("3001845") || castedSpellInven.hasNamed("3001846")
		 || castedSpellInven.hasNamed("3001847") || castedSpellInven.hasNamed("3001848")
		 || castedSpellInven.hasNamed("3001849") || castedSpellInven.hasNamed("3001850")
		 || castedSpellInven.hasNamed("3001851") || castedSpellInven.hasNamed("3001852")
		 || castedSpellInven.hasNamed("3001853") || castedSpellInven.hasNamed("3001854")
		 || castedSpellInven.hasNamed("3001855") || castedSpellInven.hasNamed("3001856")
		 || castedSpellInven.hasNamed("3001857") || castedSpellInven.hasNamed("3001858")
		 || castedSpellInven.hasNamed("3001859") || castedSpellInven.hasNamed("3001860")
		 || castedSpellInven.hasNamed("3001861") || castedSpellInven.hasNamed("3001862")
		 || castedSpellInven.hasNamed("3001863") || castedSpellInven.hasNamed("3001864")
		 || castedSpellInven.hasNamed("3001865") || castedSpellInven.hasNamed("3001866")
		 || castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001869")
		 || castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001871")
		 || castedSpellInven.hasNamed("3001872") || castedSpellInven.hasNamed("3001873")
		 || castedSpellInven.hasNamed("3001874") || castedSpellInven.hasNamed("3001875")
		 || castedSpellInven.hasNamed("3001876") || castedSpellInven.hasNamed("3001877") 
		 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879")
		 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
		 || castedSpellInven.hasNamed("3001882") || castedSpellInven.hasNamed("3001883")
		 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
		 || castedSpellInven.hasNamed("3001886") || castedSpellInven.hasNamed("3001887")
		 || castedSpellInven.hasNamed("3001888") || castedSpellInven.hasNamed("3001889") 
		 || castedSpellInven.hasNamed("3001890") || castedSpellInven.hasNamed("3001891")
		 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
		{
			trigger.message(TEXT_USABLEITEM_PREPARATION_ERROR, MSG_TYPE__SYSTEM);
			return;
		}

		if (trigger.hasQuest("qMedicineUseItem4_wait")) 
		{
			trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
			return;
		}

		if (UseSkill(trigger,"3001893",300))
			trigger.giveQuestTo("qMedicineUseItem4_wait", trigger, null);

	}

	// send using effect
	controller.effectBy(trigger);
	return;
}

quest
qMedicineCookUseItem()		// ø‰∏Æ »∏∫π æ∆¿Ã≈€ ªÁøÎ
{
	object castedSpellInven;

	string Type = Machine.getArgAt(0);

	castedSpellInven = trigger.getCastedSpellInventory();

	if(!NormalItemCanBeUsed()) return;

	if (castedSpellInven.hasNamed("3000210") || castedSpellInven.hasNamed("3000862")
	 || castedSpellInven.hasNamed("3000807") || castedSpellInven.hasNamed("3000806"))
	{
		trigger.message(TEXT_USABLEITEM_BLESSING_ERROR, MSG_TYPE__SYSTEM);
		return;
	}
	if (castedSpellInven.hasNamed("3001835") || castedSpellInven.hasNamed("3001836")
	 || castedSpellInven.hasNamed("3001837") || castedSpellInven.hasNamed("3001838")
	 || castedSpellInven.hasNamed("3001839") || castedSpellInven.hasNamed("3001840")
	 || castedSpellInven.hasNamed("3001841") || castedSpellInven.hasNamed("3001842")
	 || castedSpellInven.hasNamed("3001843") || castedSpellInven.hasNamed("3001844")
	 || castedSpellInven.hasNamed("3001845") || castedSpellInven.hasNamed("3001846")
	 || castedSpellInven.hasNamed("3001847") || castedSpellInven.hasNamed("3001848")
	 || castedSpellInven.hasNamed("3001849") || castedSpellInven.hasNamed("3001850")
	 || castedSpellInven.hasNamed("3001851") || castedSpellInven.hasNamed("3001852")
	 || castedSpellInven.hasNamed("3001853") || castedSpellInven.hasNamed("3001854")
	 || castedSpellInven.hasNamed("3001855") || castedSpellInven.hasNamed("3001856")
	 || castedSpellInven.hasNamed("3001857") || castedSpellInven.hasNamed("3001858")
	 || castedSpellInven.hasNamed("3001859") || castedSpellInven.hasNamed("3001860")
	 || castedSpellInven.hasNamed("3001861") || castedSpellInven.hasNamed("3001862")
	 || castedSpellInven.hasNamed("3001863") || castedSpellInven.hasNamed("3001864")
	 || castedSpellInven.hasNamed("3001865") || castedSpellInven.hasNamed("3001866")
	 || castedSpellInven.hasNamed("3001868") || castedSpellInven.hasNamed("3001869")
	 || castedSpellInven.hasNamed("3001870") || castedSpellInven.hasNamed("3001871")
	 || castedSpellInven.hasNamed("3001872") || castedSpellInven.hasNamed("3001873")
	 || castedSpellInven.hasNamed("3001874") || castedSpellInven.hasNamed("3001875")
	 || castedSpellInven.hasNamed("3001876") || castedSpellInven.hasNamed("3001877")
	 || castedSpellInven.hasNamed("3001878") || castedSpellInven.hasNamed("3001879")
	 || castedSpellInven.hasNamed("3001880") || castedSpellInven.hasNamed("3001881")
	 || castedSpellInven.hasNamed("3001882") || castedSpellInven.hasNamed("3001883")
	 || castedSpellInven.hasNamed("3001884") || castedSpellInven.hasNamed("3001885")
	 || castedSpellInven.hasNamed("3001886") || castedSpellInven.hasNamed("3001887")
	 || castedSpellInven.hasNamed("3001888") || castedSpellInven.hasNamed("3001889")
	 || castedSpellInven.hasNamed("3001890") || castedSpellInven.hasNamed("3001891")
	 || castedSpellInven.hasNamed("3001893") || castedSpellInven.hasNamed("3001894"))
	{
		trigger.message(TEXT_USABLEITEM_COOKS_ERROR, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.hasQuest("qMedicineUseItem4_wait")) 
	{
		trigger.message(TEXT_USABLEITEM_CANT_TIME, MSG_TYPE__SYSTEM);
		return;
	}

	if(Type == "1")
	{
		if (UseSkill(trigger,"3001894",300))
			trigger.giveQuestTo("qMedicineUseItem4_wait", trigger, null);
	}

	// send using effect
	controller.effectBy(trigger);
	return;
}

//******************************************************
// ≈‰≥¢±º ∫∏ªÛ æ∆¿Ã≈€(∑π∆€Ω∫¿« º±π∞ªÛ¿⁄)
// 2006.11.09 written by Stunlee
//******************************************************
quest
qUseItem1006540()				// º±π∞ ªÛ¿⁄
{
	integer iRandom;
	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;

	iRandom = Util.random(1, 1000);
	// Log Info
	userName = trigger.getName();
	tickTime = Util.getTick();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 100) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	if(iRandom <= 10)		// 1006561 ∑π∆€Ω∫ ≈‰≥¢±Õ ¿ÂΩƒ
	{
		trigger.addItemClassNamed("1006561", 1);
		trigger.message(TEXT_GIST_BOX_MSG1, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006561 ] ";
	}
	else if(iRandom <= 20)		// 1006562 ∑π∆€Ω∫ ≈‰≥¢ ¿Œ«¸ ∏”∏Æ∂Ï
	{
		trigger.addItemClassNamed("1006562", 1);
		trigger.message(TEXT_GIST_BOX_MSG2, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006562 ] ";
	}
	else if(iRandom <= 40)		// 1006563 ∑π∆€Ω∫ ≈‰≥¢ ≤ø∏Æ
	{
		trigger.addItemClassNamed("1006563", 1);
		trigger.message(TEXT_GIST_BOX_MSG3, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006563 ] ";
	}
	else if(iRandom <= 50)		// 1006565 ∑π∆€Ω∫ ≈‰≥¢≈– ø 
	{
		trigger.addItemClassNamed("1006565", 1);
		trigger.message(TEXT_GIST_BOX_MSG4, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006565 ] ";
	}
	else if(iRandom <= 60)		// 1006564 ∑π∆€Ω∫ ≈‰≥¢πﬂ Ω¥¡Ó
	{
		trigger.addItemClassNamed("1006564", 1);
		trigger.message(TEXT_GIST_BOX_MSG5, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006564 ] ";
	}
	else if(iRandom <= 690)		// 1006566 πﬂ∫¸∏• ¥Á±Ÿ ¡ÍΩ∫
	{
		trigger.addItemClassNamed("1006566", 1);
		trigger.message(TEXT_GIST_BOX_MSG6, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1006566 ] ";
	}
	else if(iRandom <= 840)		// 1001889 Ω≈º”¿« ø≠∏≈
	{
		trigger.addItemClassNamed("1001889", 1);
		trigger.message(TEXT_GIST_BOX_MSG7, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001889 ] ";
	}
	else if(iRandom <= 850)		// 1001895 »∏««¿« ƒÌ≈∞
	{
		trigger.addItemClassNamed("1001895", 1);
		trigger.message(TEXT_GIST_BOX_MSG8, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001895 ] ";
	}
	else if(iRandom <= 1000)	// 1001894 ¿˚¡ﬂ¿« ƒÌ≈∞
	{
		trigger.addItemClassNamed("1001894", 1);
		trigger.message(TEXT_GIST_BOX_MSG9, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001894 ] ";
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	Util.log(time_Info + Item_Info + world_Info);

	// send using effect
	controller.effectBy(trigger);
}


//******************************************************
// ¿œ∫ª ºˆ«• æ∆¿Ã≈€(±≥»ØΩ√ 100∏∏ Ω√µÂ »πµÊ)
// 2006.11.13 written by Stunlee
//******************************************************
quest
qUseItem1005056()				// ºˆ«•
{
	if(trigger.getAvailGold() < 1000000)		// ¿Ø¿˙ º“¡ˆ «—µµ √º≈©
	{
		trigger.message(TEXT_GETAVAILGOLD_SMALL_MSG, MSG_TYPE__SYSTEM);
		return ;
	}

	trigger.setGold(trigger.getGold() + 1000000);			// ¿Ø¿˙ø°∞‘ µ∑ ¡ˆ±ﬁ
	trigger.updateAttr();

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}
}
/*
//******************************************************
// øÏºˆ∞Ì∞¥øÎ º±π∞ªÛ¿⁄ æ∆¿Ã≈€
// 2006.11.14 written by Stunlee
//******************************************************
quest qUseItem1006573()			// øÏºˆ∞Ì∞¥øÎ º±π∞ªÛ¿⁄
{
	integer iRandom;

	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 2) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 200) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	iRandom = Util.random(1, 10000);

	if(iRandom <= 990)	
}
*/

//******************************************************
// ¥´ªÁ∂˜ ¿œ¡∑¿« º±π∞ ªÛ¿⁄ (¿œ∫ª ∞‹øÔπÊ«– ¿Ã∫•∆Æ ¡ˆ±ﬁøÎ)
// 2006.11.19 written by Han
//******************************************************
function integer itemSupplyCount(integer iRandom)
{
	if (iRandom <= 600)
		return 1;
	else if(iRandom <= 900)
		return 3;
	else
		return 5;
}

quest
qUseItem1006608()		// ¥´ªÁ∂˜ ¿œ¡∑¿« º±π∞ ªÛ¿⁄
{
	integer iRandom, itemCnt;

	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 5) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 50) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// Ω≈º”¿« ø≠∏≈ ¡ˆ±ﬁ
	iRandom = Util.random(1,1000);
	itemCnt = itemSupplyCount(iRandom);
	trigger.addItemClassNamed("1001889", itemCnt);
	trigger.message(TEXT_SNOWMAN_ITME_BOX_MSG1 + itemCnt + TEXT_SNOWMAN_ITME_BOX_MSG6, MSG_TYPE__SYSTEM);

	// ¡˙«≥¿« æ‡√  ¡ˆ±ﬁ
	iRandom = Util.random(1,1000);
	itemCnt = itemSupplyCount(iRandom);
	trigger.addItemClassNamed("1001890", itemCnt);
	trigger.message(TEXT_SNOWMAN_ITME_BOX_MSG2 + itemCnt + TEXT_SNOWMAN_ITME_BOX_MSG6, MSG_TYPE__SYSTEM);

	// ±´∑¬¿« «‹ ¡ˆ±ﬁ
	iRandom = Util.random(1,1000);
	itemCnt = itemSupplyCount(iRandom);
	trigger.addItemClassNamed("1001892", itemCnt);
	trigger.message(TEXT_SNOWMAN_ITME_BOX_MSG3 + itemCnt + TEXT_SNOWMAN_ITME_BOX_MSG6, MSG_TYPE__SYSTEM);

	// ¿˚¡ﬂ¿« «™µ˘ ¡ˆ±ﬁ
	iRandom = Util.random(1,1000);
	itemCnt = itemSupplyCount(iRandom);
	trigger.addItemClassNamed("1001894", itemCnt);
	trigger.message(TEXT_SNOWMAN_ITME_BOX_MSG4 + itemCnt + TEXT_SNOWMAN_ITME_BOX_MSG6, MSG_TYPE__SYSTEM);

	// »∏««¿« ƒÌ≈∞ ¡ˆ±ﬁ
	iRandom = Util.random(1,1000);
	itemCnt = itemSupplyCount(iRandom);
	trigger.addItemClassNamed("1001895", itemCnt);
	trigger.message(TEXT_SNOWMAN_ITME_BOX_MSG5 + itemCnt + TEXT_SNOWMAN_ITME_BOX_MSG6, MSG_TYPE__SYSTEM);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

//******************************************************
// ∑π∫ßæ˜ √‡«œ º±π∞ (ƒ£ƒ£ ∑π∫ßæ˜ ≈∑ ¿Ã∫•∆Æ ¡ˆ±ﬁøÎ)
// 2006.12.19 written by Han
//******************************************************
quest
qUseItem1006748()		// ∑π∫ßæ˜ √‡«œ º±π∞
{
	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 3) {
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}
	if (trigger.getAvailInvenWeight() < 30) {
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	// ƒ…¿Ã≈© ¡∂∞¢ 1∞≥ ¡ˆ±ﬁ
	trigger.addItemClassNamed("1002698", 1);
	trigger.message(TEXT_LEVEL_UP_KING_EVENT_BOX1, MSG_TYPE__SYSTEM);
	// Ω≈º”¿« ø≠∏≈ 2∞≥
	trigger.addItemClassNamed("1001889", 2);
	trigger.message(TEXT_LEVEL_UP_KING_EVENT_BOX2, MSG_TYPE__SYSTEM);
	// ∞«∞≠Ωƒ ø¿∏Æ ±∏¿Ã 3∞≥
	trigger.addItemClassNamed("1004007", 3);
	trigger.message(TEXT_LEVEL_UP_KING_EVENT_BOX3, MSG_TYPE__SYSTEM);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}

//******************************************************
// ¿œ∫ª 3¡÷≥‚ º±π∞ ªÛ¿⁄ 
// 2007. 2.20 written by Stunlee
//******************************************************
quest
qUseItem1005062()		// ¿œ∫ª 3¡÷≥‚ º±π∞ ªÛ¿⁄
{
	integer iRandom1;

	integer tickTime;
	string time_Info, world_Info, Item_Info;
	string userName;


	iRandom1 = Util.random(1,1000000);
	userName = trigger.getName();
	tickTime = Util.getTick();

	time_Info = "(" + Util.getYear(tickTime) + ") " + Util.getMonth(tickTime) + "/" + Util.getDay(tickTime) + " " + Util.getHour(tickTime) + ":" +  Util.getMinute(tickTime) + " User [" + userName + "] ";
	world_Info = "[" + trigger.getWorld().getName() + ":" + trigger.getX() + "," + trigger.getY() + "]";

	if(!NormalItemCanBeUsed()) return;

	// æ∆¿Ã≈€ ¡ˆ±ﬁ ¿¸ø° ΩΩ∑‘¿Ã∂˚ π´∞‘∂˚ √º≈©«—¥Ÿ.
	if (trigger.getEmptyInvenSlotCount() < 1)
	{
		trigger.message(TEXT_NOT_ENOUGH_SLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 10)
	{
		trigger.message(TEXT_NOT_ENOUGH_WEIGHT, MSG_TYPE__SYSTEM);
		return;
	}



	if (iRandom1 <= 10000)	// ∑πæÓ ±‚≥‰ ∞°∏È
	{
		trigger.addItemClassNamed("1005060", 1);
		trigger.message(TEXT_JAPAN_MEMORY_ITEM, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1005060 ] ";

	}
	else if (iRandom1 <= 500000)	// ¿œπ› ±‚≥‰ ∞°∏È
	{
		trigger.addItemClassNamed("1005061", 1);
		trigger.message(TEXT_JAPAN_MEMORY_ITEM, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1005061 ] ";

	}
	else if (iRandom1 <= 580000)
	{
		trigger.addItemClassNamed("1001895", 1);
		trigger.message(TEXT_JAPAN_MEMORY_ITEM_1, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001895 ] ";
	}
	else if (iRandom1 <= 660000)
	{
		trigger.addItemClassNamed("1001894", 1);
		trigger.message(TEXT_JAPAN_MEMORY_ITEM_2, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001894 ] ";
	}
	else if (iRandom1 <= 740000)
	{
		trigger.addItemClassNamed("1001890", 1);
		trigger.message(TEXT_JAPAN_MEMORY_ITEM_3, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1001890 ] ";
	}
	else if (iRandom1 <= 790000)
	{
		trigger.addItemClassNamed("1000018", 1);
		trigger.message(TEXT_JAPAN_MEMORY_ITEM_4, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000018 ] ";
	}
	else if (iRandom1 <= 840000)
	{
		trigger.addItemClassNamed("1000029", 1);
		trigger.message(TEXT_JAPAN_MEMORY_ITEM_5, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000029 ] ";
	}
	else if (iRandom1 <= 920000)
	{
		trigger.addItemClassNamed("1000017", 3);
		trigger.message(TEXT_JAPAN_MEMORY_ITEM_6, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000017 ] ";
	}
	else
	{
		trigger.addItemClassNamed("1000028", 3);
		trigger.message(TEXT_JAPAN_MEMORY_ITEM_7, MSG_TYPE__SYSTEM);
		Item_Info = "From Gift Certificate : +ITEM [ 1000028 ] ";
	}
	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);

	Util.log(time_Info + Item_Info + world_Info);
}

