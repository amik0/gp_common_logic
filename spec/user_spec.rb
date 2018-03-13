require 'spec_helper'

class TestModel < ActiveRecord::Base
  include GpCommonLogic::User
end

RSpec.describe GpCommonLogic::User, ar: true do
  before(:each) do
    ActiveRecord::Schema.define do
      create_table(:test_models, force: true) do |t|
        t.date    :birthday
        t.date    :approx_birthday
        t.integer :clothing_size
        t.timestamps
      end
    end
  end

  let(:person) { TestModel.create(birthday: nil) }

  describe 'вычисляет возраст из даты рождения' do
    it 'когда дата рождения в прошлом, возвращает число полных лет с даты рождения' do
      person.birthday = Time.zone.today
      expect(person.age).to eq 0

      person.birthday = 20.years.ago
      expect(person.age).to eq(20)

      person.birthday = 20.years.ago + 1.day
      expect(person.age).to eq(19)
    end

    it 'когда дата рождения в будущем, возраст отрицателен' do
      person.birthday = Time.zone.tomorrow
      expect(person.age).to eq -1

      person.birthday = 10.years.from_now
      expect(person.age).to eq -10
    end

    it 'когда дата рождения неопределена, возраст неопределен' do
      person.birthday = nil
      expect(person.age).to be_nil
    end
  end

  describe 'позволяет указать возраст' do
    it 'обновляет дату рождения' do
      person.age = 50
      expect(person.birthday).to eq(50.years.ago.to_date)

      person.age = '50'
      expect(person.birthday).to eq(50.years.ago.to_date)
    end

    it 'не обновляет дату рождения, если переданное значение не является возрастом' do
      expect { person.age = 10 }.not_to change { person.birthday }
      expect { person.age = '-50' }.not_to change { person.birthday }
      expect { person.age = nil }.not_to change { person.birthday }
    end
  end

  describe '#Age' do
    it 'конвертирует в возраст' do
      expect(described_class.Age(50)).to eq 50
      expect(described_class.Age('50')).to eq 50
      expect(described_class.Age(50.13)).to eq 50
      expect(described_class.Age('50-13')).to eq 50
      expect(described_class.Age('50let')).to eq 50

      expect { described_class.Age(0) }.to raise_error(TypeError)
      expect { described_class.Age(10) }.to raise_error(TypeError)
      expect { described_class.Age('-0') }.to raise_error(TypeError)
      expect { described_class.Age('-50') }.to raise_error(TypeError)
      expect { described_class.Age('fifty') }.to raise_error(TypeError)
      expect { described_class.Age(nil) }.to raise_error(TypeError)
    end
  end
end
