// $Id: TW_EquippableItem.Q,v 1.10 2003/03/17 09:07:42 softmax Exp $

#Import quest/system.h
#Import quest/tales_system.h
#Import quest/tw_mssi.h
#Import quest/tw_util.h
#Import quest/TW_NPC_Talk.h
#Import quest/TW_EquippableItem.h

quest
qEquipItem()
{
}

quest
qUnEquipItem()
{
}

quest
qCanEquip()
{
	// 전속을 할 수 있는 아이템 유무 체크 1이면 가능 0이면 불가
	if (controller.canBelong() == 1)
	{
		// 이미 전속을 한 아이템 인가를 체크 (0이면 가능 1이면 불가)
		if (controller.belong() == 0)
			controller.setBelong(1);
	}

	Machine.setBooleanReturn(true);
/*	불필요한 쓰레기 퀘스트들이므로 삭제해서 최적화한다. 낭비성 요소를 최대한 줄여서 가볍게 만든다.
	string canEquipQuestName;

	// given quest should not be blocked since in that case, result value is not set.
	canEquipQuestName = "qCanEquipItem" + controller.getClassName();
	controller.giveQuestTo(canEquipQuestName, trigger, ""); ///* no argument
*/
}

quest
qCanUnEquip()
{
	// 전속을 할 수 있는 아이템 유무 체크 1이면 가능 0이면 불가
	if (controller.canBelong() == 1)
	{
		// 이미 전속을 한 아이템 인가를 체크 (0이면 가능 1이면 불가)
		if (controller.belong() == 0)
			controller.setBelong(1);
	}

	Machine.setBooleanReturn(true);
}


/*
function
boolean
HPMPSP_CHECK(integer ADDHP, integer ADDMP, integer ADDSP)
{
	return true;
}
*/

// 커플 투구
quest
qEquipItem1000817()
{
	integer ADDEDHP;
	integer ADDEDMP;
	integer ADDEDSP;

	string HELMET_EQUIP;

	integer ADDHP = 80;
	integer ADDMP = 30;
	integer ADDSP = 50;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));
	ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP"));
	ADDEDSP = String.toInteger(trigger.getCookie("ADDEDSP"));

	HELMET_EQUIP = trigger.getCookie("HELMET_EQUIP");

	if (!HELMET_EQUIP)
	{
		ADDEDHP = ADDEDHP + ADDHP;
		ADDEDMP = ADDEDMP + ADDMP;
		ADDEDSP = ADDEDSP + ADDSP;
	}

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);
	trigger.setMaxSP(trigger.getOrgMaxSP() + ADDEDSP);

	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);
	trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);
	trigger.setCookie("ADDEDSP", Integer.toString(ADDEDSP), 0);

	HELMET_EQUIP = Integer.toString(Util.getTime());
	trigger.setCookie("HELMET_EQUIP", HELMET_EQUIP, 0);

	trigger.updateAttr();
}

quest
qUnEquipItem1000817()
{
	integer	ADDEDHP;
	integer	ADDEDMP;
	integer	ADDEDSP;

	integer SUBHP = 80;
	integer SUBMP = 30;
	integer SUBSP = 50;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - SUBHP;
	ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP")) - SUBMP;
	ADDEDSP = String.toInteger(trigger.getCookie("ADDEDSP")) - SUBSP;

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);
	trigger.setMaxSP(trigger.getOrgMaxSP() + ADDEDSP);

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	if (ADDEDMP==0)	trigger.resetCookie("ADDEDMP");
	else trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

	if (ADDEDSP==0)	trigger.resetCookie("ADDEDSP");
	else trigger.setCookie("ADDEDSP", Integer.toString(ADDEDSP), 0);

	trigger.resetCookie("HELMET_EQUIP");

	trigger.updateAttr();
}


// 태극기
quest
qEquipItem1000884()
{
	string REALHP;
	string REALMP;
	string REALSP;
	string TEMP_HP;
	string TEMP_MP;
	string TEMP_SP;

	string HELMET_EQUIP;

	integer TEMPHP;
	integer TEMPMP;
	integer TEMPSP;

	integer ADDHP = 1000;
	integer ADDMP = 500;
	integer ADDSP = 1000;
	integer MAXHP = 9999;
	integer MAXMP = 999;
	integer MAXSP = 9999;

	TEMP_HP = trigger.getCookie("REAL_HP");
	TEMP_MP = trigger.getCookie("REAL_MP");
	TEMP_SP = trigger.getCookie("REAL_SP");

	HELMET_EQUIP = trigger.getCookie("HELMET_EQUIP");

	if (TEMP_HP)
	{
		if (HELMET_EQUIP) TEMPHP = String.toInteger(TEMP_HP);
		else TEMPHP = String.toInteger(TEMP_HP)+ADDHP;
	}
	else TEMPHP = trigger.getMaxHP()+ADDHP;

	if (TEMP_MP)
	{
		if (HELMET_EQUIP) TEMPMP = String.toInteger(TEMP_MP);
		else TEMPMP = String.toInteger(TEMP_MP)+ADDMP;
	}
	else TEMPMP = trigger.getMaxMP()+ADDMP;

	if (TEMP_SP)
	{
		if (HELMET_EQUIP) TEMPSP = String.toInteger(TEMP_SP);
		else TEMPSP = String.toInteger(TEMP_SP)+ADDSP;
	}
	else TEMPSP = trigger.getMaxSP()+ADDSP;

	if (TEMPHP > MAXHP) {
		REALHP = Integer.toString(TEMPHP);
		trigger.setCookie("REAL_HP", REALHP, 0);
	}

	if (TEMPMP > MAXMP) {
		REALMP = Integer.toString(TEMPMP);
		trigger.setCookie("REAL_MP", REALMP, 0);
	}
	if (TEMPSP > MAXSP) {
		REALSP = Integer.toString(TEMPSP);
		trigger.setCookie("REAL_SP", REALSP, 0);
	}

	HELMET_EQUIP = Integer.toString(Util.getTime());
	trigger.setCookie("HELMET_EQUIP", HELMET_EQUIP, 0);

	trigger.setMaxHP(TEMPHP);
	trigger.setMaxMP(TEMPMP);
	trigger.setMaxSP(TEMPSP);

	trigger.updateAttr();
}

quest
qUnEquipItem1000884()
{
	string REALHP;
	string REALMP;
	string REALSP;

	integer TEMPHP;
	integer TEMPMP;
	integer TEMPSP;
	integer SUBHP = 1000;
	integer SUBMP = 500;
	integer SUBSP = 1000;
	integer MAXHP = 9999;
	integer MAXMP = 999;
	integer MAXSP = 9999;

	REALHP = trigger.getCookie("REAL_HP");
	REALMP = trigger.getCookie("REAL_MP");
	REALSP = trigger.getCookie("REAL_SP");

	if (REALHP) TEMPHP = String.toInteger(REALHP) - SUBHP;
	else TEMPHP = trigger.getMaxHP() - SUBHP;

	if (REALMP) TEMPMP = String.toInteger(REALMP) - SUBMP;
	else TEMPMP = trigger.getMaxMP() - SUBMP;

	if (REALSP) TEMPSP = String.toInteger(REALSP) - SUBSP;
	else TEMPSP = trigger.getMaxSP() - SUBSP;

	if (TEMPHP > MAXHP) {
		REALHP = Integer.toString(TEMPHP);
		trigger.setCookie("REAL_HP", REALHP, 0);
	} else {
		trigger.resetCookie("REAL_HP");
	}

	if (TEMPMP > MAXMP) {
		REALMP = Integer.toString(TEMPMP);
		trigger.setCookie("REAL_MP", REALMP, 0);
	} else {
		trigger.resetCookie("REAL_MP");
	}

	if (TEMPSP > MAXSP) {
		REALSP = Integer.toString(TEMPSP);
		trigger.setCookie("REAL_SP", REALSP, 0);
	} else {
		trigger.resetCookie("REAL_SP");
	}

	trigger.resetCookie("HELMET_EQUIP");

	trigger.setMaxHP(TEMPHP);
	trigger.setMaxMP(TEMPMP);
	trigger.setMaxSP(TEMPSP);

	trigger.updateAttr();
}


