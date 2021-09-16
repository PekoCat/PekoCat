// $Id: $

#Import quest/system.h
#Import quest/tales_system.h
#Import quest/TW_UsableItem.h
#Import quest/TW_UsableItem_JPN.h

function
boolean
CheckPresentMap_JPN()
{
	integer wNum;
	integer chmap = 0;

	// vahma- »ç¿ë ºÒ°¡´ÉÁö¿ª Ã¼Å©

	if(trigger.getWorld().canFight() == false) chmap = 1;

	// vahma - »ç¿ë °¡´É Æ¯Á¤ Áö¿ª Ã¼Å©
	wNum = trigger.getWorld().getNumber();

	if(wNum == 0 || wNum == 2 || wNum == 9 || wNum == 10 || wNum == 25) chmap = 0;
	else if(wNum == 44 || wNum == 49 || wNum == 55 || wNum == 56 || wNum == 57) chmap = 0;
	else if(wNum == 58 || wNum == 65 || wNum == 66 || wNum == 77) chmap = 0;
	else if(wNum == 88 || wNum == 89 || wNum == 94 || wNum == 97 || wNum == 102) chmap = 0;
	else if(wNum == 112 || wNum == 113 || wNum == 122 || wNum == 123 || wNum == 128 || wNum == 129) chmap = 0;
	else if(wNum == 176 || wNum == 177 || wNum == 181 || wNum == 182 || wNum == 184 || wNum == 186) chmap = 0;
	else if(wNum == 187 || wNum == 188 || wNum == 189 || wNum == 190 || wNum == 198 || wNum == 199) chmap = 0;
	else if(wNum == 201 || wNum == 216 || wNum == 218 || wNum == 219 || wNum == 233 || wNum == 234) chmap = 0;
	else if(wNum == 235 || wNum == 236 || wNum == 237 || wNum == 251 || wNum == 252) chmap = 0;
	else if(wNum == 257 || wNum == 259 || wNum == 260) chmap = 0;
	else if(wNum == 261 || wNum == 262 || wNum == 263 || wNum == 264) chmap = 0;
	else if(wNum == 265 || wNum == 266 || wNum == 267 || wNum == 268 || wNum == 269 || wNum == 270) chmap = 0;
	else if(wNum == 292 || wNum == 293 || wNum == 298 || wNum == 330 || wNum == 341) chmap == 0;
	else if(wNum == 349 || wNum == 351 || wNum == 352 || wNum == 353 || wNum == 354 || wNum == 371) chmap = 0;
	else if(wNum == 375 || wNum == 408 || wNum == 425 || wNum == 426) chmap = 0;
	else if(wNum == 427 || wNum == 428 || wNum == 444 || wNum == 455) chmap = 0;
	else chmap = 1;
	
	if (chmap == 1)
	{
		trigger.sayTo(TEXT_USABLEITEM_NOT_USE_FIELD, trigger);
		//trigger.message(trigger.getWorld().getName(), MSG_TYPE__SYSTEM);
		return true;
	}

    	return false;
}

function
boolean
CheckInventory_JPN(integer invwt)
{
	// ½½·Ô Ã¼Å©
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return true;
	}
	// ¹«°Ô Ã¼Å©
	if (trigger.getAvailInvenWeight() < invwt) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return true;
	}
	return false;
}

function
void
GivePresent_JPN(string GiftType, string PresentItem, integer PresentSeed, string PTN)
{
	integer mx, my;
	
	if (GiftType == "ITEM") {
		trigger.addItemClassNamed(PresentItem, 1);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_ITEM, trigger);
	}
	else if (GiftType == "SEED") {
		trigger.setGold(trigger.getGold() + PresentSeed);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_SEED1 + PresentSeed + TEXT_USABLEITEM_BOX_IN_SEED2, trigger);
	}
	else {
		mx =  trigger.getX(); my =  trigger.getY();
		trigger.getWorld().genMonster(PresentItem, 1, PTN, 1, mx-10, my-10, mx+10, my+10);
		trigger.sayTo(TEXT_USABLEITEM_BOX_IN_MONSTER, trigger);
	}

	if (controller.canBeExhausted())
		controller.decreaseNumber(1);
	return 0;
}

function
boolean
CheckRestrictDate_JPN()
{
	integer tickTime = Util.getTick();
	if (JAPAN_GIFT_RESTRICT_YEAR == 0) return false;
        else if (Util.getYear(tickTime)  <  JAPAN_GIFT_RESTRICT_YEAR)    return false;
	else if (Util.getYear(tickTime)  == JAPAN_GIFT_RESTRICT_YEAR  && 
		 Util.getMonth(tickTime) <  JAPAN_GIFT_RESTRICT_MONTH)   return false;
	else if (Util.getYear(tickTime)  == JAPAN_GIFT_RESTRICT_YEAR  && 
		 Util.getMonth(tickTime) == JAPAN_GIFT_RESTRICT_MONTH && 
		 Util.getDay(tickTime)   <= JAPAN_GIFT_RESTRICT_DAY)     return false;
	trigger.message(JAPAN_GIFT_RESTRICT_DATE_OVER, MSG_TYPE__SYSTEM);
	return true;
}



quest
qUseItem1003527()			// Japanese Present Box Item (2004/9)
{
	integer rval;
	integer val01, val02, val03, val04, val05, val06, val07, val08, val09, val10;
	integer	val11, val12, val13, val14, val15, val16, val17, val18, val19, val20;
	integer	val21, val22, val23, val24, val25, val26, val27, val28, val29, val30;
	integer	val31, val32, val33, val34, val35, val36, val37, val38, val39, val40;
	integer	val41, val42, val43, val44, val45, val46, val47, val48, val49, val50;
	integer	val51, val52, val53, val54, val55, val56, val57, val58, val59, val60;
	integer	val61, val62, val63, val64, val65, val66, val67, val68, val69, val70;
	integer	val71, val72, val73, val74, val75, val76, val77, val78, val79, val80;
	integer	val81, val82, val83, val84, val85, val86, val87, val88, val89, val90;
	integer	val91, val92, val93, val94, val95, val96, val97, val98, val99, val100;
	integer	val101, val102, val103, val104, val105, val106, val107, val108, val109, val110;
	integer	val111, val112, val113, val114, val115, val116, val117, val118, val119, val120;
	string	PresentItem, GiftType, PTN;
	integer PresentSeed;
	
	if (CheckPresentMap_JPN()) return;
	if (CheckInventory_JPN(JAPAN_GIFT_2926_INVWT)) return;
	if (CheckRestrictDate_JPN()) {controller.decreaseNumber(1); return;}

	val01 =		JAPAN_GIFT_2926_ITEM001_PER;
	val02 = val01 + JAPAN_GIFT_2926_ITEM002_PER;
	val03 = val02 + JAPAN_GIFT_2926_ITEM003_PER;
	val04 = val03 + JAPAN_GIFT_2926_ITEM004_PER;
	val05 = val04 + JAPAN_GIFT_2926_ITEM005_PER;
	val06 = val05 + JAPAN_GIFT_2926_ITEM006_PER;
	val07 = val06 + JAPAN_GIFT_2926_ITEM007_PER;
	val08 = val07 + JAPAN_GIFT_2926_ITEM008_PER;
	val09 = val08 + JAPAN_GIFT_2926_ITEM009_PER;
	val10 = val09 + JAPAN_GIFT_2926_ITEM010_PER;
	val11 = val10 + JAPAN_GIFT_2926_ITEM011_PER;
	val12 = val11 + JAPAN_GIFT_2926_ITEM012_PER;
	val13 = val12 + JAPAN_GIFT_2926_ITEM013_PER;
	val14 = val13 + JAPAN_GIFT_2926_ITEM014_PER;
	val15 = val14 + JAPAN_GIFT_2926_ITEM015_PER;
	val16 = val15 + JAPAN_GIFT_2926_ITEM016_PER;
	val17 = val16 + JAPAN_GIFT_2926_ITEM017_PER;
	val18 = val17 + JAPAN_GIFT_2926_ITEM018_PER;
	val19 = val18 + JAPAN_GIFT_2926_ITEM019_PER;
	val20 = val19 + JAPAN_GIFT_2926_ITEM020_PER;
	val21 = val20 + JAPAN_GIFT_2926_ITEM021_PER;
	val22 = val21 + JAPAN_GIFT_2926_ITEM022_PER;
	val23 = val22 + JAPAN_GIFT_2926_ITEM023_PER;
	val24 = val23 + JAPAN_GIFT_2926_ITEM024_PER;
	val25 = val24 + JAPAN_GIFT_2926_ITEM025_PER;
	val26 = val25 + JAPAN_GIFT_2926_ITEM026_PER;
	val27 = val26 + JAPAN_GIFT_2926_ITEM027_PER;
	val28 = val27 + JAPAN_GIFT_2926_ITEM028_PER;
	val29 = val28 + JAPAN_GIFT_2926_ITEM029_PER;
	val30 = val29 + JAPAN_GIFT_2926_ITEM030_PER;
	val31 = val30 + JAPAN_GIFT_2926_ITEM031_PER;
	val32 = val31 + JAPAN_GIFT_2926_ITEM032_PER;
	val33 = val32 + JAPAN_GIFT_2926_ITEM033_PER;
	val34 = val33 + JAPAN_GIFT_2926_ITEM034_PER;
	val35 = val34 + JAPAN_GIFT_2926_ITEM035_PER;
	val36 = val35 + JAPAN_GIFT_2926_ITEM036_PER;
	val37 = val36 + JAPAN_GIFT_2926_ITEM037_PER;
	val38 = val37 + JAPAN_GIFT_2926_ITEM038_PER;
	val39 = val38 + JAPAN_GIFT_2926_ITEM039_PER;
	val40 = val39 + JAPAN_GIFT_2926_ITEM040_PER;
	val41 = val40 + JAPAN_GIFT_2926_ITEM041_PER;
	val42 = val41 + JAPAN_GIFT_2926_ITEM042_PER;
	val43 = val42 + JAPAN_GIFT_2926_ITEM043_PER;
	val44 = val43 + JAPAN_GIFT_2926_ITEM044_PER;
	val45 = val44 + JAPAN_GIFT_2926_ITEM045_PER;
	val46 = val45 + JAPAN_GIFT_2926_ITEM046_PER;
	val47 = val46 + JAPAN_GIFT_2926_ITEM047_PER;
	val48 = val47 + JAPAN_GIFT_2926_ITEM048_PER;
	val49 = val48 + JAPAN_GIFT_2926_ITEM049_PER;
	val50 = val49 + JAPAN_GIFT_2926_ITEM050_PER;
	val51 = val50 + JAPAN_GIFT_2926_ITEM051_PER;
	val52 = val51 + JAPAN_GIFT_2926_ITEM052_PER;
	val53 = val52 + JAPAN_GIFT_2926_ITEM053_PER;
	val54 = val53 + JAPAN_GIFT_2926_ITEM054_PER;
	val55 = val54 + JAPAN_GIFT_2926_ITEM055_PER;
	val56 = val55 + JAPAN_GIFT_2926_ITEM056_PER;
	val57 = val56 + JAPAN_GIFT_2926_ITEM057_PER;
	val58 = val57 + JAPAN_GIFT_2926_ITEM058_PER;
	val59 = val58 + JAPAN_GIFT_2926_ITEM059_PER;
	val60 = val59 + JAPAN_GIFT_2926_ITEM060_PER;
	val61 = val60 + JAPAN_GIFT_2926_ITEM061_PER;
	val62 = val61 + JAPAN_GIFT_2926_ITEM062_PER;
	val63 = val62 + JAPAN_GIFT_2926_ITEM063_PER;
	val64 = val63 + JAPAN_GIFT_2926_ITEM064_PER;
	val65 = val64 + JAPAN_GIFT_2926_ITEM065_PER;
	val66 = val65 + JAPAN_GIFT_2926_ITEM066_PER;
	val67 = val66 + JAPAN_GIFT_2926_ITEM067_PER;
	val68 = val67 + JAPAN_GIFT_2926_ITEM068_PER;
	val69 = val68 + JAPAN_GIFT_2926_ITEM069_PER;
	val70 = val69 + JAPAN_GIFT_2926_ITEM070_PER;
	val71 = val70 + JAPAN_GIFT_2926_ITEM071_PER;
	val72 = val71 + JAPAN_GIFT_2926_ITEM072_PER;
	val73 = val72 + JAPAN_GIFT_2926_ITEM073_PER;
	val74 = val73 + JAPAN_GIFT_2926_ITEM074_PER;
	val75 = val74 + JAPAN_GIFT_2926_ITEM075_PER;
	val76 = val75 + JAPAN_GIFT_2926_ITEM076_PER;
	val77 = val76 + JAPAN_GIFT_2926_ITEM077_PER;
	val78 = val77 + JAPAN_GIFT_2926_ITEM078_PER;
	val79 = val78 + JAPAN_GIFT_2926_ITEM079_PER;
	val80 = val79 + JAPAN_GIFT_2926_ITEM080_PER;
	val81 = val80 + JAPAN_GIFT_2926_ITEM081_PER;
	val82 = val81 + JAPAN_GIFT_2926_ITEM082_PER;
	val83 = val82 + JAPAN_GIFT_2926_ITEM083_PER;
	val84 = val83 + JAPAN_GIFT_2926_ITEM084_PER;
	val85 = val84 + JAPAN_GIFT_2926_ITEM085_PER;
	val86 = val85 + JAPAN_GIFT_2926_ITEM086_PER;
	val87 = val86 + JAPAN_GIFT_2926_ITEM087_PER;
	val88 = val87 + JAPAN_GIFT_2926_ITEM088_PER;
	val89 = val88 + JAPAN_GIFT_2926_ITEM089_PER;
	val90 = val89 + JAPAN_GIFT_2926_ITEM090_PER;
	val91 = val90 + JAPAN_GIFT_2926_ITEM091_PER;
	val92 = val91 + JAPAN_GIFT_2926_ITEM092_PER;
	val93 = val92 + JAPAN_GIFT_2926_ITEM093_PER;
	val94 = val93 + JAPAN_GIFT_2926_ITEM094_PER;
	val95 = val94 + JAPAN_GIFT_2926_ITEM095_PER;
	val96 = val95 + JAPAN_GIFT_2926_ITEM096_PER;
	val97 = val96 + JAPAN_GIFT_2926_ITEM097_PER;
	val98 = val97 + JAPAN_GIFT_2926_ITEM098_PER;
	val99 = val98 + JAPAN_GIFT_2926_ITEM099_PER;
	val100 = val99 + JAPAN_GIFT_2926_ITEM100_PER;
	val101 = val100 + JAPAN_GIFT_2926_SEED101_PER;
	val102 = val101 + JAPAN_GIFT_2926_SEED102_PER;
	val103 = val102 + JAPAN_GIFT_2926_SEED103_PER;
	val104 = val103 + JAPAN_GIFT_2926_SEED104_PER;
	val105 = val104 + JAPAN_GIFT_2926_SEED105_PER;
	val106 = val105 + JAPAN_GIFT_2926_SEED106_PER;
	val107 = val106 + JAPAN_GIFT_2926_SEED107_PER;
	val108 = val107 + JAPAN_GIFT_2926_SEED108_PER;
	val109 = val108 + JAPAN_GIFT_2926_SEED109_PER;
	val110 = val109 + JAPAN_GIFT_2926_SEED110_PER;
	val111 = val110 + JAPAN_GIFT_2926_MONS111_PER;
	val112 = val111 + JAPAN_GIFT_2926_MONS112_PER;
	val113 = val112 + JAPAN_GIFT_2926_MONS113_PER;
	val114 = val113 + JAPAN_GIFT_2926_MONS114_PER;
	val115 = val114 + JAPAN_GIFT_2926_MONS115_PER;
	val116 = val115 + JAPAN_GIFT_2926_MONS116_PER;
	val117 = val116 + JAPAN_GIFT_2926_MONS117_PER;
	val118 = val117 + JAPAN_GIFT_2926_MONS118_PER;
	val119 = val118 + JAPAN_GIFT_2926_MONS119_PER;
	val120 = val119 + JAPAN_GIFT_2926_MONS120_PER;

	if (val120 != 100000) {
		trigger.message("Percentage Setting is wrong!", MSG_TYPE__SYSTEM);
	    	return;
	}

	rval  = Util.random(1, 100000);
	if      (rval <=val01) {PresentItem = JAPAN_GIFT_2926_ITEM001; GiftType="ITEM";}
	else if (rval <=val02) {PresentItem = JAPAN_GIFT_2926_ITEM002; GiftType="ITEM";}
	else if (rval <=val03) {PresentItem = JAPAN_GIFT_2926_ITEM003; GiftType="ITEM";}
	else if (rval <=val04) {PresentItem = JAPAN_GIFT_2926_ITEM004; GiftType="ITEM";}
	else if (rval <=val05) {PresentItem = JAPAN_GIFT_2926_ITEM005; GiftType="ITEM";}
	else if (rval <=val06) {PresentItem = JAPAN_GIFT_2926_ITEM006; GiftType="ITEM";}
	else if (rval <=val07) {PresentItem = JAPAN_GIFT_2926_ITEM007; GiftType="ITEM";}
	else if (rval <=val08) {PresentItem = JAPAN_GIFT_2926_ITEM008; GiftType="ITEM";}
	else if (rval <=val09) {PresentItem = JAPAN_GIFT_2926_ITEM009; GiftType="ITEM";}
	else if (rval <=val10) {PresentItem = JAPAN_GIFT_2926_ITEM010; GiftType="ITEM";}
	else if (rval <=val11) {PresentItem = JAPAN_GIFT_2926_ITEM011; GiftType="ITEM";}
	else if (rval <=val12) {PresentItem = JAPAN_GIFT_2926_ITEM012; GiftType="ITEM";}
	else if (rval <=val13) {PresentItem = JAPAN_GIFT_2926_ITEM013; GiftType="ITEM";}
	else if (rval <=val14) {PresentItem = JAPAN_GIFT_2926_ITEM014; GiftType="ITEM";}
	else if (rval <=val15) {PresentItem = JAPAN_GIFT_2926_ITEM015; GiftType="ITEM";}
	else if (rval <=val16) {PresentItem = JAPAN_GIFT_2926_ITEM016; GiftType="ITEM";}
	else if (rval <=val17) {PresentItem = JAPAN_GIFT_2926_ITEM017; GiftType="ITEM";}
	else if (rval <=val18) {PresentItem = JAPAN_GIFT_2926_ITEM018; GiftType="ITEM";}
	else if (rval <=val19) {PresentItem = JAPAN_GIFT_2926_ITEM019; GiftType="ITEM";}
	else if (rval <=val20) {PresentItem = JAPAN_GIFT_2926_ITEM020; GiftType="ITEM";}
	else if (rval <=val21) {PresentItem = JAPAN_GIFT_2926_ITEM021; GiftType="ITEM";}
	else if (rval <=val22) {PresentItem = JAPAN_GIFT_2926_ITEM022; GiftType="ITEM";}
	else if (rval <=val23) {PresentItem = JAPAN_GIFT_2926_ITEM023; GiftType="ITEM";}
	else if (rval <=val24) {PresentItem = JAPAN_GIFT_2926_ITEM024; GiftType="ITEM";}
	else if (rval <=val25) {PresentItem = JAPAN_GIFT_2926_ITEM025; GiftType="ITEM";}
	else if (rval <=val26) {PresentItem = JAPAN_GIFT_2926_ITEM026; GiftType="ITEM";}
	else if (rval <=val27) {PresentItem = JAPAN_GIFT_2926_ITEM027; GiftType="ITEM";}
	else if (rval <=val28) {PresentItem = JAPAN_GIFT_2926_ITEM028; GiftType="ITEM";}
	else if (rval <=val29) {PresentItem = JAPAN_GIFT_2926_ITEM029; GiftType="ITEM";}
	else if (rval <=val30) {PresentItem = JAPAN_GIFT_2926_ITEM030; GiftType="ITEM";}
	else if (rval <=val31) {PresentItem = JAPAN_GIFT_2926_ITEM031; GiftType="ITEM";}
	else if (rval <=val32) {PresentItem = JAPAN_GIFT_2926_ITEM032; GiftType="ITEM";}
	else if (rval <=val33) {PresentItem = JAPAN_GIFT_2926_ITEM033; GiftType="ITEM";}
	else if (rval <=val34) {PresentItem = JAPAN_GIFT_2926_ITEM034; GiftType="ITEM";}
	else if (rval <=val35) {PresentItem = JAPAN_GIFT_2926_ITEM035; GiftType="ITEM";}
	else if (rval <=val36) {PresentItem = JAPAN_GIFT_2926_ITEM036; GiftType="ITEM";}
	else if (rval <=val37) {PresentItem = JAPAN_GIFT_2926_ITEM037; GiftType="ITEM";}
	else if (rval <=val38) {PresentItem = JAPAN_GIFT_2926_ITEM038; GiftType="ITEM";}
	else if (rval <=val39) {PresentItem = JAPAN_GIFT_2926_ITEM039; GiftType="ITEM";}
	else if (rval <=val40) {PresentItem = JAPAN_GIFT_2926_ITEM040; GiftType="ITEM";}
	else if (rval <=val41) {PresentItem = JAPAN_GIFT_2926_ITEM041; GiftType="ITEM";}
	else if (rval <=val42) {PresentItem = JAPAN_GIFT_2926_ITEM042; GiftType="ITEM";}
	else if (rval <=val43) {PresentItem = JAPAN_GIFT_2926_ITEM043; GiftType="ITEM";}
	else if (rval <=val44) {PresentItem = JAPAN_GIFT_2926_ITEM044; GiftType="ITEM";}
	else if (rval <=val45) {PresentItem = JAPAN_GIFT_2926_ITEM045; GiftType="ITEM";}
	else if (rval <=val46) {PresentItem = JAPAN_GIFT_2926_ITEM046; GiftType="ITEM";}
	else if (rval <=val47) {PresentItem = JAPAN_GIFT_2926_ITEM047; GiftType="ITEM";}
	else if (rval <=val48) {PresentItem = JAPAN_GIFT_2926_ITEM048; GiftType="ITEM";}
	else if (rval <=val49) {PresentItem = JAPAN_GIFT_2926_ITEM049; GiftType="ITEM";}
	else if (rval <=val50) {PresentItem = JAPAN_GIFT_2926_ITEM050; GiftType="ITEM";}
	else if (rval <=val51) {PresentItem = JAPAN_GIFT_2926_ITEM051; GiftType="ITEM";}
	else if (rval <=val52) {PresentItem = JAPAN_GIFT_2926_ITEM052; GiftType="ITEM";}
	else if (rval <=val53) {PresentItem = JAPAN_GIFT_2926_ITEM053; GiftType="ITEM";}
	else if (rval <=val54) {PresentItem = JAPAN_GIFT_2926_ITEM054; GiftType="ITEM";}
	else if (rval <=val55) {PresentItem = JAPAN_GIFT_2926_ITEM055; GiftType="ITEM";}
	else if (rval <=val56) {PresentItem = JAPAN_GIFT_2926_ITEM056; GiftType="ITEM";}
	else if (rval <=val57) {PresentItem = JAPAN_GIFT_2926_ITEM057; GiftType="ITEM";}
	else if (rval <=val58) {PresentItem = JAPAN_GIFT_2926_ITEM058; GiftType="ITEM";}
	else if (rval <=val59) {PresentItem = JAPAN_GIFT_2926_ITEM059; GiftType="ITEM";}
	else if (rval <=val60) {PresentItem = JAPAN_GIFT_2926_ITEM060; GiftType="ITEM";}
	else if (rval <=val61) {PresentItem = JAPAN_GIFT_2926_ITEM061; GiftType="ITEM";}
	else if (rval <=val62) {PresentItem = JAPAN_GIFT_2926_ITEM062; GiftType="ITEM";}
	else if (rval <=val63) {PresentItem = JAPAN_GIFT_2926_ITEM063; GiftType="ITEM";}
	else if (rval <=val64) {PresentItem = JAPAN_GIFT_2926_ITEM064; GiftType="ITEM";}
	else if (rval <=val65) {PresentItem = JAPAN_GIFT_2926_ITEM065; GiftType="ITEM";}
	else if (rval <=val66) {PresentItem = JAPAN_GIFT_2926_ITEM066; GiftType="ITEM";}
	else if (rval <=val67) {PresentItem = JAPAN_GIFT_2926_ITEM067; GiftType="ITEM";}
	else if (rval <=val68) {PresentItem = JAPAN_GIFT_2926_ITEM068; GiftType="ITEM";}
	else if (rval <=val69) {PresentItem = JAPAN_GIFT_2926_ITEM069; GiftType="ITEM";}
	else if (rval <=val70) {PresentItem = JAPAN_GIFT_2926_ITEM070; GiftType="ITEM";}
	else if (rval <=val71) {PresentItem = JAPAN_GIFT_2926_ITEM071; GiftType="ITEM";}
	else if (rval <=val72) {PresentItem = JAPAN_GIFT_2926_ITEM072; GiftType="ITEM";}
	else if (rval <=val73) {PresentItem = JAPAN_GIFT_2926_ITEM073; GiftType="ITEM";}
	else if (rval <=val74) {PresentItem = JAPAN_GIFT_2926_ITEM074; GiftType="ITEM";}
	else if (rval <=val75) {PresentItem = JAPAN_GIFT_2926_ITEM075; GiftType="ITEM";}
	else if (rval <=val76) {PresentItem = JAPAN_GIFT_2926_ITEM076; GiftType="ITEM";}
	else if (rval <=val77) {PresentItem = JAPAN_GIFT_2926_ITEM077; GiftType="ITEM";}
	else if (rval <=val78) {PresentItem = JAPAN_GIFT_2926_ITEM078; GiftType="ITEM";}
	else if (rval <=val79) {PresentItem = JAPAN_GIFT_2926_ITEM079; GiftType="ITEM";}
	else if (rval <=val80) {PresentItem = JAPAN_GIFT_2926_ITEM080; GiftType="ITEM";}
	else if (rval <=val81) {PresentItem = JAPAN_GIFT_2926_ITEM081; GiftType="ITEM";}
	else if (rval <=val82) {PresentItem = JAPAN_GIFT_2926_ITEM082; GiftType="ITEM";}
	else if (rval <=val83) {PresentItem = JAPAN_GIFT_2926_ITEM083; GiftType="ITEM";}
	else if (rval <=val84) {PresentItem = JAPAN_GIFT_2926_ITEM084; GiftType="ITEM";}
	else if (rval <=val85) {PresentItem = JAPAN_GIFT_2926_ITEM085; GiftType="ITEM";}
	else if (rval <=val86) {PresentItem = JAPAN_GIFT_2926_ITEM086; GiftType="ITEM";}
	else if (rval <=val87) {PresentItem = JAPAN_GIFT_2926_ITEM087; GiftType="ITEM";}
	else if (rval <=val88) {PresentItem = JAPAN_GIFT_2926_ITEM088; GiftType="ITEM";}
	else if (rval <=val89) {PresentItem = JAPAN_GIFT_2926_ITEM089; GiftType="ITEM";}
	else if (rval <=val90) {PresentItem = JAPAN_GIFT_2926_ITEM090; GiftType="ITEM";}
	else if (rval <=val91) {PresentItem = JAPAN_GIFT_2926_ITEM091; GiftType="ITEM";}
	else if (rval <=val92) {PresentItem = JAPAN_GIFT_2926_ITEM092; GiftType="ITEM";}
	else if (rval <=val93) {PresentItem = JAPAN_GIFT_2926_ITEM093; GiftType="ITEM";}
	else if (rval <=val94) {PresentItem = JAPAN_GIFT_2926_ITEM094; GiftType="ITEM";}
	else if (rval <=val95) {PresentItem = JAPAN_GIFT_2926_ITEM095; GiftType="ITEM";}
	else if (rval <=val96) {PresentItem = JAPAN_GIFT_2926_ITEM096; GiftType="ITEM";}
	else if (rval <=val97) {PresentItem = JAPAN_GIFT_2926_ITEM097; GiftType="ITEM";}
	else if (rval <=val98) {PresentItem = JAPAN_GIFT_2926_ITEM098; GiftType="ITEM";}
	else if (rval <=val99) {PresentItem = JAPAN_GIFT_2926_ITEM099; GiftType="ITEM";}
	else if (rval <=val100) {PresentItem = JAPAN_GIFT_2926_ITEM100; GiftType="ITEM";}
	else if (rval <= val101) {PresentSeed = JAPAN_GIFT_2926_SEED101; GiftType="SEED";}
	else if (rval <= val102) {PresentSeed = JAPAN_GIFT_2926_SEED102; GiftType="SEED";}
	else if (rval <= val103) {PresentSeed = JAPAN_GIFT_2926_SEED103; GiftType="SEED";}
	else if (rval <= val104) {PresentSeed = JAPAN_GIFT_2926_SEED104; GiftType="SEED";}
	else if (rval <= val105) {PresentSeed = JAPAN_GIFT_2926_SEED105; GiftType="SEED";}
	else if (rval <= val106) {PresentSeed = JAPAN_GIFT_2926_SEED106; GiftType="SEED";}
	else if (rval <= val107) {PresentSeed = JAPAN_GIFT_2926_SEED107; GiftType="SEED";}
	else if (rval <= val108) {PresentSeed = JAPAN_GIFT_2926_SEED108; GiftType="SEED";}
	else if (rval <= val109) {PresentSeed = JAPAN_GIFT_2926_SEED109; GiftType="SEED";}
	else if (rval <= val110) {PresentSeed = JAPAN_GIFT_2926_SEED110; GiftType="SEED";}
	else if (rval <= val111) {PresentItem = JAPAN_GIFT_2926_MONS111; PTN = JAPAN_GIFT_2926_MONS111_PTN;}
	else if (rval <= val112) {PresentItem = JAPAN_GIFT_2926_MONS112; PTN = JAPAN_GIFT_2926_MONS112_PTN;}
	else if (rval <= val113) {PresentItem = JAPAN_GIFT_2926_MONS113; PTN = JAPAN_GIFT_2926_MONS113_PTN;}
	else if (rval <= val114) {PresentItem = JAPAN_GIFT_2926_MONS114; PTN = JAPAN_GIFT_2926_MONS114_PTN;}
	else if (rval <= val115) {PresentItem = JAPAN_GIFT_2926_MONS115; PTN = JAPAN_GIFT_2926_MONS115_PTN;}
	else if (rval <= val116) {PresentItem = JAPAN_GIFT_2926_MONS116; PTN = JAPAN_GIFT_2926_MONS116_PTN;}
	else if (rval <= val117) {PresentItem = JAPAN_GIFT_2926_MONS117; PTN = JAPAN_GIFT_2926_MONS117_PTN;}
	else if (rval <= val118) {PresentItem = JAPAN_GIFT_2926_MONS118; PTN = JAPAN_GIFT_2926_MONS118_PTN;}
	else if (rval <= val119) {PresentItem = JAPAN_GIFT_2926_MONS119; PTN = JAPAN_GIFT_2926_MONS119_PTN;}
	else if (rval <= val120) {PresentItem = JAPAN_GIFT_2926_MONS120; PTN = JAPAN_GIFT_2926_MONS120_PTN;}
	
	GivePresent_JPN(GiftType, PresentItem, PresentSeed, PTN);
	return;
}



