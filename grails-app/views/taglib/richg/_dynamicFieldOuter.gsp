<div id="${id}" class="dynamic-field">
    ${body}

    <div id="add-${var}-button">
        <input type="button" value="Add ${var}" onclick="addDynamicField('${var}', ${size})"/>
    </div>

    <script type="text/javascript">
        $(".dynamic-field-child.clone").attr("style", "display: none;");
        $(".dynamic-field-child.clone :input").attr("disabled", true);
    </script>
</div>