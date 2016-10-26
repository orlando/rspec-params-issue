require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'post #create' do
    subject do
      post :create, as: :json, params: {
        questions: [
          {
            prompt: '1',
            details: {}
          },
          {
            prompt: '2',
            details: {}
          },
          {
            prompt: 'Should have no choices, but for some reason they get pushed into question 2!',
            details: {
              answer: 1,
              choices: [
                'Choice 1',
                'Correct Choice',
                'Another Choice'
              ]
            }
          }
        ]
      }
    end
    it 'should be success' do
      expect(subject).to be_success
    end
    it 'should set details to empty on first question' do
      json = JSON.parse(subject.body)
      p json
      expect(json['questions'][0]['details']).to eq({})
    end
    it 'should set details to empty on second question' do
      json = JSON.parse(subject.body)
      expect(json['questions'][1]['details']).to eq({})
    end
    it 'should set prompt on third question' do
      json = JSON.parse(subject.body)
      expect(json['questions'][2]['prompt']).to eq('Should have no choices, but for some reason they get pushed into question 2!')
    end
    it 'should set answer on third question' do
      json = JSON.parse(subject.body)
      expect(json['questions'][2]['details']['answer']).to eq(1)
    end
    it 'should set choices on third question' do
      json = JSON.parse(subject.body)
      expect(json['questions'][2]['details']['choices']).to eq(
        [
          'Choice 1',
          'Correct Choice',
          'Another Choice'
        ]
      )
    end
  end
end
