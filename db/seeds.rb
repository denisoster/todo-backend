FactoryBot.create_list :user, 5

User.all.each do |user|
  5.times { FactoryBot.create :project, user: user }
end

Project.all.each do |project|
  10.times { FactoryBot.create :task, project: project }
end

Task.all.each do |task|
  5.times { FactoryBot.create :comment, task: task }
end
