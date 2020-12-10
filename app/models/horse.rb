class Horse < ActiveRecord::Base
    belongs_to :user

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
end