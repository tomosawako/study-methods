require 'rails_helper'

describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:enduser) { create(:enduser) }
    let(:category) { create(:category) }
    let!(:post) {( build(:post, enduser_id: enduser.id)) }
    let!(:post) {( build(:post, category_id: category.id)) }

    context 'fieldカラム' do
      it '空欄でないこと' do
        post.field = ''
        is_expected.to eq false
      end
    end

    context 'reference_bookカラム' do
      it '空欄でないこと' do
        post.reference_book = ''
        is_expected.to eq false
      end
    end

    context 'study_method' do
      it '空欄でないこと' do
        post.study_method = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        post.study_method = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字はx' do
        post.study_method = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context 'total_study_time' do
      it '空欄でないこと' do
        post.total_study_time = ''
        is_expected.to eq false
      end
    end

    context 'achievement' do
      it '空欄でないこと' do
        post.achievement = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        post.achievement = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字はx' do
        post.achievement = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Enduserモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:enduser).macro).to eq :belongs_to
      end
    end
    context 'Categoryモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
  end
end





