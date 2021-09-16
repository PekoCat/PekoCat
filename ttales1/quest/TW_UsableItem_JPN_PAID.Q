// $Id: TW_UsableItem_JPN_PAID.Q,v 0.01 2005/10/24 11:19:00 vahma Exp $

#Import quest/system.h
#Import quest/tales_system.h
#Import quest/TW_UsableItem.h
#Import quest/tw_util.h
#Import	quest/TW_UsableItem_JPN_PAID.h

quest
qUseItem1004022()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;
    
    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }

    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (trigger.getRandomItem(0)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qUseItem1004023()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;

    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (trigger.getRandomItem(1)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qUseItem1004024()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;

    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }

    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (trigger.getRandomItem(2)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qUseItem1004025()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;

    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }

    if (trigger.getRandomItem(3)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qUseItem1004026()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;

    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }

    if (trigger.getRandomItem(4)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qUseItem1004027()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;

    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }

    if (trigger.getRandomItem(5)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qUseItem1004028()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;

    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }

    if (trigger.getRandomItem(6)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qUseItem1004029()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;

    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }

    if (trigger.getRandomItem(7)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qUseItem1004030()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;

    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }

    if (trigger.getRandomItem(8)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qUseItem1004031()		// vahma - japan gashapon
{
    integer UserWeight;
    integer UserSlot;

    UserWeight = trigger.getCarryingItemInventory().availWeight();
    UserSlot = trigger.getEmptyInvenSlotCount();

    if (UserWeight < 50) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
    
    if (UserSlot < 1) {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }

    if (trigger.getRandomItem(9)){
	if (controller.canBeExhausted())
	    controller.decreaseNumber(1);
	Cash_Log();
	return;
    }
    else {
	trigger.sayTo(TEXT_PAID_AVAILEVENT, trigger);
	return;
    }
}

quest
qDropCashItemZ()
{
	integer iSeed, nSeed;
	string iName;
	iName = controller.getClassName();

	trigger.message(TEXT_CASH_ITEM_DROP, MSG_TYPE__SYSTEM);
	Util.log("! Cash Item Drop! # Item[ " + iName + " / " + controller.getDescClassNamed(iName) + "], User[" + trigger.getName() + "], when[" + Util.getTimeString("%A %b %d %T") + "] at [" + trigger.getWorld().getNumber() + "]");
	controller.sweep();
}

quest
qUseItem1004094()
{
    string mimiJPN;

    mimiJPN = trigger.getCookie("mi");

    if (mimiJPN == "1") {
	trigger.message(TEXT_MIMI_OFF, MSG_TYPE__AUTOHIDE_WINDOW);
	trigger.setCookie("mi", "0", 0);
	return;
    } else if (mimiJPN == "0") {
	trigger.message(TEXT_MIMI_ON, MSG_TYPE__AUTOHIDE_WINDOW);
	trigger.setCookie("mi", "1", 0);
	return;
    }
    return;
}