quest
qUseItem1003528()			// Japanese Present Box Item (2004/9)
{
	integer rval;
	integer val01, val02, val03, val04, val05, val06, val07, val08, val09, val10;
	integer	val11, val12, val13, val14, val15, val16, val17, val18, val19, val20;
	integer	val21, val22, val23, val24, val25, val26, val27, val28, val29, val30;
	integer	val31, val32, val33, val34, val35, val36, val37, val38, val39, val40;
	integer	val41, val42, val43, val44, val45, val46, val47, val48, val49, val50;
	integer	val51, val52, val53, val54, val55, val56, val57, val58, val59, val60;
	integer	val61, val62, val63, val64, val65, val66, val67, val68, val69, val70;
	integer	val71, val72, val73, val74, val75, val76, val77, val78, val79, val80;
	integer	val81, val82, val83, val84, val85, val86, val87, val88, val89, val90;
	integer	val91, val92, val93, val94, val95, val96, val97, val98, val99, val100;
	integer	val101, val102, val103, val104, val105, val106, val107, val108, val109, val110;
	integer	val111, val112, val113, val114, val115, val116, val117, val118, val119, val120;
	string	PresentItem, GiftType, PTN;
	integer PresentSeed;
	
	if (CheckPresentMap_JPN()) return;
	if (CheckInventory_JPN(JAPAN_GIFT_2927_INVWT)) return;
	if (CheckRestrictDate_JPN()) {controller.decreaseNumber(1); return;}

	val01 =		JAPAN_GIFT_2927_ITEM001_PER;
	val02 = val01 + JAPAN_GIFT_2927_ITEM002_PER;
	val03 = val02 + JAPAN_GIFT_2927_ITEM003_PER;
	val04 = val03 + JAPAN_GIFT_2927_ITEM004_PER;
	val05 = val04 + JAPAN_GIFT_2927_ITEM005_PER;
	val06 = val05 + JAPAN_GIFT_2927_ITEM006_PER;
	val07 = val06 + JAPAN_GIFT_2927_ITEM007_PER;
	val08 = val07 + JAPAN_GIFT_2927_ITEM008_PER;
	val09 = val08 + JAPAN_GIFT_2927_ITEM009_PER;
	val10 = val09 + JAPAN_GIFT_2927_ITEM010_PER;
	val11 = val10 + JAPAN_GIFT_2927_ITEM011_PER;
	val12 = val11 + JAPAN_GIFT_2927_ITEM012_PER;
	val13 = val12 + JAPAN_GIFT_2927_ITEM013_PER;
	val14 = val13 + JAPAN_GIFT_2927_ITEM014_PER;
	val15 = val14 + JAPAN_GIFT_2927_ITEM015_PER;
	val16 = val15 + JAPAN_GIFT_2927_ITEM016_PER;
	val17 = val16 + JAPAN_GIFT_2927_ITEM017_PER;
	val18 = val17 + JAPAN_GIFT_2927_ITEM018_PER;
	val19 = val18 + JAPAN_GIFT_2927_ITEM019_PER;
	val20 = val19 + JAPAN_GIFT_2927_ITEM020_PER;
	val21 = val20 + JAPAN_GIFT_2927_ITEM021_PER;
	val22 = val21 + JAPAN_GIFT_2927_ITEM022_PER;
	val23 = val22 + JAPAN_GIFT_2927_ITEM023_PER;
	val24 = val23 + JAPAN_GIFT_2927_ITEM024_PER;
	val25 = val24 + JAPAN_GIFT_2927_ITEM025_PER;
	val26 = val25 + JAPAN_GIFT_2927_ITEM026_PER;
	val27 = val26 + JAPAN_GIFT_2927_ITEM027_PER;
	val28 = val27 + JAPAN_GIFT_2927_ITEM028_PER;
	val29 = val28 + JAPAN_GIFT_2927_ITEM029_PER;
	val30 = val29 + JAPAN_GIFT_2927_ITEM030_PER;
	val31 = val30 + JAPAN_GIFT_2927_ITEM031_PER;
	val32 = val31 + JAPAN_GIFT_2927_ITEM032_PER;
	val33 = val32 + JAPAN_GIFT_2927_ITEM033_PER;
	val34 = val33 + JAPAN_GIFT_2927_ITEM034_PER;
	val35 = val34 + JAPAN_GIFT_2927_ITEM035_PER;
	val36 = val35 + JAPAN_GIFT_2927_ITEM036_PER;
	val37 = val36 + JAPAN_GIFT_2927_ITEM037_PER;
	val38 = val37 + JAPAN_GIFT_2927_ITEM038_PER;
	val39 = val38 + JAPAN_GIFT_2927_ITEM039_PER;
	val40 = val39 + JAPAN_GIFT_2927_ITEM040_PER;
	val41 = val40 + JAPAN_GIFT_2927_ITEM041_PER;
	val42 = val41 + JAPAN_GIFT_2927_ITEM042_PER;
	val43 = val42 + JAPAN_GIFT_2927_ITEM043_PER;
	val44 = val43 + JAPAN_GIFT_2927_ITEM044_PER;
	val45 = val44 + JAPAN_GIFT_2927_ITEM045_PER;
	val46 = val45 + JAPAN_GIFT_2927_ITEM046_PER;
	val47 = val46 + JAPAN_GIFT_2927_ITEM047_PER;
	val48 = val47 + JAPAN_GIFT_2927_ITEM048_PER;
	val49 = val48 + JAPAN_GIFT_2927_ITEM049_PER;
	val50 = val49 + JAPAN_GIFT_2927_ITEM050_PER;
	val51 = val50 + JAPAN_GIFT_2927_ITEM051_PER;
	val52 = val51 + JAPAN_GIFT_2927_ITEM052_PER;
	val53 = val52 + JAPAN_GIFT_2927_ITEM053_PER;
	val54 = val53 + JAPAN_GIFT_2927_ITEM054_PER;
	val55 = val54 + JAPAN_GIFT_2927_ITEM055_PER;
	val56 = val55 + JAPAN_GIFT_2927_ITEM056_PER;
	val57 = val56 + JAPAN_GIFT_2927_ITEM057_PER;
	val58 = val57 + JAPAN_GIFT_2927_ITEM058_PER;
	val59 = val58 + JAPAN_GIFT_2927_ITEM059_PER;
	val60 = val59 + JAPAN_GIFT_2927_ITEM060_PER;
	val61 = val60 + JAPAN_GIFT_2927_ITEM061_PER;
	val62 = val61 + JAPAN_GIFT_2927_ITEM062_PER;
	val63 = val62 + JAPAN_GIFT_2927_ITEM063_PER;
	val64 = val63 + JAPAN_GIFT_2927_ITEM064_PER;
	val65 = val64 + JAPAN_GIFT_2927_ITEM065_PER;
	val66 = val65 + JAPAN_GIFT_2927_ITEM066_PER;
	val67 = val66 + JAPAN_GIFT_2927_ITEM067_PER;
	val68 = val67 + JAPAN_GIFT_2927_ITEM068_PER;
	val69 = val68 + JAPAN_GIFT_2927_ITEM069_PER;
	val70 = val69 + JAPAN_GIFT_2927_ITEM070_PER;
	val71 = val70 + JAPAN_GIFT_2927_ITEM071_PER;
	val72 = val71 + JAPAN_GIFT_2927_ITEM072_PER;
	val73 = val72 + JAPAN_GIFT_2927_ITEM073_PER;
	val74 = val73 + JAPAN_GIFT_2927_ITEM074_PER;
	val75 = val74 + JAPAN_GIFT_2927_ITEM075_PER;
	val76 = val75 + JAPAN_GIFT_2927_ITEM076_PER;
	val77 = val76 + JAPAN_GIFT_2927_ITEM077_PER;
	val78 = val77 + JAPAN_GIFT_2927_ITEM078_PER;
	val79 = val78 + JAPAN_GIFT_2927_ITEM079_PER;
	val80 = val79 + JAPAN_GIFT_2927_ITEM080_PER;
	val81 = val80 + JAPAN_GIFT_2927_ITEM081_PER;
	val82 = val81 + JAPAN_GIFT_2927_ITEM082_PER;
	val83 = val82 + JAPAN_GIFT_2927_ITEM083_PER;
	val84 = val83 + JAPAN_GIFT_2927_ITEM084_PER;
	val85 = val84 + JAPAN_GIFT_2927_ITEM085_PER;
	val86 = val85 + JAPAN_GIFT_2927_ITEM086_PER;
	val87 = val86 + JAPAN_GIFT_2927_ITEM087_PER;
	val88 = val87 + JAPAN_GIFT_2927_ITEM088_PER;
	val89 = val88 + JAPAN_GIFT_2927_ITEM089_PER;
	val90 = val89 + JAPAN_GIFT_2927_ITEM090_PER;
	val91 = val90 + JAPAN_GIFT_2927_ITEM091_PER;
	val92 = val91 + JAPAN_GIFT_2927_ITEM092_PER;
	val93 = val92 + JAPAN_GIFT_2927_ITEM093_PER;
	val94 = val93 + JAPAN_GIFT_2927_ITEM094_PER;
	val95 = val94 + JAPAN_GIFT_2927_ITEM095_PER;
	val96 = val95 + JAPAN_GIFT_2927_ITEM096_PER;
	val97 = val96 + JAPAN_GIFT_2927_ITEM097_PER;
	val98 = val97 + JAPAN_GIFT_2927_ITEM098_PER;
	val99 = val98 + JAPAN_GIFT_2927_ITEM099_PER;
	val100 = val99 + JAPAN_GIFT_2927_ITEM100_PER;
	val101 = val100 + JAPAN_GIFT_2927_SEED101_PER;
	val102 = val101 + JAPAN_GIFT_2927_SEED102_PER;
	val103 = val102 + JAPAN_GIFT_2927_SEED103_PER;
	val104 = val103 + JAPAN_GIFT_2927_SEED104_PER;
	val105 = val104 + JAPAN_GIFT_2927_SEED105_PER;
	val106 = val105 + JAPAN_GIFT_2927_SEED106_PER;
	val107 = val106 + JAPAN_GIFT_2927_SEED107_PER;
	val108 = val107 + JAPAN_GIFT_2927_SEED108_PER;
	val109 = val108 + JAPAN_GIFT_2927_SEED109_PER;
	val110 = val109 + JAPAN_GIFT_2927_SEED110_PER;
	val111 = val110 + JAPAN_GIFT_2927_MONS111_PER;
	val112 = val111 + JAPAN_GIFT_2927_MONS112_PER;
	val113 = val112 + JAPAN_GIFT_2927_MONS113_PER;
	val114 = val113 + JAPAN_GIFT_2927_MONS114_PER;
	val115 = val114 + JAPAN_GIFT_2927_MONS115_PER;
	val116 = val115 + JAPAN_GIFT_2927_MONS116_PER;
	val117 = val116 + JAPAN_GIFT_2927_MONS117_PER;
	val118 = val117 + JAPAN_GIFT_2927_MONS118_PER;
	val119 = val118 + JAPAN_GIFT_2927_MONS119_PER;
	val120 = val119 + JAPAN_GIFT_2927_MONS120_PER;

	if (val120 != 100000) {
		trigger.message("Percentage Setting is wrong!", MSG_TYPE__SYSTEM);
	    	return;
	}

	rval  = Util.random(1, 100000);
	if      (rval <=val01) {PresentItem = JAPAN_GIFT_2927_ITEM001; GiftType="ITEM";}
	else if (rval <=val02) {PresentItem = JAPAN_GIFT_2927_ITEM002; GiftType="ITEM";}
	else if (rval <=val03) {PresentItem = JAPAN_GIFT_2927_ITEM003; GiftType="ITEM";}
	else if (rval <=val04) {PresentItem = JAPAN_GIFT_2927_ITEM004; GiftType="ITEM";}
	else if (rval <=val05) {PresentItem = JAPAN_GIFT_2927_ITEM005; GiftType="ITEM";}
	else if (rval <=val06) {PresentItem = JAPAN_GIFT_2927_ITEM006; GiftType="ITEM";}
	else if (rval <=val07) {PresentItem = JAPAN_GIFT_2927_ITEM007; GiftType="ITEM";}
	else if (rval <=val08) {PresentItem = JAPAN_GIFT_2927_ITEM008; GiftType="ITEM";}
	else if (rval <=val09) {PresentItem = JAPAN_GIFT_2927_ITEM009; GiftType="ITEM";}
	else if (rval <=val10) {PresentItem = JAPAN_GIFT_2927_ITEM010; GiftType="ITEM";}
	else if (rval <=val11) {PresentItem = JAPAN_GIFT_2927_ITEM011; GiftType="ITEM";}
	else if (rval <=val12) {PresentItem = JAPAN_GIFT_2927_ITEM012; GiftType="ITEM";}
	else if (rval <=val13) {PresentItem = JAPAN_GIFT_2927_ITEM013; GiftType="ITEM";}
	else if (rval <=val14) {PresentItem = JAPAN_GIFT_2927_ITEM014; GiftType="ITEM";}
	else if (rval <=val15) {PresentItem = JAPAN_GIFT_2927_ITEM015; GiftType="ITEM";}
	else if (rval <=val16) {PresentItem = JAPAN_GIFT_2927_ITEM016; GiftType="ITEM";}
	else if (rval <=val17) {PresentItem = JAPAN_GIFT_2927_ITEM017; GiftType="ITEM";}
	else if (rval <=val18) {PresentItem = JAPAN_GIFT_2927_ITEM018; GiftType="ITEM";}
	else if (rval <=val19) {PresentItem = JAPAN_GIFT_2927_ITEM019; GiftType="ITEM";}
	else if (rval <=val20) {PresentItem = JAPAN_GIFT_2927_ITEM020; GiftType="ITEM";}
	else if (rval <=val21) {PresentItem = JAPAN_GIFT_2927_ITEM021; GiftType="ITEM";}
	else if (rval <=val22) {PresentItem = JAPAN_GIFT_2927_ITEM022; GiftType="ITEM";}
	else if (rval <=val23) {PresentItem = JAPAN_GIFT_2927_ITEM023; GiftType="ITEM";}
	else if (rval <=val24) {PresentItem = JAPAN_GIFT_2927_ITEM024; GiftType="ITEM";}
	else if (rval <=val25) {PresentItem = JAPAN_GIFT_2927_ITEM025; GiftType="ITEM";}
	else if (rval <=val26) {PresentItem = JAPAN_GIFT_2927_ITEM026; GiftType="ITEM";}
	else if (rval <=val27) {PresentItem = JAPAN_GIFT_2927_ITEM027; GiftType="ITEM";}
	else if (rval <=val28) {PresentItem = JAPAN_GIFT_2927_ITEM028; GiftType="ITEM";}
	else if (rval <=val29) {PresentItem = JAPAN_GIFT_2927_ITEM029; GiftType="ITEM";}
	else if (rval <=val30) {PresentItem = JAPAN_GIFT_2927_ITEM030; GiftType="ITEM";}
	else if (rval <=val31) {PresentItem = JAPAN_GIFT_2927_ITEM031; GiftType="ITEM";}
	else if (rval <=val32) {PresentItem = JAPAN_GIFT_2927_ITEM032; GiftType="ITEM";}
	else if (rval <=val33) {PresentItem = JAPAN_GIFT_2927_ITEM033; GiftType="ITEM";}
	else if (rval <=val34) {PresentItem = JAPAN_GIFT_2927_ITEM034; GiftType="ITEM";}
	else if (rval <=val35) {PresentItem = JAPAN_GIFT_2927_ITEM035; GiftType="ITEM";}
	else if (rval <=val36) {PresentItem = JAPAN_GIFT_2927_ITEM036; GiftType="ITEM";}
	else if (rval <=val37) {PresentItem = JAPAN_GIFT_2927_ITEM037; GiftType="ITEM";}
	else if (rval <=val38) {PresentItem = JAPAN_GIFT_2927_ITEM038; GiftType="ITEM";}
	else if (rval <=val39) {PresentItem = JAPAN_GIFT_2927_ITEM039; GiftType="ITEM";}
	else if (rval <=val40) {PresentItem = JAPAN_GIFT_2927_ITEM040; GiftType="ITEM";}
	else if (rval <=val41) {PresentItem = JAPAN_GIFT_2927_ITEM041; GiftType="ITEM";}
	else if (rval <=val42) {PresentItem = JAPAN_GIFT_2927_ITEM042; GiftType="ITEM";}
	else if (rval <=val43) {PresentItem = JAPAN_GIFT_2927_ITEM043; GiftType="ITEM";}
	else if (rval <=val44) {PresentItem = JAPAN_GIFT_2927_ITEM044; GiftType="ITEM";}
	else if (rval <=val45) {PresentItem = JAPAN_GIFT_2927_ITEM045; GiftType="ITEM";}
	else if (rval <=val46) {PresentItem = JAPAN_GIFT_2927_ITEM046; GiftType="ITEM";}
	else if (rval <=val47) {PresentItem = JAPAN_GIFT_2927_ITEM047; GiftType="ITEM";}
	else if (rval <=val48) {PresentItem = JAPAN_GIFT_2927_ITEM048; GiftType="ITEM";}
	else if (rval <=val49) {PresentItem = JAPAN_GIFT_2927_ITEM049; GiftType="ITEM";}
	else if (rval <=val50) {PresentItem = JAPAN_GIFT_2927_ITEM050; GiftType="ITEM";}
	else if (rval <=val51) {PresentItem = JAPAN_GIFT_2927_ITEM051; GiftType="ITEM";}
	else if (rval <=val52) {PresentItem = JAPAN_GIFT_2927_ITEM052; GiftType="ITEM";}
	else if (rval <=val53) {PresentItem = JAPAN_GIFT_2927_ITEM053; GiftType="ITEM";}
	else if (rval <=val54) {PresentItem = JAPAN_GIFT_2927_ITEM054; GiftType="ITEM";}
	else if (rval <=val55) {PresentItem = JAPAN_GIFT_2927_ITEM055; GiftType="ITEM";}
	else if (rval <=val56) {PresentItem = JAPAN_GIFT_2927_ITEM056; GiftType="ITEM";}
	else if (rval <=val57) {PresentItem = JAPAN_GIFT_2927_ITEM057; GiftType="ITEM";}
	else if (rval <=val58) {PresentItem = JAPAN_GIFT_2927_ITEM058; GiftType="ITEM";}
	else if (rval <=val59) {PresentItem = JAPAN_GIFT_2927_ITEM059; GiftType="ITEM";}
	else if (rval <=val60) {PresentItem = JAPAN_GIFT_2927_ITEM060; GiftType="ITEM";}
	else if (rval <=val61) {PresentItem = JAPAN_GIFT_2927_ITEM061; GiftType="ITEM";}
	else if (rval <=val62) {PresentItem = JAPAN_GIFT_2927_ITEM062; GiftType="ITEM";}
	else if (rval <=val63) {PresentItem = JAPAN_GIFT_2927_ITEM063; GiftType="ITEM";}
	else if (rval <=val64) {PresentItem = JAPAN_GIFT_2927_ITEM064; GiftType="ITEM";}
	else if (rval <=val65) {PresentItem = JAPAN_GIFT_2927_ITEM065; GiftType="ITEM";}
	else if (rval <=val66) {PresentItem = JAPAN_GIFT_2927_ITEM066; GiftType="ITEM";}
	else if (rval <=val67) {PresentItem = JAPAN_GIFT_2927_ITEM067; GiftType="ITEM";}
	else if (rval <=val68) {PresentItem = JAPAN_GIFT_2927_ITEM068; GiftType="ITEM";}
	else if (rval <=val69) {PresentItem = JAPAN_GIFT_2927_ITEM069; GiftType="ITEM";}
	else if (rval <=val70) {PresentItem = JAPAN_GIFT_2927_ITEM070; GiftType="ITEM";}
	else if (rval <=val71) {PresentItem = JAPAN_GIFT_2927_ITEM071; GiftType="ITEM";}
	else if (rval <=val72) {PresentItem = JAPAN_GIFT_2927_ITEM072; GiftType="ITEM";}
	else if (rval <=val73) {PresentItem = JAPAN_GIFT_2927_ITEM073; GiftType="ITEM";}
	else if (rval <=val74) {PresentItem = JAPAN_GIFT_2927_ITEM074; GiftType="ITEM";}
	else if (rval <=val75) {PresentItem = JAPAN_GIFT_2927_ITEM075; GiftType="ITEM";}
	else if (rval <=val76) {PresentItem = JAPAN_GIFT_2927_ITEM076; GiftType="ITEM";}
	else if (rval <=val77) {PresentItem = JAPAN_GIFT_2927_ITEM077; GiftType="ITEM";}
	else if (rval <=val78) {PresentItem = JAPAN_GIFT_2927_ITEM078; GiftType="ITEM";}
	else if (rval <=val79) {PresentItem = JAPAN_GIFT_2927_ITEM079; GiftType="ITEM";}
	else if (rval <=val80) {PresentItem = JAPAN_GIFT_2927_ITEM080; GiftType="ITEM";}
	else if (rval <=val81) {PresentItem = JAPAN_GIFT_2927_ITEM081; GiftType="ITEM";}
	else if (rval <=val82) {PresentItem = JAPAN_GIFT_2927_ITEM082; GiftType="ITEM";}
	else if (rval <=val83) {PresentItem = JAPAN_GIFT_2927_ITEM083; GiftType="ITEM";}
	else if (rval <=val84) {PresentItem = JAPAN_GIFT_2927_ITEM084; GiftType="ITEM";}
	else if (rval <=val85) {PresentItem = JAPAN_GIFT_2927_ITEM085; GiftType="ITEM";}
	else if (rval <=val86) {PresentItem = JAPAN_GIFT_2927_ITEM086; GiftType="ITEM";}
	else if (rval <=val87) {PresentItem = JAPAN_GIFT_2927_ITEM087; GiftType="ITEM";}
	else if (rval <=val88) {PresentItem = JAPAN_GIFT_2927_ITEM088; GiftType="ITEM";}
	else if (rval <=val89) {PresentItem = JAPAN_GIFT_2927_ITEM089; GiftType="ITEM";}
	else if (rval <=val90) {PresentItem = JAPAN_GIFT_2927_ITEM090; GiftType="ITEM";}
	else if (rval <=val91) {PresentItem = JAPAN_GIFT_2927_ITEM091; GiftType="ITEM";}
	else if (rval <=val92) {PresentItem = JAPAN_GIFT_2927_ITEM092; GiftType="ITEM";}
	else if (rval <=val93) {PresentItem = JAPAN_GIFT_2927_ITEM093; GiftType="ITEM";}
	else if (rval <=val94) {PresentItem = JAPAN_GIFT_2927_ITEM094; GiftType="ITEM";}
	else if (rval <=val95) {PresentItem = JAPAN_GIFT_2927_ITEM095; GiftType="ITEM";}
	else if (rval <=val96) {PresentItem = JAPAN_GIFT_2927_ITEM096; GiftType="ITEM";}
	else if (rval <=val97) {PresentItem = JAPAN_GIFT_2927_ITEM097; GiftType="ITEM";}
	else if (rval <=val98) {PresentItem = JAPAN_GIFT_2927_ITEM098; GiftType="ITEM";}
	else if (rval <=val99) {PresentItem = JAPAN_GIFT_2927_ITEM099; GiftType="ITEM";}
	else if (rval <=val100) {PresentItem = JAPAN_GIFT_2927_ITEM100; GiftType="ITEM";}
	else if (rval <= val101) {PresentSeed = JAPAN_GIFT_2927_SEED101; GiftType="SEED";}
	else if (rval <= val102) {PresentSeed = JAPAN_GIFT_2927_SEED102; GiftType="SEED";}
	else if (rval <= val103) {PresentSeed = JAPAN_GIFT_2927_SEED103; GiftType="SEED";}
	else if (rval <= val104) {PresentSeed = JAPAN_GIFT_2927_SEED104; GiftType="SEED";}
	else if (rval <= val105) {PresentSeed = JAPAN_GIFT_2927_SEED105; GiftType="SEED";}
	else if (rval <= val106) {PresentSeed = JAPAN_GIFT_2927_SEED106; GiftType="SEED";}
	else if (rval <= val107) {PresentSeed = JAPAN_GIFT_2927_SEED107; GiftType="SEED";}
	else if (rval <= val108) {PresentSeed = JAPAN_GIFT_2927_SEED108; GiftType="SEED";}
	else if (rval <= val109) {PresentSeed = JAPAN_GIFT_2927_SEED109; GiftType="SEED";}
	else if (rval <= val110) {PresentSeed = JAPAN_GIFT_2927_SEED110; GiftType="SEED";}
	else if (rval <= val111) {PresentItem = JAPAN_GIFT_2927_MONS111; PTN = JAPAN_GIFT_2927_MONS111_PTN;}
	else if (rval <= val112) {PresentItem = JAPAN_GIFT_2927_MONS112; PTN = JAPAN_GIFT_2927_MONS112_PTN;}
	else if (rval <= val113) {PresentItem = JAPAN_GIFT_2927_MONS113; PTN = JAPAN_GIFT_2927_MONS113_PTN;}
	else if (rval <= val114) {PresentItem = JAPAN_GIFT_2927_MONS114; PTN = JAPAN_GIFT_2927_MONS114_PTN;}
	else if (rval <= val115) {PresentItem = JAPAN_GIFT_2927_MONS115; PTN = JAPAN_GIFT_2927_MONS115_PTN;}
	else if (rval <= val116) {PresentItem = JAPAN_GIFT_2927_MONS116; PTN = JAPAN_GIFT_2927_MONS116_PTN;}
	else if (rval <= val117) {PresentItem = JAPAN_GIFT_2927_MONS117; PTN = JAPAN_GIFT_2927_MONS117_PTN;}
	else if (rval <= val118) {PresentItem = JAPAN_GIFT_2927_MONS118; PTN = JAPAN_GIFT_2927_MONS118_PTN;}
	else if (rval <= val119) {PresentItem = JAPAN_GIFT_2927_MONS119; PTN = JAPAN_GIFT_2927_MONS119_PTN;}
	else if (rval <= val120) {PresentItem = JAPAN_GIFT_2927_MONS120; PTN = JAPAN_GIFT_2927_MONS120_PTN;}
	
	GivePresent_JPN(GiftType, PresentItem, PresentSeed, PTN);
	return;
}


