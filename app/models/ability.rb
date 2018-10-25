class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, Project, user: user
    can :manage, Task, project: { user: user }
    can :manage, Comment, task: { project: { user_id: user.id } }
  end
end
