json.array! @users do |user|
    json.id user.id
    json.super_secrect_token user.token
    json.name user.name
end