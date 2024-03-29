# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :event do
    title { Faker::Hipster.sentence }
    abstract { Faker::Hipster.paragraph(sentence_count: 2) }

    program

    after(:build) do |event|
      event.submitter = build(:submitter).user unless event.submitter # so that we don't have two submitters
      event.speakers << build(:speaker).user unless event.speakers.any?
      # set an event_type if none is passed to the factory.
      # needs to be created here because otherwise it doesn't belong to the
      # same conference as the event
      event.event_type ||= build(:event_type, program: event.program)
    end

    factory :event_full do
      difficulty_level
      after(:build) do |event|
        event.commercials << build(:event_commercial, commercialable: event)
        event.difficulty_level = build(:difficulty_level, program: event.program)
        event.track = build(:track, program: event.program)
        unless event.program.conference.venue
          create(:venue, conference: event.program.conference)
        end
        event.comment_threads << build(:comment, commentable: event)
      end

      factory :event_scheduled do
        transient do
          hour { nil }
        end

        after(:build) do |event, evaluator|
          event.state = 'confirmed'
          event.event_schedules << build(:event_schedule, event: event, start_time: evaluator.hour)
        end
      end
    end
  end

  factory :event_xss, parent: :event do
    abstract { '<div id="divInjectedElement"></div>' }
  end
end
