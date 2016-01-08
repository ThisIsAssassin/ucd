addCommandHandler("tog",
	function ()
		outputDebugString(tostring(not isControlEnabled("fire")))
		toggleControl("fire", not isControlEnabled("fire")) 
	end
)

local aimKeys = getBoundKeys("aim_weapon")
local fireKeys = getBoundKeys("fire")
local exceptedWeapons = {[41] = true}
local exceptedSlots = {[0] = true, [1] = true, [8] = true, [10] = true, [11] = true, [12] = true}
local disallowedTeams = {["Citizens"] = true, ["Not logged in"] = true}

function fireCheck(button, state)
	if (localPlayer.vehicle) then return end
	if (fireKeys[button] and state == true) then
		if (exports.UCDsafeZones:isElementWithinSafeZone(localPlayer) or (not exports.UCDturfing:isElementInLV(localPlayer) and disallowedTeams[localPlayer.team.name])) then
			toggleControl("fire", false)
			return
		end
		if (exceptedSlots[localPlayer.weaponSlot] or exceptedWeapons[localPlayer:getWeapon()]) then
			return
		end
		--outputDebugString("fire")
		if (not getControlState("aim_weapon")) then
			toggleControl("fire", false)
			--outputDebugString("not aiming")
		end
	end
	if (fireKeys[button] and state == false) then
		if (not exports.UCDsafeZones:isElementWithinSafeZone(localPlayer) and not localPlayer.frozen) then
			toggleControl("fire", true)
		end
	end
end
addEventHandler("onClientKey", root, fireCheck)

function aimCheck(button, state)
	if (localPlayer.vehicle) then return end
	if (aimKeys[button] and state == true) then
		--if ((disallowedTeams[localPlayer.team.name] and not exports.UCDturfing:isElementInLV(localPlayer)) and localPlayer.weaponSlot ~= 11 and not exceptedWeapons[localPlayer:getWeapon()] and not exports.UCDsafeZones:isElementWithinSafeZone(localPlayer)) then
		if ((disallowedTeams[localPlayer.team.name] and not exports.UCDturfing:isElementInLV(localPlayer)) or exports.UCDsafeZones:isElementWithinSafeZone(localPlayer)) then
			outputDebugString("true")
			toggleControl("aim_weapon", false)
			toggleControl("fire", false)
		else
			outputDebugString("false")
			toggleControl("aim_weapon", true)
			toggleControl("fire", true)
		end
	end
end
addEventHandler("onClientKey", root, aimCheck)
