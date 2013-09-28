
require 'spec_helper'

describe User do

  before do
    @user = User.new email: "foo@bar.com", password: "foobarbaz", first_name: "foo", last_name: "bar"
  end

  subject { @user }

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

    before do
      @user = User.create! do |u|
        u.first_name = "foo"
        u.last_name = "bar"
        u.email = "foo@bar.com"
        u.password = "12345678"
      end
      @uni = University.create! name: 'baz'
      @atendance = Atendance.create! user: @user, university: @uni
    end
    subject {@user}

    it 'should have atendances' do
      expect(subject.respond_to? :atendances).to be_true
      expect(subject.atendances).to eq [@atendance]
    end

    it 'should have universities' do
      expect(subject.respond_to? :universities).to be_true
      expect(subject.universities).to eq [@uni]
    end
  end

  context 'tire' do

    before do
      @user = User.create! do |u|
        u.first_name = "foo"
        u.last_name = "bar"
        u.email = "foo@bar.com"
        u.password = "12345678"
      end
      @uni = University.create! name: 'baz'
      @atendance = Atendance.create! user: @user, university: @uni
      @search = User.search 'foo'
    end
    subject {@search}

    it 'should not contain root in json' do
      expect(User.include_root_in_json).to be_false
    end

    it 'should have Tire functionality' do
      expect(subject.results.map {|m| m.id}).to include @user.id.to_s
    end

    it 'should have id in search results' do
      expect(subject.results.last.respond_to? :id).to be_true
      expect(subject.results.map {|m| m.id}).to include @user.id.to_s
    end

    it 'should have first_name in search results' do
      expect(subject.results.last.respond_to? :first_name).to be_true
      expect(subject.results.map {|m| m.first_name}).to include @user.first_name
    end

    it 'should have last_name in search results' do
      expect(subject.results.last.respond_to? :last_name).to be_true
      expect(subject.results.map {|m| m.last_name}).to include @user.last_name
    end

    it 'should have universities in search results' do
      sleep 1
      subject = User.search @user.first_name
      expect(subject.results.last.respond_to? :universities).to be_true
      expect(subject.results.map {|m| m.universities}).to include @uni.name
    end

    it 'shoult be able to search by first name' do
      subject = User.search "first_name:#{@user.first_name}", load: true
      expect(subject.results).to include @user
    end

    it 'should be able to search by last name' do
      subject = User.search "last_name:#{@user.last_name}", load: true
      expect(subject.results).to include @user
    end

    it 'should be able to search by university name' do
      @user.universities.create! name: "Another uni"
      sleep 1
      subject = User.search "universities:#{@uni.name}", load: true
      expect(subject.results).to include @user
      subject = User.search "universities:\"Another uni\"", load: true
      expect(subject.results).to include @user
    end
  end
end
