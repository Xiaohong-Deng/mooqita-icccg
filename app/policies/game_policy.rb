class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.has_member? user
  end

  def update?
    show? && record.round_end_for?(user)
  end

  def show_questioner?
    ! judge?
  end

  def answer_raiser?
    show_questioner?
  end

  def question_raiser?
    record.has_questioner? user
  end

  def judge?
    record.has_judge? user
  end
end