quest
qUseItem1003529()			// Japanese Present Box Item (2004/9)
{
	integer rval;
	integer val01, val02, val03, val04, val05, val06, val07, val08, val09, val10;
	integer	val11, val12, val13, val14, val15, val16, val17, val18, val19, val20;
	integer	val21, val22, val23, val24, val25, val26, val27, val28, val29, val30;
	integer	val31, val32, val33, val34, val35, val36, val37, val38, val39, val40;
	integer	val41, val42, val43, val44, val45, val46, val47, val48, val49, val50;
	integer	val51, val52, val53, val54, val55, val56, val57, val58, val59, val60;
	integer	val61, val62, val63, val64, val65, val66, val67, val68, val69, val70;
	integer	val71, val72, val73, val74, val75, val76, val77, val78, val79, val80;
	integer	val81, val82, val83, val84, val85, val86, val87, val88, val89, val90;
	integer	val91, val92, val93, val94, val95, val96, val97, val98, val99, val100;
	integer	val101, val102, val103, val104, val105, val106, val107, val108, val109, val110;
	integer	val111, val112, val113, val114, val115, val116, val117, val118, val119, val120;
	string	PresentItem, GiftType, PTN;
	integer PresentSeed;
	
	if (CheckPresentMap_JPN()) return;
	if (CheckInventory_JPN(JAPAN_GIFT_2928_INVWT)) return;
	if (CheckRestrictDate_JPN()) {controller.decreaseNumber(1); return;}

	val01 =		JAPAN_GIFT_2928_ITEM001_PER;
	val02 = val01 + JAPAN_GIFT_2928_ITEM002_PER;
	val03 = val02 + JAPAN_GIFT_2928_ITEM003_PER;
	val04 = val03 + JAPAN_GIFT_2928_ITEM004_PER;
	val05 = val04 + JAPAN_GIFT_2928_ITEM005_PER;
	val06 = val05 + JAPAN_GIFT_2928_ITEM006_PER;
	val07 = val06 + JAPAN_GIFT_2928_ITEM007_PER;
	val08 = val07 + JAPAN_GIFT_2928_ITEM008_PER;
	val09 = val08 + JAPAN_GIFT_2928_ITEM009_PER;
	val10 = val09 + JAPAN_GIFT_2928_ITEM010_PER;
	val11 = val10 + JAPAN_GIFT_2928_ITEM011_PER;
	val12 = val11 + JAPAN_GIFT_2928_ITEM012_PER;
	val13 = val12 + JAPAN_GIFT_2928_ITEM013_PER;
	val14 = val13 + JAPAN_GIFT_2928_ITEM014_PER;
	val15 = val14 + JAPAN_GIFT_2928_ITEM015_PER;
	val16 = val15 + JAPAN_GIFT_2928_ITEM016_PER;
	val17 = val16 + JAPAN_GIFT_2928_ITEM017_PER;
	val18 = val17 + JAPAN_GIFT_2928_ITEM018_PER;
	val19 = val18 + JAPAN_GIFT_2928_ITEM019_PER;
	val20 = val19 + JAPAN_GIFT_2928_ITEM020_PER;
	val21 = val20 + JAPAN_GIFT_2928_ITEM021_PER;
	val22 = val21 + JAPAN_GIFT_2928_ITEM022_PER;
	val23 = val22 + JAPAN_GIFT_2928_ITEM023_PER;
	val24 = val23 + JAPAN_GIFT_2928_ITEM024_PER;
	val25 = val24 + JAPAN_GIFT_2928_ITEM025_PER;
	val26 = val25 + JAPAN_GIFT_2928_ITEM026_PER;
	val27 = val26 + JAPAN_GIFT_2928_ITEM027_PER;
	val28 = val27 + JAPAN_GIFT_2928_ITEM028_PER;
	val29 = val28 + JAPAN_GIFT_2928_ITEM029_PER;
	val30 = val29 + JAPAN_GIFT_2928_ITEM030_PER;
	val31 = val30 + JAPAN_GIFT_2928_ITEM031_PER;
	val32 = val31 + JAPAN_GIFT_2928_ITEM032_PER;
	val33 = val32 + JAPAN_GIFT_2928_ITEM033_PER;
	val34 = val33 + JAPAN_GIFT_2928_ITEM034_PER;
	val35 = val34 + JAPAN_GIFT_2928_ITEM035_PER;
	val36 = val35 + JAPAN_GIFT_2928_ITEM036_PER;
	val37 = val36 + JAPAN_GIFT_2928_ITEM037_PER;
	val38 = val37 + JAPAN_GIFT_2928_ITEM038_PER;
	val39 = val38 + JAPAN_GIFT_2928_ITEM039_PER;
	val40 = val39 + JAPAN_GIFT_2928_ITEM040_PER;
	val41 = val40 + JAPAN_GIFT_2928_ITEM041_PER;
	val42 = val41 + JAPAN_GIFT_2928_ITEM042_PER;
	val43 = val42 + JAPAN_GIFT_2928_ITEM043_PER;
	val44 = val43 + JAPAN_GIFT_2928_ITEM044_PER;
	val45 = val44 + JAPAN_GIFT_2928_ITEM045_PER;
	val46 = val45 + JAPAN_GIFT_2928_ITEM046_PER;
	val47 = val46 + JAPAN_GIFT_2928_ITEM047_PER;
	val48 = val47 + JAPAN_GIFT_2928_ITEM048_PER;
	val49 = val48 + JAPAN_GIFT_2928_ITEM049_PER;
	val50 = val49 + JAPAN_GIFT_2928_ITEM050_PER;
	val51 = val50 + JAPAN_GIFT_2928_ITEM051_PER;
	val52 = val51 + JAPAN_GIFT_2928_ITEM052_PER;
	val53 = val52 + JAPAN_GIFT_2928_ITEM053_PER;
	val54 = val53 + JAPAN_GIFT_2928_ITEM054_PER;
	val55 = val54 + JAPAN_GIFT_2928_ITEM055_PER;
	val56 = val55 + JAPAN_GIFT_2928_ITEM056_PER;
	val57 = val56 + JAPAN_GIFT_2928_ITEM057_PER;
	val58 = val57 + JAPAN_GIFT_2928_ITEM058_PER;
	val59 = val58 + JAPAN_GIFT_2928_ITEM059_PER;
	val60 = val59 + JAPAN_GIFT_2928_ITEM060_PER;
	val61 = val60 + JAPAN_GIFT_2928_ITEM061_PER;
	val62 = val61 + JAPAN_GIFT_2928_ITEM062_PER;
	val63 = val62 + JAPAN_GIFT_2928_ITEM063_PER;
	val64 = val63 + JAPAN_GIFT_2928_ITEM064_PER;
	val65 = val64 + JAPAN_GIFT_2928_ITEM065_PER;
	val66 = val65 + JAPAN_GIFT_2928_ITEM066_PER;
	val67 = val66 + JAPAN_GIFT_2928_ITEM067_PER;
	val68 = val67 + JAPAN_GIFT_2928_ITEM068_PER;
	val69 = val68 + JAPAN_GIFT_2928_ITEM069_PER;
	val70 = val69 + JAPAN_GIFT_2928_ITEM070_PER;
	val71 = val70 + JAPAN_GIFT_2928_ITEM071_PER;
	val72 = val71 + JAPAN_GIFT_2928_ITEM072_PER;
	val73 = val72 + JAPAN_GIFT_2928_ITEM073_PER;
	val74 = val73 + JAPAN_GIFT_2928_ITEM074_PER;
	val75 = val74 + JAPAN_GIFT_2928_ITEM075_PER;
	val76 = val75 + JAPAN_GIFT_2928_ITEM076_PER;
	val77 = val76 + JAPAN_GIFT_2928_ITEM077_PER;
	val78 = val77 + JAPAN_GIFT_2928_ITEM078_PER;
	val79 = val78 + JAPAN_GIFT_2928_ITEM079_PER;
	val80 = val79 + JAPAN_GIFT_2928_ITEM080_PER;
	val81 = val80 + JAPAN_GIFT_2928_ITEM081_PER;
	val82 = val81 + JAPAN_GIFT_2928_ITEM082_PER;
	val83 = val82 + JAPAN_GIFT_2928_ITEM083_PER;
	val84 = val83 + JAPAN_GIFT_2928_ITEM084_PER;
	val85 = val84 + JAPAN_GIFT_2928_ITEM085_PER;
	val86 = val85 + JAPAN_GIFT_2928_ITEM086_PER;
	val87 = val86 + JAPAN_GIFT_2928_ITEM087_PER;
	val88 = val87 + JAPAN_GIFT_2928_ITEM088_PER;
	val89 = val88 + JAPAN_GIFT_2928_ITEM089_PER;
	val90 = val89 + JAPAN_GIFT_2928_ITEM090_PER;
	val91 = val90 + JAPAN_GIFT_2928_ITEM091_PER;
	val92 = val91 + JAPAN_GIFT_2928_ITEM092_PER;
	val93 = val92 + JAPAN_GIFT_2928_ITEM093_PER;
	val94 = val93 + JAPAN_GIFT_2928_ITEM094_PER;
	val95 = val94 + JAPAN_GIFT_2928_ITEM095_PER;
	val96 = val95 + JAPAN_GIFT_2928_ITEM096_PER;
	val97 = val96 + JAPAN_GIFT_2928_ITEM097_PER;
	val98 = val97 + JAPAN_GIFT_2928_ITEM098_PER;
	val99 = val98 + JAPAN_GIFT_2928_ITEM099_PER;
	val100 = val99 + JAPAN_GIFT_2928_ITEM100_PER;
	val101 = val100 + JAPAN_GIFT_2928_SEED101_PER;
	val102 = val101 + JAPAN_GIFT_2928_SEED102_PER;
	val103 = val102 + JAPAN_GIFT_2928_SEED103_PER;
	val104 = val103 + JAPAN_GIFT_2928_SEED104_PER;
	val105 = val104 + JAPAN_GIFT_2928_SEED105_PER;
	val106 = val105 + JAPAN_GIFT_2928_SEED106_PER;
	val107 = val106 + JAPAN_GIFT_2928_SEED107_PER;
	val108 = val107 + JAPAN_GIFT_2928_SEED108_PER;
	val109 = val108 + JAPAN_GIFT_2928_SEED109_PER;
	val110 = val109 + JAPAN_GIFT_2928_SEED110_PER;
	val111 = val110 + JAPAN_GIFT_2928_MONS111_PER;
	val112 = val111 + JAPAN_GIFT_2928_MONS112_PER;
	val113 = val112 + JAPAN_GIFT_2928_MONS113_PER;
	val114 = val113 + JAPAN_GIFT_2928_MONS114_PER;
	val115 = val114 + JAPAN_GIFT_2928_MONS115_PER;
	val116 = val115 + JAPAN_GIFT_2928_MONS116_PER;
	val117 = val116 + JAPAN_GIFT_2928_MONS117_PER;
	val118 = val117 + JAPAN_GIFT_2928_MONS118_PER;
	val119 = val118 + JAPAN_GIFT_2928_MONS119_PER;
	val120 = val119 + JAPAN_GIFT_2928_MONS120_PER;

	if (val120 != 100000) {
		trigger.message("Percentage Setting is wrong!", MSG_TYPE__SYSTEM);
	    	return;
	}

	rval  = Util.random(1, 100000);
	if      (rval <=val01) {PresentItem = JAPAN_GIFT_2928_ITEM001; GiftType="ITEM";}
	else if (rval <=val02) {PresentItem = JAPAN_GIFT_2928_ITEM002; GiftType="ITEM";}
	else if (rval <=val03) {PresentItem = JAPAN_GIFT_2928_ITEM003; GiftType="ITEM";}
	else if (rval <=val04) {PresentItem = JAPAN_GIFT_2928_ITEM004; GiftType="ITEM";}
	else if (rval <=val05) {PresentItem = JAPAN_GIFT_2928_ITEM005; GiftType="ITEM";}
	else if (rval <=val06) {PresentItem = JAPAN_GIFT_2928_ITEM006; GiftType="ITEM";}
	else if (rval <=val07) {PresentItem = JAPAN_GIFT_2928_ITEM007; GiftType="ITEM";}
	else if (rval <=val08) {PresentItem = JAPAN_GIFT_2928_ITEM008; GiftType="ITEM";}
	else if (rval <=val09) {PresentItem = JAPAN_GIFT_2928_ITEM009; GiftType="ITEM";}
	else if (rval <=val10) {PresentItem = JAPAN_GIFT_2928_ITEM010; GiftType="ITEM";}
	else if (rval <=val11) {PresentItem = JAPAN_GIFT_2928_ITEM011; GiftType="ITEM";}
	else if (rval <=val12) {PresentItem = JAPAN_GIFT_2928_ITEM012; GiftType="ITEM";}
	else if (rval <=val13) {PresentItem = JAPAN_GIFT_2928_ITEM013; GiftType="ITEM";}
	else if (rval <=val14) {PresentItem = JAPAN_GIFT_2928_ITEM014; GiftType="ITEM";}
	else if (rval <=val15) {PresentItem = JAPAN_GIFT_2928_ITEM015; GiftType="ITEM";}
	else if (rval <=val16) {PresentItem = JAPAN_GIFT_2928_ITEM016; GiftType="ITEM";}
	else if (rval <=val17) {PresentItem = JAPAN_GIFT_2928_ITEM017; GiftType="ITEM";}
	else if (rval <=val18) {PresentItem = JAPAN_GIFT_2928_ITEM018; GiftType="ITEM";}
	else if (rval <=val19) {PresentItem = JAPAN_GIFT_2928_ITEM019; GiftType="ITEM";}
	else if (rval <=val20) {PresentItem = JAPAN_GIFT_2928_ITEM020; GiftType="ITEM";}
	else if (rval <=val21) {PresentItem = JAPAN_GIFT_2928_ITEM021; GiftType="ITEM";}
	else if (rval <=val22) {PresentItem = JAPAN_GIFT_2928_ITEM022; GiftType="ITEM";}
	else if (rval <=val23) {PresentItem = JAPAN_GIFT_2928_ITEM023; GiftType="ITEM";}
	else if (rval <=val24) {PresentItem = JAPAN_GIFT_2928_ITEM024; GiftType="ITEM";}
	else if (rval <=val25) {PresentItem = JAPAN_GIFT_2928_ITEM025; GiftType="ITEM";}
	else if (rval <=val26) {PresentItem = JAPAN_GIFT_2928_ITEM026; GiftType="ITEM";}
	else if (rval <=val27) {PresentItem = JAPAN_GIFT_2928_ITEM027; GiftType="ITEM";}
	else if (rval <=val28) {PresentItem = JAPAN_GIFT_2928_ITEM028; GiftType="ITEM";}
	else if (rval <=val29) {PresentItem = JAPAN_GIFT_2928_ITEM029; GiftType="ITEM";}
	else if (rval <=val30) {PresentItem = JAPAN_GIFT_2928_ITEM030; GiftType="ITEM";}
	else if (rval <=val31) {PresentItem = JAPAN_GIFT_2928_ITEM031; GiftType="ITEM";}
	else if (rval <=val32) {PresentItem = JAPAN_GIFT_2928_ITEM032; GiftType="ITEM";}
	else if (rval <=val33) {PresentItem = JAPAN_GIFT_2928_ITEM033; GiftType="ITEM";}
	else if (rval <=val34) {PresentItem = JAPAN_GIFT_2928_ITEM034; GiftType="ITEM";}
	else if (rval <=val35) {PresentItem = JAPAN_GIFT_2928_ITEM035; GiftType="ITEM";}
	else if (rval <=val36) {PresentItem = JAPAN_GIFT_2928_ITEM036; GiftType="ITEM";}
	else if (rval <=val37) {PresentItem = JAPAN_GIFT_2928_ITEM037; GiftType="ITEM";}
	else if (rval <=val38) {PresentItem = JAPAN_GIFT_2928_ITEM038; GiftType="ITEM";}
	else if (rval <=val39) {PresentItem = JAPAN_GIFT_2928_ITEM039; GiftType="ITEM";}
	else if (rval <=val40) {PresentItem = JAPAN_GIFT_2928_ITEM040; GiftType="ITEM";}
	else if (rval <=val41) {PresentItem = JAPAN_GIFT_2928_ITEM041; GiftType="ITEM";}
	else if (rval <=val42) {PresentItem = JAPAN_GIFT_2928_ITEM042; GiftType="ITEM";}
	else if (rval <=val43) {PresentItem = JAPAN_GIFT_2928_ITEM043; GiftType="ITEM";}
	else if (rval <=val44) {PresentItem = JAPAN_GIFT_2928_ITEM044; GiftType="ITEM";}
	else if (rval <=val45) {PresentItem = JAPAN_GIFT_2928_ITEM045; GiftType="ITEM";}
	else if (rval <=val46) {PresentItem = JAPAN_GIFT_2928_ITEM046; GiftType="ITEM";}
	else if (rval <=val47) {PresentItem = JAPAN_GIFT_2928_ITEM047; GiftType="ITEM";}
	else if (rval <=val48) {PresentItem = JAPAN_GIFT_2928_ITEM048; GiftType="ITEM";}
	else if (rval <=val49) {PresentItem = JAPAN_GIFT_2928_ITEM049; GiftType="ITEM";}
	else if (rval <=val50) {PresentItem = JAPAN_GIFT_2928_ITEM050; GiftType="ITEM";}
	else if (rval <=val51) {PresentItem = JAPAN_GIFT_2928_ITEM051; GiftType="ITEM";}
	else if (rval <=val52) {PresentItem = JAPAN_GIFT_2928_ITEM052; GiftType="ITEM";}
	else if (rval <=val53) {PresentItem = JAPAN_GIFT_2928_ITEM053; GiftType="ITEM";}
	else if (rval <=val54) {PresentItem = JAPAN_GIFT_2928_ITEM054; GiftType="ITEM";}
	else if (rval <=val55) {PresentItem = JAPAN_GIFT_2928_ITEM055; GiftType="ITEM";}
	else if (rval <=val56) {PresentItem = JAPAN_GIFT_2928_ITEM056; GiftType="ITEM";}
	else if (rval <=val57) {PresentItem = JAPAN_GIFT_2928_ITEM057; GiftType="ITEM";}
	else if (rval <=val58) {PresentItem = JAPAN_GIFT_2928_ITEM058; GiftType="ITEM";}
	else if (rval <=val59) {PresentItem = JAPAN_GIFT_2928_ITEM059; GiftType="ITEM";}
	else if (rval <=val60) {PresentItem = JAPAN_GIFT_2928_ITEM060; GiftType="ITEM";}
	else if (rval <=val61) {PresentItem = JAPAN_GIFT_2928_ITEM061; GiftType="ITEM";}
	else if (rval <=val62) {PresentItem = JAPAN_GIFT_2928_ITEM062; GiftType="ITEM";}
	else if (rval <=val63) {PresentItem = JAPAN_GIFT_2928_ITEM063; GiftType="ITEM";}
	else if (rval <=val64) {PresentItem = JAPAN_GIFT_2928_ITEM064; GiftType="ITEM";}
	else if (rval <=val65) {PresentItem = JAPAN_GIFT_2928_ITEM065; GiftType="ITEM";}
	else if (rval <=val66) {PresentItem = JAPAN_GIFT_2928_ITEM066; GiftType="ITEM";}
	else if (rval <=val67) {PresentItem = JAPAN_GIFT_2928_ITEM067; GiftType="ITEM";}
	else if (rval <=val68) {PresentItem = JAPAN_GIFT_2928_ITEM068; GiftType="ITEM";}
	else if (rval <=val69) {PresentItem = JAPAN_GIFT_2928_ITEM069; GiftType="ITEM";}
	else if (rval <=val70) {PresentItem = JAPAN_GIFT_2928_ITEM070; GiftType="ITEM";}
	else if (rval <=val71) {PresentItem = JAPAN_GIFT_2928_ITEM071; GiftType="ITEM";}
	else if (rval <=val72) {PresentItem = JAPAN_GIFT_2928_ITEM072; GiftType="ITEM";}
	else if (rval <=val73) {PresentItem = JAPAN_GIFT_2928_ITEM073; GiftType="ITEM";}
	else if (rval <=val74) {PresentItem = JAPAN_GIFT_2928_ITEM074; GiftType="ITEM";}
	else if (rval <=val75) {PresentItem = JAPAN_GIFT_2928_ITEM075; GiftType="ITEM";}
	else if (rval <=val76) {PresentItem = JAPAN_GIFT_2928_ITEM076; GiftType="ITEM";}
	else if (rval <=val77) {PresentItem = JAPAN_GIFT_2928_ITEM077; GiftType="ITEM";}
	else if (rval <=val78) {PresentItem = JAPAN_GIFT_2928_ITEM078; GiftType="ITEM";}
	else if (rval <=val79) {PresentItem = JAPAN_GIFT_2928_ITEM079; GiftType="ITEM";}
	else if (rval <=val80) {PresentItem = JAPAN_GIFT_2928_ITEM080; GiftType="ITEM";}
	else if (rval <=val81) {PresentItem = JAPAN_GIFT_2928_ITEM081; GiftType="ITEM";}
	else if (rval <=val82) {PresentItem = JAPAN_GIFT_2928_ITEM082; GiftType="ITEM";}
	else if (rval <=val83) {PresentItem = JAPAN_GIFT_2928_ITEM083; GiftType="ITEM";}
	else if (rval <=val84) {PresentItem = JAPAN_GIFT_2928_ITEM084; GiftType="ITEM";}
	else if (rval <=val85) {PresentItem = JAPAN_GIFT_2928_ITEM085; GiftType="ITEM";}
	else if (rval <=val86) {PresentItem = JAPAN_GIFT_2928_ITEM086; GiftType="ITEM";}
	else if (rval <=val87) {PresentItem = JAPAN_GIFT_2928_ITEM087; GiftType="ITEM";}
	else if (rval <=val88) {PresentItem = JAPAN_GIFT_2928_ITEM088; GiftType="ITEM";}
	else if (rval <=val89) {PresentItem = JAPAN_GIFT_2928_ITEM089; GiftType="ITEM";}
	else if (rval <=val90) {PresentItem = JAPAN_GIFT_2928_ITEM090; GiftType="ITEM";}
	else if (rval <=val91) {PresentItem = JAPAN_GIFT_2928_ITEM091; GiftType="ITEM";}
	else if (rval <=val92) {PresentItem = JAPAN_GIFT_2928_ITEM092; GiftType="ITEM";}
	else if (rval <=val93) {PresentItem = JAPAN_GIFT_2928_ITEM093; GiftType="ITEM";}
	else if (rval <=val94) {PresentItem = JAPAN_GIFT_2928_ITEM094; GiftType="ITEM";}
	else if (rval <=val95) {PresentItem = JAPAN_GIFT_2928_ITEM095; GiftType="ITEM";}
	else if (rval <=val96) {PresentItem = JAPAN_GIFT_2928_ITEM096; GiftType="ITEM";}
	else if (rval <=val97) {PresentItem = JAPAN_GIFT_2928_ITEM097; GiftType="ITEM";}
	else if (rval <=val98) {PresentItem = JAPAN_GIFT_2928_ITEM098; GiftType="ITEM";}
	else if (rval <=val99) {PresentItem = JAPAN_GIFT_2928_ITEM099; GiftType="ITEM";}
	else if (rval <=val100) {PresentItem = JAPAN_GIFT_2928_ITEM100; GiftType="ITEM";}
	else if (rval <= val101) {PresentSeed = JAPAN_GIFT_2928_SEED101; GiftType="SEED";}
	else if (rval <= val102) {PresentSeed = JAPAN_GIFT_2928_SEED102; GiftType="SEED";}
	else if (rval <= val103) {PresentSeed = JAPAN_GIFT_2928_SEED103; GiftType="SEED";}
	else if (rval <= val104) {PresentSeed = JAPAN_GIFT_2928_SEED104; GiftType="SEED";}
	else if (rval <= val105) {PresentSeed = JAPAN_GIFT_2928_SEED105; GiftType="SEED";}
	else if (rval <= val106) {PresentSeed = JAPAN_GIFT_2928_SEED106; GiftType="SEED";}
	else if (rval <= val107) {PresentSeed = JAPAN_GIFT_2928_SEED107; GiftType="SEED";}
	else if (rval <= val108) {PresentSeed = JAPAN_GIFT_2928_SEED108; GiftType="SEED";}
	else if (rval <= val109) {PresentSeed = JAPAN_GIFT_2928_SEED109; GiftType="SEED";}
	else if (rval <= val110) {PresentSeed = JAPAN_GIFT_2928_SEED110; GiftType="SEED";}
	else if (rval <= val111) {PresentItem = JAPAN_GIFT_2928_MONS111; PTN = JAPAN_GIFT_2928_MONS111_PTN;}
	else if (rval <= val112) {PresentItem = JAPAN_GIFT_2928_MONS112; PTN = JAPAN_GIFT_2928_MONS112_PTN;}
	else if (rval <= val113) {PresentItem = JAPAN_GIFT_2928_MONS113; PTN = JAPAN_GIFT_2928_MONS113_PTN;}
	else if (rval <= val114) {PresentItem = JAPAN_GIFT_2928_MONS114; PTN = JAPAN_GIFT_2928_MONS114_PTN;}
	else if (rval <= val115) {PresentItem = JAPAN_GIFT_2928_MONS115; PTN = JAPAN_GIFT_2928_MONS115_PTN;}
	else if (rval <= val116) {PresentItem = JAPAN_GIFT_2928_MONS116; PTN = JAPAN_GIFT_2928_MONS116_PTN;}
	else if (rval <= val117) {PresentItem = JAPAN_GIFT_2928_MONS117; PTN = JAPAN_GIFT_2928_MONS117_PTN;}
	else if (rval <= val118) {PresentItem = JAPAN_GIFT_2928_MONS118; PTN = JAPAN_GIFT_2928_MONS118_PTN;}
	else if (rval <= val119) {PresentItem = JAPAN_GIFT_2928_MONS119; PTN = JAPAN_GIFT_2928_MONS119_PTN;}
	else if (rval <= val120) {PresentItem = JAPAN_GIFT_2928_MONS120; PTN = JAPAN_GIFT_2928_MONS120_PTN;}
	
	GivePresent_JPN(GiftType, PresentItem, PresentSeed, PTN);
	return;
}



