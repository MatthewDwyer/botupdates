-- if the bot can restart itself schedule a bot restart.  It will fix any issues with missing data required by the updated bot.
if server.allowBotRestarts then
	irc_chat(server.ircMain, "The bot will restart itself in 3 minutes to complete the bot update.")
	tempTimer( 180, [[ restartBot() ]] )
end

conn:execute("UPDATE server set updateBranch = 'a20'")

if not botMaintenance.fixMapPermissions then
	botMaintenance.fixMapPermissions = "true"
	saveBotMaintenance()
	sendCommand("webpermission add webapi.getplayersOnline 1000")
	sendCommand("webpermission add webapi.getstats 1000")
	sendCommand("webpermission add webapi.getlandclaims 1000")
end

if tonumber(server.gameVersionNumber) >= 17 then
	if not botMaintenance.fixedItemNames then
		botMaintenance.fixedItemNames = "true"
		saveBotMaintenance()
		fixShop()
	end
end

sendCommand("version")

if not botMaintenance.adminItemsOnBlacklist then
	botMaintenance.adminItemsOnBlacklist = "true"
	saveBotMaintenance()
	conn:execute("UPDATE badItems SET action = 'ban' WHERE item = '*Admin'")
	loadBadItems()
end