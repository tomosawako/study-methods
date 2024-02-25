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
    end
  end

end





