require 'test'

RSpec.describe Test, "#score" do
    context "with no strikes or spares"
        it "sums the pin count for each roll" do
            test = Test.new
            20.times { test.hit(4) }
            expect(test.score).to eq 80
        end
    end