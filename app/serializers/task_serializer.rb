class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :status, :deadline, :position, :project_id
  has_many :comments
end
