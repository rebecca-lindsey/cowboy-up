class User < ActiveRecord::Base
    has_secure_password
    has_many :horses, dependent: :destroy

    def self.all_alpha_sort
        all.order(:name)
    end
end