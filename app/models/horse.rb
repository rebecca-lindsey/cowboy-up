class Horse < ActiveRecord::Base
    belongs_to :user

    def self.color_list
        color_arr = ["Appaloosa", "Bay", "Bay Dapple", "Black", "Brown", "Buckskin", "Champagne", "Chestnut", "Cream", "Dun", "Flaxen Chestnut", "Gray", "Grulla", "Palomino", "Roan", "Silver Dapple", "White"]
    end

    def self.sex_list
        sex_arr = ["Mare", "Stallion", "Gelding"]
    end

    def self.breeds
        select(:breed).map(&:breed).uniq.sort
    end

    def color_selector
        case self.color
        when "Bay", "Bay Dapple"
            "bay"
        when "Appaloosa", "White"
            "white"
        when "Black"
            "black"
        when "Brown"
            "brown"
        when "Buckskin", "Palomino", "Dun"
            "gold"
        when "Champagne"
            "champagne"
        when "Chestnut", "Flaxen Chestnut"
            "chestnut"
        when "Cream"
            "cream"
        when "Gray", "Silver Dapple", "Grulla"
            "gray"
        when "Roan"
            "roan"
        end
    end

    def slug
        self.name.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        self.all.find{|horse| horse.slug == slug}
    end
end