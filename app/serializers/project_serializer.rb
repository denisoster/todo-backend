class ProjectSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title
  has_many :tasks
end
