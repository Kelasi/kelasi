
require 'spec_helper'
require 'uni_normalize'

describe User do

  let(:atendance) { FactoryGirl.create :current_attendance }
  let(:user) { atendance.user }
  let(:university) { atendance.university }

  context 'validations' do
    subject { FactoryGirl.build :user }

    it "should be valid with default attributes", :vcr do
      expect(subject).to be_valid
    end

    it "Should have a first name", :vcr do
      subject.first_name = ""
      expect(subject).to be_invalid
    end

    it "Should have a last name", :vcr do
      subject.last_name = ""
      expect(subject).to be_invalid
    end

    it "should have an introducer", :vcr do
      subject.introducer = nil
      expect(subject).to be_invalid
    end
  end

  context 'relations' do

    let(:introduced_user) { FactoryGirl.create :introduced_user, introducer: user }

    subject { user }

    it 'should have atendances', :vcr do
      expect(subject.respond_to? :atendances).to be_true
      expect(subject.atendances).to eq [atendance]
    end

    it 'should have universities', :vcr do
      expect(subject.respond_to? :universities).to be_true
      expect(subject.universities).to eq [university]
    end

    it "should return currently attending universities", :vcr do
      expect(subject.currently_attending).to include university
    end

    it "should have an introducer", :vcr do
      expect(introduced_user.respond_to? :introducer).to be_true
      expect(introduced_user.introducer).to eq user
    end
  end

  context 'tire' do

    subject { User.search user.first_name }

    it 'should not contain root in json', :vcr do
      expect(User.include_root_in_json).to be_false
    end

    it 'should have Tire functionality', :vcr do
      expect(subject.results.map {|m| m.id}).to include user.id.to_s
    end

    it 'should have id in search results', :vcr do
      expect(subject.results.last.respond_to? :id).to be_true
      expect(subject.results.map {|m| m.id}).to include user.id.to_s
    end

    it 'should have first_name in search results', :vcr do
      expect(subject.results.last.respond_to? :first_name).to be_true
      expect(subject.results.map {|m| m.first_name}).to include user.first_name
    end

    it 'should have last_name in search results', :vcr do
      expect(subject.results.last.respond_to? :last_name).to be_true
      expect(subject.results.map {|m| m.last_name}).to include user.last_name
    end

    it 'should have universities in search results', :vcr do
      expect(subject.results.last.respond_to? :universities).to be_true
      expect(subject.results.map {|m| m.universities}.flatten).to include uni_normalize university.name
    end

    it 'shoult be able to search by first name', :vcr do
      subject = User.search "first_name:#{user.first_name}", load: true
      expect(subject.results).to include user
    end

    it 'should be able to search by last name', :vcr do
      subject = User.search "last_name:#{user.last_name}", load: true
      expect(subject.results).to include user
    end

    it 'should be able to search by university name', :vcr do
      subject = User.search %Q(universities:*#{uni_normalize university.name}*), load: true
      expect(subject.results).to include user
    end

    describe :search_user do

      it "should search by first name", :vcr do
        subject = User.search_user first_name: user.first_name
        expect(subject).to include user
      end

      it "should search by last name", :vcr do
        subject = User.search_user last_name: user.last_name
        expect(subject).to include user
      end

      it "should search by university name", :vcr do
        subject = User.search_user university: university.name
        expect(subject).to include user
      end
    end
  end
end
