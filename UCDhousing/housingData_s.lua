-------------------------------------------------------------------
--// PROJECT: Union of Clarity and Diversity
--// RESOURCE: UCDhousing
--// DEVELOPER(S): Lewis Watson (Noki)
--// DATE: 09/12/2015
--// PURPOSE: To centralize, cache and manage housing data.
--// FILE: \housingData_s.lua [server]
-------------------------------------------------------------------

db = exports.UCDsql:getConnection()
-- Change this variable sometime to not cause confustion with the houseData table
housingData = {}
housePickup = {}
--houseBlip = {}

function createHouse(houseID, houseTable, syncToClient)
	if (not houseID) or (not houseTable) then
		return
	end
	if (housePickup[houseID]) then
		housePickup[houseID]:destroy()
		housePickup[houseID] = nil
		
		--houseBlip[houseID]:destroy()
		--houseBlip[houseID] = nil
	end
	
	local hX, hY, hZ = houseTable.x, houseTable.y, houseTable.z
	if (houseTable.sale == 1) then modelID = 1273 else modelID = 1272 end
	
	housePickup[houseID] = createPickup(hX, hY, hZ, 3, modelID, 0)
	housePickup[houseID]:setData("houseID", houseID)
	--houseBlip[houseID] = createBlipAttachedTo(housePickup[houseID], 0) -- Debug purposes
	
	-- Do a per house update system
	housingData[houseID] = {}
	for column, value in pairs(houseTable) do
		if (column ~= "houseID") then
			housingData[houseID][column] = value
		end
	end
	
	-- Syncing a massive table? Fuck no
	
	--[[
	-- Change this as we don't need to send the whole table every time a house is created [changed to sync individual house]
	-- Possibly reconsider this altogether as this is almost like a DoS attack [the added if statement and syncToClient param should handle this]
	-- DONE
	if (syncToClient == true) then
		triggerLatentClientEvent(exports.UCDaccounts:getAllLoggedInPlayers(), "UCDhousing.syncHouse", resourceRoot, houseID, housingData[houseID])
	end
	
	-- OLD
	--for _, plr in pairs(Element.getAllByType("player")) do
	--	triggerLatentClientEvent(plr, "UCDhousing.syncHousingTable", resourceRoot, housingData)
	--end
	--]]
end

addEventHandler("onResourceStart", resourceRoot,
	function ()
		db:query(createHouses, {}, "SELECT * FROM `housing`")
	end
)

function createHouses(queryHandle)
	local result = queryHandle:poll(0)
	for _, v in ipairs(result) do		
		-- Cache them in the a table for easy access
		housingData[v.houseID] = {}
		for column, value in pairs(v) do
			if (column ~= "houseID") then
				housingData[v.houseID][column] = value
			end
		end
		
		-- Cache first, create later
		createHouse(v.houseID, v)
	end
	outputDebugString("["..tostring(getThisResource().name).."] Houses successfully cached!")
end

--[[
function syncHousingTable(plr)
	if not plr then plr = client end -- For triggering events
	triggerLatentClientEvent(plr, "UCDhousing.syncHousingTable", resourceRoot, housingData)
	outputDebugString("Sending housing data client side for "..plr:getName())
end
addEvent("UCDhousing.requestHousingTableSync", true)
addEventHandler("UCDhousing.requestHousingTableSync", root, function () syncHousingTable(client) end)
addEventHandler("onPlayerLogin", root, function () syncHousingTable(source) end)
--]]

function setHouseData(houseID, column, value)
	if (not houseID) or (not column) or (not value) or (not db) then
		return nil
	end
	if (type(houseID) ~= "number") or (type(column) ~= "string") or (type(value) == "table") then
		return false
	end
	
	if (not housingData[houseID]) then
		return nil
	end
	
	housingData[houseID][column] = value
		
	if (housingData[houseID]) then
		if (value ~= nil) then
			db:exec("UPDATE `housing` SET `??`=? WHERE `houseID`=?", column, value, houseID)
		end
	end
	
	-- This should eliminate the sync issue, but it will be laggy at the most
	-- 02/10/15 - It now syncs the individual house
	-- 09/12/15 - We don't even need this shit :D
	--[[
	for _, plr in pairs(Element.getAllByType("player")) do
		triggerLatentClientEvent(plr, "UCDhousing.syncHouse", resourceRoot, houseID, housingData[houseID])
	end
	--]]
	
	return true
end

function getHouseData(houseID, column)
	if (not houseID) or (not column) then
		return nil
	end
	if (type(column) ~= "string") or (type(houseID) ~= "number") then
		return false
	end
	
	if (column == "*") then
		return housingData[houseID]
	else
		if (housingData[houseID] == nil) or (housingData[houseID][column] == nil) then
			return nil
		end
	end
	
	return housingData[houseID][column]
end

-- Delete house
function deleteHouse(plr, _, id)
	if (exports.UCDadmin:isPlayerAdmin(plr) and exports.UCDadmin:getPlayerAdminRank(plr) >= 2) then
		if (id and tonumber(id) and housingData[tonumber(id)]) then
			id = tonumber(id)
			housePickup[id]:destroy()
			--houseBlip[id]:destroy()
			housePickup[id] = nil
			--houseBlip[id] = nil
			housingData[id] = nil
			db:exec("DELETE FROM `housing` WHERE `houseID` = ?", id)
		end
	end
end
addCommandHandler("delhouse", deleteHouse)
