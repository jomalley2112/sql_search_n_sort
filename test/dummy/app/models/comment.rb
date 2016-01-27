class Comment < ActiveRecord::Base
	extend SqlSearchableSortable
	belongs_to :article

	sql_sortable "article_headline"
end