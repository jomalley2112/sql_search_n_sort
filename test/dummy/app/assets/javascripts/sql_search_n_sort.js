function clear_search() {
	frm = $("#search-form");
	$(frm).find("input#search_for").val("");
	$(frm).submit();
}