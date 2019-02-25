require 'telegram/bot'
require_relative 'last_result'

TOKEN = ENV['TELEGRAM_TOKEN']

Telegram::Bot::Client.run(TOKEN, logger: Logger.new($stderr)) do |bot|
  bot.logger.info('Bot has been started')

  bot.listen do |message|
    case message.text
    when '/start'
      kb = Telegram::Bot::Types::ReplyKeyboardMarkup.new keyboard: ['/england'], one_time_keyboard: true

      bot.api.send_message(chat_id: message.chat.id, text: 'Привет, какой результат интересует?', reply_markup: kb)
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: 'Bye-bye')
    when '/england'
      bot.api.send_message(chat_id: message.chat.id, text: LastResult.new.perform)
    end
  end
end
