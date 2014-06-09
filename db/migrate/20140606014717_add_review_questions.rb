class AddReviewQuestions < ActiveRecord::Migration
  def change
    ReviewQuestion.create(text: 'Do you know what is expected of you at work?')
    ReviewQuestion.create(text: 'Do you have the materials, equipment and finances to do your work well?')
    ReviewQuestion.create(text: 'At work, do you have the opportunity to do what you do best every day?')
    ReviewQuestion.create(text: 'In the last seven days, have you received recognition or praise for doing good work?')
    ReviewQuestion.create(text: 'Is your leadership’s care for you as a person well communicated?')
    ReviewQuestion.create(text: 'Is there someone at work who encourages your development?')
    ReviewQuestion.create(text: 'At work, do your opinions seem to count?')
    ReviewQuestion.create(text: 'Do you feel your job is important to the mission of Tandem Ministries?')
    ReviewQuestion.create(text: 'Are your fellow staff committed to doing quality work?')
    ReviewQuestion.create(text: 'Is your faith thriving within your current work environment?')
    ReviewQuestion.create(text: 'I am friends with the people on my team')
    ReviewQuestion.create(text: 'In the last six months, has someone at work talked to you about your personal, professional and/or spiritual growth?')
    ReviewQuestion.create(text: ' In the last year have you had opportunities to learn and grow personally, professionally and spiritually?')
  end
end
