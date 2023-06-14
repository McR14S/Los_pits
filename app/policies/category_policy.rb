class CategoryPolicy < BasePolicy
    def method_missing(m, *args, &block)
        Current.user.admin? || Current.user.superadmin?
    end
end
