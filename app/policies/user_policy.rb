class UserPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def check_role?(user_role)
    user.role.eql?(user_role)
  end

  def all_rights?
    if director? || manager? || admin? || superadmin?
      true
    elsif booker? || master? || user?
      false
    end
  end

  def user?
    check_role?("Пользователь")
  end

  def superadmin?
    check_role?("superadmin")
  end

  def booker?
    check_role?("Бухгалтер склада")
  end

  def admin?
    check_role?("Администратор")
  end

  def director?
    check_role?("Директор")
  end

  def manager?
    check_role?("Управляющий")
  end

  def master?
    check_role?("Мастер")
  end
end
