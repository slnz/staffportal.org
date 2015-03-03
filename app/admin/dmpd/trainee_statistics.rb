ActiveAdmin.register User::AsTrainee, as: 'Trainee Statistics' do
  actions :all, except: [:new, :edit, :create, :update, :destroy]
  decorate_with User::AsTraineeDecorator
  menu parent: 'DMPD'

  controller do
    def scoped_collection
      User::AsTrainee.trainees.includes(:logs)
    end
  end

  filter :username
  filter :first_name
  filter :last_name

  index do
    column('Name') do |user|
      user.name
    end
    column('Goal') do |user|
      number_to_currency user.goal
    end
    column('Monthly Pledged') do |user|
      number_to_currency user.logs.last.try(:total_monthly_pledged) || 0
    end
    column('% Pledged') do |user|
      number_to_percentage(
        ((user.logs.last.try(:total_monthly_pledged) || 0) / user.goal) * 100,
        precision: 0)
    end
    column('Monthly Confirmed') do |user|
      number_to_currency user.logs.last.try(:total_monthly_confirmed) || 0
    end
    column('% Confirmed') do |user|
      number_to_percentage(
        ((user.logs.last.try(:total_monthly_confirmed) || 0) / user.goal) * 100,
        precision: 0)
    end
    column('Special Pledged') do |user|
      number_to_currency user.logs.last.try(:total_special_pledged) || 0
    end
    column('Special Confirmed') do |user|
      number_to_currency user.logs.last.try(:total_special_confirmed) || 0
    end
    column('Contact Ratio') do |user|
      number_with_precision(
        user.logs.last.try(:contact_ratio) || 0, precision: 2)
    end
    actions
  end

  show do |user|
    panel 'Trainee Statistics' do
      table_for user.logs do
        column :range
        column('Goal') do |_log|
          number_to_currency user.goal
        end
        column('Monthly Pledged') do |log|
          number_to_currency log.total_monthly_pledged
        end
        column('% Pledged') do |log|
          number_to_percentage(
            (log.total_monthly_pledged / user.goal) * 100, precision: 0)
        end
        column('Monthly Confirmed') do |log|
          number_to_currency log.total_monthly_confirmed
        end
        column('% Confirmed') do |log|
          number_to_percentage(
            (log.total_monthly_confirmed / user.goal) * 100, precision: 0)
        end
        column('Special Pledged') do |log|
          number_to_currency log.total_special_pledged
        end
        column('Special Confirmed') do |log|
          number_to_currency log.total_special_confirmed
        end
        column('Contact Ratio') do |log|
          number_with_precision(
            log.contact_ratio, precision: 2)
        end
      end
    end
    columns do
      column do
        panel 'Monthly Pledged' do
          @metric = user.object.logs.pluck(:start, :total_monthly_pledged)
          render partial: 'metrics/column_chart',
                 locals: { metric: @metric, max: user.goal }
        end
      end
      column do
        panel 'Monthly Confirmed' do
          @metric = user.object.logs.pluck(:start, :total_monthly_confirmed)
          render partial: 'metrics/column_chart',
                 locals: { metric: @metric, max: user.goal }
        end
      end
    end
    panel 'Ministry Partners' do
      table_for user.object.contacts.where('frequency > 0').order('gift_date asc') do
        column :first_name
        column :last_name
        column('amount') do |contact|
          number_to_currency contact.amount
        end
        column('frequency') do |contact|
          Dmpd::Contact.frequencies.select do |key, hash|
            hash == contact.frequency
          end.keys[0]
        end
        column :gift_date
      end
    end
  end
end
