# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Post # Allow all users to read posts
    can :create, Post # Allow all users to create posts
    can :update, Post, user_id: user.id  # Allow users to edit their own posts
    can :delete, Post, user_id: user.id
    can :read, Comment # Allow all users to read comments
    can :create, Comment # Allow all users to create comments
    can :update, Comment, user_id: user.id  # Allow users to edit their own comments
    can :delete, Comment, user_id: user.id
    can :read, Topic # Allow all users to read topic
    can :create, Topic # Allow all users to create topic
    can :update, Topic, user_id: user.id  # Allow users to edit their own topic
    can :delete, Topic, user_id: user.id

  end
end
