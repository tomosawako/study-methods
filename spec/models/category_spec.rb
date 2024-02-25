require 'rails_helper'

describe 'Categoryモデルのテスト' do

  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:category)).to be_valid
  end
end