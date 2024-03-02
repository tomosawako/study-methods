require 'rails_helper'

describe 'ユーザログイン後のテスト' do
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

  describe '自分のユーザー詳細画面のテスト' do
    before do
      visit enduser_path(enduser)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/endusers/' + enduser.id.to_s
      end
      it '投稿一覧のユーザー画像のリンク先が正しい' do
        expect(page).to have_link '', href: enduser_path(enduser)
      end
      it '投稿一覧の投稿画像のリンク先が正しい' do
        expect(page).to have_link '', href: post_path(post)
      end
      it '投稿一覧に自分の投稿のctegory.nameが表示される' do
        expect(page).to have_content post.category.name
      end
      it '投稿一覧に自分の投稿のfieldが表示される' do
        expect(page).to have_content post.field
      end
      it '投稿一覧に自分の投稿のreference_bookが表示される' do
        expect(page).to have_content post.reference_book
      end
      it '投稿一覧に自分の投稿のstudy_methodが表示される' do
        expect(page).to have_content post.study_method
      end
      it '投稿一覧に自分の投稿のtotal_study_timeが表示される' do
        expect(page).to have_content post.total_study_time
      end
      it '投稿一覧に自分の投稿のachievementが表示される' do
        expect(page).to have_content post.achievement
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: enduser_path(other_enduser)
        expect(page).not_to have_content other_post.field
        expect(page).not_to have_content other_post.reference_book
        expect(page).not_to have_content other_post.study_method
        expect(page).not_to have_content other_post.total_study_time
        expect(page).not_to have_content other_post.achievement
      end
    end
  end

  describe '自分のユーザー情報編集画面のテスト' do
    before do
      visit edit_enduser_path(enduser)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/endusers/' + enduser.id.to_s + '/edit'
      end
      it '名前編集フォームが表示される' do
        expect(page).to have_field 'enduser[name]', with: enduser.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'enduser[profile_image]'
      end
      it 'email編集フォームが表示される' do
        expect(page).to have_field 'enduser[email]', with: enduser.email
      end
      it '変更を保存ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @enduser_old_name = enduser.name
        @enduser_old_email = enduser.email
        fill_in 'enduser[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'enduser[email]', with: Faker::Internet.email
        expect(enduser.profile_image).to be_attached
        click_button '変更を保存'
      end

      it '名前が正しく表示される' do
        expect(page).not_to eq @enduser_old_name
      end
      it 'emailが正しく表示される' do
        expect(page).not_to eq @enduser_old_email
      end
      it 'リダイレクト先が、自分のユーザー詳細' do
        expect(current_path).to eq '/endusers/' + enduser.id.to_s
      end
    end
  end
end