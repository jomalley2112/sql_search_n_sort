class Comment < ActiveRecord::Base
	extend SqlSearchableSortable
	belongs_to :article

	sql_sortable headline: { db_table: :article }
end