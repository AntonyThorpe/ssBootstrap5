<div class="row">
	<% if $Menu(2) %>
		<div class="col-sm-3 sidebar d-sm-none d-md-block">
			<% include SideBar %>
		</div>
	<% end_if %>
	<% if $Menu(2) %>
		<div class="col-sm-8">
	<% end_if %>

	<article>
		<h1>$Title</h1>
		<div class="content">
			$Content
		</div>
		<div class="row">
			<div class="col-sm-5">
				$Form
			</div>
			<div class="col-sm-7">
			</div>
		</div>
	</article>

	<% if $Menu(2) %>
		</div>
		<div class="col-sm-1"></div>
	<% end_if %>
</div>
