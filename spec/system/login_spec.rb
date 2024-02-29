require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
       it '新規登録リンクが表示される' do
        sign_up_link = find_all('a')[4].text
        expect(sign_up_link).to match(/新規登録/)
      end
      it '新規登録リンクの内容が正しい' do
        sign_up_link = find_all('a')[4].text
        expect(page).to have_link sign_up_link, href: new_enduser_registration_path
      end
      it 'ログインリンクが表示される' do
        log_in_link = find_all('a')[5].text
        expect(log_in_link).to match(/ログイン/)
      end
      it 'ログインリンクの内容が正しい' do
        log_in_link = find_all('a')[5].text
        expect(page).to have_link log_in_link, href: new_enduser_session_path
      end
    end
  end

  describe 'ログイン前のヘッダーのテスト' do
    before do
      visit root_path
    end
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
      subject { current_path }

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
      it '新規登録を押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[2].text
        signup_link = signup_link.delete(' ')
        signup_link.gsub!(/\n/, '')
        click_link signup_link, match: :first
        is_expected.to eq '/endusers/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[3].text
        login_link = login_link.delete(' ')
        login_link.gsub!(/\n/, '')
        click_link login_link, match: :first
        is_expected.to eq '/endusers/sign_in'
      end
    end
  end

  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_enduser_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/endusers/sign_up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'enduser[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'enduser[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'enduser[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'enduser[password_confirmation]'
      end
      it 'サインアップボタンが表示される' do
        expect(page).to have_button 'サインアップ'
      end
    end

    context '新規投稿成功のテスト' do
      before do
        fill_in 'enduser[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'enduser[email]', with: Faker::Internet.email
        fill_in 'enduser[password]', with: 'password'
        fill_in 'enduser[password_confirmation]', with: 'password'
      end

      it '正しく新規投稿される' do
        expect {click_button 'サインアップ' }.to change(Enduser.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザーの詳細画面(マイページ)になっている' do
        click_button 'サインアップ'
        expect(current_path).to eq '/endusers/' + Enduser.last.id.to_s
      end
    end
  end

  describe 'ユーザーログインのテスト' do
    let(:enduser){ create(:enduser) }

    before do
      visit new_enduser_session_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/endusers/sign_in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'enduser[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'enduser[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
      it 'nameフォームが表示されない' do
        expect(page).not_to have_field 'enduser[name]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'enduser[email]', with: enduser.email
        fill_in 'enduser[password]', with: enduser.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、投稿一覧になっている' do
        expect(current_path).to eq '/posts'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'enduser[email]', with: ''
        fill_in 'enduser[password]', with: ''
        click_button 'ログイン'
      end
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
      expect(current_path).to eq '/endusers/sign_in'
    end
  end

  describe 'ユーザーログイン後のヘッダーのテスト' do
    let!(:enduser) { create(:enduser) }
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
      subject { current_path }

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
