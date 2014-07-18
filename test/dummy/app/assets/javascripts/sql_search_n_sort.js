function clear_search() {
	frm = $("#search-form");
	$(frm).find("input[id='search_for']").val("");
	$(frm).submit();
}