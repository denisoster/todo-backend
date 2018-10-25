class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :description, :attachment
end
