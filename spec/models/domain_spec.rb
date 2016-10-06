require 'rails_helper'

RSpec.describe Domain, type: :model do
  subject { FactoryGirl.create(:domain) }

  let(:city) { FactoryGirl.create(:city) }
  let(:county) { FactoryGirl.create(:county) }

  describe '#add' do
    context "when the resource hasn't been added yet" do
      before { subject.add(city) }

      it 'adds the resource to the domain' do
        expect { subject.cities.to eq [city] }
      end
    end

    context 'when adding the resource for a second time' do
      before do
        subject.add(city)
        subject.add(city)
      end

      it 'does nothing' do
        expect { subject.citites.count.to be 1 }
      end
    end
  end

  describe '#remove' do
    context 'when the resource is in the membership' do
      before do
        subject.add(city)
        subject.remove(city)
      end

      it 'removes the resource' do
        expect { subject.cities.count.to be 0 }
      end
    end

    context "when the resource isn't in the membership" do
      before { subject.remove(city) }

      it 'does nothing' do
        expect { subject.cities.count.to be 0 }
      end
    end
  end
end
