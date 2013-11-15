
require 'spec_helper'
require 'uni_normalize'

describe User do

  let(:user) { FactoryGirl.build :user }

  subject { user }

  it "Should have a first name" do
    subject.first_name = ""
    subject.save
    expect(subject).to be_invalid
  end

  it "Should have a last name" do
    subject.last_name = ""
    subject.save
    expect(subject).to be_invalid
  end

  context 'relations' do

    let(:atendance) { FactoryGirl.create :current_attendance }
    let(:user) { atendance.user }
    let(:university) { atendance.university }

    subject { user }

    it 'should have atendances' do
      expect(subject.respond_to? :atendances).to be_true
      expect(subject.atendances).to eq [atendance]
    end

    it 'should have universities' do
      expect(subject.respond_to? :universities).to be_true
      expect(subject.universities).to eq [university]
    end

    it "should return currently attending universities" do
      expect(subject.currently_attending).to include university
    end
  end

  context 'tire' do

    let(:atendance) { FactoryGirl.create :current_attendance }
    let(:user) { atendance.user }
    let(:university) { atendance.university }

    subject { User.search user.first_name }

    before { User.tire.index.refresh }
    before do
      Tire::Configuration.client.get "#{Tire::Configuration.url}/_cluster/health?wait_for_status=yellow"
    end

    it 'should not contain root in json' do
      expect(User.include_root_in_json).to be_false
    end

    it 'should have Tire functionality' do
      expect(subject.results.map {|m| m.id}).to include user.id.to_s
    end

    it 'should have id in search results' do
      expect(subject.results.last.respond_to? :id).to be_true
      expect(subject.results.map {|m| m.id}).to include user.id.to_s
    end

    it 'should have first_name in search results' do
      expect(subject.results.last.respond_to? :first_name).to be_true
      expect(subject.results.map {|m| m.first_name}).to include user.first_name
    end

    it 'should have last_name in search results' do
      expect(subject.results.last.respond_to? :last_name).to be_true
      expect(subject.results.map {|m| m.last_name}).to include user.last_name
    end

    it 'should have universities in search results' do
      expect(subject.results.last.respond_to? :universities).to be_true
      expect(subject.results.map {|m| m.universities}.flatten).to include uni_normalize university.name
    end

    it 'shoult be able to search by first name' do
      subject = User.search "first_name:#{user.first_name}", load: true
      expect(subject.results).to include user
    end

    it 'should be able to search by last name' do
      subject = User.search "last_name:#{user.last_name}", load: true
      expect(subject.results).to include user
    end

    it 'should be able to search by university name' do
      subject = User.search %Q(universities:*#{uni_normalize university.name}*), load: true
      expect(subject.results).to include user
    end

    describe :search_user do

      it "should search by first name" do
        subject = User.search_user first_name: user.first_name
        expect(subject).to include user
      end

      it "should search by last name" do
        subject = User.search_user last_name: user.last_name
        expect(subject).to include user
      end

      it "should search by university name" do
        subject = User.search_user university: university.name
        expect(subject).to include user
      end
    end
  end
end
