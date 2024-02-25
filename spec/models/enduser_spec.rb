require 'rails_helper'

RSpec.describe 'Enduserモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { enduser.valid? }

    let!(:other_enduser) { create(:enduser) }
    let(:enduser) { build(:enduser) }

    context 'nameカラム' do
      it '空欄でないこと' do
        enduser.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        enduser.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        enduser.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        enduser.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        enduser.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '一意性があること' do
        enduser.name = other_enduser.name
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Enduser.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
