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
      before do
        fill_in 'post[field]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[reference_book]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[study_method]', with: Faker::Lorem.characters(number:30)
        fill_in 'post[total_study_time]', with: rand(1..10)
        fill_in 'post[achievement]', with: Faker::Lorem.characters(number:30)
      end
      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(enduser.posts, :count).by(1)
      end
      it '投稿後のリダイレクト先は正しいか' do
        click_button '投稿'
        expect(current_path).to eq '/posts/' + Post.last.id.to_s
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts'
      end
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post.field
        expect(page).to have_content post.reference_book
        expect(page).to have_content post.study_method
        expect(page).to have_content post.total_study_time
        expect(page).to have_content post.achievement
      end
      it '自分と他人の画像のリンクが正しい' do
        expect(page).to have_link '', href: enduser_path(post.enduser)
        expect(page).to have_link '', href: enduser_path(other_post.enduser)
      end
      it '削除リンクが表示されているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが表示されているか' do
        expect(page).to have_link '編集'
      end
    end
    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        second_enduser_post = FactoryBot.create(:post, enduser: enduser)
        visit post_path(second_enduser_post)
        click_link '編集'
        expect(current_path).to eq edit_post_path(second_enduser_post)
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除'
      end
      it '正しく削除される' do
        expect(Post.where(id: post.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/posts'
      end
    end
  end

  describe '投稿詳細画面のテスト' do
    before do
      visit post_path(post)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
      it 'ユーザー画像・名前のリンク先が正しい' do
        expect(page).to have_link post.enduser.name, href: enduser_path(post.enduser)
      end
      it '投稿したユーザー名が表示される' do
        expect(page).to have_content post.enduser.name
      end
      it '投稿の科目・資格名が表示される' do
        expect(page).to have_content post.category.name
      end
      it '投稿の分野が表示される' do
        expect(page).to have_content post.field
      end
      it '投稿の参考書・アプリが表示される' do
        expect(page).to have_content post.reference_book
      end
      it '投稿の勉強方法が表示される' do
        expect(page).to have_content post.study_method
      end
      it '投稿の勉強時間が表示される' do
        expect(page).to have_content post.total_study_time
      end
      it '投稿の成果が表示される' do
        expect(page).to have_content post.achievement
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_post_path(post)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除', href: post_path(post)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        second_enduser_post = FactoryBot.create(:post, enduser: enduser)
        visit post_path(second_enduser_post)
        click_link '編集'
        expect(current_path).to eq edit_post_path(second_enduser_post)
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除'
      end
      it '正しく削除される' do
        expect(Post.where(id: post.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/posts'
      end
    end
  end

  describe '投稿編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it 'field編集フォームが表示される' do
        expect(page).to have_field 'post[field]', with: post.field
      end
      it 'reference_book編集フォームが表示される' do
        expect(page).to have_field 'post[reference_book]', with: post.reference_book
      end
      it 'study_method編集フォームが表示される' do
        expect(page).to have_field 'post[study_method]', with: post.study_method
      end
      it 'total_study_time編集フォームが表示される' do
        expect(page).to have_field 'post[total_study_time]', with: post.total_study_time
      end
      it 'achievement編集フォームが表示される' do
        expect(page).to have_field 'post[achievement]', with: post.achievement
      end
      it '変更を保存ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end
    context '編集成功のテスト' do
      before do
        @post_old_field = post.field
        @post_old_reference_book = post.reference_book
        @post_old_study_method = post.study_method
        @post_old_total_study_time = post.total_study_time
        @post_old_achievement = post.achievement
        fill_in 'post[field]', with: Faker::Lorem.characters(number:9)
        fill_in 'post[reference_book]', with: Faker::Lorem.characters(number:9)
        fill_in 'post[study_method]', with: Faker::Lorem.characters(number:29)
        fill_in 'post[total_study_time]', with: rand(11..20)
        fill_in 'post[achievement]', with: Faker::Lorem.characters(number:29)
        click_button '変更を保存'
      end

      it 'fieldが正しく変更される' do
        expect(post.reload.field).not_to eq @post_old_field
      end
      it 'reference_bookが正しく変更される' do
        expect(post.reload.reference_book).not_to eq @post_old_reference_book
      end
      it 'が正しく変更される' do
        expect(post.reload.study_method).not_to eq @post_old_study_method
      end
      it 'が正しく変更される' do
        expect(post.reload.total_study_time).not_to eq @post_old_total_study_time
      end
      it 'が正しく変更される' do
        expect(post.reload.achievement).not_to eq @post_old_achievement
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
    end
  end
end