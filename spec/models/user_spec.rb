
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
end