// 커플링 (남)
quest
qEquipItem1002036()
{
	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, true);
	trigger.updateAttr();
}

quest
qUnEquipItem1002036()
{
	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, false);
	trigger.updateAttr();
}


// 커플링 (여)
quest
qEquipItem1002037()
{
	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, true);
	trigger.updateAttr();
}

quest
qUnEquipItem1002037()
{
	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, false);
	trigger.updateAttr();
}


// 커플링+1 (남)
quest
qEquipItem1002142()
{
	string REALMP;
	string TEMP_MP;
	integer TEMPMP;
	integer ADDMP = 10;
	integer MAXMP = 999;

	TEMP_MP = trigger.getCookie("REAL_MP");
	TEMPMP = trigger.getMaxMP() + ADDMP;

	if (TEMP_MP)
	{
		TEMPMP = String.toInteger(TEMP_MP) + ADDMP;
	}

	if (TEMPMP > MAXMP)
	{
		REALMP = Integer.toString(TEMPMP);
		trigger.setCookie("REAL_MP", REALMP, 0);
	}

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, true);
	trigger.setMaxMP(TEMPMP);
	trigger.updateAttr();
}

quest
qUnEquipItem1002142()
{
	string REALMP;
	string TEMP_MP;

	integer TEMPMP;
	integer SUBMP = 10;
	integer MAXMP = 999;

	TEMP_MP = trigger.getCookie("REAL_MP");

	TEMPMP = trigger.getMaxMP() - SUBMP;

	if (TEMP_MP)
	{
		TEMPMP = String.toInteger(TEMP_MP) - SUBMP;
	}

	if (TEMPMP > MAXMP)
	{
		REALMP = Integer.toString(TEMPMP);
		trigger.setCookie("REAL_MP", REALMP, 0);
	}
	else
	{
		trigger.resetCookie("REAL_MP");
	}

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, false);
	trigger.setMaxMP(TEMPMP);
	trigger.updateAttr();
}


// 커플링+2 (남)
quest
qEquipItem1002143()
{
	string REALMP;
	string TEMP_MP;
	integer TEMPMP;
	integer ADDMP = 20;
	integer MAXMP = 999;

	TEMP_MP = trigger.getCookie("REAL_MP");
	TEMPMP = trigger.getMaxMP() + ADDMP;

	if (TEMP_MP)
	{
		TEMPMP = String.toInteger(TEMP_MP) + ADDMP;
	}

	if (TEMPMP > MAXMP)
	{
		REALMP = Integer.toString(TEMPMP);
		trigger.setCookie("REAL_MP", REALMP, 0);
	}

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, true);
	trigger.setMaxMP(TEMPMP);
	trigger.updateAttr();
}

quest
qUnEquipItem1002143()
{
	string REALMP;
	string TEMP_MP;

	integer TEMPMP;
	integer SUBMP = 20;
	integer MAXMP = 999;

	TEMP_MP = trigger.getCookie("REAL_MP");

	TEMPMP = trigger.getMaxMP() - SUBMP;

	if (TEMP_MP) {
		TEMPMP = String.toInteger(TEMP_MP) - SUBMP;
	}

	if (TEMPMP > MAXMP) {
		REALMP = Integer.toString(TEMPMP);
		trigger.setCookie("REAL_MP", REALMP, 0);
	} else {
		trigger.resetCookie("REAL_MP");
	}

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, false);
	trigger.setMaxMP(TEMPMP);
	trigger.updateAttr();
}


// 커플링+3 (남)
quest
qEquipItem1002144()
{
	string REALMP;
	string TEMP_MP;
	integer TEMPMP;
	integer ADDMP = 40;
	integer MAXMP = 999;

	TEMP_MP = trigger.getCookie("REAL_MP");
	TEMPMP = trigger.getMaxMP() + ADDMP;

	if (TEMP_MP)
	{
		TEMPMP = String.toInteger(TEMP_MP) + ADDMP;
	}

	if (TEMPMP > MAXMP)
	{
		REALMP = Integer.toString(TEMPMP);
		trigger.setCookie("REAL_MP", REALMP, 0);
	}

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, true);
	trigger.setMaxMP(TEMPMP);
	trigger.updateAttr();
}

quest
qUnEquipItem1002144()
{
	string REALMP;
	string TEMP_MP;

	integer TEMPMP;
	integer SUBMP = 40;
	integer MAXMP = 999;

	TEMP_MP = trigger.getCookie("REAL_MP");

	TEMPMP = trigger.getMaxMP() - SUBMP;

	if (TEMP_MP) {
		TEMPMP = String.toInteger(TEMP_MP) - SUBMP;
	}

	if (TEMPMP > MAXMP) {
		REALMP = Integer.toString(TEMPMP);
		trigger.setCookie("REAL_MP", REALMP, 0);
	} else {
		trigger.resetCookie("REAL_MP");
	}

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, false);
	trigger.setMaxMP(TEMPMP);
	trigger.updateAttr();
}


// 커플링+1 (여)
quest
qEquipItem1002145()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;
	integer	ADDHP = 100;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP < 0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("COUPLE_ADD_HP")) trigger.resetCookie("COUPLE_ADD_HP");
	}

	ADD_HP_STRING = trigger.getCookie("REAL_HP");

	if(ADD_HP_STRING)
	{
		ADDHP = String.toInteger(ADD_HP_STRING);
		ADDEDHP = ADDEDHP + ADDHP;
		if(trigger.getCookie("REAL_HP")) trigger.resetCookie("REAL_HP");
	} // 예전 쿠키(REAL_HP) 있을때 처리. 실제 체력을 나타내는 REAL_HP는 의미가 없음.
	else
	{
		ADD_HP_STRING = trigger.getCookie("COUPLE_ADD_HP");
		if(!ADD_HP_STRING)
		{
			ADDEDHP = ADDEDHP + ADDHP;
			trigger.setCookie("COUPLE_ADD_HP", Integer.toString(ADDHP), 0);
		}

	} // 현재 쿠키 (COUPLE_ADD_HP) 있을때 처리. 장착됨을 알리는 쿠키가 없을때 ADDEDHP 에 ADDHP 를 더해준다.

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, true);
	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);
	trigger.updateAttr();
}

quest
qUnEquipItem1002145()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("COUPLE_ADD_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, false);
	trigger.resetCookie("COUPLE_ADD_HP");

	trigger.updateAttr();
}


// 커플링+2 (여)
quest
qEquipItem1002146()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;
	integer	ADDHP = 150;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP < 0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("COUPLE_ADD_HP")) trigger.resetCookie("COUPLE_ADD_HP");
	}

	ADD_HP_STRING = trigger.getCookie("REAL_HP");

	if(ADD_HP_STRING)
	{
		ADDHP = String.toInteger(ADD_HP_STRING);
		ADDEDHP = ADDEDHP + ADDHP;
		if(trigger.getCookie("REAL_HP")) trigger.resetCookie("REAL_HP");
	} // 예전 쿠키(REAL_HP) 있을때 처리. 실제 체력을 나타내는 REAL_HP는 의미가 없음.
	else
	{
		ADD_HP_STRING = trigger.getCookie("COUPLE_ADD_HP");
		if(!ADD_HP_STRING)
		{
			ADDEDHP = ADDEDHP + ADDHP;
			trigger.setCookie("COUPLE_ADD_HP", Integer.toString(ADDHP), 0);
		}

	} // 현재 쿠키 (COUPLE_ADD_HP) 있을때 처리. 장착됨을 알리는 쿠키가 없을때 ADDEDHP 에 ADDHP 를 더해준다.

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, true);
	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);
	trigger.updateAttr();
}

