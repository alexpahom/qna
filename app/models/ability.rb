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
    can :create, [Question, Answer, Comment, Subscription]
    can :update, [Question, Answer], author_id: user.id
    can :destroy, [Question, Answer, Comment, Subscription], author_id: user.id

    can :destroy, ActiveStorage::Attachment do |file|
      user.author_of?(file.record)
    end

    can :destroy, Link do |link|
      user.author_of? link.linkable
    end

    can :assign_best, Answer, question: { author_id: user.id }

    can :process_rank, [Question, Answer] do |rankable|
      !user.author_of?(rankable)
    end
  end
end
