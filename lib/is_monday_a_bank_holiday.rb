require 'yaml'
require 'sinatra/base'
require_relative 'is_monday_a_bank_holiday/next_monday'

module IsMondayABankHoliday

  class App < Sinatra::Base

    set :views, "#{Dir.pwd}/views"
    set :public, "#{Dir.pwd}/public"

    get '/' do
      @next_monday = NextMonday.new

      erb :index
    end
  end
end
