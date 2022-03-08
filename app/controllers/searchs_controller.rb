class SearchsController < ApplicationController
	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		elsif @model == 'book'
			@records = Book.search_for(@content, @method)
		elsif @model == 'tag'
			@records = Tag.search_books_for(@content, @method)
		end
	end

  private


  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      else
        Book.where('title LIKE ?', '%'+content+'%')
      end
    elsif model == 'tag'
      if method == 'perfect'
        Tag.where(tag_name: content)
      else
        Tag.where('tag_name LIKE ?', '%'+content+'%')
      end
    end
  end
end
