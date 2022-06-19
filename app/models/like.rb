class Like < ApplicationRecord
  validates:post_id,{presence:true}
   validates:user_id,{presence:true}
end
