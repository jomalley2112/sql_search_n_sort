class Comment < ActiveRecord::Base
	extend SqlSearchableSortable
	belongs_to :article

	sql_sortable headline: { joined_table: :article }
end