quest
qUseItem1003530()			// Japanese Present Box Item (2004/9)
{
	integer rval;
	integer val01, val02, val03, val04, val05, val06, val07, val08, val09, val10;
	integer	val11, val12, val13, val14, val15, val16, val17, val18, val19, val20;
	integer	val21, val22, val23, val24, val25, val26, val27, val28, val29, val30;
	integer	val31, val32, val33, val34, val35, val36, val37, val38, val39, val40;
	integer	val41, val42, val43, val44, val45, val46, val47, val48, val49, val50;
	integer	val51, val52, val53, val54, val55, val56, val57, val58, val59, val60;
	integer	val61, val62, val63, val64, val65, val66, val67, val68, val69, val70;
	integer	val71, val72, val73, val74, val75, val76, val77, val78, val79, val80;
	integer	val81, val82, val83, val84, val85, val86, val87, val88, val89, val90;
	integer	val91, val92, val93, val94, val95, val96, val97, val98, val99, val100;
	integer	val101, val102, val103, val104, val105, val106, val107, val108, val109, val110;
	integer	val111, val112, val113, val114, val115, val116, val117, val118, val119, val120;
	string	PresentItem, GiftType, PTN;
	integer PresentSeed;
	
	if (CheckPresentMap_JPN()) return;
	if (CheckInventory_JPN(JAPAN_GIFT_2929_INVWT)) return;
	if (CheckRestrictDate_JPN()) {controller.decreaseNumber(1); return;}

	val01 =		JAPAN_GIFT_2929_ITEM001_PER;
	val02 = val01 + JAPAN_GIFT_2929_ITEM002_PER;
	val03 = val02 + JAPAN_GIFT_2929_ITEM003_PER;
	val04 = val03 + JAPAN_GIFT_2929_ITEM004_PER;
	val05 = val04 + JAPAN_GIFT_2929_ITEM005_PER;
	val06 = val05 + JAPAN_GIFT_2929_ITEM006_PER;
	val07 = val06 + JAPAN_GIFT_2929_ITEM007_PER;
	val08 = val07 + JAPAN_GIFT_2929_ITEM008_PER;
	val09 = val08 + JAPAN_GIFT_2929_ITEM009_PER;
	val10 = val09 + JAPAN_GIFT_2929_ITEM010_PER;
	val11 = val10 + JAPAN_GIFT_2929_ITEM011_PER;
	val12 = val11 + JAPAN_GIFT_2929_ITEM012_PER;
	val13 = val12 + JAPAN_GIFT_2929_ITEM013_PER;
	val14 = val13 + JAPAN_GIFT_2929_ITEM014_PER;
	val15 = val14 + JAPAN_GIFT_2929_ITEM015_PER;
	val16 = val15 + JAPAN_GIFT_2929_ITEM016_PER;
	val17 = val16 + JAPAN_GIFT_2929_ITEM017_PER;
	val18 = val17 + JAPAN_GIFT_2929_ITEM018_PER;
	val19 = val18 + JAPAN_GIFT_2929_ITEM019_PER;
	val20 = val19 + JAPAN_GIFT_2929_ITEM020_PER;
	val21 = val20 + JAPAN_GIFT_2929_ITEM021_PER;
	val22 = val21 + JAPAN_GIFT_2929_ITEM022_PER;
	val23 = val22 + JAPAN_GIFT_2929_ITEM023_PER;
	val24 = val23 + JAPAN_GIFT_2929_ITEM024_PER;
	val25 = val24 + JAPAN_GIFT_2929_ITEM025_PER;
	val26 = val25 + JAPAN_GIFT_2929_ITEM026_PER;
	val27 = val26 + JAPAN_GIFT_2929_ITEM027_PER;
	val28 = val27 + JAPAN_GIFT_2929_ITEM028_PER;
	val29 = val28 + JAPAN_GIFT_2929_ITEM029_PER;
	val30 = val29 + JAPAN_GIFT_2929_ITEM030_PER;
	val31 = val30 + JAPAN_GIFT_2929_ITEM031_PER;
	val32 = val31 + JAPAN_GIFT_2929_ITEM032_PER;
	val33 = val32 + JAPAN_GIFT_2929_ITEM033_PER;
	val34 = val33 + JAPAN_GIFT_2929_ITEM034_PER;
	val35 = val34 + JAPAN_GIFT_2929_ITEM035_PER;
	val36 = val35 + JAPAN_GIFT_2929_ITEM036_PER;
	val37 = val36 + JAPAN_GIFT_2929_ITEM037_PER;
	val38 = val37 + JAPAN_GIFT_2929_ITEM038_PER;
	val39 = val38 + JAPAN_GIFT_2929_ITEM039_PER;
	val40 = val39 + JAPAN_GIFT_2929_ITEM040_PER;
	val41 = val40 + JAPAN_GIFT_2929_ITEM041_PER;
	val42 = val41 + JAPAN_GIFT_2929_ITEM042_PER;
	val43 = val42 + JAPAN_GIFT_2929_ITEM043_PER;
	val44 = val43 + JAPAN_GIFT_2929_ITEM044_PER;
	val45 = val44 + JAPAN_GIFT_2929_ITEM045_PER;
	val46 = val45 + JAPAN_GIFT_2929_ITEM046_PER;
	val47 = val46 + JAPAN_GIFT_2929_ITEM047_PER;
	val48 = val47 + JAPAN_GIFT_2929_ITEM048_PER;
	val49 = val48 + JAPAN_GIFT_2929_ITEM049_PER;
	val50 = val49 + JAPAN_GIFT_2929_ITEM050_PER;
	val51 = val50 + JAPAN_GIFT_2929_ITEM051_PER;
	val52 = val51 + JAPAN_GIFT_2929_ITEM052_PER;
	val53 = val52 + JAPAN_GIFT_2929_ITEM053_PER;
	val54 = val53 + JAPAN_GIFT_2929_ITEM054_PER;
	val55 = val54 + JAPAN_GIFT_2929_ITEM055_PER;
	val56 = val55 + JAPAN_GIFT_2929_ITEM056_PER;
	val57 = val56 + JAPAN_GIFT_2929_ITEM057_PER;
	val58 = val57 + JAPAN_GIFT_2929_ITEM058_PER;
	val59 = val58 + JAPAN_GIFT_2929_ITEM059_PER;
	val60 = val59 + JAPAN_GIFT_2929_ITEM060_PER;
	val61 = val60 + JAPAN_GIFT_2929_ITEM061_PER;
	val62 = val61 + JAPAN_GIFT_2929_ITEM062_PER;
	val63 = val62 + JAPAN_GIFT_2929_ITEM063_PER;
	val64 = val63 + JAPAN_GIFT_2929_ITEM064_PER;
	val65 = val64 + JAPAN_GIFT_2929_ITEM065_PER;
	val66 = val65 + JAPAN_GIFT_2929_ITEM066_PER;
	val67 = val66 + JAPAN_GIFT_2929_ITEM067_PER;
	val68 = val67 + JAPAN_GIFT_2929_ITEM068_PER;
	val69 = val68 + JAPAN_GIFT_2929_ITEM069_PER;
	val70 = val69 + JAPAN_GIFT_2929_ITEM070_PER;
	val71 = val70 + JAPAN_GIFT_2929_ITEM071_PER;
	val72 = val71 + JAPAN_GIFT_2929_ITEM072_PER;
	val73 = val72 + JAPAN_GIFT_2929_ITEM073_PER;
	val74 = val73 + JAPAN_GIFT_2929_ITEM074_PER;
	val75 = val74 + JAPAN_GIFT_2929_ITEM075_PER;
	val76 = val75 + JAPAN_GIFT_2929_ITEM076_PER;
	val77 = val76 + JAPAN_GIFT_2929_ITEM077_PER;
	val78 = val77 + JAPAN_GIFT_2929_ITEM078_PER;
	val79 = val78 + JAPAN_GIFT_2929_ITEM079_PER;
	val80 = val79 + JAPAN_GIFT_2929_ITEM080_PER;
	val81 = val80 + JAPAN_GIFT_2929_ITEM081_PER;
	val82 = val81 + JAPAN_GIFT_2929_ITEM082_PER;
	val83 = val82 + JAPAN_GIFT_2929_ITEM083_PER;
	val84 = val83 + JAPAN_GIFT_2929_ITEM084_PER;
	val85 = val84 + JAPAN_GIFT_2929_ITEM085_PER;
	val86 = val85 + JAPAN_GIFT_2929_ITEM086_PER;
	val87 = val86 + JAPAN_GIFT_2929_ITEM087_PER;
	val88 = val87 + JAPAN_GIFT_2929_ITEM088_PER;
	val89 = val88 + JAPAN_GIFT_2929_ITEM089_PER;
	val90 = val89 + JAPAN_GIFT_2929_ITEM090_PER;
	val91 = val90 + JAPAN_GIFT_2929_ITEM091_PER;
	val92 = val91 + JAPAN_GIFT_2929_ITEM092_PER;
	val93 = val92 + JAPAN_GIFT_2929_ITEM093_PER;
	val94 = val93 + JAPAN_GIFT_2929_ITEM094_PER;
	val95 = val94 + JAPAN_GIFT_2929_ITEM095_PER;
	val96 = val95 + JAPAN_GIFT_2929_ITEM096_PER;
	val97 = val96 + JAPAN_GIFT_2929_ITEM097_PER;
	val98 = val97 + JAPAN_GIFT_2929_ITEM098_PER;
	val99 = val98 + JAPAN_GIFT_2929_ITEM099_PER;
	val100 = val99 + JAPAN_GIFT_2929_ITEM100_PER;
	val101 = val100 + JAPAN_GIFT_2929_SEED101_PER;
	val102 = val101 + JAPAN_GIFT_2929_SEED102_PER;
	val103 = val102 + JAPAN_GIFT_2929_SEED103_PER;
	val104 = val103 + JAPAN_GIFT_2929_SEED104_PER;
	val105 = val104 + JAPAN_GIFT_2929_SEED105_PER;
	val106 = val105 + JAPAN_GIFT_2929_SEED106_PER;
	val107 = val106 + JAPAN_GIFT_2929_SEED107_PER;
	val108 = val107 + JAPAN_GIFT_2929_SEED108_PER;
	val109 = val108 + JAPAN_GIFT_2929_SEED109_PER;
	val110 = val109 + JAPAN_GIFT_2929_SEED110_PER;
	val111 = val110 + JAPAN_GIFT_2929_MONS111_PER;
	val112 = val111 + JAPAN_GIFT_2929_MONS112_PER;
	val113 = val112 + JAPAN_GIFT_2929_MONS113_PER;
	val114 = val113 + JAPAN_GIFT_2929_MONS114_PER;
	val115 = val114 + JAPAN_GIFT_2929_MONS115_PER;
	val116 = val115 + JAPAN_GIFT_2929_MONS116_PER;
	val117 = val116 + JAPAN_GIFT_2929_MONS117_PER;
	val118 = val117 + JAPAN_GIFT_2929_MONS118_PER;
	val119 = val118 + JAPAN_GIFT_2929_MONS119_PER;
	val120 = val119 + JAPAN_GIFT_2929_MONS120_PER;

	if (val120 != 100000) {
		trigger.message("Percentage Setting is wrong!", MSG_TYPE__SYSTEM);
	    	return;
	}

	rval  = Util.random(1, 100000);
	if      (rval <=val01) {PresentItem = JAPAN_GIFT_2929_ITEM001; GiftType="ITEM";}
	else if (rval <=val02) {PresentItem = JAPAN_GIFT_2929_ITEM002; GiftType="ITEM";}
	else if (rval <=val03) {PresentItem = JAPAN_GIFT_2929_ITEM003; GiftType="ITEM";}
	else if (rval <=val04) {PresentItem = JAPAN_GIFT_2929_ITEM004; GiftType="ITEM";}
	else if (rval <=val05) {PresentItem = JAPAN_GIFT_2929_ITEM005; GiftType="ITEM";}
	else if (rval <=val06) {PresentItem = JAPAN_GIFT_2929_ITEM006; GiftType="ITEM";}
	else if (rval <=val07) {PresentItem = JAPAN_GIFT_2929_ITEM007; GiftType="ITEM";}
	else if (rval <=val08) {PresentItem = JAPAN_GIFT_2929_ITEM008; GiftType="ITEM";}
	else if (rval <=val09) {PresentItem = JAPAN_GIFT_2929_ITEM009; GiftType="ITEM";}
	else if (rval <=val10) {PresentItem = JAPAN_GIFT_2929_ITEM010; GiftType="ITEM";}
	else if (rval <=val11) {PresentItem = JAPAN_GIFT_2929_ITEM011; GiftType="ITEM";}
	else if (rval <=val12) {PresentItem = JAPAN_GIFT_2929_ITEM012; GiftType="ITEM";}
	else if (rval <=val13) {PresentItem = JAPAN_GIFT_2929_ITEM013; GiftType="ITEM";}
	else if (rval <=val14) {PresentItem = JAPAN_GIFT_2929_ITEM014; GiftType="ITEM";}
	else if (rval <=val15) {PresentItem = JAPAN_GIFT_2929_ITEM015; GiftType="ITEM";}
	else if (rval <=val16) {PresentItem = JAPAN_GIFT_2929_ITEM016; GiftType="ITEM";}
	else if (rval <=val17) {PresentItem = JAPAN_GIFT_2929_ITEM017; GiftType="ITEM";}
	else if (rval <=val18) {PresentItem = JAPAN_GIFT_2929_ITEM018; GiftType="ITEM";}
	else if (rval <=val19) {PresentItem = JAPAN_GIFT_2929_ITEM019; GiftType="ITEM";}
	else if (rval <=val20) {PresentItem = JAPAN_GIFT_2929_ITEM020; GiftType="ITEM";}
	else if (rval <=val21) {PresentItem = JAPAN_GIFT_2929_ITEM021; GiftType="ITEM";}
	else if (rval <=val22) {PresentItem = JAPAN_GIFT_2929_ITEM022; GiftType="ITEM";}
	else if (rval <=val23) {PresentItem = JAPAN_GIFT_2929_ITEM023; GiftType="ITEM";}
	else if (rval <=val24) {PresentItem = JAPAN_GIFT_2929_ITEM024; GiftType="ITEM";}
	else if (rval <=val25) {PresentItem = JAPAN_GIFT_2929_ITEM025; GiftType="ITEM";}
	else if (rval <=val26) {PresentItem = JAPAN_GIFT_2929_ITEM026; GiftType="ITEM";}
	else if (rval <=val27) {PresentItem = JAPAN_GIFT_2929_ITEM027; GiftType="ITEM";}
	else if (rval <=val28) {PresentItem = JAPAN_GIFT_2929_ITEM028; GiftType="ITEM";}
	else if (rval <=val29) {PresentItem = JAPAN_GIFT_2929_ITEM029; GiftType="ITEM";}
	else if (rval <=val30) {PresentItem = JAPAN_GIFT_2929_ITEM030; GiftType="ITEM";}
	else if (rval <=val31) {PresentItem = JAPAN_GIFT_2929_ITEM031; GiftType="ITEM";}
	else if (rval <=val32) {PresentItem = JAPAN_GIFT_2929_ITEM032; GiftType="ITEM";}
	else if (rval <=val33) {PresentItem = JAPAN_GIFT_2929_ITEM033; GiftType="ITEM";}
	else if (rval <=val34) {PresentItem = JAPAN_GIFT_2929_ITEM034; GiftType="ITEM";}
	else if (rval <=val35) {PresentItem = JAPAN_GIFT_2929_ITEM035; GiftType="ITEM";}
	else if (rval <=val36) {PresentItem = JAPAN_GIFT_2929_ITEM036; GiftType="ITEM";}
	else if (rval <=val37) {PresentItem = JAPAN_GIFT_2929_ITEM037; GiftType="ITEM";}
	else if (rval <=val38) {PresentItem = JAPAN_GIFT_2929_ITEM038; GiftType="ITEM";}
	else if (rval <=val39) {PresentItem = JAPAN_GIFT_2929_ITEM039; GiftType="ITEM";}
	else if (rval <=val40) {PresentItem = JAPAN_GIFT_2929_ITEM040; GiftType="ITEM";}
	else if (rval <=val41) {PresentItem = JAPAN_GIFT_2929_ITEM041; GiftType="ITEM";}
	else if (rval <=val42) {PresentItem = JAPAN_GIFT_2929_ITEM042; GiftType="ITEM";}
	else if (rval <=val43) {PresentItem = JAPAN_GIFT_2929_ITEM043; GiftType="ITEM";}
	else if (rval <=val44) {PresentItem = JAPAN_GIFT_2929_ITEM044; GiftType="ITEM";}
	else if (rval <=val45) {PresentItem = JAPAN_GIFT_2929_ITEM045; GiftType="ITEM";}
	else if (rval <=val46) {PresentItem = JAPAN_GIFT_2929_ITEM046; GiftType="ITEM";}
	else if (rval <=val47) {PresentItem = JAPAN_GIFT_2929_ITEM047; GiftType="ITEM";}
	else if (rval <=val48) {PresentItem = JAPAN_GIFT_2929_ITEM048; GiftType="ITEM";}
	else if (rval <=val49) {PresentItem = JAPAN_GIFT_2929_ITEM049; GiftType="ITEM";}
	else if (rval <=val50) {PresentItem = JAPAN_GIFT_2929_ITEM050; GiftType="ITEM";}
	else if (rval <=val51) {PresentItem = JAPAN_GIFT_2929_ITEM051; GiftType="ITEM";}
	else if (rval <=val52) {PresentItem = JAPAN_GIFT_2929_ITEM052; GiftType="ITEM";}
	else if (rval <=val53) {PresentItem = JAPAN_GIFT_2929_ITEM053; GiftType="ITEM";}
	else if (rval <=val54) {PresentItem = JAPAN_GIFT_2929_ITEM054; GiftType="ITEM";}
	else if (rval <=val55) {PresentItem = JAPAN_GIFT_2929_ITEM055; GiftType="ITEM";}
	else if (rval <=val56) {PresentItem = JAPAN_GIFT_2929_ITEM056; GiftType="ITEM";}
	else if (rval <=val57) {PresentItem = JAPAN_GIFT_2929_ITEM057; GiftType="ITEM";}
	else if (rval <=val58) {PresentItem = JAPAN_GIFT_2929_ITEM058; GiftType="ITEM";}
	else if (rval <=val59) {PresentItem = JAPAN_GIFT_2929_ITEM059; GiftType="ITEM";}
	else if (rval <=val60) {PresentItem = JAPAN_GIFT_2929_ITEM060; GiftType="ITEM";}
	else if (rval <=val61) {PresentItem = JAPAN_GIFT_2929_ITEM061; GiftType="ITEM";}
	else if (rval <=val62) {PresentItem = JAPAN_GIFT_2929_ITEM062; GiftType="ITEM";}
	else if (rval <=val63) {PresentItem = JAPAN_GIFT_2929_ITEM063; GiftType="ITEM";}
	else if (rval <=val64) {PresentItem = JAPAN_GIFT_2929_ITEM064; GiftType="ITEM";}
	else if (rval <=val65) {PresentItem = JAPAN_GIFT_2929_ITEM065; GiftType="ITEM";}
	else if (rval <=val66) {PresentItem = JAPAN_GIFT_2929_ITEM066; GiftType="ITEM";}
	else if (rval <=val67) {PresentItem = JAPAN_GIFT_2929_ITEM067; GiftType="ITEM";}
	else if (rval <=val68) {PresentItem = JAPAN_GIFT_2929_ITEM068; GiftType="ITEM";}
	else if (rval <=val69) {PresentItem = JAPAN_GIFT_2929_ITEM069; GiftType="ITEM";}
	else if (rval <=val70) {PresentItem = JAPAN_GIFT_2929_ITEM070; GiftType="ITEM";}
	else if (rval <=val71) {PresentItem = JAPAN_GIFT_2929_ITEM071; GiftType="ITEM";}
	else if (rval <=val72) {PresentItem = JAPAN_GIFT_2929_ITEM072; GiftType="ITEM";}
	else if (rval <=val73) {PresentItem = JAPAN_GIFT_2929_ITEM073; GiftType="ITEM";}
	else if (rval <=val74) {PresentItem = JAPAN_GIFT_2929_ITEM074; GiftType="ITEM";}
	else if (rval <=val75) {PresentItem = JAPAN_GIFT_2929_ITEM075; GiftType="ITEM";}
	else if (rval <=val76) {PresentItem = JAPAN_GIFT_2929_ITEM076; GiftType="ITEM";}
	else if (rval <=val77) {PresentItem = JAPAN_GIFT_2929_ITEM077; GiftType="ITEM";}
	else if (rval <=val78) {PresentItem = JAPAN_GIFT_2929_ITEM078; GiftType="ITEM";}
	else if (rval <=val79) {PresentItem = JAPAN_GIFT_2929_ITEM079; GiftType="ITEM";}
	else if (rval <=val80) {PresentItem = JAPAN_GIFT_2929_ITEM080; GiftType="ITEM";}
	else if (rval <=val81) {PresentItem = JAPAN_GIFT_2929_ITEM081; GiftType="ITEM";}
	else if (rval <=val82) {PresentItem = JAPAN_GIFT_2929_ITEM082; GiftType="ITEM";}
	else if (rval <=val83) {PresentItem = JAPAN_GIFT_2929_ITEM083; GiftType="ITEM";}
	else if (rval <=val84) {PresentItem = JAPAN_GIFT_2929_ITEM084; GiftType="ITEM";}
	else if (rval <=val85) {PresentItem = JAPAN_GIFT_2929_ITEM085; GiftType="ITEM";}
	else if (rval <=val86) {PresentItem = JAPAN_GIFT_2929_ITEM086; GiftType="ITEM";}
	else if (rval <=val87) {PresentItem = JAPAN_GIFT_2929_ITEM087; GiftType="ITEM";}
	else if (rval <=val88) {PresentItem = JAPAN_GIFT_2929_ITEM088; GiftType="ITEM";}
	else if (rval <=val89) {PresentItem = JAPAN_GIFT_2929_ITEM089; GiftType="ITEM";}
	else if (rval <=val90) {PresentItem = JAPAN_GIFT_2929_ITEM090; GiftType="ITEM";}
	else if (rval <=val91) {PresentItem = JAPAN_GIFT_2929_ITEM091; GiftType="ITEM";}
	else if (rval <=val92) {PresentItem = JAPAN_GIFT_2929_ITEM092; GiftType="ITEM";}
	else if (rval <=val93) {PresentItem = JAPAN_GIFT_2929_ITEM093; GiftType="ITEM";}
	else if (rval <=val94) {PresentItem = JAPAN_GIFT_2929_ITEM094; GiftType="ITEM";}
	else if (rval <=val95) {PresentItem = JAPAN_GIFT_2929_ITEM095; GiftType="ITEM";}
	else if (rval <=val96) {PresentItem = JAPAN_GIFT_2929_ITEM096; GiftType="ITEM";}
	else if (rval <=val97) {PresentItem = JAPAN_GIFT_2929_ITEM097; GiftType="ITEM";}
	else if (rval <=val98) {PresentItem = JAPAN_GIFT_2929_ITEM098; GiftType="ITEM";}
	else if (rval <=val99) {PresentItem = JAPAN_GIFT_2929_ITEM099; GiftType="ITEM";}
	else if (rval <=val100) {PresentItem = JAPAN_GIFT_2929_ITEM100; GiftType="ITEM";}
	else if (rval <= val101) {PresentSeed = JAPAN_GIFT_2929_SEED101; GiftType="SEED";}
	else if (rval <= val102) {PresentSeed = JAPAN_GIFT_2929_SEED102; GiftType="SEED";}
	else if (rval <= val103) {PresentSeed = JAPAN_GIFT_2929_SEED103; GiftType="SEED";}
	else if (rval <= val104) {PresentSeed = JAPAN_GIFT_2929_SEED104; GiftType="SEED";}
	else if (rval <= val105) {PresentSeed = JAPAN_GIFT_2929_SEED105; GiftType="SEED";}
	else if (rval <= val106) {PresentSeed = JAPAN_GIFT_2929_SEED106; GiftType="SEED";}
	else if (rval <= val107) {PresentSeed = JAPAN_GIFT_2929_SEED107; GiftType="SEED";}
	else if (rval <= val108) {PresentSeed = JAPAN_GIFT_2929_SEED108; GiftType="SEED";}
	else if (rval <= val109) {PresentSeed = JAPAN_GIFT_2929_SEED109; GiftType="SEED";}
	else if (rval <= val110) {PresentSeed = JAPAN_GIFT_2929_SEED110; GiftType="SEED";}
	else if (rval <= val111) {PresentItem = JAPAN_GIFT_2929_MONS111; PTN = JAPAN_GIFT_2929_MONS111_PTN;}
	else if (rval <= val112) {PresentItem = JAPAN_GIFT_2929_MONS112; PTN = JAPAN_GIFT_2929_MONS112_PTN;}
	else if (rval <= val113) {PresentItem = JAPAN_GIFT_2929_MONS113; PTN = JAPAN_GIFT_2929_MONS113_PTN;}
	else if (rval <= val114) {PresentItem = JAPAN_GIFT_2929_MONS114; PTN = JAPAN_GIFT_2929_MONS114_PTN;}
	else if (rval <= val115) {PresentItem = JAPAN_GIFT_2929_MONS115; PTN = JAPAN_GIFT_2929_MONS115_PTN;}
	else if (rval <= val116) {PresentItem = JAPAN_GIFT_2929_MONS116; PTN = JAPAN_GIFT_2929_MONS116_PTN;}
	else if (rval <= val117) {PresentItem = JAPAN_GIFT_2929_MONS117; PTN = JAPAN_GIFT_2929_MONS117_PTN;}
	else if (rval <= val118) {PresentItem = JAPAN_GIFT_2929_MONS118; PTN = JAPAN_GIFT_2929_MONS118_PTN;}
	else if (rval <= val119) {PresentItem = JAPAN_GIFT_2929_MONS119; PTN = JAPAN_GIFT_2929_MONS119_PTN;}
	else if (rval <= val120) {PresentItem = JAPAN_GIFT_2929_MONS120; PTN = JAPAN_GIFT_2929_MONS120_PTN;}
	
	GivePresent_JPN(GiftType, PresentItem, PresentSeed, PTN);
	return;
}



