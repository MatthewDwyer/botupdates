-- if the bot can restart itself schedule a bot restart.  It will fix any issues with missing data required by the updated bot.
if server.allowBotRestarts then
	irc_chat(server.ircMain, "The bot will restart itself in 3 minutes to complete the bot update.")
	tempTimer( 180, [[ restartBot() ]] )
end

-- fix an oops
if not botMaintenance.fixedExile then
	for k,v in pairs(players) do
		v.exiled = false
	end

	conn:execute("UPDATE players SET exiled = 0")

	botMaintenance.fixedExile = "true"
	saveBotMaintenance()
end

if tonumber(server.gameVersionNumber) >= 17 then
	if not botMaintenance.fixedItemNames then
		botMaintenance.fixedItemNames = "true"
		saveBotMaintenance()
		fixShop()
	end
end

sendCommand("version")