quest
qUnEquipItem1002146()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("COUPLE_ADD_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, false);
	trigger.resetCookie("COUPLE_ADD_HP");

	trigger.updateAttr();
}


// 커플링+3 (여)
quest
qEquipItem1002147()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;
	integer	ADDHP = 200;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP < 0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("COUPLE_ADD_HP")) trigger.resetCookie("COUPLE_ADD_HP");
	}

	ADD_HP_STRING = trigger.getCookie("REAL_HP");

	if(ADD_HP_STRING)
	{
		ADDHP = String.toInteger(ADD_HP_STRING);
		ADDEDHP = ADDEDHP + ADDHP;
		if(trigger.getCookie("REAL_HP")) trigger.resetCookie("REAL_HP");
	} // 예전 쿠키(REAL_HP) 있을때 처리. 실제 체력을 나타내는 REAL_HP는 의미가 없음.
	else
	{
		ADD_HP_STRING = trigger.getCookie("COUPLE_ADD_HP");
		if(!ADD_HP_STRING)
		{
			ADDEDHP = ADDEDHP + ADDHP;
			trigger.setCookie("COUPLE_ADD_HP", Integer.toString(ADDHP), 0);
		}

	} // 현재 쿠키 (COUPLE_ADD_HP) 있을때 처리. 장착됨을 알리는 쿠키가 없을때 ADDEDHP 에 ADDHP 를 더해준다.

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, true);
	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);
	trigger.updateAttr();
}

quest
qUnEquipItem1002147()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("COUPLE_ADD_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.setState(CREATURE_STATE__EQUIP_COUPLE_RING, false);
	trigger.resetCookie("COUPLE_ADD_HP");

	trigger.updateAttr();
}


// 유치원 가방
quest
qEquipItem1002324()
{
	if (!trigger.getCookie("EquipWeightUpItem")) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 200);
		trigger.updateAttr();

		trigger.setCookie("EquipWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1002324()
{
	if (trigger.getCookie("EquipWeightUpItem")) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 200);
		trigger.updateAttr();

		trigger.resetCookie("EquipWeightUpItem");
	}
}

quest
qCanUnEquipItem1002324()
{
	if ((trigger.getAvailInvenWeight() - 200) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
	}
}


// 거북이 등딱지
quest
qEquipItem1002325()
{
	if (!trigger.getCookie("EquipWeightUpItem")) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 150);
		trigger.updateAttr();

		trigger.setCookie("EquipWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1002325()
{
	if (trigger.getCookie("EquipWeightUpItem")) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 150);
		trigger.updateAttr();

		trigger.resetCookie("EquipWeightUpItem");
	}
}

quest
qCanUnEquipItem1002325()
{
	if ((trigger.getAvailInvenWeight() - 150) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
	}
}


// 보조 가방
quest
qEquipItem1002326()
{
	if (trigger.getCookie("EquipWeightUpItem") != "Equip") {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 100);
		trigger.updateAttr();

		trigger.setCookie("EquipWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1002326()
{
	if (trigger.getCookie("EquipWeightUpItem")) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 100);
		trigger.updateAttr();

		trigger.resetCookie("EquipWeightUpItem");
	}
}

quest
qCanUnEquipItem1002326()
{
	if ((trigger.getAvailInvenWeight() - 100) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
	}
}

// 나뭇가지 봇짐
quest
qEquipItem1006275()
{
	if (trigger.getCookie("ShowWeightUpItem") != "Equip") {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 200);
		trigger.updateAttr();

		trigger.setCookie("ShowWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1006275()
{
	if (trigger.getCookie("ShowWeightUpItem")) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 200);
		trigger.updateAttr();

		trigger.resetCookie("ShowWeightUpItem");
	}
}

quest
qCanUnEquipItem1006275()
{
	if ((trigger.getAvailInvenWeight() - 200) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
	}
}

// 돼지 꼬리
quest
qEquipItem1002327()
{
	string REALSP;
	string TEMP_SP;
	integer TEMPSP;
	integer ADDSP = 100;
	integer MAXSP = 9999;

	TEMP_SP = trigger.getCookie("REAL_SP");

	TEMPSP = trigger.getMaxSP() + ADDSP;

	if (TEMP_SP) {
		TEMPSP = String.toInteger(TEMP_SP) + ADDSP;
	}

	if (TEMPSP > MAXSP) {
		REALSP = Integer.toString(TEMPSP);
		trigger.setCookie("REAL_SP", REALSP, 0);
	}

	trigger.setMaxSP(TEMPSP);
	trigger.updateAttr();
}

quest
qUnEquipItem1002327()
{
	string REALSP;
	string TEMP_SP;

	integer TEMPSP;
	integer SUBSP = 100;
	integer MAXSP = 9999;

	TEMP_SP = trigger.getCookie("REAL_SP");

	TEMPSP = trigger.getMaxSP() - SUBSP;

	if (TEMP_SP) {
		TEMPSP = String.toInteger(TEMP_SP) - SUBSP;
	}

	if (TEMPSP > MAXSP) {
		REALSP = Integer.toString(TEMPSP);
		trigger.setCookie("REAL_SP", REALSP, 0);
	} else {
		trigger.resetCookie("REAL_SP");
	}

	trigger.setMaxSP(TEMPSP);
	trigger.updateAttr();
}


// 반창고
quest
qEquipItem1000903()
{
	trigger.setRegen(1);
}

quest
qUnEquipItem1000903()
{
	trigger.setRegen(0);
}


// 리프 머리띠
quest
qEquipItem1000907()
{
	trigger.setRegen(2);
}

quest
qUnEquipItem1000907()
{
	trigger.setRegen(0);
}


// 체력의 반지
quest
qEquipItem1000923()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;

	integer ADDHP = trigger.getOrgMaxHP() * 30 / 100;
	if (ADDHP>800)	ADDHP = 800;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP < 0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("RING_ADD_HP")) trigger.resetCookie("RING_ADD_HP");
	}

	ADD_HP_STRING = trigger.getCookie("HP_RING_ADD_HP");
	if(ADD_HP_STRING)
	{
		ADDHP = String.toInteger(ADD_HP_STRING);
		ADDEDHP = ADDEDHP + ADDHP;
		if(trigger.getCookie("HP_RING_ADD_HP")) trigger.resetCookie("HP_RING_ADD_HP");
		if(trigger.getCookie("REAL_HP")) trigger.resetCookie("REAL_HP");
	} // 예전 쿠키(HP_RING_ADD_HP,REAL_HP) 있을때 처리. 실제 체력을 나타내는 REAL_HP는 의미가 없음.
	else
	{
		ADD_HP_STRING = trigger.getCookie("RING_ADD_HP");
		if(!ADD_HP_STRING)
		{
			ADDEDHP = ADDEDHP + ADDHP;
			trigger.setCookie("RING_ADD_HP", Integer.toString(ADDHP), 0);
		}
	} // 현재 쿠키 (RING_ADD_HP) 있을때 처리. 장착됨을 알리는 쿠키가 없을때 ADDEDHP 에 ADDHP 를 더해준다.

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);
	trigger.updateAttr();
}

quest
qUnEquipItem1000923()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("RING_ADD_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.resetCookie("RING_ADD_HP");

	trigger.updateAttr();
}


// 토끼꼬리
quest
qEquipItem1000934()
{
	string REALSP;
	string TEMP_SP;
	integer TEMPSP;
	integer ADDSP = 100;
	integer MAXSP = 9999;

	TEMP_SP = trigger.getCookie("REAL_SP");

	TEMPSP = trigger.getMaxSP() + ADDSP;

	if (TEMP_SP) {
		TEMPSP = String.toInteger(TEMP_SP) + ADDSP;
	}

	if (TEMPSP > MAXSP) {
		REALSP = Integer.toString(TEMPSP);
		trigger.setCookie("REAL_SP", REALSP, 0);
	}

	trigger.setMaxSP(TEMPSP);
	trigger.updateAttr();
}

