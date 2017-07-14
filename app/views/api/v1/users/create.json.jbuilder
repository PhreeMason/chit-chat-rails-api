json.data do
  json.user do
    json.call{
      @user,
      :id, 
      :username
    }  
  end
  json.token(Auth.create_token(@user.id))
end
