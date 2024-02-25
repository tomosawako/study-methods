require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'TopページのURLが正しいか' do
        expect(current_path).to eq '/'
      end
      it 'ログインリンクが表示される: ログインリンクの内容が正しい' do
        log_in_link = find_all('a')[5].text
        expect(page).to have_link log_in_link, href: new_enduser_session_path
      end
    end
  end
end