quest
qUseItem1003531()			// Japanese Present Box Item (2004/9)
{
	integer rval;
	integer val01, val02, val03, val04, val05, val06, val07, val08, val09, val10;
	integer	val11, val12, val13, val14, val15, val16, val17, val18, val19, val20;
	integer	val21, val22, val23, val24, val25, val26, val27, val28, val29, val30;
	integer	val31, val32, val33, val34, val35, val36, val37, val38, val39, val40;
	integer	val41, val42, val43, val44, val45, val46, val47, val48, val49, val50;
	integer	val51, val52, val53, val54, val55, val56, val57, val58, val59, val60;
	integer	val61, val62, val63, val64, val65, val66, val67, val68, val69, val70;
	integer	val71, val72, val73, val74, val75, val76, val77, val78, val79, val80;
	integer	val81, val82, val83, val84, val85, val86, val87, val88, val89, val90;
	integer	val91, val92, val93, val94, val95, val96, val97, val98, val99, val100;
	integer	val101, val102, val103, val104, val105, val106, val107, val108, val109, val110;
	integer	val111, val112, val113, val114, val115, val116, val117, val118, val119, val120;
	string	PresentItem, GiftType, PTN;
	integer PresentSeed;
	
	if (CheckPresentMap_JPN()) return;
	if (CheckInventory_JPN(JAPAN_GIFT_2930_INVWT)) return;
	if (CheckRestrictDate_JPN()) {controller.decreaseNumber(1); return;}

	val01 =		JAPAN_GIFT_2930_ITEM001_PER;
	val02 = val01 + JAPAN_GIFT_2930_ITEM002_PER;
	val03 = val02 + JAPAN_GIFT_2930_ITEM003_PER;
	val04 = val03 + JAPAN_GIFT_2930_ITEM004_PER;
	val05 = val04 + JAPAN_GIFT_2930_ITEM005_PER;
	val06 = val05 + JAPAN_GIFT_2930_ITEM006_PER;
	val07 = val06 + JAPAN_GIFT_2930_ITEM007_PER;
	val08 = val07 + JAPAN_GIFT_2930_ITEM008_PER;
	val09 = val08 + JAPAN_GIFT_2930_ITEM009_PER;
	val10 = val09 + JAPAN_GIFT_2930_ITEM010_PER;
	val11 = val10 + JAPAN_GIFT_2930_ITEM011_PER;
	val12 = val11 + JAPAN_GIFT_2930_ITEM012_PER;
	val13 = val12 + JAPAN_GIFT_2930_ITEM013_PER;
	val14 = val13 + JAPAN_GIFT_2930_ITEM014_PER;
	val15 = val14 + JAPAN_GIFT_2930_ITEM015_PER;
	val16 = val15 + JAPAN_GIFT_2930_ITEM016_PER;
	val17 = val16 + JAPAN_GIFT_2930_ITEM017_PER;
	val18 = val17 + JAPAN_GIFT_2930_ITEM018_PER;
	val19 = val18 + JAPAN_GIFT_2930_ITEM019_PER;
	val20 = val19 + JAPAN_GIFT_2930_ITEM020_PER;
	val21 = val20 + JAPAN_GIFT_2930_ITEM021_PER;
	val22 = val21 + JAPAN_GIFT_2930_ITEM022_PER;
	val23 = val22 + JAPAN_GIFT_2930_ITEM023_PER;
	val24 = val23 + JAPAN_GIFT_2930_ITEM024_PER;
	val25 = val24 + JAPAN_GIFT_2930_ITEM025_PER;
	val26 = val25 + JAPAN_GIFT_2930_ITEM026_PER;
	val27 = val26 + JAPAN_GIFT_2930_ITEM027_PER;
	val28 = val27 + JAPAN_GIFT_2930_ITEM028_PER;
	val29 = val28 + JAPAN_GIFT_2930_ITEM029_PER;
	val30 = val29 + JAPAN_GIFT_2930_ITEM030_PER;
	val31 = val30 + JAPAN_GIFT_2930_ITEM031_PER;
	val32 = val31 + JAPAN_GIFT_2930_ITEM032_PER;
	val33 = val32 + JAPAN_GIFT_2930_ITEM033_PER;
	val34 = val33 + JAPAN_GIFT_2930_ITEM034_PER;
	val35 = val34 + JAPAN_GIFT_2930_ITEM035_PER;
	val36 = val35 + JAPAN_GIFT_2930_ITEM036_PER;
	val37 = val36 + JAPAN_GIFT_2930_ITEM037_PER;
	val38 = val37 + JAPAN_GIFT_2930_ITEM038_PER;
	val39 = val38 + JAPAN_GIFT_2930_ITEM039_PER;
	val40 = val39 + JAPAN_GIFT_2930_ITEM040_PER;
	val41 = val40 + JAPAN_GIFT_2930_ITEM041_PER;
	val42 = val41 + JAPAN_GIFT_2930_ITEM042_PER;
	val43 = val42 + JAPAN_GIFT_2930_ITEM043_PER;
	val44 = val43 + JAPAN_GIFT_2930_ITEM044_PER;
	val45 = val44 + JAPAN_GIFT_2930_ITEM045_PER;
	val46 = val45 + JAPAN_GIFT_2930_ITEM046_PER;
	val47 = val46 + JAPAN_GIFT_2930_ITEM047_PER;
	val48 = val47 + JAPAN_GIFT_2930_ITEM048_PER;
	val49 = val48 + JAPAN_GIFT_2930_ITEM049_PER;
	val50 = val49 + JAPAN_GIFT_2930_ITEM050_PER;
	val51 = val50 + JAPAN_GIFT_2930_ITEM051_PER;
	val52 = val51 + JAPAN_GIFT_2930_ITEM052_PER;
	val53 = val52 + JAPAN_GIFT_2930_ITEM053_PER;
	val54 = val53 + JAPAN_GIFT_2930_ITEM054_PER;
	val55 = val54 + JAPAN_GIFT_2930_ITEM055_PER;
	val56 = val55 + JAPAN_GIFT_2930_ITEM056_PER;
	val57 = val56 + JAPAN_GIFT_2930_ITEM057_PER;
	val58 = val57 + JAPAN_GIFT_2930_ITEM058_PER;
	val59 = val58 + JAPAN_GIFT_2930_ITEM059_PER;
	val60 = val59 + JAPAN_GIFT_2930_ITEM060_PER;
	val61 = val60 + JAPAN_GIFT_2930_ITEM061_PER;
	val62 = val61 + JAPAN_GIFT_2930_ITEM062_PER;
	val63 = val62 + JAPAN_GIFT_2930_ITEM063_PER;
	val64 = val63 + JAPAN_GIFT_2930_ITEM064_PER;
	val65 = val64 + JAPAN_GIFT_2930_ITEM065_PER;
	val66 = val65 + JAPAN_GIFT_2930_ITEM066_PER;
	val67 = val66 + JAPAN_GIFT_2930_ITEM067_PER;
	val68 = val67 + JAPAN_GIFT_2930_ITEM068_PER;
	val69 = val68 + JAPAN_GIFT_2930_ITEM069_PER;
	val70 = val69 + JAPAN_GIFT_2930_ITEM070_PER;
	val71 = val70 + JAPAN_GIFT_2930_ITEM071_PER;
	val72 = val71 + JAPAN_GIFT_2930_ITEM072_PER;
	val73 = val72 + JAPAN_GIFT_2930_ITEM073_PER;
	val74 = val73 + JAPAN_GIFT_2930_ITEM074_PER;
	val75 = val74 + JAPAN_GIFT_2930_ITEM075_PER;
	val76 = val75 + JAPAN_GIFT_2930_ITEM076_PER;
	val77 = val76 + JAPAN_GIFT_2930_ITEM077_PER;
	val78 = val77 + JAPAN_GIFT_2930_ITEM078_PER;
	val79 = val78 + JAPAN_GIFT_2930_ITEM079_PER;
	val80 = val79 + JAPAN_GIFT_2930_ITEM080_PER;
	val81 = val80 + JAPAN_GIFT_2930_ITEM081_PER;
	val82 = val81 + JAPAN_GIFT_2930_ITEM082_PER;
	val83 = val82 + JAPAN_GIFT_2930_ITEM083_PER;
	val84 = val83 + JAPAN_GIFT_2930_ITEM084_PER;
	val85 = val84 + JAPAN_GIFT_2930_ITEM085_PER;
	val86 = val85 + JAPAN_GIFT_2930_ITEM086_PER;
	val87 = val86 + JAPAN_GIFT_2930_ITEM087_PER;
	val88 = val87 + JAPAN_GIFT_2930_ITEM088_PER;
	val89 = val88 + JAPAN_GIFT_2930_ITEM089_PER;
	val90 = val89 + JAPAN_GIFT_2930_ITEM090_PER;
	val91 = val90 + JAPAN_GIFT_2930_ITEM091_PER;
	val92 = val91 + JAPAN_GIFT_2930_ITEM092_PER;
	val93 = val92 + JAPAN_GIFT_2930_ITEM093_PER;
	val94 = val93 + JAPAN_GIFT_2930_ITEM094_PER;
	val95 = val94 + JAPAN_GIFT_2930_ITEM095_PER;
	val96 = val95 + JAPAN_GIFT_2930_ITEM096_PER;
	val97 = val96 + JAPAN_GIFT_2930_ITEM097_PER;
	val98 = val97 + JAPAN_GIFT_2930_ITEM098_PER;
	val99 = val98 + JAPAN_GIFT_2930_ITEM099_PER;
	val100 = val99 + JAPAN_GIFT_2930_ITEM100_PER;
	val101 = val100 + JAPAN_GIFT_2930_SEED101_PER;
	val102 = val101 + JAPAN_GIFT_2930_SEED102_PER;
	val103 = val102 + JAPAN_GIFT_2930_SEED103_PER;
	val104 = val103 + JAPAN_GIFT_2930_SEED104_PER;
	val105 = val104 + JAPAN_GIFT_2930_SEED105_PER;
	val106 = val105 + JAPAN_GIFT_2930_SEED106_PER;
	val107 = val106 + JAPAN_GIFT_2930_SEED107_PER;
	val108 = val107 + JAPAN_GIFT_2930_SEED108_PER;
	val109 = val108 + JAPAN_GIFT_2930_SEED109_PER;
	val110 = val109 + JAPAN_GIFT_2930_SEED110_PER;
	val111 = val110 + JAPAN_GIFT_2930_MONS111_PER;
	val112 = val111 + JAPAN_GIFT_2930_MONS112_PER;
	val113 = val112 + JAPAN_GIFT_2930_MONS113_PER;
	val114 = val113 + JAPAN_GIFT_2930_MONS114_PER;
	val115 = val114 + JAPAN_GIFT_2930_MONS115_PER;
	val116 = val115 + JAPAN_GIFT_2930_MONS116_PER;
	val117 = val116 + JAPAN_GIFT_2930_MONS117_PER;
	val118 = val117 + JAPAN_GIFT_2930_MONS118_PER;
	val119 = val118 + JAPAN_GIFT_2930_MONS119_PER;
	val120 = val119 + JAPAN_GIFT_2930_MONS120_PER;

	if (val120 != 100000) {
		trigger.message("Percentage Setting is wrong!", MSG_TYPE__SYSTEM);
	    	return;
	}

	rval  = Util.random(1, 100000);
	if      (rval <=val01) {PresentItem = JAPAN_GIFT_2930_ITEM001; GiftType="ITEM";}
	else if (rval <=val02) {PresentItem = JAPAN_GIFT_2930_ITEM002; GiftType="ITEM";}
	else if (rval <=val03) {PresentItem = JAPAN_GIFT_2930_ITEM003; GiftType="ITEM";}
	else if (rval <=val04) {PresentItem = JAPAN_GIFT_2930_ITEM004; GiftType="ITEM";}
	else if (rval <=val05) {PresentItem = JAPAN_GIFT_2930_ITEM005; GiftType="ITEM";}
	else if (rval <=val06) {PresentItem = JAPAN_GIFT_2930_ITEM006; GiftType="ITEM";}
	else if (rval <=val07) {PresentItem = JAPAN_GIFT_2930_ITEM007; GiftType="ITEM";}
	else if (rval <=val08) {PresentItem = JAPAN_GIFT_2930_ITEM008; GiftType="ITEM";}
	else if (rval <=val09) {PresentItem = JAPAN_GIFT_2930_ITEM009; GiftType="ITEM";}
	else if (rval <=val10) {PresentItem = JAPAN_GIFT_2930_ITEM010; GiftType="ITEM";}
	else if (rval <=val11) {PresentItem = JAPAN_GIFT_2930_ITEM011; GiftType="ITEM";}
	else if (rval <=val12) {PresentItem = JAPAN_GIFT_2930_ITEM012; GiftType="ITEM";}
	else if (rval <=val13) {PresentItem = JAPAN_GIFT_2930_ITEM013; GiftType="ITEM";}
	else if (rval <=val14) {PresentItem = JAPAN_GIFT_2930_ITEM014; GiftType="ITEM";}
	else if (rval <=val15) {PresentItem = JAPAN_GIFT_2930_ITEM015; GiftType="ITEM";}
	else if (rval <=val16) {PresentItem = JAPAN_GIFT_2930_ITEM016; GiftType="ITEM";}
	else if (rval <=val17) {PresentItem = JAPAN_GIFT_2930_ITEM017; GiftType="ITEM";}
	else if (rval <=val18) {PresentItem = JAPAN_GIFT_2930_ITEM018; GiftType="ITEM";}
	else if (rval <=val19) {PresentItem = JAPAN_GIFT_2930_ITEM019; GiftType="ITEM";}
	else if (rval <=val20) {PresentItem = JAPAN_GIFT_2930_ITEM020; GiftType="ITEM";}
	else if (rval <=val21) {PresentItem = JAPAN_GIFT_2930_ITEM021; GiftType="ITEM";}
	else if (rval <=val22) {PresentItem = JAPAN_GIFT_2930_ITEM022; GiftType="ITEM";}
	else if (rval <=val23) {PresentItem = JAPAN_GIFT_2930_ITEM023; GiftType="ITEM";}
	else if (rval <=val24) {PresentItem = JAPAN_GIFT_2930_ITEM024; GiftType="ITEM";}
	else if (rval <=val25) {PresentItem = JAPAN_GIFT_2930_ITEM025; GiftType="ITEM";}
	else if (rval <=val26) {PresentItem = JAPAN_GIFT_2930_ITEM026; GiftType="ITEM";}
	else if (rval <=val27) {PresentItem = JAPAN_GIFT_2930_ITEM027; GiftType="ITEM";}
	else if (rval <=val28) {PresentItem = JAPAN_GIFT_2930_ITEM028; GiftType="ITEM";}
	else if (rval <=val29) {PresentItem = JAPAN_GIFT_2930_ITEM029; GiftType="ITEM";}
	else if (rval <=val30) {PresentItem = JAPAN_GIFT_2930_ITEM030; GiftType="ITEM";}
	else if (rval <=val31) {PresentItem = JAPAN_GIFT_2930_ITEM031; GiftType="ITEM";}
	else if (rval <=val32) {PresentItem = JAPAN_GIFT_2930_ITEM032; GiftType="ITEM";}
	else if (rval <=val33) {PresentItem = JAPAN_GIFT_2930_ITEM033; GiftType="ITEM";}
	else if (rval <=val34) {PresentItem = JAPAN_GIFT_2930_ITEM034; GiftType="ITEM";}
	else if (rval <=val35) {PresentItem = JAPAN_GIFT_2930_ITEM035; GiftType="ITEM";}
	else if (rval <=val36) {PresentItem = JAPAN_GIFT_2930_ITEM036; GiftType="ITEM";}
	else if (rval <=val37) {PresentItem = JAPAN_GIFT_2930_ITEM037; GiftType="ITEM";}
	else if (rval <=val38) {PresentItem = JAPAN_GIFT_2930_ITEM038; GiftType="ITEM";}
	else if (rval <=val39) {PresentItem = JAPAN_GIFT_2930_ITEM039; GiftType="ITEM";}
	else if (rval <=val40) {PresentItem = JAPAN_GIFT_2930_ITEM040; GiftType="ITEM";}
	else if (rval <=val41) {PresentItem = JAPAN_GIFT_2930_ITEM041; GiftType="ITEM";}
	else if (rval <=val42) {PresentItem = JAPAN_GIFT_2930_ITEM042; GiftType="ITEM";}
	else if (rval <=val43) {PresentItem = JAPAN_GIFT_2930_ITEM043; GiftType="ITEM";}
	else if (rval <=val44) {PresentItem = JAPAN_GIFT_2930_ITEM044; GiftType="ITEM";}
	else if (rval <=val45) {PresentItem = JAPAN_GIFT_2930_ITEM045; GiftType="ITEM";}
	else if (rval <=val46) {PresentItem = JAPAN_GIFT_2930_ITEM046; GiftType="ITEM";}
	else if (rval <=val47) {PresentItem = JAPAN_GIFT_2930_ITEM047; GiftType="ITEM";}
	else if (rval <=val48) {PresentItem = JAPAN_GIFT_2930_ITEM048; GiftType="ITEM";}
	else if (rval <=val49) {PresentItem = JAPAN_GIFT_2930_ITEM049; GiftType="ITEM";}
	else if (rval <=val50) {PresentItem = JAPAN_GIFT_2930_ITEM050; GiftType="ITEM";}
	else if (rval <=val51) {PresentItem = JAPAN_GIFT_2930_ITEM051; GiftType="ITEM";}
	else if (rval <=val52) {PresentItem = JAPAN_GIFT_2930_ITEM052; GiftType="ITEM";}
	else if (rval <=val53) {PresentItem = JAPAN_GIFT_2930_ITEM053; GiftType="ITEM";}
	else if (rval <=val54) {PresentItem = JAPAN_GIFT_2930_ITEM054; GiftType="ITEM";}
	else if (rval <=val55) {PresentItem = JAPAN_GIFT_2930_ITEM055; GiftType="ITEM";}
	else if (rval <=val56) {PresentItem = JAPAN_GIFT_2930_ITEM056; GiftType="ITEM";}
	else if (rval <=val57) {PresentItem = JAPAN_GIFT_2930_ITEM057; GiftType="ITEM";}
	else if (rval <=val58) {PresentItem = JAPAN_GIFT_2930_ITEM058; GiftType="ITEM";}
	else if (rval <=val59) {PresentItem = JAPAN_GIFT_2930_ITEM059; GiftType="ITEM";}
	else if (rval <=val60) {PresentItem = JAPAN_GIFT_2930_ITEM060; GiftType="ITEM";}
	else if (rval <=val61) {PresentItem = JAPAN_GIFT_2930_ITEM061; GiftType="ITEM";}
	else if (rval <=val62) {PresentItem = JAPAN_GIFT_2930_ITEM062; GiftType="ITEM";}
	else if (rval <=val63) {PresentItem = JAPAN_GIFT_2930_ITEM063; GiftType="ITEM";}
	else if (rval <=val64) {PresentItem = JAPAN_GIFT_2930_ITEM064; GiftType="ITEM";}
	else if (rval <=val65) {PresentItem = JAPAN_GIFT_2930_ITEM065; GiftType="ITEM";}
	else if (rval <=val66) {PresentItem = JAPAN_GIFT_2930_ITEM066; GiftType="ITEM";}
	else if (rval <=val67) {PresentItem = JAPAN_GIFT_2930_ITEM067; GiftType="ITEM";}
	else if (rval <=val68) {PresentItem = JAPAN_GIFT_2930_ITEM068; GiftType="ITEM";}
	else if (rval <=val69) {PresentItem = JAPAN_GIFT_2930_ITEM069; GiftType="ITEM";}
	else if (rval <=val70) {PresentItem = JAPAN_GIFT_2930_ITEM070; GiftType="ITEM";}
	else if (rval <=val71) {PresentItem = JAPAN_GIFT_2930_ITEM071; GiftType="ITEM";}
	else if (rval <=val72) {PresentItem = JAPAN_GIFT_2930_ITEM072; GiftType="ITEM";}
	else if (rval <=val73) {PresentItem = JAPAN_GIFT_2930_ITEM073; GiftType="ITEM";}
	else if (rval <=val74) {PresentItem = JAPAN_GIFT_2930_ITEM074; GiftType="ITEM";}
	else if (rval <=val75) {PresentItem = JAPAN_GIFT_2930_ITEM075; GiftType="ITEM";}
	else if (rval <=val76) {PresentItem = JAPAN_GIFT_2930_ITEM076; GiftType="ITEM";}
	else if (rval <=val77) {PresentItem = JAPAN_GIFT_2930_ITEM077; GiftType="ITEM";}
	else if (rval <=val78) {PresentItem = JAPAN_GIFT_2930_ITEM078; GiftType="ITEM";}
	else if (rval <=val79) {PresentItem = JAPAN_GIFT_2930_ITEM079; GiftType="ITEM";}
	else if (rval <=val80) {PresentItem = JAPAN_GIFT_2930_ITEM080; GiftType="ITEM";}
	else if (rval <=val81) {PresentItem = JAPAN_GIFT_2930_ITEM081; GiftType="ITEM";}
	else if (rval <=val82) {PresentItem = JAPAN_GIFT_2930_ITEM082; GiftType="ITEM";}
	else if (rval <=val83) {PresentItem = JAPAN_GIFT_2930_ITEM083; GiftType="ITEM";}
	else if (rval <=val84) {PresentItem = JAPAN_GIFT_2930_ITEM084; GiftType="ITEM";}
	else if (rval <=val85) {PresentItem = JAPAN_GIFT_2930_ITEM085; GiftType="ITEM";}
	else if (rval <=val86) {PresentItem = JAPAN_GIFT_2930_ITEM086; GiftType="ITEM";}
	else if (rval <=val87) {PresentItem = JAPAN_GIFT_2930_ITEM087; GiftType="ITEM";}
	else if (rval <=val88) {PresentItem = JAPAN_GIFT_2930_ITEM088; GiftType="ITEM";}
	else if (rval <=val89) {PresentItem = JAPAN_GIFT_2930_ITEM089; GiftType="ITEM";}
	else if (rval <=val90) {PresentItem = JAPAN_GIFT_2930_ITEM090; GiftType="ITEM";}
	else if (rval <=val91) {PresentItem = JAPAN_GIFT_2930_ITEM091; GiftType="ITEM";}
	else if (rval <=val92) {PresentItem = JAPAN_GIFT_2930_ITEM092; GiftType="ITEM";}
	else if (rval <=val93) {PresentItem = JAPAN_GIFT_2930_ITEM093; GiftType="ITEM";}
	else if (rval <=val94) {PresentItem = JAPAN_GIFT_2930_ITEM094; GiftType="ITEM";}
	else if (rval <=val95) {PresentItem = JAPAN_GIFT_2930_ITEM095; GiftType="ITEM";}
	else if (rval <=val96) {PresentItem = JAPAN_GIFT_2930_ITEM096; GiftType="ITEM";}
	else if (rval <=val97) {PresentItem = JAPAN_GIFT_2930_ITEM097; GiftType="ITEM";}
	else if (rval <=val98) {PresentItem = JAPAN_GIFT_2930_ITEM098; GiftType="ITEM";}
	else if (rval <=val99) {PresentItem = JAPAN_GIFT_2930_ITEM099; GiftType="ITEM";}
	else if (rval <=val100) {PresentItem = JAPAN_GIFT_2930_ITEM100; GiftType="ITEM";}
	else if (rval <= val101) {PresentSeed = JAPAN_GIFT_2930_SEED101; GiftType="SEED";}
	else if (rval <= val102) {PresentSeed = JAPAN_GIFT_2930_SEED102; GiftType="SEED";}
	else if (rval <= val103) {PresentSeed = JAPAN_GIFT_2930_SEED103; GiftType="SEED";}
	else if (rval <= val104) {PresentSeed = JAPAN_GIFT_2930_SEED104; GiftType="SEED";}
	else if (rval <= val105) {PresentSeed = JAPAN_GIFT_2930_SEED105; GiftType="SEED";}
	else if (rval <= val106) {PresentSeed = JAPAN_GIFT_2930_SEED106; GiftType="SEED";}
	else if (rval <= val107) {PresentSeed = JAPAN_GIFT_2930_SEED107; GiftType="SEED";}
	else if (rval <= val108) {PresentSeed = JAPAN_GIFT_2930_SEED108; GiftType="SEED";}
	else if (rval <= val109) {PresentSeed = JAPAN_GIFT_2930_SEED109; GiftType="SEED";}
	else if (rval <= val110) {PresentSeed = JAPAN_GIFT_2930_SEED110; GiftType="SEED";}
	else if (rval <= val111) {PresentItem = JAPAN_GIFT_2930_MONS111; PTN = JAPAN_GIFT_2930_MONS111_PTN;}
	else if (rval <= val112) {PresentItem = JAPAN_GIFT_2930_MONS112; PTN = JAPAN_GIFT_2930_MONS112_PTN;}
	else if (rval <= val113) {PresentItem = JAPAN_GIFT_2930_MONS113; PTN = JAPAN_GIFT_2930_MONS113_PTN;}
	else if (rval <= val114) {PresentItem = JAPAN_GIFT_2930_MONS114; PTN = JAPAN_GIFT_2930_MONS114_PTN;}
	else if (rval <= val115) {PresentItem = JAPAN_GIFT_2930_MONS115; PTN = JAPAN_GIFT_2930_MONS115_PTN;}
	else if (rval <= val116) {PresentItem = JAPAN_GIFT_2930_MONS116; PTN = JAPAN_GIFT_2930_MONS116_PTN;}
	else if (rval <= val117) {PresentItem = JAPAN_GIFT_2930_MONS117; PTN = JAPAN_GIFT_2930_MONS117_PTN;}
	else if (rval <= val118) {PresentItem = JAPAN_GIFT_2930_MONS118; PTN = JAPAN_GIFT_2930_MONS118_PTN;}
	else if (rval <= val119) {PresentItem = JAPAN_GIFT_2930_MONS119; PTN = JAPAN_GIFT_2930_MONS119_PTN;}
	else if (rval <= val120) {PresentItem = JAPAN_GIFT_2930_MONS120; PTN = JAPAN_GIFT_2930_MONS120_PTN;}
	
	GivePresent_JPN(GiftType, PresentItem, PresentSeed, PTN);
	return;
}





