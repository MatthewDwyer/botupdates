-- if the bot can restart itself schedule a bot restart in 10 minutes.  It will fix any issues with missing data required by the updated bot.
if server.allowBotRestarts then
	irc_chat(server.ircMain, "The bot will restart itself in 3 minutes to complete the bot update.")
	tempTimer( 180, [[ restartBot() ]] )
end

--server.updateBranch = "v1"
--conn:execute("UPDATE server set updateBranch = 'v1'")

if not botMaintenance.fixMapPermissions then
	botMaintenance.fixMapPermissions = "true"
	saveBotMaintenance()
end

sendCommand("version")

if server.useAllocsWebAPI and not server.readLogUsingTelnet then
	tempTimer( 5, [[sendcommand("lp")]] )
end

if not botMaintenance.adminItemsOnBlacklist then
	botMaintenance.adminItemsOnBlacklist = "true"
	saveBotMaintenance()
	conn:execute("UPDATE badItems SET action = 'ban' WHERE item = '*Admin'")
	loadBadItems()
end