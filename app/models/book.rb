class Book < ApplicationRecord
    #------relations-----
        belongs_to :author
    #-----options-------
        before_save do
            title.capitalize!
            genre.downcase!
        end
    #-----validate------
        validates :title, presence: true, length: {maximum: 60},
                          uniqueness: { case_sensitive: false }
        validates :genre, presence: true, length: {maximum: 30}
        validates :year, presence: true,
                         numericality: { greater_than_or_equal_to: 0, 
                                    less_than_or_equal_to: 9999,
                                    only_integer: true}
        validates :plot, presence: true, length: {maximum: 255}
    end
    