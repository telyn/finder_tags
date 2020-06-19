# frozen_string_literal: true

RSpec.describe FinderTags do
  it "has a version number" do
    expect(FinderTags::VERSION).not_to be nil
  end

  # the default purple, blue and grey tags on my laptop have names focussed
  # around music production, which is a bonus cause it means I didn't have to
  # make any extra effort to test the modern tag names :)
  PURPLE_NAME = "Cool Track"
  BLUE_NAME = "Cool Noise"
  GREY_NAME = "Released"
  describe "#tags" do
    subject { described_class.new("spec/test-data/#{file}").tags }
    before do
      skip "Can't use xattr on travis" if ENV["TRAVIS"]
    end

    context "on the 'no-tag' test-data file" do
      let(:file) { "no-tag" }

      it { is_expected.to eq [] }
    end

    context "on the 'red' test-data file" do
      let(:file) { "red" }

      it { is_expected.to eq [FinderTags::Tag.new("Red", :red)] }
    end

    context "on the 'orange' test-data file" do
      let(:file) { "orange" }

      it { is_expected.to eq [FinderTags::Tag.new("Orange", :orange)] }
    end

    context "on the 'yellow' test-data file" do
      let(:file) { "yellow" }

      it { is_expected.to eq [FinderTags::Tag.new("Yellow", :yellow)] }
    end

    context "on the 'green' test-data file" do
      let(:file) { "green" }

      it { is_expected.to eq [FinderTags::Tag.new("Green", :green)] }
    end

    context "on the 'blue' test-data file" do
      let(:file) { "blue" }

      it { is_expected.to eq [FinderTags::Tag.new(BLUE_NAME, :blue)] }
    end

    context "on the 'purple' test-data file" do
      let(:file) { "purple" }

      it { is_expected.to eq [FinderTags::Tag.new(PURPLE_NAME, :purple)] }
    end

    context "on the 'grey' test-data file" do
      let(:file) { "grey" }

      it { is_expected.to eq [FinderTags::Tag.new(GREY_NAME, :grey)] }
    end

    context "on the 'red-legacy' test-data file" do
      let(:file) { "red-legacy" }

      it { is_expected.to eq [FinderTags::Tag.new("Red", :red)] }
    end

    context "on the 'orange-legacy' test-data file" do
      let(:file) { "orange-legacy" }

      it { is_expected.to eq [FinderTags::Tag.new("Orange", :orange)] }
    end

    context "on the 'yellow-legacy' test-data file" do
      let(:file) { "yellow-legacy" }

      it { is_expected.to eq [FinderTags::Tag.new("Yellow", :yellow)] }
    end

    context "on the 'green-legacy' test-data file" do
      let(:file) { "green-legacy" }

      it { is_expected.to eq [FinderTags::Tag.new("Green", :green)] }
    end

    context "on the 'blue-legacy' test-data file" do
      let(:file) { "blue-legacy" }

      it { is_expected.to eq [FinderTags::Tag.new("Blue", :blue)] }
    end

    context "on the 'purple-legacy' test-data file" do
      let(:file) { "purple-legacy" }

      it { is_expected.to eq [FinderTags::Tag.new("Purple", :purple)] }
    end

    context "on the 'grey-legacy' test-data file" do
      let(:file) { "grey-legacy" }

      it { is_expected.to eq [FinderTags::Tag.new("Grey", :grey)] }
    end
  end
end