quest
qUnEquipItem1000934()
{
	string REALSP;
	string TEMP_SP;

	integer TEMPSP;
	integer SUBSP = 100;
	integer MAXSP = 9999;

	TEMP_SP = trigger.getCookie("REAL_SP");

	TEMPSP = trigger.getMaxSP() - SUBSP;

	if (TEMP_SP) {
		TEMPSP = String.toInteger(TEMP_SP) - SUBSP;
	}

	if (TEMPSP > MAXSP) {
		REALSP = Integer.toString(TEMPSP);
		trigger.setCookie("REAL_SP", REALSP, 0);
	} else {
		trigger.resetCookie("REAL_SP");
	}

	trigger.setMaxSP(TEMPSP);
	trigger.updateAttr();
}


// 샌들
quest
qEquipItem1000955()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 1);
}

quest
qUnEquipItem1000955()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 1);
}


// 짚신
quest
qEquipItem1000956()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 1);
	trigger.setRunSpeed(trigger.getRunSpeed() + 1);
}

quest
qUnEquipItem1000956()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 1);
	trigger.setRunSpeed(trigger.getRunSpeed() - 1);
}


// 레더 슈즈
quest
qEquipItem1000958()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 1);
	trigger.setRunSpeed(trigger.getRunSpeed() + 1);
	trigger.setConsumeStamina(7);
}

quest
qUnEquipItem1000958()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 1);
	trigger.setRunSpeed(trigger.getRunSpeed() - 1);
	trigger.setConsumeStamina(10);
}


// 조깅화
quest
qEquipItem1000959()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 2);
	trigger.setRunSpeed(trigger.getRunSpeed() + 2);
	trigger.setConsumeStamina(5);
}

quest
qUnEquipItem1000959()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 2);
	trigger.setRunSpeed(trigger.getRunSpeed() - 2);
	trigger.setConsumeStamina(10);
}


// 워 부츠
quest
qEquipItem1000960()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 1);
}

quest
qUnEquipItem1000960()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 1);
}


// 윙 슈즈
quest
qEquipItem1000961()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 3);
	trigger.setRunSpeed(trigger.getRunSpeed() + 3);
	trigger.setConsumeStamina(5);
}

quest
qUnEquipItem1000961()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 3);
	trigger.setRunSpeed(trigger.getRunSpeed() - 3);
	trigger.setConsumeStamina(10);
}


// 밍쿠 슈즈
quest
qEquipItem1000967()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 4);
	trigger.setRunSpeed(trigger.getRunSpeed() + 4);
}

quest
qUnEquipItem1000967()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() -4);
	trigger.setRunSpeed(trigger.getRunSpeed() -4);
}


// 운영자용 신발
quest
qEquipItem1000974()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 20);
	trigger.setRunSpeed(trigger.getRunSpeed() + 20);
}

quest
qUnEquipItem1000974()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 20);
	trigger.setRunSpeed(trigger.getRunSpeed() - 20);
}

//******************************************************
// 검투사의 신발
// 2006.08.29 written by Han
//******************************************************
// 검투사의 신발
quest
qEquipItem1006200()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 1);
	trigger.setRunSpeed(trigger.getRunSpeed() + 2);
}

quest
qUnEquipItem1006200()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 1);
	trigger.setRunSpeed(trigger.getRunSpeed() - 2);
}

//******************************************************
// 추석 이벤트용 걷기/뛰기 속도 다운 장착 퀘스트
// 2006.09.07 written by Han
//******************************************************
quest
qEquipItem1006282()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 6);
	trigger.setRunSpeed(trigger.getRunSpeed() - 6);
}

quest
qUnEquipItem1006282()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 6);
	trigger.setRunSpeed(trigger.getRunSpeed() + 6);
}

// 우산 모자
quest
qEquipItem1002155()
{
	trigger.setState(CREATURE_STATE__WEATHER_AVOID_RAIN, true);
}

quest
qUnEquipItem1002155()
{
	trigger.setState(CREATURE_STATE__WEATHER_AVOID_RAIN, false);
}


// 삿갓
quest
qEquipItem1002156()
{
	trigger.setState(CREATURE_STATE__WEATHER_AVOID_SNOW, true);
}

quest
qUnEquipItem1002156()
{
	trigger.setState(CREATURE_STATE__WEATHER_AVOID_SNOW, false);
}


// 산타 모자
quest
qEquipItem1002157()
{
	trigger.setState(CREATURE_STATE__WEATHER_AVOID_SNOW, true);
}

quest
qUnEquipItem1002157()
{
	trigger.setState(CREATURE_STATE__WEATHER_AVOID_SNOW, false);
}


// 빨간 산타 보따리
quest
qEquipItem1002677()
{
	if( !trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 300);
		trigger.updateAttr();

		trigger.setCookie("EquipWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1002677()
{
	if( trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 300);
		trigger.updateAttr();

		trigger.resetCookie("EquipWeightUpItem");
	}
}

quest
qCanUnEquipItem1002677()
{
	if ((trigger.getAvailInvenWeight() - 300) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
	}
}


// 날개 가방
quest
qEquipItem1002694()
{
	if( !trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 300);
		trigger.updateAttr();

		trigger.setCookie("EquipWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1002694()
{
	if( trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 300);
		trigger.updateAttr();

		trigger.resetCookie("EquipWeightUpItem");
	}
}

quest
qCanUnEquipItem1002694()
{
	if ((trigger.getAvailInvenWeight() - 300) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
        }
}


// 순록옷
quest
qEquipItem1002697()
{
	trigger.setRunSpeed(trigger.getRunSpeed() + 2);
}

quest
qUnEquipItem1002697()
{
	trigger.setRunSpeed(trigger.getRunSpeed() - 2);
}


// 애정 운동화
quest
qEquipItem1002775()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 3);
	trigger.setRunSpeed(trigger.getRunSpeed() - 3);
}

quest
qUnEquipItem1002775()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 3);
	trigger.setRunSpeed(trigger.getRunSpeed() + 3);
}


// 큐피트 날개
quest
qEquipItem1002796()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;

	integer ADDHP = trigger.getOrgMaxHP() * 10 / 100;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP<0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("BODY_ADD_HP")) trigger.resetCookie("BODY_ADD_HP");
	}

	ADD_HP_STRING = trigger.getCookie("BODY_ADD_HP");

	if (!ADD_HP_STRING)
	{
		ADDEDHP = ADDEDHP + ADDHP;
		trigger.setCookie("BODY_ADD_HP", Integer.toString(ADDHP), 0);
	}

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.updateAttr();
}

quest
qUnEquipItem1002796()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("BODY_ADD_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.resetCookie("BODY_ADD_HP");

	trigger.updateAttr();
}


// 큐피트 슈즈
quest
qEquipItem1002798()
{
	string	SHOE_EQUIP;
	integer	ADDEDSP;

	SHOE_EQUIP = trigger.getCookie("SHOE_EQUIP");

	ADDEDSP = String.toInteger(trigger.getCookie("ADDEDSP"));
	if (!SHOE_EQUIP)	ADDEDSP = ADDEDSP + 300;

	trigger.setMaxSP(trigger.getOrgMaxSP() + ADDEDSP);

	trigger.setCookie("ADDEDSP", Integer.toString(ADDEDSP), 0);

	SHOE_EQUIP = Integer.toString(Util.getTime());
	trigger.setCookie("SHOE_EQUIP", SHOE_EQUIP, 0);

	trigger.setRunSpeed(trigger.getRunSpeed() + 2);

	trigger.updateAttr();
}

quest
qUnEquipItem1002798()
{
	integer ADDEDSP = String.toInteger(trigger.getCookie("ADDEDSP")) - 300;

	trigger.setMaxSP(trigger.getOrgMaxSP() + ADDEDSP);

	if (ADDEDSP==0) trigger.resetCookie("ADDEDSP");
	else trigger.setCookie("ADDEDSP", Integer.toString(ADDEDSP), 0);

	trigger.resetCookie("SHOE_EQUIP");

	trigger.setRunSpeed(trigger.getRunSpeed() - 2);

	trigger.updateAttr();
}


