# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can [:update, :destroy], [Question, Answer, Comment], author_id: user.id

    can :destroy, ActiveStorage::Attachment do |file|
      user.author_of?(file.record)
    end

    can :destroy, Link, linkable: { author_id: user.id }

    can :assign_best, Answer, question: { author_id: user.id }

    can :manage, Rank do |rank|
      !user.author_of?(rank.rankable)
    end
  end
end
