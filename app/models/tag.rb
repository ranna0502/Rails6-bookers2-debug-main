class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :books, through: :tagmaps

  def self.search_books_for(content, method)

    if method == 'perfect'
      tags = Tag.where(tag_name: content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end

    return tags.inject(init = []) {|result, tag| result + tag.books}

  end
end