// 링 오브 호크아이
quest
qEquipItem1002852()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;

	integer ADDHP = trigger.getOrgMaxHP() * 20 / 100;
	if (ADDHP>500)	ADDHP = 500;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP<0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("RING_ADD_HP")) trigger.resetCookie("RING_ADD_HP");
	}

	ADD_HP_STRING = trigger.getCookie("RING_ADD_HP");
	if (!ADD_HP_STRING)
	{
		ADDEDHP = ADDEDHP + ADDHP;
		trigger.setCookie("RING_ADD_HP", Integer.toString(ADDHP), 0);
	}

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.updateAttr();
}

quest
qUnEquipItem1002852()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("RING_ADD_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.resetCookie("RING_ADD_HP");

	trigger.updateAttr();
}


//  파초선
quest
qUnEquipItem1002866()
{
	integer ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP")) - String.toInteger(trigger.getCookie("BODY_ADD_MP"));

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);

	if (ADDEDMP==0) trigger.resetCookie("ADDEDMP");
	else trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

	trigger.resetCookie("BODY_ADD_MP");

	trigger.updateAttr();
}

quest
qEquipItem1002866()
{
	string	ADD_MP_STRING;
	integer	ADDEDMP;

	integer ADDMP = 150;

	ADD_MP_STRING = trigger.getCookie("BODY_ADD_MP");

	ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP"));
	if (!ADD_MP_STRING) ADDEDMP = ADDEDMP + ADDMP;

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);

	trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);
	trigger.setCookie("BODY_ADD_MP", Integer.toString(ADDMP), 0);

	trigger.updateAttr();
}


//  금은각의 호로병
quest
qEquipItem1002867()
{
	if( !trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 200);
		trigger.updateAttr();

		trigger.setCookie("EquipWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1002867()
{
	if( trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 200);
		trigger.updateAttr();

		trigger.resetCookie("EquipWeightUpItem");
	}
}

quest
qCanUnEquipItem1002867()
{
	if ((trigger.getAvailInvenWeight() - 200) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
	}
}


//  여래불의 장심
quest
qEquipItem1002868()
{
 	string	ADD_MREGEN_STRING;
	integer ADDEDMREGEN;
	integer ADDMREGEN;

	ADDEDMREGEN = String.toInteger(trigger.getCookie("ADDEDMREGEN"));
	ADDMREGEN = trigger.getMregen() - ADDEDMREGEN;    //두배 상승이므로 Mregen 자체가 상승치.

	ADD_MREGEN_STRING = trigger.getCookie("BODY_ADD_MREGEN");

	if( !ADD_MREGEN_STRING )
	{
		ADDEDMREGEN = ADDEDMREGEN + ADDMREGEN;
		trigger.setMregen(trigger.getMregen() + ADDMREGEN);

		trigger.setCookie("ADDEDMREGEN", Integer.toString(ADDEDMREGEN), 0);
		trigger.setCookie("BODY_ADD_MREGEN", Integer.toString(ADDMREGEN), 0);
	}
}

quest
qUnEquipItem1002868()
{
	integer ADDEDMREGEN, ADDMREGEN = String.toInteger(trigger.getCookie("BODY_ADD_MREGEN"));
	ADDEDMREGEN = String.toInteger(trigger.getCookie("ADDEDMREGEN")) - ADDMREGEN;

	trigger.setMregen( trigger.getMregen() - ADDMREGEN );

	if (ADDEDMREGEN==0) trigger.resetCookie("ADDEDMREGEN");
	else trigger.setCookie("ADDEDMREGEN", Integer.toString(ADDEDMREGEN), 0);

	trigger.resetCookie("BODY_ADD_MREGEN");
}



//  근두운
quest
qEquipItem1002869()
{
 	string	ADD_REGEN_STRING;
	integer ADDEDREGEN;
	integer ADDREGEN;

	ADDEDREGEN = String.toInteger(trigger.getCookie("ADDEDREGEN"));
	ADDREGEN = trigger.getRegen() - ADDEDREGEN;   // 두배 상승이므로 Regen 자체가 상승치.

	ADD_REGEN_STRING = trigger.getCookie("BODY_ADD_REGEN");

	if( !ADD_REGEN_STRING )
	{
		ADDEDREGEN = ADDEDREGEN + ADDREGEN;
		trigger.setRegen(trigger.getRegen() + ADDREGEN);

		trigger.setCookie("ADDEDREGEN", Integer.toString(ADDEDREGEN), 0);
		trigger.setCookie("BODY_ADD_REGEN", Integer.toString(ADDREGEN), 0);
	}
}

quest
qUnEquipItem1002869()
{
	integer ADDEDREGEN, ADDREGEN = String.toInteger(trigger.getCookie("BODY_ADD_REGEN"));
	ADDEDREGEN = String.toInteger(trigger.getCookie("ADDEDREGEN")) - ADDREGEN;

	trigger.setRegen( trigger.getRegen() - ADDREGEN );

	if (ADDEDREGEN==0) trigger.resetCookie("ADDEDREGEN");
	else trigger.setCookie("ADDEDREGEN", Integer.toString(ADDEDREGEN), 0);

	trigger.resetCookie("BODY_ADD_REGEN");
}


//  건곤 배낭
quest
qEquipItem1002879()
{
	if( !trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 400);
		trigger.updateAttr();

		trigger.setCookie("EquipWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1002879()
{
	if( trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 400);
		trigger.updateAttr();

		trigger.resetCookie("EquipWeightUpItem");
	}
}

quest
qCanUnEquipItem1002879()
{
	if ((trigger.getAvailInvenWeight() - 400) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
	}
}


//  명왕지염
quest
qEquipItem1002898()
{
	if( !trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 300);
		trigger.updateAttr();

		trigger.setCookie("EquipWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1002898()
{
	if( trigger.getCookie("EquipWeightUpItem") ) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 300);
		trigger.updateAttr();

		trigger.resetCookie("EquipWeightUpItem");
	}
}

quest
qCanUnEquipItem1002898()
{
	if ((trigger.getAvailInvenWeight() - 300) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
	}
}


//  관세천수
quest
qEquipItem1002899()
{
	string	ADD_MP_STRING;
	integer	ADDEDMP;

	integer ADDMP = 400;

	ADD_MP_STRING = trigger.getCookie("BODY_ADD_MP");

	ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP"));
	if (!ADD_MP_STRING) ADDEDMP = ADDEDMP + ADDMP;

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);

	trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);
	trigger.setCookie("BODY_ADD_MP", Integer.toString(ADDMP), 0);

	trigger.updateAttr();
}

quest
qUnEquipItem1002899()
{
	integer ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP")) - String.toInteger(trigger.getCookie("BODY_ADD_MP"));

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);

	if (ADDEDMP==0) trigger.resetCookie("ADDEDMP");
	else trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

	trigger.resetCookie("BODY_ADD_MP");

	trigger.updateAttr();
}


// 이그니스 슈즈
quest
qEquipItem1002987()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 3);
	trigger.setRunSpeed(trigger.getRunSpeed() + 2);
	trigger.setConsumeStamina(5);
}

quest
qUnEquipItem1002987()
{
    trigger.setWalkSpeed(trigger.getWalkSpeed() - 3);
	trigger.setRunSpeed(trigger.getRunSpeed() - 2);
	trigger.setConsumeStamina(10);
}


// 챔피언 슈즈
quest
qEquipItem1003453()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 5);
	trigger.setRunSpeed(trigger.getRunSpeed() + 5);
}

quest
qUnEquipItem1003453()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 5);
	trigger.setRunSpeed(trigger.getRunSpeed() - 5);
}