quest
qUseItem1003532()			// Japanese Present Box Item (2004/9)
{
	integer rval;
	integer val01, val02, val03, val04, val05, val06, val07, val08, val09, val10;
	integer	val11, val12, val13, val14, val15, val16, val17, val18, val19, val20;
	integer	val21, val22, val23, val24, val25, val26, val27, val28, val29, val30;
	integer	val31, val32, val33, val34, val35, val36, val37, val38, val39, val40;
	integer	val41, val42, val43, val44, val45, val46, val47, val48, val49, val50;
	integer	val51, val52, val53, val54, val55, val56, val57, val58, val59, val60;
	integer	val61, val62, val63, val64, val65, val66, val67, val68, val69, val70;
	integer	val71, val72, val73, val74, val75, val76, val77, val78, val79, val80;
	integer	val81, val82, val83, val84, val85, val86, val87, val88, val89, val90;
	integer	val91, val92, val93, val94, val95, val96, val97, val98, val99, val100;
	integer	val101, val102, val103, val104, val105, val106, val107, val108, val109, val110;
	integer	val111, val112, val113, val114, val115, val116, val117, val118, val119, val120;
	string	PresentItem, GiftType, PTN;
	integer PresentSeed;
	
	if (CheckPresentMap_JPN()) return;
	if (CheckInventory_JPN(JAPAN_GIFT_2931_INVWT)) return;
	if (CheckRestrictDate_JPN()) {controller.decreaseNumber(1); return;}

	val01 =		JAPAN_GIFT_2931_ITEM001_PER;
	val02 = val01 + JAPAN_GIFT_2931_ITEM002_PER;
	val03 = val02 + JAPAN_GIFT_2931_ITEM003_PER;
	val04 = val03 + JAPAN_GIFT_2931_ITEM004_PER;
	val05 = val04 + JAPAN_GIFT_2931_ITEM005_PER;
	val06 = val05 + JAPAN_GIFT_2931_ITEM006_PER;
	val07 = val06 + JAPAN_GIFT_2931_ITEM007_PER;
	val08 = val07 + JAPAN_GIFT_2931_ITEM008_PER;
	val09 = val08 + JAPAN_GIFT_2931_ITEM009_PER;
	val10 = val09 + JAPAN_GIFT_2931_ITEM010_PER;
	val11 = val10 + JAPAN_GIFT_2931_ITEM011_PER;
	val12 = val11 + JAPAN_GIFT_2931_ITEM012_PER;
	val13 = val12 + JAPAN_GIFT_2931_ITEM013_PER;
	val14 = val13 + JAPAN_GIFT_2931_ITEM014_PER;
	val15 = val14 + JAPAN_GIFT_2931_ITEM015_PER;
	val16 = val15 + JAPAN_GIFT_2931_ITEM016_PER;
	val17 = val16 + JAPAN_GIFT_2931_ITEM017_PER;
	val18 = val17 + JAPAN_GIFT_2931_ITEM018_PER;
	val19 = val18 + JAPAN_GIFT_2931_ITEM019_PER;
	val20 = val19 + JAPAN_GIFT_2931_ITEM020_PER;
	val21 = val20 + JAPAN_GIFT_2931_ITEM021_PER;
	val22 = val21 + JAPAN_GIFT_2931_ITEM022_PER;
	val23 = val22 + JAPAN_GIFT_2931_ITEM023_PER;
	val24 = val23 + JAPAN_GIFT_2931_ITEM024_PER;
	val25 = val24 + JAPAN_GIFT_2931_ITEM025_PER;
	val26 = val25 + JAPAN_GIFT_2931_ITEM026_PER;
	val27 = val26 + JAPAN_GIFT_2931_ITEM027_PER;
	val28 = val27 + JAPAN_GIFT_2931_ITEM028_PER;
	val29 = val28 + JAPAN_GIFT_2931_ITEM029_PER;
	val30 = val29 + JAPAN_GIFT_2931_ITEM030_PER;
	val31 = val30 + JAPAN_GIFT_2931_ITEM031_PER;
	val32 = val31 + JAPAN_GIFT_2931_ITEM032_PER;
	val33 = val32 + JAPAN_GIFT_2931_ITEM033_PER;
	val34 = val33 + JAPAN_GIFT_2931_ITEM034_PER;
	val35 = val34 + JAPAN_GIFT_2931_ITEM035_PER;
	val36 = val35 + JAPAN_GIFT_2931_ITEM036_PER;
	val37 = val36 + JAPAN_GIFT_2931_ITEM037_PER;
	val38 = val37 + JAPAN_GIFT_2931_ITEM038_PER;
	val39 = val38 + JAPAN_GIFT_2931_ITEM039_PER;
	val40 = val39 + JAPAN_GIFT_2931_ITEM040_PER;
	val41 = val40 + JAPAN_GIFT_2931_ITEM041_PER;
	val42 = val41 + JAPAN_GIFT_2931_ITEM042_PER;
	val43 = val42 + JAPAN_GIFT_2931_ITEM043_PER;
	val44 = val43 + JAPAN_GIFT_2931_ITEM044_PER;
	val45 = val44 + JAPAN_GIFT_2931_ITEM045_PER;
	val46 = val45 + JAPAN_GIFT_2931_ITEM046_PER;
	val47 = val46 + JAPAN_GIFT_2931_ITEM047_PER;
	val48 = val47 + JAPAN_GIFT_2931_ITEM048_PER;
	val49 = val48 + JAPAN_GIFT_2931_ITEM049_PER;
	val50 = val49 + JAPAN_GIFT_2931_ITEM050_PER;
	val51 = val50 + JAPAN_GIFT_2931_ITEM051_PER;
	val52 = val51 + JAPAN_GIFT_2931_ITEM052_PER;
	val53 = val52 + JAPAN_GIFT_2931_ITEM053_PER;
	val54 = val53 + JAPAN_GIFT_2931_ITEM054_PER;
	val55 = val54 + JAPAN_GIFT_2931_ITEM055_PER;
	val56 = val55 + JAPAN_GIFT_2931_ITEM056_PER;
	val57 = val56 + JAPAN_GIFT_2931_ITEM057_PER;
	val58 = val57 + JAPAN_GIFT_2931_ITEM058_PER;
	val59 = val58 + JAPAN_GIFT_2931_ITEM059_PER;
	val60 = val59 + JAPAN_GIFT_2931_ITEM060_PER;
	val61 = val60 + JAPAN_GIFT_2931_ITEM061_PER;
	val62 = val61 + JAPAN_GIFT_2931_ITEM062_PER;
	val63 = val62 + JAPAN_GIFT_2931_ITEM063_PER;
	val64 = val63 + JAPAN_GIFT_2931_ITEM064_PER;
	val65 = val64 + JAPAN_GIFT_2931_ITEM065_PER;
	val66 = val65 + JAPAN_GIFT_2931_ITEM066_PER;
	val67 = val66 + JAPAN_GIFT_2931_ITEM067_PER;
	val68 = val67 + JAPAN_GIFT_2931_ITEM068_PER;
	val69 = val68 + JAPAN_GIFT_2931_ITEM069_PER;
	val70 = val69 + JAPAN_GIFT_2931_ITEM070_PER;
	val71 = val70 + JAPAN_GIFT_2931_ITEM071_PER;
	val72 = val71 + JAPAN_GIFT_2931_ITEM072_PER;
	val73 = val72 + JAPAN_GIFT_2931_ITEM073_PER;
	val74 = val73 + JAPAN_GIFT_2931_ITEM074_PER;
	val75 = val74 + JAPAN_GIFT_2931_ITEM075_PER;
	val76 = val75 + JAPAN_GIFT_2931_ITEM076_PER;
	val77 = val76 + JAPAN_GIFT_2931_ITEM077_PER;
	val78 = val77 + JAPAN_GIFT_2931_ITEM078_PER;
	val79 = val78 + JAPAN_GIFT_2931_ITEM079_PER;
	val80 = val79 + JAPAN_GIFT_2931_ITEM080_PER;
	val81 = val80 + JAPAN_GIFT_2931_ITEM081_PER;
	val82 = val81 + JAPAN_GIFT_2931_ITEM082_PER;
	val83 = val82 + JAPAN_GIFT_2931_ITEM083_PER;
	val84 = val83 + JAPAN_GIFT_2931_ITEM084_PER;
	val85 = val84 + JAPAN_GIFT_2931_ITEM085_PER;
	val86 = val85 + JAPAN_GIFT_2931_ITEM086_PER;
	val87 = val86 + JAPAN_GIFT_2931_ITEM087_PER;
	val88 = val87 + JAPAN_GIFT_2931_ITEM088_PER;
	val89 = val88 + JAPAN_GIFT_2931_ITEM089_PER;
	val90 = val89 + JAPAN_GIFT_2931_ITEM090_PER;
	val91 = val90 + JAPAN_GIFT_2931_ITEM091_PER;
	val92 = val91 + JAPAN_GIFT_2931_ITEM092_PER;
	val93 = val92 + JAPAN_GIFT_2931_ITEM093_PER;
	val94 = val93 + JAPAN_GIFT_2931_ITEM094_PER;
	val95 = val94 + JAPAN_GIFT_2931_ITEM095_PER;
	val96 = val95 + JAPAN_GIFT_2931_ITEM096_PER;
	val97 = val96 + JAPAN_GIFT_2931_ITEM097_PER;
	val98 = val97 + JAPAN_GIFT_2931_ITEM098_PER;
	val99 = val98 + JAPAN_GIFT_2931_ITEM099_PER;
	val100 = val99 + JAPAN_GIFT_2931_ITEM100_PER;
	val101 = val100 + JAPAN_GIFT_2931_SEED101_PER;
	val102 = val101 + JAPAN_GIFT_2931_SEED102_PER;
	val103 = val102 + JAPAN_GIFT_2931_SEED103_PER;
	val104 = val103 + JAPAN_GIFT_2931_SEED104_PER;
	val105 = val104 + JAPAN_GIFT_2931_SEED105_PER;
	val106 = val105 + JAPAN_GIFT_2931_SEED106_PER;
	val107 = val106 + JAPAN_GIFT_2931_SEED107_PER;
	val108 = val107 + JAPAN_GIFT_2931_SEED108_PER;
	val109 = val108 + JAPAN_GIFT_2931_SEED109_PER;
	val110 = val109 + JAPAN_GIFT_2931_SEED110_PER;
	val111 = val110 + JAPAN_GIFT_2931_MONS111_PER;
	val112 = val111 + JAPAN_GIFT_2931_MONS112_PER;
	val113 = val112 + JAPAN_GIFT_2931_MONS113_PER;
	val114 = val113 + JAPAN_GIFT_2931_MONS114_PER;
	val115 = val114 + JAPAN_GIFT_2931_MONS115_PER;
	val116 = val115 + JAPAN_GIFT_2931_MONS116_PER;
	val117 = val116 + JAPAN_GIFT_2931_MONS117_PER;
	val118 = val117 + JAPAN_GIFT_2931_MONS118_PER;
	val119 = val118 + JAPAN_GIFT_2931_MONS119_PER;
	val120 = val119 + JAPAN_GIFT_2931_MONS120_PER;

	if (val120 != 100000) {
		trigger.message("Percentage Setting is wrong!", MSG_TYPE__SYSTEM);
	    	return;
	}

	rval  = Util.random(1, 100000);
	if      (rval <=val01) {PresentItem = JAPAN_GIFT_2931_ITEM001; GiftType="ITEM";}
	else if (rval <=val02) {PresentItem = JAPAN_GIFT_2931_ITEM002; GiftType="ITEM";}
	else if (rval <=val03) {PresentItem = JAPAN_GIFT_2931_ITEM003; GiftType="ITEM";}
	else if (rval <=val04) {PresentItem = JAPAN_GIFT_2931_ITEM004; GiftType="ITEM";}
	else if (rval <=val05) {PresentItem = JAPAN_GIFT_2931_ITEM005; GiftType="ITEM";}
	else if (rval <=val06) {PresentItem = JAPAN_GIFT_2931_ITEM006; GiftType="ITEM";}
	else if (rval <=val07) {PresentItem = JAPAN_GIFT_2931_ITEM007; GiftType="ITEM";}
	else if (rval <=val08) {PresentItem = JAPAN_GIFT_2931_ITEM008; GiftType="ITEM";}
	else if (rval <=val09) {PresentItem = JAPAN_GIFT_2931_ITEM009; GiftType="ITEM";}
	else if (rval <=val10) {PresentItem = JAPAN_GIFT_2931_ITEM010; GiftType="ITEM";}
	else if (rval <=val11) {PresentItem = JAPAN_GIFT_2931_ITEM011; GiftType="ITEM";}
	else if (rval <=val12) {PresentItem = JAPAN_GIFT_2931_ITEM012; GiftType="ITEM";}
	else if (rval <=val13) {PresentItem = JAPAN_GIFT_2931_ITEM013; GiftType="ITEM";}
	else if (rval <=val14) {PresentItem = JAPAN_GIFT_2931_ITEM014; GiftType="ITEM";}
	else if (rval <=val15) {PresentItem = JAPAN_GIFT_2931_ITEM015; GiftType="ITEM";}
	else if (rval <=val16) {PresentItem = JAPAN_GIFT_2931_ITEM016; GiftType="ITEM";}
	else if (rval <=val17) {PresentItem = JAPAN_GIFT_2931_ITEM017; GiftType="ITEM";}
	else if (rval <=val18) {PresentItem = JAPAN_GIFT_2931_ITEM018; GiftType="ITEM";}
	else if (rval <=val19) {PresentItem = JAPAN_GIFT_2931_ITEM019; GiftType="ITEM";}
	else if (rval <=val20) {PresentItem = JAPAN_GIFT_2931_ITEM020; GiftType="ITEM";}
	else if (rval <=val21) {PresentItem = JAPAN_GIFT_2931_ITEM021; GiftType="ITEM";}
	else if (rval <=val22) {PresentItem = JAPAN_GIFT_2931_ITEM022; GiftType="ITEM";}
	else if (rval <=val23) {PresentItem = JAPAN_GIFT_2931_ITEM023; GiftType="ITEM";}
	else if (rval <=val24) {PresentItem = JAPAN_GIFT_2931_ITEM024; GiftType="ITEM";}
	else if (rval <=val25) {PresentItem = JAPAN_GIFT_2931_ITEM025; GiftType="ITEM";}
	else if (rval <=val26) {PresentItem = JAPAN_GIFT_2931_ITEM026; GiftType="ITEM";}
	else if (rval <=val27) {PresentItem = JAPAN_GIFT_2931_ITEM027; GiftType="ITEM";}
	else if (rval <=val28) {PresentItem = JAPAN_GIFT_2931_ITEM028; GiftType="ITEM";}
	else if (rval <=val29) {PresentItem = JAPAN_GIFT_2931_ITEM029; GiftType="ITEM";}
	else if (rval <=val30) {PresentItem = JAPAN_GIFT_2931_ITEM030; GiftType="ITEM";}
	else if (rval <=val31) {PresentItem = JAPAN_GIFT_2931_ITEM031; GiftType="ITEM";}
	else if (rval <=val32) {PresentItem = JAPAN_GIFT_2931_ITEM032; GiftType="ITEM";}
	else if (rval <=val33) {PresentItem = JAPAN_GIFT_2931_ITEM033; GiftType="ITEM";}
	else if (rval <=val34) {PresentItem = JAPAN_GIFT_2931_ITEM034; GiftType="ITEM";}
	else if (rval <=val35) {PresentItem = JAPAN_GIFT_2931_ITEM035; GiftType="ITEM";}
	else if (rval <=val36) {PresentItem = JAPAN_GIFT_2931_ITEM036; GiftType="ITEM";}
	else if (rval <=val37) {PresentItem = JAPAN_GIFT_2931_ITEM037; GiftType="ITEM";}
	else if (rval <=val38) {PresentItem = JAPAN_GIFT_2931_ITEM038; GiftType="ITEM";}
	else if (rval <=val39) {PresentItem = JAPAN_GIFT_2931_ITEM039; GiftType="ITEM";}
	else if (rval <=val40) {PresentItem = JAPAN_GIFT_2931_ITEM040; GiftType="ITEM";}
	else if (rval <=val41) {PresentItem = JAPAN_GIFT_2931_ITEM041; GiftType="ITEM";}
	else if (rval <=val42) {PresentItem = JAPAN_GIFT_2931_ITEM042; GiftType="ITEM";}
	else if (rval <=val43) {PresentItem = JAPAN_GIFT_2931_ITEM043; GiftType="ITEM";}
	else if (rval <=val44) {PresentItem = JAPAN_GIFT_2931_ITEM044; GiftType="ITEM";}
	else if (rval <=val45) {PresentItem = JAPAN_GIFT_2931_ITEM045; GiftType="ITEM";}
	else if (rval <=val46) {PresentItem = JAPAN_GIFT_2931_ITEM046; GiftType="ITEM";}
	else if (rval <=val47) {PresentItem = JAPAN_GIFT_2931_ITEM047; GiftType="ITEM";}
	else if (rval <=val48) {PresentItem = JAPAN_GIFT_2931_ITEM048; GiftType="ITEM";}
	else if (rval <=val49) {PresentItem = JAPAN_GIFT_2931_ITEM049; GiftType="ITEM";}
	else if (rval <=val50) {PresentItem = JAPAN_GIFT_2931_ITEM050; GiftType="ITEM";}
	else if (rval <=val51) {PresentItem = JAPAN_GIFT_2931_ITEM051; GiftType="ITEM";}
	else if (rval <=val52) {PresentItem = JAPAN_GIFT_2931_ITEM052; GiftType="ITEM";}
	else if (rval <=val53) {PresentItem = JAPAN_GIFT_2931_ITEM053; GiftType="ITEM";}
	else if (rval <=val54) {PresentItem = JAPAN_GIFT_2931_ITEM054; GiftType="ITEM";}
	else if (rval <=val55) {PresentItem = JAPAN_GIFT_2931_ITEM055; GiftType="ITEM";}
	else if (rval <=val56) {PresentItem = JAPAN_GIFT_2931_ITEM056; GiftType="ITEM";}
	else if (rval <=val57) {PresentItem = JAPAN_GIFT_2931_ITEM057; GiftType="ITEM";}
	else if (rval <=val58) {PresentItem = JAPAN_GIFT_2931_ITEM058; GiftType="ITEM";}
	else if (rval <=val59) {PresentItem = JAPAN_GIFT_2931_ITEM059; GiftType="ITEM";}
	else if (rval <=val60) {PresentItem = JAPAN_GIFT_2931_ITEM060; GiftType="ITEM";}
	else if (rval <=val61) {PresentItem = JAPAN_GIFT_2931_ITEM061; GiftType="ITEM";}
	else if (rval <=val62) {PresentItem = JAPAN_GIFT_2931_ITEM062; GiftType="ITEM";}
	else if (rval <=val63) {PresentItem = JAPAN_GIFT_2931_ITEM063; GiftType="ITEM";}
	else if (rval <=val64) {PresentItem = JAPAN_GIFT_2931_ITEM064; GiftType="ITEM";}
	else if (rval <=val65) {PresentItem = JAPAN_GIFT_2931_ITEM065; GiftType="ITEM";}
	else if (rval <=val66) {PresentItem = JAPAN_GIFT_2931_ITEM066; GiftType="ITEM";}
	else if (rval <=val67) {PresentItem = JAPAN_GIFT_2931_ITEM067; GiftType="ITEM";}
	else if (rval <=val68) {PresentItem = JAPAN_GIFT_2931_ITEM068; GiftType="ITEM";}
	else if (rval <=val69) {PresentItem = JAPAN_GIFT_2931_ITEM069; GiftType="ITEM";}
	else if (rval <=val70) {PresentItem = JAPAN_GIFT_2931_ITEM070; GiftType="ITEM";}
	else if (rval <=val71) {PresentItem = JAPAN_GIFT_2931_ITEM071; GiftType="ITEM";}
	else if (rval <=val72) {PresentItem = JAPAN_GIFT_2931_ITEM072; GiftType="ITEM";}
	else if (rval <=val73) {PresentItem = JAPAN_GIFT_2931_ITEM073; GiftType="ITEM";}
	else if (rval <=val74) {PresentItem = JAPAN_GIFT_2931_ITEM074; GiftType="ITEM";}
	else if (rval <=val75) {PresentItem = JAPAN_GIFT_2931_ITEM075; GiftType="ITEM";}
	else if (rval <=val76) {PresentItem = JAPAN_GIFT_2931_ITEM076; GiftType="ITEM";}
	else if (rval <=val77) {PresentItem = JAPAN_GIFT_2931_ITEM077; GiftType="ITEM";}
	else if (rval <=val78) {PresentItem = JAPAN_GIFT_2931_ITEM078; GiftType="ITEM";}
	else if (rval <=val79) {PresentItem = JAPAN_GIFT_2931_ITEM079; GiftType="ITEM";}
	else if (rval <=val80) {PresentItem = JAPAN_GIFT_2931_ITEM080; GiftType="ITEM";}
	else if (rval <=val81) {PresentItem = JAPAN_GIFT_2931_ITEM081; GiftType="ITEM";}
	else if (rval <=val82) {PresentItem = JAPAN_GIFT_2931_ITEM082; GiftType="ITEM";}
	else if (rval <=val83) {PresentItem = JAPAN_GIFT_2931_ITEM083; GiftType="ITEM";}
	else if (rval <=val84) {PresentItem = JAPAN_GIFT_2931_ITEM084; GiftType="ITEM";}
	else if (rval <=val85) {PresentItem = JAPAN_GIFT_2931_ITEM085; GiftType="ITEM";}
	else if (rval <=val86) {PresentItem = JAPAN_GIFT_2931_ITEM086; GiftType="ITEM";}
	else if (rval <=val87) {PresentItem = JAPAN_GIFT_2931_ITEM087; GiftType="ITEM";}
	else if (rval <=val88) {PresentItem = JAPAN_GIFT_2931_ITEM088; GiftType="ITEM";}
	else if (rval <=val89) {PresentItem = JAPAN_GIFT_2931_ITEM089; GiftType="ITEM";}
	else if (rval <=val90) {PresentItem = JAPAN_GIFT_2931_ITEM090; GiftType="ITEM";}
	else if (rval <=val91) {PresentItem = JAPAN_GIFT_2931_ITEM091; GiftType="ITEM";}
	else if (rval <=val92) {PresentItem = JAPAN_GIFT_2931_ITEM092; GiftType="ITEM";}
	else if (rval <=val93) {PresentItem = JAPAN_GIFT_2931_ITEM093; GiftType="ITEM";}
	else if (rval <=val94) {PresentItem = JAPAN_GIFT_2931_ITEM094; GiftType="ITEM";}
	else if (rval <=val95) {PresentItem = JAPAN_GIFT_2931_ITEM095; GiftType="ITEM";}
	else if (rval <=val96) {PresentItem = JAPAN_GIFT_2931_ITEM096; GiftType="ITEM";}
	else if (rval <=val97) {PresentItem = JAPAN_GIFT_2931_ITEM097; GiftType="ITEM";}
	else if (rval <=val98) {PresentItem = JAPAN_GIFT_2931_ITEM098; GiftType="ITEM";}
	else if (rval <=val99) {PresentItem = JAPAN_GIFT_2931_ITEM099; GiftType="ITEM";}
	else if (rval <=val100) {PresentItem = JAPAN_GIFT_2931_ITEM100; GiftType="ITEM";}
	else if (rval <= val101) {PresentSeed = JAPAN_GIFT_2931_SEED101; GiftType="SEED";}
	else if (rval <= val102) {PresentSeed = JAPAN_GIFT_2931_SEED102; GiftType="SEED";}
	else if (rval <= val103) {PresentSeed = JAPAN_GIFT_2931_SEED103; GiftType="SEED";}
	else if (rval <= val104) {PresentSeed = JAPAN_GIFT_2931_SEED104; GiftType="SEED";}
	else if (rval <= val105) {PresentSeed = JAPAN_GIFT_2931_SEED105; GiftType="SEED";}
	else if (rval <= val106) {PresentSeed = JAPAN_GIFT_2931_SEED106; GiftType="SEED";}
	else if (rval <= val107) {PresentSeed = JAPAN_GIFT_2931_SEED107; GiftType="SEED";}
	else if (rval <= val108) {PresentSeed = JAPAN_GIFT_2931_SEED108; GiftType="SEED";}
	else if (rval <= val109) {PresentSeed = JAPAN_GIFT_2931_SEED109; GiftType="SEED";}
	else if (rval <= val110) {PresentSeed = JAPAN_GIFT_2931_SEED110; GiftType="SEED";}
	else if (rval <= val111) {PresentItem = JAPAN_GIFT_2931_MONS111; PTN = JAPAN_GIFT_2931_MONS111_PTN;}
	else if (rval <= val112) {PresentItem = JAPAN_GIFT_2931_MONS112; PTN = JAPAN_GIFT_2931_MONS112_PTN;}
	else if (rval <= val113) {PresentItem = JAPAN_GIFT_2931_MONS113; PTN = JAPAN_GIFT_2931_MONS113_PTN;}
	else if (rval <= val114) {PresentItem = JAPAN_GIFT_2931_MONS114; PTN = JAPAN_GIFT_2931_MONS114_PTN;}
	else if (rval <= val115) {PresentItem = JAPAN_GIFT_2931_MONS115; PTN = JAPAN_GIFT_2931_MONS115_PTN;}
	else if (rval <= val116) {PresentItem = JAPAN_GIFT_2931_MONS116; PTN = JAPAN_GIFT_2931_MONS116_PTN;}
	else if (rval <= val117) {PresentItem = JAPAN_GIFT_2931_MONS117; PTN = JAPAN_GIFT_2931_MONS117_PTN;}
	else if (rval <= val118) {PresentItem = JAPAN_GIFT_2931_MONS118; PTN = JAPAN_GIFT_2931_MONS118_PTN;}
	else if (rval <= val119) {PresentItem = JAPAN_GIFT_2931_MONS119; PTN = JAPAN_GIFT_2931_MONS119_PTN;}
	else if (rval <= val120) {PresentItem = JAPAN_GIFT_2931_MONS120; PTN = JAPAN_GIFT_2931_MONS120_PTN;}
	
	GivePresent_JPN(GiftType, PresentItem, PresentSeed, PTN);
	return;
}



