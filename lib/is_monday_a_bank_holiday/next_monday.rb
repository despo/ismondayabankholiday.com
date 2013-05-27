module IsMondayABankHoliday
  class NextMonday

    attr_accessor :country
    def initialize country=:england
      @country = country
    end

    def date
      format_date next_holiday[:datetime_field]
    end

    def description
      next_holiday[:description]
    end

    def is_bank_holiday?
      next_holiday[:datetime_field] == next_monday
    end

    private

    def next_holiday
      @next_holiday ||= country_data.select { |entry| entry[:datetime_field] > Date.today }.first
    end

    def data
      @data ||= YAML::load_file("#{Dir.pwd}/config/public_holidays.yml")
    end

    def country_data
      data[:bank_holiday_mondays][@country]
    end

    def next_monday
      date  = Date.parse "Monday"
      delta = date > Date.today ? 0 : 7
      next_monday = date + delta
    end

    def format_date date
      "#{date.strftime("%A")} the #{ordinalize(date.day)} of  #{date.strftime("%B %Y")}"
    end

    def ordinalize day
      return "#{day}th" if (11..13).include?(day % 100)
      case day % 10
      when 1; "#{day}st"
      when 2; "#{day}nd"
      when 3; "#{day}rd"
      else    "#{day}th"
      end
    end
  end
end
