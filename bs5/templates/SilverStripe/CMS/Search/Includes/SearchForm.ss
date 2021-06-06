<form $FormAttributes class="row mt-2 mt-0 md-0">
	<% if $Message %>
	   <p id="{$FormName}_error" class="message $MessageType">$Message</p>
	<% else %>
	   <p id="{$FormName}_error" class="message $MessageType" style="display: none"></p>
	<% end_if %>
	<fieldset>
        <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
    <button class="btn btn-outline-success my-2 my-0 sm-0" type="submit" name="action_results">Go</button>
	</fieldset>
</form>
