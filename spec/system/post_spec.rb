require 'rails_helper'

describe '投稿のテスト' do
  let!(:enduser) { create(:enduser) }
  let!(:other_enduser) { create(:enduser) }
  let!(:category) { create(:category) }
  let!(:post) { create(:post, enduser: enduser, category: category) }
  let!(:other_post) { create(:post, enduser: other_enduser, category: category) }

  before do
    visit new_enduser_session_path
    fill_in 'enduser[email]', with: enduser.email
    fill_in 'enduser[password]', with: enduser.password
    click_button 'ログイン'
  end

  describe '投稿画面のテスト' do
    before do
      visit new_post_path
    end
    context '表示の確認' do
      it 'new_post_pathが"/post/new"であるか' do
        expect(current_path).to eq('/posts/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post[field]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[reference_book]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[study_method]', with: Faker::Lorem.characters(number:30)
        fill_in 'post[total_study_time]', with: rand(1..100)
        fill_in 'post[achievement]', with: Faker::Lorem.characters(number:30)
        click_button '投稿'
        expect(page).to have_current_path post_path(post.last)
      end
    end
  end

  describe '投稿一覧のテスト' do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post.field
        expect(page).to have_content post.reference_book
        expect(page).to have_content post.study_method
        expect(page).to have_content post.total_study_time
        expect(page).to have_content post.achievement
      end
      it '削除リンクが表示されているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが表示されているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンク先の確認' do
      it '編集の遷移先は編集か' do
        edit_link = find('a')[9]
        click_link edit_link, match: :first
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
    end
    context '削除のテスト' do
      it 'postの削除' do
        expect{ post.destroy }.to change{ Post.count }.by(-1)
      end
    end
  end
end