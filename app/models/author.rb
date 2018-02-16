class Author < ApplicationRecord
    #------relations-----
        has_many :books, dependent: :destroy
    #-----options-------
        before_save do
            self.first_name = first_name.downcase.capitalize
            self.last_name = last_name.downcase.capitalize
        end
    #-----validate------
        validates :first_name, presence: true, length: {maximum: 15}
        validates :last_name, presence: true, length: {maximum: 15}
        validates :bio, presence: true, length: {maximum: 255}
    end
    