SqlSearchNSort.config do |config|
	#Add to this array any parameters you don't want the search/sort forms to pass along . (like "page" in Kaminari)
	config.suppress_params = {
		search: [],
		sort: []
		} 
end