quest
qUseItem1003533()			// Japanese Present Box Item (2004/9)
{
	integer rval;
	integer val01, val02, val03, val04, val05, val06, val07, val08, val09, val10;
	integer	val11, val12, val13, val14, val15, val16, val17, val18, val19, val20;
	integer	val21, val22, val23, val24, val25, val26, val27, val28, val29, val30;
	integer	val31, val32, val33, val34, val35, val36, val37, val38, val39, val40;
	integer	val41, val42, val43, val44, val45, val46, val47, val48, val49, val50;
	integer	val51, val52, val53, val54, val55, val56, val57, val58, val59, val60;
	integer	val61, val62, val63, val64, val65, val66, val67, val68, val69, val70;
	integer	val71, val72, val73, val74, val75, val76, val77, val78, val79, val80;
	integer	val81, val82, val83, val84, val85, val86, val87, val88, val89, val90;
	integer	val91, val92, val93, val94, val95, val96, val97, val98, val99, val100;
	integer	val101, val102, val103, val104, val105, val106, val107, val108, val109, val110;
	integer	val111, val112, val113, val114, val115, val116, val117, val118, val119, val120;
	string	PresentItem, GiftType, PTN;
	integer PresentSeed;
	
	if (CheckPresentMap_JPN()) return;
	if (CheckInventory_JPN(JAPAN_GIFT_2932_INVWT)) return;
	if (CheckRestrictDate_JPN()) {controller.decreaseNumber(1); return;}

	val01 =		JAPAN_GIFT_2932_ITEM001_PER;
	val02 = val01 + JAPAN_GIFT_2932_ITEM002_PER;
	val03 = val02 + JAPAN_GIFT_2932_ITEM003_PER;
	val04 = val03 + JAPAN_GIFT_2932_ITEM004_PER;
	val05 = val04 + JAPAN_GIFT_2932_ITEM005_PER;
	val06 = val05 + JAPAN_GIFT_2932_ITEM006_PER;
	val07 = val06 + JAPAN_GIFT_2932_ITEM007_PER;
	val08 = val07 + JAPAN_GIFT_2932_ITEM008_PER;
	val09 = val08 + JAPAN_GIFT_2932_ITEM009_PER;
	val10 = val09 + JAPAN_GIFT_2932_ITEM010_PER;
	val11 = val10 + JAPAN_GIFT_2932_ITEM011_PER;
	val12 = val11 + JAPAN_GIFT_2932_ITEM012_PER;
	val13 = val12 + JAPAN_GIFT_2932_ITEM013_PER;
	val14 = val13 + JAPAN_GIFT_2932_ITEM014_PER;
	val15 = val14 + JAPAN_GIFT_2932_ITEM015_PER;
	val16 = val15 + JAPAN_GIFT_2932_ITEM016_PER;
	val17 = val16 + JAPAN_GIFT_2932_ITEM017_PER;
	val18 = val17 + JAPAN_GIFT_2932_ITEM018_PER;
	val19 = val18 + JAPAN_GIFT_2932_ITEM019_PER;
	val20 = val19 + JAPAN_GIFT_2932_ITEM020_PER;
	val21 = val20 + JAPAN_GIFT_2932_ITEM021_PER;
	val22 = val21 + JAPAN_GIFT_2932_ITEM022_PER;
	val23 = val22 + JAPAN_GIFT_2932_ITEM023_PER;
	val24 = val23 + JAPAN_GIFT_2932_ITEM024_PER;
	val25 = val24 + JAPAN_GIFT_2932_ITEM025_PER;
	val26 = val25 + JAPAN_GIFT_2932_ITEM026_PER;
	val27 = val26 + JAPAN_GIFT_2932_ITEM027_PER;
	val28 = val27 + JAPAN_GIFT_2932_ITEM028_PER;
	val29 = val28 + JAPAN_GIFT_2932_ITEM029_PER;
	val30 = val29 + JAPAN_GIFT_2932_ITEM030_PER;
	val31 = val30 + JAPAN_GIFT_2932_ITEM031_PER;
	val32 = val31 + JAPAN_GIFT_2932_ITEM032_PER;
	val33 = val32 + JAPAN_GIFT_2932_ITEM033_PER;
	val34 = val33 + JAPAN_GIFT_2932_ITEM034_PER;
	val35 = val34 + JAPAN_GIFT_2932_ITEM035_PER;
	val36 = val35 + JAPAN_GIFT_2932_ITEM036_PER;
	val37 = val36 + JAPAN_GIFT_2932_ITEM037_PER;
	val38 = val37 + JAPAN_GIFT_2932_ITEM038_PER;
	val39 = val38 + JAPAN_GIFT_2932_ITEM039_PER;
	val40 = val39 + JAPAN_GIFT_2932_ITEM040_PER;
	val41 = val40 + JAPAN_GIFT_2932_ITEM041_PER;
	val42 = val41 + JAPAN_GIFT_2932_ITEM042_PER;
	val43 = val42 + JAPAN_GIFT_2932_ITEM043_PER;
	val44 = val43 + JAPAN_GIFT_2932_ITEM044_PER;
	val45 = val44 + JAPAN_GIFT_2932_ITEM045_PER;
	val46 = val45 + JAPAN_GIFT_2932_ITEM046_PER;
	val47 = val46 + JAPAN_GIFT_2932_ITEM047_PER;
	val48 = val47 + JAPAN_GIFT_2932_ITEM048_PER;
	val49 = val48 + JAPAN_GIFT_2932_ITEM049_PER;
	val50 = val49 + JAPAN_GIFT_2932_ITEM050_PER;
	val51 = val50 + JAPAN_GIFT_2932_ITEM051_PER;
	val52 = val51 + JAPAN_GIFT_2932_ITEM052_PER;
	val53 = val52 + JAPAN_GIFT_2932_ITEM053_PER;
	val54 = val53 + JAPAN_GIFT_2932_ITEM054_PER;
	val55 = val54 + JAPAN_GIFT_2932_ITEM055_PER;
	val56 = val55 + JAPAN_GIFT_2932_ITEM056_PER;
	val57 = val56 + JAPAN_GIFT_2932_ITEM057_PER;
	val58 = val57 + JAPAN_GIFT_2932_ITEM058_PER;
	val59 = val58 + JAPAN_GIFT_2932_ITEM059_PER;
	val60 = val59 + JAPAN_GIFT_2932_ITEM060_PER;
	val61 = val60 + JAPAN_GIFT_2932_ITEM061_PER;
	val62 = val61 + JAPAN_GIFT_2932_ITEM062_PER;
	val63 = val62 + JAPAN_GIFT_2932_ITEM063_PER;
	val64 = val63 + JAPAN_GIFT_2932_ITEM064_PER;
	val65 = val64 + JAPAN_GIFT_2932_ITEM065_PER;
	val66 = val65 + JAPAN_GIFT_2932_ITEM066_PER;
	val67 = val66 + JAPAN_GIFT_2932_ITEM067_PER;
	val68 = val67 + JAPAN_GIFT_2932_ITEM068_PER;
	val69 = val68 + JAPAN_GIFT_2932_ITEM069_PER;
	val70 = val69 + JAPAN_GIFT_2932_ITEM070_PER;
	val71 = val70 + JAPAN_GIFT_2932_ITEM071_PER;
	val72 = val71 + JAPAN_GIFT_2932_ITEM072_PER;
	val73 = val72 + JAPAN_GIFT_2932_ITEM073_PER;
	val74 = val73 + JAPAN_GIFT_2932_ITEM074_PER;
	val75 = val74 + JAPAN_GIFT_2932_ITEM075_PER;
	val76 = val75 + JAPAN_GIFT_2932_ITEM076_PER;
	val77 = val76 + JAPAN_GIFT_2932_ITEM077_PER;
	val78 = val77 + JAPAN_GIFT_2932_ITEM078_PER;
	val79 = val78 + JAPAN_GIFT_2932_ITEM079_PER;
	val80 = val79 + JAPAN_GIFT_2932_ITEM080_PER;
	val81 = val80 + JAPAN_GIFT_2932_ITEM081_PER;
	val82 = val81 + JAPAN_GIFT_2932_ITEM082_PER;
	val83 = val82 + JAPAN_GIFT_2932_ITEM083_PER;
	val84 = val83 + JAPAN_GIFT_2932_ITEM084_PER;
	val85 = val84 + JAPAN_GIFT_2932_ITEM085_PER;
	val86 = val85 + JAPAN_GIFT_2932_ITEM086_PER;
	val87 = val86 + JAPAN_GIFT_2932_ITEM087_PER;
	val88 = val87 + JAPAN_GIFT_2932_ITEM088_PER;
	val89 = val88 + JAPAN_GIFT_2932_ITEM089_PER;
	val90 = val89 + JAPAN_GIFT_2932_ITEM090_PER;
	val91 = val90 + JAPAN_GIFT_2932_ITEM091_PER;
	val92 = val91 + JAPAN_GIFT_2932_ITEM092_PER;
	val93 = val92 + JAPAN_GIFT_2932_ITEM093_PER;
	val94 = val93 + JAPAN_GIFT_2932_ITEM094_PER;
	val95 = val94 + JAPAN_GIFT_2932_ITEM095_PER;
	val96 = val95 + JAPAN_GIFT_2932_ITEM096_PER;
	val97 = val96 + JAPAN_GIFT_2932_ITEM097_PER;
	val98 = val97 + JAPAN_GIFT_2932_ITEM098_PER;
	val99 = val98 + JAPAN_GIFT_2932_ITEM099_PER;
	val100 = val99 + JAPAN_GIFT_2932_ITEM100_PER;
	val101 = val100 + JAPAN_GIFT_2932_SEED101_PER;
	val102 = val101 + JAPAN_GIFT_2932_SEED102_PER;
	val103 = val102 + JAPAN_GIFT_2932_SEED103_PER;
	val104 = val103 + JAPAN_GIFT_2932_SEED104_PER;
	val105 = val104 + JAPAN_GIFT_2932_SEED105_PER;
	val106 = val105 + JAPAN_GIFT_2932_SEED106_PER;
	val107 = val106 + JAPAN_GIFT_2932_SEED107_PER;
	val108 = val107 + JAPAN_GIFT_2932_SEED108_PER;
	val109 = val108 + JAPAN_GIFT_2932_SEED109_PER;
	val110 = val109 + JAPAN_GIFT_2932_SEED110_PER;
	val111 = val110 + JAPAN_GIFT_2932_MONS111_PER;
	val112 = val111 + JAPAN_GIFT_2932_MONS112_PER;
	val113 = val112 + JAPAN_GIFT_2932_MONS113_PER;
	val114 = val113 + JAPAN_GIFT_2932_MONS114_PER;
	val115 = val114 + JAPAN_GIFT_2932_MONS115_PER;
	val116 = val115 + JAPAN_GIFT_2932_MONS116_PER;
	val117 = val116 + JAPAN_GIFT_2932_MONS117_PER;
	val118 = val117 + JAPAN_GIFT_2932_MONS118_PER;
	val119 = val118 + JAPAN_GIFT_2932_MONS119_PER;
	val120 = val119 + JAPAN_GIFT_2932_MONS120_PER;

	if (val120 != 100000) {
		trigger.message("Percentage Setting is wrong!", MSG_TYPE__SYSTEM);
	    	return;
	}

	rval  = Util.random(1, 100000);
	if      (rval <=val01) {PresentItem = JAPAN_GIFT_2932_ITEM001; GiftType="ITEM";}
	else if (rval <=val02) {PresentItem = JAPAN_GIFT_2932_ITEM002; GiftType="ITEM";}
	else if (rval <=val03) {PresentItem = JAPAN_GIFT_2932_ITEM003; GiftType="ITEM";}
	else if (rval <=val04) {PresentItem = JAPAN_GIFT_2932_ITEM004; GiftType="ITEM";}
	else if (rval <=val05) {PresentItem = JAPAN_GIFT_2932_ITEM005; GiftType="ITEM";}
	else if (rval <=val06) {PresentItem = JAPAN_GIFT_2932_ITEM006; GiftType="ITEM";}
	else if (rval <=val07) {PresentItem = JAPAN_GIFT_2932_ITEM007; GiftType="ITEM";}
	else if (rval <=val08) {PresentItem = JAPAN_GIFT_2932_ITEM008; GiftType="ITEM";}
	else if (rval <=val09) {PresentItem = JAPAN_GIFT_2932_ITEM009; GiftType="ITEM";}
	else if (rval <=val10) {PresentItem = JAPAN_GIFT_2932_ITEM010; GiftType="ITEM";}
	else if (rval <=val11) {PresentItem = JAPAN_GIFT_2932_ITEM011; GiftType="ITEM";}
	else if (rval <=val12) {PresentItem = JAPAN_GIFT_2932_ITEM012; GiftType="ITEM";}
	else if (rval <=val13) {PresentItem = JAPAN_GIFT_2932_ITEM013; GiftType="ITEM";}
	else if (rval <=val14) {PresentItem = JAPAN_GIFT_2932_ITEM014; GiftType="ITEM";}
	else if (rval <=val15) {PresentItem = JAPAN_GIFT_2932_ITEM015; GiftType="ITEM";}
	else if (rval <=val16) {PresentItem = JAPAN_GIFT_2932_ITEM016; GiftType="ITEM";}
	else if (rval <=val17) {PresentItem = JAPAN_GIFT_2932_ITEM017; GiftType="ITEM";}
	else if (rval <=val18) {PresentItem = JAPAN_GIFT_2932_ITEM018; GiftType="ITEM";}
	else if (rval <=val19) {PresentItem = JAPAN_GIFT_2932_ITEM019; GiftType="ITEM";}
	else if (rval <=val20) {PresentItem = JAPAN_GIFT_2932_ITEM020; GiftType="ITEM";}
	else if (rval <=val21) {PresentItem = JAPAN_GIFT_2932_ITEM021; GiftType="ITEM";}
	else if (rval <=val22) {PresentItem = JAPAN_GIFT_2932_ITEM022; GiftType="ITEM";}
	else if (rval <=val23) {PresentItem = JAPAN_GIFT_2932_ITEM023; GiftType="ITEM";}
	else if (rval <=val24) {PresentItem = JAPAN_GIFT_2932_ITEM024; GiftType="ITEM";}
	else if (rval <=val25) {PresentItem = JAPAN_GIFT_2932_ITEM025; GiftType="ITEM";}
	else if (rval <=val26) {PresentItem = JAPAN_GIFT_2932_ITEM026; GiftType="ITEM";}
	else if (rval <=val27) {PresentItem = JAPAN_GIFT_2932_ITEM027; GiftType="ITEM";}
	else if (rval <=val28) {PresentItem = JAPAN_GIFT_2932_ITEM028; GiftType="ITEM";}
	else if (rval <=val29) {PresentItem = JAPAN_GIFT_2932_ITEM029; GiftType="ITEM";}
	else if (rval <=val30) {PresentItem = JAPAN_GIFT_2932_ITEM030; GiftType="ITEM";}
	else if (rval <=val31) {PresentItem = JAPAN_GIFT_2932_ITEM031; GiftType="ITEM";}
	else if (rval <=val32) {PresentItem = JAPAN_GIFT_2932_ITEM032; GiftType="ITEM";}
	else if (rval <=val33) {PresentItem = JAPAN_GIFT_2932_ITEM033; GiftType="ITEM";}
	else if (rval <=val34) {PresentItem = JAPAN_GIFT_2932_ITEM034; GiftType="ITEM";}
	else if (rval <=val35) {PresentItem = JAPAN_GIFT_2932_ITEM035; GiftType="ITEM";}
	else if (rval <=val36) {PresentItem = JAPAN_GIFT_2932_ITEM036; GiftType="ITEM";}
	else if (rval <=val37) {PresentItem = JAPAN_GIFT_2932_ITEM037; GiftType="ITEM";}
	else if (rval <=val38) {PresentItem = JAPAN_GIFT_2932_ITEM038; GiftType="ITEM";}
	else if (rval <=val39) {PresentItem = JAPAN_GIFT_2932_ITEM039; GiftType="ITEM";}
	else if (rval <=val40) {PresentItem = JAPAN_GIFT_2932_ITEM040; GiftType="ITEM";}
	else if (rval <=val41) {PresentItem = JAPAN_GIFT_2932_ITEM041; GiftType="ITEM";}
	else if (rval <=val42) {PresentItem = JAPAN_GIFT_2932_ITEM042; GiftType="ITEM";}
	else if (rval <=val43) {PresentItem = JAPAN_GIFT_2932_ITEM043; GiftType="ITEM";}
	else if (rval <=val44) {PresentItem = JAPAN_GIFT_2932_ITEM044; GiftType="ITEM";}
	else if (rval <=val45) {PresentItem = JAPAN_GIFT_2932_ITEM045; GiftType="ITEM";}
	else if (rval <=val46) {PresentItem = JAPAN_GIFT_2932_ITEM046; GiftType="ITEM";}
	else if (rval <=val47) {PresentItem = JAPAN_GIFT_2932_ITEM047; GiftType="ITEM";}
	else if (rval <=val48) {PresentItem = JAPAN_GIFT_2932_ITEM048; GiftType="ITEM";}
	else if (rval <=val49) {PresentItem = JAPAN_GIFT_2932_ITEM049; GiftType="ITEM";}
	else if (rval <=val50) {PresentItem = JAPAN_GIFT_2932_ITEM050; GiftType="ITEM";}
	else if (rval <=val51) {PresentItem = JAPAN_GIFT_2932_ITEM051; GiftType="ITEM";}
	else if (rval <=val52) {PresentItem = JAPAN_GIFT_2932_ITEM052; GiftType="ITEM";}
	else if (rval <=val53) {PresentItem = JAPAN_GIFT_2932_ITEM053; GiftType="ITEM";}
	else if (rval <=val54) {PresentItem = JAPAN_GIFT_2932_ITEM054; GiftType="ITEM";}
	else if (rval <=val55) {PresentItem = JAPAN_GIFT_2932_ITEM055; GiftType="ITEM";}
	else if (rval <=val56) {PresentItem = JAPAN_GIFT_2932_ITEM056; GiftType="ITEM";}
	else if (rval <=val57) {PresentItem = JAPAN_GIFT_2932_ITEM057; GiftType="ITEM";}
	else if (rval <=val58) {PresentItem = JAPAN_GIFT_2932_ITEM058; GiftType="ITEM";}
	else if (rval <=val59) {PresentItem = JAPAN_GIFT_2932_ITEM059; GiftType="ITEM";}
	else if (rval <=val60) {PresentItem = JAPAN_GIFT_2932_ITEM060; GiftType="ITEM";}
	else if (rval <=val61) {PresentItem = JAPAN_GIFT_2932_ITEM061; GiftType="ITEM";}
	else if (rval <=val62) {PresentItem = JAPAN_GIFT_2932_ITEM062; GiftType="ITEM";}
	else if (rval <=val63) {PresentItem = JAPAN_GIFT_2932_ITEM063; GiftType="ITEM";}
	else if (rval <=val64) {PresentItem = JAPAN_GIFT_2932_ITEM064; GiftType="ITEM";}
	else if (rval <=val65) {PresentItem = JAPAN_GIFT_2932_ITEM065; GiftType="ITEM";}
	else if (rval <=val66) {PresentItem = JAPAN_GIFT_2932_ITEM066; GiftType="ITEM";}
	else if (rval <=val67) {PresentItem = JAPAN_GIFT_2932_ITEM067; GiftType="ITEM";}
	else if (rval <=val68) {PresentItem = JAPAN_GIFT_2932_ITEM068; GiftType="ITEM";}
	else if (rval <=val69) {PresentItem = JAPAN_GIFT_2932_ITEM069; GiftType="ITEM";}
	else if (rval <=val70) {PresentItem = JAPAN_GIFT_2932_ITEM070; GiftType="ITEM";}
	else if (rval <=val71) {PresentItem = JAPAN_GIFT_2932_ITEM071; GiftType="ITEM";}
	else if (rval <=val72) {PresentItem = JAPAN_GIFT_2932_ITEM072; GiftType="ITEM";}
	else if (rval <=val73) {PresentItem = JAPAN_GIFT_2932_ITEM073; GiftType="ITEM";}
	else if (rval <=val74) {PresentItem = JAPAN_GIFT_2932_ITEM074; GiftType="ITEM";}
	else if (rval <=val75) {PresentItem = JAPAN_GIFT_2932_ITEM075; GiftType="ITEM";}
	else if (rval <=val76) {PresentItem = JAPAN_GIFT_2932_ITEM076; GiftType="ITEM";}
	else if (rval <=val77) {PresentItem = JAPAN_GIFT_2932_ITEM077; GiftType="ITEM";}
	else if (rval <=val78) {PresentItem = JAPAN_GIFT_2932_ITEM078; GiftType="ITEM";}
	else if (rval <=val79) {PresentItem = JAPAN_GIFT_2932_ITEM079; GiftType="ITEM";}
	else if (rval <=val80) {PresentItem = JAPAN_GIFT_2932_ITEM080; GiftType="ITEM";}
	else if (rval <=val81) {PresentItem = JAPAN_GIFT_2932_ITEM081; GiftType="ITEM";}
	else if (rval <=val82) {PresentItem = JAPAN_GIFT_2932_ITEM082; GiftType="ITEM";}
	else if (rval <=val83) {PresentItem = JAPAN_GIFT_2932_ITEM083; GiftType="ITEM";}
	else if (rval <=val84) {PresentItem = JAPAN_GIFT_2932_ITEM084; GiftType="ITEM";}
	else if (rval <=val85) {PresentItem = JAPAN_GIFT_2932_ITEM085; GiftType="ITEM";}
	else if (rval <=val86) {PresentItem = JAPAN_GIFT_2932_ITEM086; GiftType="ITEM";}
	else if (rval <=val87) {PresentItem = JAPAN_GIFT_2932_ITEM087; GiftType="ITEM";}
	else if (rval <=val88) {PresentItem = JAPAN_GIFT_2932_ITEM088; GiftType="ITEM";}
	else if (rval <=val89) {PresentItem = JAPAN_GIFT_2932_ITEM089; GiftType="ITEM";}
	else if (rval <=val90) {PresentItem = JAPAN_GIFT_2932_ITEM090; GiftType="ITEM";}
	else if (rval <=val91) {PresentItem = JAPAN_GIFT_2932_ITEM091; GiftType="ITEM";}
	else if (rval <=val92) {PresentItem = JAPAN_GIFT_2932_ITEM092; GiftType="ITEM";}
	else if (rval <=val93) {PresentItem = JAPAN_GIFT_2932_ITEM093; GiftType="ITEM";}
	else if (rval <=val94) {PresentItem = JAPAN_GIFT_2932_ITEM094; GiftType="ITEM";}
	else if (rval <=val95) {PresentItem = JAPAN_GIFT_2932_ITEM095; GiftType="ITEM";}
	else if (rval <=val96) {PresentItem = JAPAN_GIFT_2932_ITEM096; GiftType="ITEM";}
	else if (rval <=val97) {PresentItem = JAPAN_GIFT_2932_ITEM097; GiftType="ITEM";}
	else if (rval <=val98) {PresentItem = JAPAN_GIFT_2932_ITEM098; GiftType="ITEM";}
	else if (rval <=val99) {PresentItem = JAPAN_GIFT_2932_ITEM099; GiftType="ITEM";}
	else if (rval <=val100) {PresentItem = JAPAN_GIFT_2932_ITEM100; GiftType="ITEM";}
	else if (rval <= val101) {PresentSeed = JAPAN_GIFT_2932_SEED101; GiftType="SEED";}
	else if (rval <= val102) {PresentSeed = JAPAN_GIFT_2932_SEED102; GiftType="SEED";}
	else if (rval <= val103) {PresentSeed = JAPAN_GIFT_2932_SEED103; GiftType="SEED";}
	else if (rval <= val104) {PresentSeed = JAPAN_GIFT_2932_SEED104; GiftType="SEED";}
	else if (rval <= val105) {PresentSeed = JAPAN_GIFT_2932_SEED105; GiftType="SEED";}
	else if (rval <= val106) {PresentSeed = JAPAN_GIFT_2932_SEED106; GiftType="SEED";}
	else if (rval <= val107) {PresentSeed = JAPAN_GIFT_2932_SEED107; GiftType="SEED";}
	else if (rval <= val108) {PresentSeed = JAPAN_GIFT_2932_SEED108; GiftType="SEED";}
	else if (rval <= val109) {PresentSeed = JAPAN_GIFT_2932_SEED109; GiftType="SEED";}
	else if (rval <= val110) {PresentSeed = JAPAN_GIFT_2932_SEED110; GiftType="SEED";}
	else if (rval <= val111) {PresentItem = JAPAN_GIFT_2932_MONS111; PTN = JAPAN_GIFT_2932_MONS111_PTN;}
	else if (rval <= val112) {PresentItem = JAPAN_GIFT_2932_MONS112; PTN = JAPAN_GIFT_2932_MONS112_PTN;}
	else if (rval <= val113) {PresentItem = JAPAN_GIFT_2932_MONS113; PTN = JAPAN_GIFT_2932_MONS113_PTN;}
	else if (rval <= val114) {PresentItem = JAPAN_GIFT_2932_MONS114; PTN = JAPAN_GIFT_2932_MONS114_PTN;}
	else if (rval <= val115) {PresentItem = JAPAN_GIFT_2932_MONS115; PTN = JAPAN_GIFT_2932_MONS115_PTN;}
	else if (rval <= val116) {PresentItem = JAPAN_GIFT_2932_MONS116; PTN = JAPAN_GIFT_2932_MONS116_PTN;}
	else if (rval <= val117) {PresentItem = JAPAN_GIFT_2932_MONS117; PTN = JAPAN_GIFT_2932_MONS117_PTN;}
	else if (rval <= val118) {PresentItem = JAPAN_GIFT_2932_MONS118; PTN = JAPAN_GIFT_2932_MONS118_PTN;}
	else if (rval <= val119) {PresentItem = JAPAN_GIFT_2932_MONS119; PTN = JAPAN_GIFT_2932_MONS119_PTN;}
	else if (rval <= val120) {PresentItem = JAPAN_GIFT_2932_MONS120; PTN = JAPAN_GIFT_2932_MONS120_PTN;}
	
	GivePresent_JPN(GiftType, PresentItem, PresentSeed, PTN);
	return;
}


