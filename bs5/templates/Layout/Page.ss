<div <% if $Menu(2) %>class="row aside"<% end_if %>>
	<% if $Menu(2) %>
		<div class="col-3 sidebar d-sm-none d-md-block">
			<% include SideBar %>
		</div>
	<% end_if %>
	<% if $Menu(2) %>
		<div class="col-8">
	<% end_if %>

	<article>
		<h1>$Title</h1>
		<div class="content">$Content</div>
	</article>
	$Form

	<% if $Menu(2) %>
		</div>
		<div class="col-1"></div>
	<% end_if %>
</div>
