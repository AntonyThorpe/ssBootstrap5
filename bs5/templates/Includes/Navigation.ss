<nav class="navbar navbar-expand-md navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="$BaseHref">$SiteConfig.Title</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse" style="">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <% loop $Menu(1) %>
                    <li class="nav-item $LinkingMode">
                    <a class="nav-link<%if $Current %> active<% end_if %>" href="$Link" title="$Title">$MenuTitle</a>
                    </li>
                <% end_loop %>
            </ul>
            <% if $SearchForm %>
                $SearchForm
            <% end_if %>
        </div>
    </div>
</nav>
