class Author < ApplicationRecord
    #------relations-----
        has_many :books
    #-----options-------
        before_save do
            self.first_name = first_name.downcase.capitalize
            self.last_name = last_name.downcase.capitalize
        end
    #-----validate------
        validates :first_name, presence: true, length: {maximum: 10}, 
                    uniqueness: { case_sensitive: false }
    
        validates :last_name, presence: true, length: {maximum: 10}
        validates :bio, presence: true, length: {maximum: 255}
    end
    