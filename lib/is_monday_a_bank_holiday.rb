require 'yaml'
require 'sinatra/base'
require_relative 'is_monday_a_bank_holiday/next_monday'

module IsMondayABankHoliday

  class App < Sinatra::Base

    set :views, "#{Dir.pwd}/views"
    set :public_dir, "#{Dir.pwd}/public"

    get '/' do
      @next_monday = NextMonday.new

      erb :index
    end

    get '/wales' do
      @next_monday = NextMonday.new(:england)

      erb :index
    end

    get '/:country' do |country|
      @next_monday = NextMonday.new(country.to_sym)

      erb :index
    end
  end
end
