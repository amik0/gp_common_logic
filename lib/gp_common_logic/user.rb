require 'active_support/concern'

module GpCommonLogic

  module User
    extend ActiveSupport::Concern

    def user_segment_id
      clothing_size_part =
        if clothing_size.nil?
          0
        elsif clothing_size <= 50
          50
        else
          52
        end

      user_age = age

      age_part =
        if user_age.nil?
          0
        elsif user_age <= 44
          44
        else
          45
        end

      age_part * 100 + clothing_size_part
    end

    # @return [Integer, NilClass] число полных лет с даты рождения
    def age(birthday = self.birthday || self.approx_birthday)
      return if birthday.nil?

      today = Time.zone.today

      if today.month > birthday.month || (today.month == birthday.month && today.day >= birthday.day)
        today.year - birthday.year
      else
        today.year - birthday.year - 1
      end
    end

    def age=(value)
      self.birthday = Age(value).years.ago.to_date
    rescue TypeError
      # noop
    end

    module_function

    # Преобразует в возраст
    # @raise [TypeError] +value+ не может быть возрастом
    # @return [Integer] неотрицательное целое
    def Age(value)
      age = value.to_i
      if age > 10
        age
      else
        raise TypeError, "invalid age value #{value.inspect} was given. Age must be integer greater than 10."
      end
    end

  end

end
