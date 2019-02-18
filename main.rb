require 'telegram/bot'
require_relative 'last_result'

TOKEN = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start', '/start start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Hello, #{message.from.first_name}"
      )
    when '/stop'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Bye, #{message.from.first_name}"
      )
    when '/result'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "first result of EPL #{LastResult.new.perform}"
      )
    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'Please type /result'
      )
    end
  end
end
