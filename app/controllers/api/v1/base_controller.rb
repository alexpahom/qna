# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  skip_authorization_check
  skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!

  protected

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_ability
    @ability ||= Ability.new(current_resource_owner)
  end
end
