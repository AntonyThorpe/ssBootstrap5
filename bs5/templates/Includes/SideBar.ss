<%--Include SidebarMenu recursively --%>
<ul class="list-group">
    <% loop $Children %>
    <li class="list-group-item list-group-item-action<% if $Current %> active<% end_if %>">
		    <a href="$Link" class="$LinkingMode" title="$Title">
		        $MenuTitle
		    </a>
		    <% if $Children %>
			    <ul>
			        <% include SidebarMenu %>
			    </ul>
		    <% end_if %>
		</li>
	<% end_loop %>
</ul>