// 삼바 슈즈
quest
qEquipItem1003869()
{
	string	SHOE_EQUIP;
	integer	ADDEDSP;

	SHOE_EQUIP = trigger.getCookie("SHOE_EQUIP");

	ADDEDSP = String.toInteger(trigger.getCookie("ADDEDSP"));
	if (!SHOE_EQUIP)	ADDEDSP = ADDEDSP + 600;

	trigger.setMaxSP(trigger.getOrgMaxSP() + ADDEDSP);

	trigger.setCookie("ADDEDSP", Integer.toString(ADDEDSP), 0);

	SHOE_EQUIP = Integer.toString(Util.getTime());
	trigger.setCookie("SHOE_EQUIP", SHOE_EQUIP, 0);

	trigger.setWalkSpeed(trigger.getWalkSpeed() + 5);
	trigger.setRunSpeed(trigger.getRunSpeed() + 5);

	trigger.updateAttr();
}

quest
qUnEquipItem1003869()
{
	integer ADDEDSP = String.toInteger(trigger.getCookie("ADDEDSP")) - 600;

	trigger.setMaxSP(trigger.getOrgMaxSP() + ADDEDSP);

	if (ADDEDSP==0) trigger.resetCookie("ADDEDSP");
	else trigger.setCookie("ADDEDSP", Integer.toString(ADDEDSP), 0);

	trigger.resetCookie("SHOE_EQUIP");

	trigger.setWalkSpeed(trigger.getWalkSpeed() - 5);
	trigger.setRunSpeed(trigger.getRunSpeed() - 5);

	trigger.updateAttr();
}


// 노란 풍선
quest
qEquipItem1004466()
{
	// 대만의 경우 근두운과 같은 아이템과 충돌날 수 있음. 테스트 필요함.
	// 충돌날 수 있는 거 감안하고 진행되어야 됨.
	string ADD_MREGEN_STRING;
	integer ADDEDMREGEN;
	integer ADDMREGEN;

	ADDEDMREGEN = String.toInteger(trigger.getCookie("ADDEDMREGEN"));
	ADDMREGEN = trigger.getMregen() - ADDEDMREGEN;

	ADD_MREGEN_STRING = trigger.getCookie("BODY_ADD_MREGEN");

	if(!ADD_MREGEN_STRING) {
		ADDEDMREGEN = ADDEDMREGEN + ADDMREGEN;
		trigger.setMregen(trigger.getMregen() + ADDMREGEN);

		trigger.setCookie("ADDEDMREGEN", Integer.toString(ADDEDMREGEN), 0);
		trigger.setCookie("BODY_ADD_MREGEN", Integer.toString(ADDMREGEN), 0);
	}
}

quest
qUnEquipItem1004466()
{
	integer ADDEDMREGEN, ADDMREGEN;
	ADDMREGEN = String.toInteger(trigger.getCookie("BODY_ADD_MREGEN"));
	ADDEDMREGEN = String.toInteger(trigger.getCookie("ADDEDMREGEN")) - ADDMREGEN;

	// 이러면 음수로 떨어지는 경우엔 어떻게? 뭔가 불안하게 구현되어 있다. 흠...
	trigger.setMregen(trigger.getMregen() - ADDMREGEN);

	if (ADDEDMREGEN==0)
		trigger.resetCookie("ADDEDMREGEN");
	else
		trigger.setCookie("ADDEDMREGEN", Integer.toString(ADDEDMREGEN), 0);

	trigger.resetCookie("BODY_ADD_MREGEN");
}


// 녹색 풍선
quest
qEquipItem1004467()
{
	string ADD_REGEN_STRING;
	integer ADDEDREGEN;
	integer ADDREGEN;

	ADDEDREGEN = String.toInteger(trigger.getCookie("ADDEDREGEN"));
	ADDREGEN = trigger.getRegen() - ADDEDREGEN;

	ADD_REGEN_STRING = trigger.getCookie("BODY_ADD_REGEN");

	if(!ADD_REGEN_STRING) {
		ADDEDREGEN = ADDEDREGEN + ADDREGEN;
		trigger.setRegen(trigger.getRegen() + ADDREGEN);

		trigger.setCookie("ADDEDREGEN", Integer.toString(ADDEDREGEN), 0);
		trigger.setCookie("BODY_ADD_REGEN", Integer.toString(ADDREGEN), 0);
	}
}

quest
qUnEquipItem1004467()
{
	integer ADDEDREGEN, ADDREGEN;
	ADDREGEN = String.toInteger(trigger.getCookie("BODY_ADD_REGEN"));
	ADDEDREGEN = String.toInteger(trigger.getCookie("ADDEDREGEN")) - ADDREGEN;

	trigger.setRegen( trigger.getRegen() - ADDREGEN );

	if (ADDEDREGEN==0)
		trigger.resetCookie("ADDEDREGEN");
	else
		trigger.setCookie("ADDEDREGEN", Integer.toString(ADDEDREGEN), 0);

	trigger.resetCookie("BODY_ADD_REGEN");
}


//----------------------------------------------------------
// SET ITEM (홍염 SET)
// 2004. 09. 22 Written by Han
//----------------------------------------------------------
// 홍염셋 풀 착용

// 세트아이템 더미
quest
qSetItemEquip()
{

}

// 세트아이템 더미
quest
qSetItemUnEquip()
{

}

quest
qSetItemEquip0001()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 3);
	trigger.setRunSpeed(trigger.getRunSpeed() + 3);
}

quest
qSetItemUnEquip0001()
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 3);
	trigger.setRunSpeed(trigger.getRunSpeed() - 3);
}

quest
qSetItemEquip0002()
{
	trigger.setStab(trigger.getStab() + 5);
	trigger.setHack(trigger.getHack() + 5);
	trigger.setInt(trigger.getInt() + 5);
	trigger.setDefence(trigger.getDefence() + 5);
	trigger.setMagicResist(trigger.getMagicResist() + 5);
	trigger.setDex(trigger.getDex() + 5);
	trigger.setAgi(trigger.getAgi() + 5);
	trigger.updateAttr();
}

quest
qSetItemUnEquip0002()
{
	trigger.setStab(trigger.getOrgStab());
	trigger.setHack(trigger.getOrgHack());
	trigger.setInt(trigger.getOrgInt());
	trigger.setDefence(trigger.getOrgDefence());
	trigger.setMagicResist(trigger.getOrgMagicResist());
	trigger.setDex(trigger.getOrgDex());
	trigger.setAgi(trigger.getOrgAgi());
	trigger.updateAttr();
}

// 홍염셋 갑옷
quest
qEquipItem1000989()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;

	integer ADDHP = 200;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP<0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("SET_BODY_ADD_HP"))
			trigger.resetCookie("SET_BODY_ADD_HP");
	}

	ADD_HP_STRING = trigger.getCookie("SET_BODY_ADD_HP");

	if (!ADD_HP_STRING)
	{
		ADDEDHP = ADDEDHP + ADDHP;
		trigger.setCookie("SET_BODY_ADD_HP", Integer.toString(ADDHP), 0);
	}

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.updateAttr();
}

quest
qUnEquipItem1000989()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("SET_BODY_ADD_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.resetCookie("SET_BODY_ADD_HP");

	trigger.updateAttr();
}

// 홍염셋 날개
quest
qEquipItem1000988()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;

	integer ADDHP = 100;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP<0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("SET_WING_ADD_HP"))
			trigger.resetCookie("SET_WING_ADD_HP");
	}

	ADD_HP_STRING = trigger.getCookie("SET_WING_ADD_HP");

	if (!ADD_HP_STRING)
	{
		ADDEDHP = ADDEDHP + ADDHP;
		trigger.setCookie("SET_WING_ADD_HP", Integer.toString(ADDHP), 0);
	}

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.updateAttr();
}

quest
qUnEquipItem1000988()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("SET_WING_ADD_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.resetCookie("SET_WING_ADD_HP");

	trigger.updateAttr();
}


