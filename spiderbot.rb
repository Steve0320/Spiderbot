require 'discordrb'
# require './active_record'

bot_id = ENV['discord_id']
bot_token = ENV['discord_token']

# Exit with error if required ENV vars are not present
unless bot_id && bot_token
	puts 'Error: Environment variables discord_id and discord_token must exist'
	exit(1)
end

responses = {}

# Initialize bot
bot = Discordrb::Bot.new(client_id: bot_id, token: bot_token)

# Allow user to teach responses
bot.message(with_text: '!teach') do |event|

	event.respond("I await your instructions eagerly, #{event.user.name}. What phrase should this trigger on?")

	trigger_phrase = nil

	# Enter the teaching loop. This loop is entered every time the user
	# responds to the bot.
	event.user.await(:teach) do |teaching_event|

		stop = false

		if !trigger_phrase
			trigger_phrase = teaching_event.message.content
			teaching_event.respond("Trigger phrase is #{trigger_phrase}. What should the response be?")
			stop = false
		else
			response_phrase = teaching_event.message.content
			teaching_event.respond("Response is #{response_phrase}. Call !#{trigger_phrase} to trigger.")
			responses[trigger_phrase] = response_phrase
			stop = true
		end

		stop

	end

end

bot.message do |event|

	message = event.message.content

	if message.start_with?('!') && message != '!teach'
		message = message[1..-1]
		response = responses[message]
		event.respond(response) if response
	end

end

# Be real creepy :P
bot.ready do
	bot.watching = 'you'
end

bot.run