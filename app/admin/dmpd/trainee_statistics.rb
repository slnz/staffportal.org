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
    panel 'Trainee Cumulative Statistics' do
      @hours_total = 0
      @appointment_asks = 0
      @appointment_set = 0
      @appointment_set_total = 0
      @decisions = 0
      @decisions_total = 0
      @yes_to_monthly_total = 0
      table_for user.object.logs.where('created_at > ?', 12.months.ago).decorate do
        column :range
        column('# Hrs Calling') do |log|
          @hours_total += log.calling_hours
          value = log.calling_hours
          text = "#{number_with_precision(log.calling_hours, precision: 0)} / #{number_with_precision(@hours_total, precision: 0)}"
          status_tag text, :green if value > 2
          status_tag text if value >= 1 && value <= 2
          status_tag text, :red if value < 1 && value > 0
          status_tag text, :orange if value == 0
        end
        column('# Asks for Appt') do |log|
          @appointment_asks += log.appointment_asks
          value = log.appointment_asks
          text = "#{log.appointment_asks} / #{@appointment_asks}"
          status_tag text, :green if value >= 8
          status_tag text if value < 8 && value > 5
          status_tag text, :red if value <= 5 && value > 0
          status_tag text, :orange if value == 0
        end
        column('# Gave Appt') do |log|
          @appointment_set_total += log.appointment_set
          status_tag "#{log.appointment_set} / #{@appointment_set_total}"
        end
        column('% Gave Appt') do |log|
          @appointment_set += log.appointment_set
          if @appointment_asks.nonzero?
            value = (@appointment_set.to_d / @appointment_asks.to_d) * 100
            status_tag number_to_percentage(value, precision: 0), :green if value >= 70
            status_tag number_to_percentage(value, precision: 0) if value < 70 && value > 30
            status_tag number_to_percentage(value, precision: 0), :red if value <= 30 && value > 0
            status_tag number_to_percentage(value, precision: 0), :orange if value == 0
          else
            status_tag '0%', :orange
          end
        end
        column('# Dec.') do |log|
          @decisions_total += log.decisions
          status_tag "#{log.decisions} / #{@decisions_total}"
        end
        column('# Yes to Monthly.') do |log|
          @yes_to_monthly_total = log.yes_to_monthly - @yes_to_monthly_total
          status_tag "#{@yes_to_monthly_total} / #{log.yes_to_monthly}"
          @yes_to_monthly_total = log.yes_to_monthly
        end
        column('% Yes to Monthly') do |log|
          @decisions += log.decisions
          if @decisions.nonzero?
            value = (log.yes_to_monthly.to_d / @decisions.to_d) * 100
            status_tag number_to_percentage(value, precision: 0), :orange if value > 100
            status_tag number_to_percentage(value, precision: 0), :green if value >= 70 && value <= 100
            status_tag number_to_percentage(value, precision: 0) if value < 70 && value > 30
            status_tag number_to_percentage(value, precision: 0), :red if value <= 30 && value > 0
          else
            status_tag '0%', :orange
          end
        end
        column('Total Monthly') do |log|
          status_tag number_to_currency(log.total_monthly_pledged)
        end
        column('Avg Monthly') do |log|
          if (log.total_monthly_pledged / log.yes_to_monthly).nan?
            status_tag '$0.00', :orange
          else
            value = log.total_monthly_pledged / log.yes_to_monthly
            status_tag number_to_currency(value), :green if value >= 70
            status_tag number_to_currency(value) if value < 70 && value > 30
            status_tag number_to_currency(value), :red if value <= 30
          end
        end
        column('Contact Ratio') do |log|
          value = log.contact_ratio.nan? ? 0 : log.contact_ratio
          status_tag number_with_precision(value, precision: 2), :orange if value == 0
          status_tag number_with_precision(value, precision: 2), :green if value >= 1
          status_tag number_with_precision(value, precision: 2), :red if value < 1 && value > 0
        end
      end
    end
    panel 'Trainee Financial Statistics' do
      table_for user.object.logs.where('created_at > ?', 12.months.ago).decorate do
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
      end
    end
    columns do
      column do
        panel 'Monthly Pledged' do
          @metric = user.object.logs.where('created_at > ?', 12.months.ago).pluck(:start, :total_monthly_pledged)
          render partial: 'metrics/column_chart',
                 locals: { metric: @metric, max: user.goal }
        end
      end
      column do
        panel 'Monthly Confirmed' do
          @metric = user.object.logs.where('created_at > ?', 12.months.ago).pluck(:start, :total_monthly_confirmed)
          render partial: 'metrics/column_chart',
                 locals: { metric: @metric, max: user.goal }
        end
      end
    end
    panel 'Ministry Partners' do
      table_for user.object.contacts.where('frequency > 0 AND created_at > ?', 12.months.ago).order('gift_date asc') do
        column('amount') do |contact|
          number_to_currency contact.amount
        end
        column('frequency') do |contact|
          Dmpd::Contact.frequencies.select do |_key, hash|
            hash == contact.frequency
          end.keys[0]
        end
        column :gift_date
      end
    end
  end
end