function boolean
CheckEquipCondition(integer level, integer xienLevel, integer stab, integer hack, integer ac, integer mac, integer int, integer dex, integer physicalAttackLimitBreakLev, integer spellAttackLimitBreakLev, integer physicalDefenseLimitBreakLev, integer spellDefenseLimitBreakLev, integer xienLimitBreakLev)
{
	// 몬스터는 언제든 장착할 수 있다.
	if (trigger.isMonster()) return true;

	xienLevel = 0;

	// 레벨 검사
	if (trigger.getLevel() < level) {
		trigger.message(TEXT_EQUIP_LOW_LEVEL, MSG_TYPE__SYSTEM);
		return false;
	}
	// 시엔 레벨 검사
	// 찌르기 검사
	if (trigger.getStab() < stab) {
		trigger.message(TEXT_EQUIP_STAB_LEVEL, MSG_TYPE__SYSTEM);
		return false;
	}
	// 베기 검사
	if (trigger.getHack() < hack) {
		trigger.message(TEXT_EQUIP_HACK_LEVEL, MSG_TYPE__SYSTEM);
		return false;
	}
	// 물리 방어력
	if (trigger.getDefence() < ac) {
		trigger.message(TEXT_EQUIP_LOW_DEF, MSG_TYPE__SYSTEM);
		return false;
	}
	// 마법 방어력
	if (trigger.getMagicResist() < mac) {
		trigger.message(TEXT_EQUIP_LOW_MAGIC_DEF, MSG_TYPE__SYSTEM);
		return false;
	}
	// 마법 공격력 검사
	if (trigger.getInt() < int) {
		trigger.message(TEXT_EQUIP_LOW_MAGIC_ATT, MSG_TYPE__SYSTEM);
		return false;
	}
	// 민첩성 검사
	if (trigger.getDex() < dex) {
		trigger.message(TEXT_EQUIP_LOW_DEX, MSG_TYPE__SYSTEM);
		return false;
	}
	// 물리공격제한LV 검사
	if (trigger.physicalAttackLimitBreakLev() < physicalAttackLimitBreakLev) {
		trigger.message(TEXT_EQUIP_LOW_ATT_LEVEL, MSG_TYPE__SYSTEM);
		return false;
	}
	// 마법공격제한LV 검사
	if (trigger.spellAttackLimitBreakLev() < spellAttackLimitBreakLev) {
		trigger.message(TEXT_EQUIP_LOW_MAGIC_ATT_LEVEL, MSG_TYPE__SYSTEM);
		return false;
	}
	// 물리방어제한LV 검사
	if (trigger.physicalDefenseLimitBreakLev() < physicalDefenseLimitBreakLev) {
		trigger.message(TEXT_EQUIP_LOW_DEF_LEVEL, MSG_TYPE__SYSTEM);
		return false;
	}
	// 마법방어제한LV 검사
	if (trigger.spellDefenseLimitBreakLev() < spellDefenseLimitBreakLev) {
		trigger.message(TEXT_EQUIP_MAGIC_DEF_LEVEL, MSG_TYPE__SYSTEM);
		return false;
	}
	// 시엔레벨제한LV 검사
	if (trigger.xienLimitBreakLev() < xienLimitBreakLev) {
		trigger.message(TEXT_EQUIP_LOW_XIEN_LEVEL, MSG_TYPE__SYSTEM);
		return false;
	}

	return true;
}


quest				// 라이언 헬멧
qCanEquipItem1000976()
{
	boolean bResult = CheckEquipCondition(5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	Machine.setBooleanReturn(bResult);
}

quest				// 라이언 아머
qCanEquipItem1000977()
{
	boolean bResult = CheckEquipCondition(5, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	Machine.setBooleanReturn(bResult);
}

quest				// 라이언 건틀렛
qCanEquipItem1000978()
{
	boolean bResult = CheckEquipCondition(5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	Machine.setBooleanReturn(bResult);
}



//2004.04.13 퀘스트용 아이템 추가 by kimo
quest
qEquipItem1002817()
{
	//속도가 느려진다.
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 2);
	trigger.setRunSpeed(trigger.getRunSpeed() - 2);
}

quest
qCanUnEquipItem1002817()
{
	integer episode = 1;
	integer currentValue;
	integer globalSwitch = 94;
	currentValue = trigger.getGlobalSwitch(episode, globalSwitch);
	if(currentValue < 7)
	{
		// 아이템을 벗을 수 없다.
		Machine.setBooleanReturn(false);
		trigger.message(TEXT_EQUIP_CURSE_ITEM, MSG_TYPE__SYSTEM);
	}
	else
	{
		Machine.setBooleanReturn(true);
	}
}

quest
qCanUnEquipItemTraining()
{
	if (trigger.getCharacterType() != CHAR_TYPE0) {
		Machine.setBooleanReturn(true);
	} else if (trigger.getGlobalSwitch(1, 250) < 8) {
		Machine.setBooleanReturn(false);
		trigger.message(TEXT_UNEQUIP_CANT_CAUSE_QUEST, MSG_TYPE__SYSTEM);
	} else {
		Machine.setBooleanReturn(true);
	}
}


// 2005.03.17 리틀 플라티나 윙

quest
qEquipItem1004363()
{

}

quest
qUnEquipItem1004363()
{

}

// 2005.06.20 보라풍선
quest
qEquipItem1004468()
{
	trigger.setRunSpeed(trigger.getRunSpeed() + 2);
	// 60*60*24*3 (3일 사용 - 착용시점 부터)
	ExpireItem("1004468", 259200);
}

quest
qUnEquipItem1004468()
{
	trigger.setRunSpeed(trigger.getRunSpeed() - 2);
}


// 2006.01.04 유료 치장아이템 앉았을 때 사용효과
// HP 리젠량 증가 + 10
quest
qEquipItem1004065()
{
	trigger.setRegen(trigger.getRegen() + 10);
}

quest
qUnEquipItem1004065()
{
	trigger.setRegen(trigger.getRegen() - 10);
}

// MP 리젠량 증가 + 5
quest
qEquipItem1004067()
{
	trigger.setMregen(trigger.getMregen() + 5);
}

quest
qUnEquipItem1004067()
{
	trigger.setMregen(trigger.getMregen() - 5);
}

// SP 리젠량 증가 + 5
quest
qEquipItem1004068()
{
	trigger.setStaminaRegen(trigger.getStaminaRegen() + 5);
}

quest
qUnEquipItem1004068()
{
	trigger.setStaminaRegen(trigger.getStaminaRegen() - 5);
}

// 일본 셋팅 - 보리스 륙색
// Boris bag - for japan setting by vahme quest
quest
qEquipItem1005035()
{
	if (trigger.getCookie("EquipWeightUpItem") != "Equip") {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() + 200);
		trigger.updateAttr();

		trigger.setCookie("EquipWeightUpItem","Equip",0);
	}
}

quest
qUnEquipItem1005035()
{
	if (trigger.getCookie("EquipWeightUpItem")) {
		trigger.setMaxInvenWeight(trigger.getMaxInvenWeight() - 200);
		trigger.updateAttr();

		trigger.resetCookie("EquipWeightUpItem");
	}
}

quest
qCanUnEquipItem1005035()
{
	if ((trigger.getAvailInvenWeight() - 200) < 1) {
		trigger.message(TEXT_NO_UNEQUIP_OVER_WEIGHT, MSG_TYPE__SYSTEM);
		Machine.setBooleanReturn(false);
	} else {
		Machine.setBooleanReturn(true);
	}
}
//***************************************************************************************
// 장착아이템 퀘스트는 위에 작성
// 무기 어빌리티는 아래에서 작성
//
// 무기 어빌리티
// 2005. 11. 22 Written by Han
//***************************************************************************************

// 하급 생명력 (HP 100 증가)
quest
qAbilityItem320006()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;

	integer ADDHP = 100;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP < 0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("LOW_HP"))
			trigger.resetCookie("LOW_HP");
	}

	ADD_HP_STRING = trigger.getCookie("LOW_HP");

	if (!ADD_HP_STRING)
	{
		ADDEDHP = ADDEDHP + ADDHP;
		trigger.setCookie("LOW_HP", Integer.toString(ADDHP), 0);
	}

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.updateAttr();
}

