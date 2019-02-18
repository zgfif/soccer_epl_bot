require 'telegram/bot'
require_relative 'last_result'

TOKEN = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start', '/start start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Привет, #{message.from.first_name} \xF0\x9F\x98\x89"
      )
    when '/stop'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "До встречи, #{message.from.first_name} \xF0\x9F\x98\x81"
      )
    when '/result'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: LastResult.new.perform
      )
    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'Пожалуйста, введите /result'
      )
    end
  end
end
