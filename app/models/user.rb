class User < ActiveRecord::Base
    has_secure_password
    has_many :horses

    def self.all_alpha_sort
        all.order(:name)
    end
end