quest
qUnAbilityItem320006()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("LOW_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if(trigger.getHP() > trigger.getMaxHP())
		trigger.setHP(trigger.getMaxHP());

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.resetCookie("LOW_HP");

	trigger.updateAttr();
}

// 중급 생명력 (HP 200 증가)
quest
qAbilityItem320007()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;

	integer ADDHP = 200;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP < 0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("MIDDLE_HP"))
			trigger.resetCookie("MIDDLE_HP");
	}

	ADD_HP_STRING = trigger.getCookie("MIDDLE_HP");

	if (!ADD_HP_STRING)
	{
		ADDEDHP = ADDEDHP + ADDHP;
		trigger.setCookie("MIDDLE_HP", Integer.toString(ADDHP), 0);
	}

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.updateAttr();
}

quest
qUnAbilityItem320007()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("MIDDLE_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if(trigger.getHP() > trigger.getMaxHP())
		trigger.setHP(trigger.getMaxHP());

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.resetCookie("MIDDLE_HP");

	trigger.updateAttr();
}

// 상급 생명력 (HP 300 증가)
quest
qAbilityItem320008()
{
	string	ADD_HP_STRING;
	integer	ADDEDHP;

	integer ADDHP = 300;

	ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP"));

	if(ADDEDHP < 0)
	{
		ADDEDHP = 0; // ADDEDHP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("HIGH_HP"))
			trigger.resetCookie("HIGH_HP");
	}

	ADD_HP_STRING = trigger.getCookie("HIGH_HP");

	if (!ADD_HP_STRING)
	{
		ADDEDHP = ADDEDHP + ADDHP;
		trigger.setCookie("HIGH_HP", Integer.toString(ADDHP), 0);
	}

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);
	trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.updateAttr();
}

quest
qUnAbilityItem320008()
{
	integer ADDEDHP = String.toInteger(trigger.getCookie("ADDEDHP")) - String.toInteger(trigger.getCookie("HIGH_HP"));

	trigger.setMaxHP(trigger.getOrgMaxHP() + ADDEDHP);

	if(trigger.getHP() > trigger.getMaxHP())
		trigger.setHP(trigger.getMaxHP());

	if (ADDEDHP==0) trigger.resetCookie("ADDEDHP");
	else trigger.setCookie("ADDEDHP", Integer.toString(ADDEDHP), 0);

	trigger.resetCookie("HIGH_HP");

	trigger.updateAttr();
}

// 하급 마나 (MP 50 증가)
quest
qAbilityItem320009()
{
	string	ADD_MP_STRING;
	integer	ADDEDMP;

	integer ADDMP = 50;

	ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP"));

	if(ADDEDMP < 0)
	{
		ADDEDMP = 0; // ADDEDMP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("LOW_MP"))
			trigger.resetCookie("LOW_MP");
	}

	ADD_MP_STRING = trigger.getCookie("LOW_MP");

	if (!ADD_MP_STRING)
	{
		ADDEDMP = ADDEDMP + ADDMP;
		trigger.setCookie("LOW_MP", Integer.toString(ADDMP), 0);
	}

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);
	trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

	trigger.updateAttr();
}

quest
qUnAbilityItem320009()
{
	integer ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP")) - String.toInteger(trigger.getCookie("LOW_MP"));

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);

	if(trigger.getMP() > trigger.getMaxMP())
		trigger.setMP(trigger.getMaxMP());

	if (ADDEDMP==0) trigger.resetCookie("ADDEDMP");
	else trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

	trigger.resetCookie("LOW_MP");

	trigger.updateAttr();
}

// 중급 마나 (MP 100 증가)
quest
qAbilityItem320010()
{
	string	ADD_MP_STRING;
	integer	ADDEDMP;

	integer ADDMP = 100;

	ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP"));

	if(ADDEDMP < 0)
	{
		ADDEDMP = 0; // ADDEDMP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("MIDDLE_MP"))
			trigger.resetCookie("MIDDLE_MP");
	}

	ADD_MP_STRING = trigger.getCookie("MIDDLE_MP");

	if (!ADD_MP_STRING)
	{
		ADDEDMP = ADDEDMP + ADDMP;
		trigger.setCookie("MIDDLE_MP", Integer.toString(ADDMP), 0);
	}

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);
	trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

	trigger.updateAttr();
}

quest
qUnAbilityItem320010()
{
	integer ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP")) - String.toInteger(trigger.getCookie("MIDDLE_MP"));

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);

	if(trigger.getMP() > trigger.getMaxMP())
		trigger.setMP(trigger.getMaxMP());

	if (ADDEDMP==0) trigger.resetCookie("ADDEDMP");
	else trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

	trigger.resetCookie("MIDDLE_MP");

	trigger.updateAttr();
}

// 상급 마나 (MP 170 증가)
quest
qAbilityItem320011()
{
	string	ADD_MP_STRING;
	integer	ADDEDMP;

	integer ADDMP = 170;

	ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP"));

	if(ADDEDMP < 0)
	{
		ADDEDMP = 0; // ADDEDMP가 0 아래로 내려가는 버그 수정
		if(trigger.getCookie("HIGH_MP"))
			trigger.resetCookie("HIGH_MP");
	}

	ADD_MP_STRING = trigger.getCookie("HIGH_MP");

	if (!ADD_MP_STRING)
	{
		ADDEDMP = ADDEDMP + ADDMP;
		trigger.setCookie("HIGH_MP", Integer.toString(ADDMP), 0);
	}

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);
	trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

	trigger.updateAttr();
}

quest
qUnAbilityItem320011()
{
	integer ADDEDMP = String.toInteger(trigger.getCookie("ADDEDMP")) - String.toInteger(trigger.getCookie("HIGH_MP"));

	trigger.setMaxMP(trigger.getOrgMaxMP() + ADDEDMP);

	if(trigger.getMP() > trigger.getMaxMP())
		trigger.setMP(trigger.getMaxMP());

	if (ADDEDMP==0) trigger.resetCookie("ADDEDMP");
	else trigger.setCookie("ADDEDMP", Integer.toString(ADDEDMP), 0);

	trigger.resetCookie("HIGH_MP");

	trigger.updateAttr();
}

//******************************************************
// 서리지팡이
// 2006.08.29 written by Han
//******************************************************
quest
qEquipItem1006281()
{
	trigger.castNamedWithDuration("3001727", 0);
}

quest
qUnEquipItem1006281()
{
	object castedSpellInven;

	castedSpellInven = trigger.getCastedSpellInventory();

	if (castedSpellInven.hasNamed("3001727"))
		castedSpellInven.finalizeNamed("3001727");
}


//******************************************************
// 토끼털 옷
// 2006.11.09 written by Stunlee
//******************************************************
quest
qEquipItem1006565()
{
	trigger.setRunSpeed(trigger.getRunSpeed() + 1);
}

quest
qUnEquipItem1006565()
{
	trigger.setRunSpeed(trigger.getRunSpeed() - 1);
}

//******************************************************
// 레퍼스의 혼 셋트 아이템
// 2006.11.14 written by Stunlee
//******************************************************
quest qSetItemEquip0003()			// 레퍼스의 혼 셋트 아이템 장착
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() + 1);
	trigger.setRunSpeed(trigger.getRunSpeed() + 1);
}

quest qSetItemUnEquip0003()			// 레퍼스의 혼 셋트 아이템 탈착
{
	trigger.setWalkSpeed(trigger.getWalkSpeed() - 1);
	trigger.setRunSpeed(trigger.getRunSpeed() - 1);
}
