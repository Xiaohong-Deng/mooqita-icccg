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
    show? && ! judge?
  end

  def raise_answer?
    show_questioner?
  end

  def raise_question?
    record.has_questioner? user
  end

  def judge?
    record.has_judge? user
  end
end
