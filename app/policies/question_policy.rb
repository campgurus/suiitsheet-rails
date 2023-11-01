class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

    attr_reader :user, :post

    def initialize(user, question)
      @user = user
      @question = question
    end

    def update?
      user.admin?
    end
  end
end