//trash Item dump NPC function

quest
qPickItemTimer2()
{
	//integer exnum = JAPAN_GIFT_RESTRICT_EXPIRE_HOUR * 60 * 60;
	//controller.setExpireTime(exnum);
	//trigger.sayTo(JAPAN_GIFT_RESTRICT_EXPIRE_MSG1 + JAPAN_GIFT_RESTRICT_EXPIRE_HOUR + JAPAN_GIFT_RESTRICT_EXPIRE_MSG2, trigger);
	trigger.sayTo(JAPAN_GIFT_RESTRICT_EXPIRE_MSG1, trigger);
}

quest
qPickItemTimer3()	// vahma - for kelberos quest
{
	integer exnum = 60 * 60 * 24 * 7;
	if (controller.getExpireTime() == 0)
	{
	controller.setExpireTime(exnum);
	//trigger.sayTo(JAPAN_GIFT_RESTRICT_EXPIRE_MSG1 + JAPAN_GIFT_RESTRICT_EXPIRE_HOUR + JAPAN_GIFT_RESTRICT_EXPIRE_MSG2, trigger);
	trigger.sayTo("168 " + JAPAN_GIFT_RESTRICT_EXPIRE_MSG2, trigger);
	trigger.sayTo(JAPAN_GIFT_RESTRICT_EXPIRE_MSG3, trigger);
	}
}

quest
qPickItemTimer4()	// vahma - 10 minutes version of 3
{
	integer exnum = 60 * 10;
	if (controller.getExpireTime() == 0)
	{
	    controller.setExpireTime(exnum);
	    trigger.sayTo(exnum + JAPAN_GIFT_RESTRICT_EXPIRE_MSG2, trigger);
	    trigger.sayTo(JAPAN_GIFT_RESTRICT_EXPIRE_MSG3, trigger);
	}
}

// vahma : netcafe box

quest
qUseItem1003723()				// net cafe event box
{
	string itemID = "";
	integer selection;

	// ¾ÆÀÌÅÛ Áö±Þ ÀE¡ ½½·ÔÀÌ¶E¹«°Ô¶EÃ¼Å©ÇÑ´Ù.
	
	if (trigger.getEmptyInvenSlotCount() < 1) {
		trigger.message(TEXT_CLAD_LACK_EVSLOT, MSG_TYPE__SYSTEM);
		return;
	}

	if (trigger.getAvailInvenWeight() < 5) {
		trigger.message(TEXT_CLAD_LACK_EVWEIGHT, MSG_TYPE__SYSTEM);
		return;
	}

	selection = Util.random(1, 100);

	if (selection <= 1) {			// ¿ÍÀÎ
		itemID	= "1001027";
	} else if (selection <= 6) {		// »ç°¢ ±Eß
		itemID	= "1000883";
	} else if (selection <= 14) {		// ²ÉÀÙ ¸Ó¸®ÇÉ
		itemID	= "1000902";
	} else if (selection <= 30) {		// Á¤·ÉÃÊ
		itemID	= "1001827";
	} else if (selection <= 100) {		// ¼ö¼± µµ±¸
		itemID	= "1000076";
	}

	// ¾ÆÀÌÅÛÀ» ÁØ´Ù.
	if (itemID != "") trigger.addItemClassNamed(itemID, 1);

	// decrease number
	if (controller.canBeExhausted()) {
		controller.decreaseNumber(1);
	}

	// send using effect
	controller.effectBy(trigger);
}
