# frozen_string_literal: true
# == Schema Information
#
# Table name: appointments
#
#  id               :bigint(8)        not null, primary key
#  ends_at          :datetime
#  kind             :string           not null
#  starts_at        :datetime
#  weekly_recurring :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tenant_id        :bigint(8)
#
# Indexes
#
#  index_appointments_on_tenant_id  (tenant_id)
#

class Appointment < ApplicationRecord
  ####### Relationship
  has_one :home, dependent: :destroy
  belongs_to :tenant, optional: true


  ######### Validates
  validates :kind, :starts_at, :ends_at, presence: true
  validates :kind, inclusion: %w(opening appointment)


  ######## Scope
  scope :openings, -> { where(kind: :opening) }
  scope :appointments, -> { where(kind: :appointment) }
  scope :filter_by_date, ->(beginning_date, end_date){ where(starts_at: beginning_date..end_date) }
  scope :weekly_events, -> { where(weekly_recurring: true) }



  ######## Methodes


  TIME_STEP = 1.day

  class << self
    def availabilities(date = Time.zone.today)
      first_day = date.beginning_of_day
      last_day = (date+ 6.days).end_of_day
      bookable(first_day, last_day)
    end

    def bookable(first_day, last_day)
      bookable = stay_bookable(first_day, last_day)
      booking = reservations(appointments.filter_by_date(first_day, last_day).to_a)
      array = []
      (first_day.to_i..last_day.to_i).step(1.day) do |date|
        date = Time.zone.at(date).to_date
        hash = { date: date, slots: bookable[date] || [] }
        hash[:slots] -= booking[date] if booking[date].present?
        array << hash
      end
      array
    end

    def stay_bookable(first_day, last_day)
      booking_open = openings.filter_by_date(first_day, last_day).to_a
      Event.openings.weekly_events.where("starts_at < ?", first_day).find_each do |event|
        number_of = ((first_day.to_f - event.starts_at.to_f) / 1.week).ceil
        weeks = number_of.weeks
        booking_open << Event.new(starts_at: event.starts_at + weeks, ends_at: event.ends_at + weeks, kind: :opening) if number_of >= 1
      end
      reservations(booking_open)
    end

    def reservations(reservation)
      return {} if reservation.empty?

      hash = {}
      reservation.select! do |event|
        date = event.starts_at.to_date
        hash[date] ||= []
        (event.starts_at.to_i..event.ends_at.to_i).step(TIME_STEP) do |datetime|
          hash[date] << Time.zone.at(datetime).strftime('%k:%M').strip
        end
        hash[date].pop
      end
      hash
    end
  end
end
