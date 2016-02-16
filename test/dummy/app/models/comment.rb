class Comment < ActiveRecord::Base
	extend SqlSearchableSortable
	belongs_to :article

	sql_sortable :commentator, {updated_at: { display_text: "Last Update" }}, {headline: { joined_table: :article }}
end