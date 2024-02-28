require 'rails_helper'

describe 'ヘッダーのテスト' do
  let!(:enduser) { create(:enduser) }

  before do
    visit root_path
  end

  describe 'ログイン前のヘッダーのテスト' do
    context '表示内容の確認' do
      it 'Homeリンクが表示される' do
        home_link = find_all('a')[1].text
        expect(home_link).to match(/Home/)
      end
      it '新規登録リンクが表示される' do
        about_link = find_all('a')[2].text
        expect(about_link).to match(/新規登録/)
      end
      it 'ログインリンクが表示される' do
        signup_link = find_all('a')[3].text
        expect(signup_link).to match(/ログイン/)
      end
    end

    context 'リンクの内容の確認' do
      it 'ロゴを押すと、トップ画面に遷移する' do
        logo_link = find_all('a')[0].text
        logo_link = logo_link.delete(' ')
        logo_link.gsub!(/\n/, '')
        click_link logo_link
        is_expected.to eq '/'
      end
      it 'Homeを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[1].text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      it '新規登録を押すと、トップ画面に遷移する' do
        signup_link = find_all('a')[2].text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link, match: :first
        is_expected.to eq '/endusers/sign_up'
      end
      it 'ログインを押すと、トップ画面に遷移する' do
        login_link = find_all('a')[2].text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link, match: :first
        is_expected.to eq '/endusers/sign_in'
      end
    end
  end

  describe 'ログイン後のヘッダーのテスト' do
    before do
      visit new_enduser_session_path
      fill_in 'enduser[email]', with: enduser.email
      fill_in 'enduser[password]', with: enduser.password
      click_button 'ログイン'
    end
    context 'ヘッダーの表示を確認' do
      it 'マイページリンクが表示される' do
        mypage_link = find_all('a')[1].text
        expect(mypage_link).to match(/マイページ/)
      end
      it '新規投稿リンクが表示される' do
        newpost_link = find_all('a')[2].text
        expect(newpost_link).to match(/新規投稿/)
      end
      it '投稿一覧リンクが表示される' do
        posts_link = find_all('a')[3].text
        expect(posts_link).to match(/投稿一覧/)
      end
      it 'Log outリンクが表示される' do
        logout_link = find_all('a')[4].text
        expect(logout_link).to match(/ログアウト/)
      end
    end
    context 'リンクの内容のテスト' do
      it 'マイページリンクを押すと、自分のユーザ詳細画面に遷移する' do
        mypage_link = find_all('a')[1].text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/endusers/' + enduser.id.to_s
      end
      it '新規投稿を押すと、新規投稿画面に遷移する' do
        newpost_link = find_all('a')[2].text
        newpost_link = newpost_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link newpost_link
        is_expected.to eq '/posts/new'
      end
      it '投稿一覧を押すと、投稿一覧画面に遷移する' do
        posts_link = find_all('a')[3].text
        posts_link = posts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link posts_link
        is_expected.to eq '/posts'
      end
      it 'ログアウトを押すと、正しくログアウトできる:ログアウト後のリダイレクト先がトップ画面になっている' do
        logout_link = find_all('a')[4].text
        logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link logout_link
        expect(current_path).to eq '/'
      end
    end
  end
end

