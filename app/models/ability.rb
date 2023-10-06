# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Post # Allow all users to read posts
    can :create, Post # Allow all users to create posts
    can :update, Post, user_id: user.id  # Allow users to edit their own posts
    can :read, Comment # Allow all users to read comments
    can :create, Comment # Allow all users to create comments
    can :update, Comment, user_id: user.id  # Allow users to edit their own comments
    can :read, Topic # Allow all users to read comments
    can :create, Topic # Allow all users to create comments
    can :update, Topic, user_id: user.id  # Allow users to edit their own comments
  end
end
