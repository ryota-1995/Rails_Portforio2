require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # 無効なユーザー登録に対するテスト
  test "invalid signup information" do
    # signup_path(作成時のurl)にgetリクエストでアクセスする
    get signup_path
    # ブロックないの処理を実行する前と後でcountの結果に変化がないことを確認する
    assert_no_difference "User.count" do
      # name属性が空白（無効）なユーザーデータでusers_pathにpostリクエスト
      post users_path, params: { user: { name: "",
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "bar" } }
    end
    # newアクションが描画されている事を確認する
    assert_template "users/new"
  end

  # 有効なユーザー登録に対するテスト
  test "valid signup information" do
    # signup_path(作成時のurl)にgetリクエストでアクセスする
    get signup_path
    # ブロック内の処理を実行する前後でcountの結果の差が1であることを確認する
    assert_difference "User.count", 1 do
      # users_pathに有効なユーザーでpostリクエスト
      post users_path, params: { user: { name: "Example User",
                                        email: "user@example.com",
                                        password: "password",
                                        password_confirmation: "password" } }
    end
    # postの結果によって指定されたリダイレクト先にリダイレクトする
    follow_redirect!
    # showアクションが描画されていることを確認する
    assert_template "users/show"
  end
end
