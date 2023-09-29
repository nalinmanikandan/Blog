# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    # Define abilities for posts
    can :read, Post # Allow all users to read posts
    can :create, Post # Allow all users to create posts

    # Allow users to edit their own posts
    can :update, Post, user_id: user.id

    # Define abilities for comments
    can :read, Comment # Allow all users to read comments
    can :create, Comment # Allow all users to create comments

    # Allow users to edit their own comments
    can :update, Comment, user_id: user.id
  end
end
