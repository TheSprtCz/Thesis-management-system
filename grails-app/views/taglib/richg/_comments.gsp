<div id="comments">
<g:if test="${comments}">
    <h3 class="header">
        Comments
    </h3>
    <g:each in="${comments}" var="comment" status="i">
        <richg:comment comment="${comment}" index="${i}"/>
    </g:each>
</g:if>
</div>

<h4 class="header">
    Leave a comment
</h4>
<g:hiddenField name="comment.article.id" value="${article?.id}" />
<g:textArea class="comment" name="comment.content" rows="5" />
<button id="add-comment" class="btn btn-primary pull-right">
    <g:message code="default.button.post.label" default="Post Comment" />
</button>
<script type="text/javascript">
    commentsCount = ${comments?.size()};
    $('#add-comment').click(function() {
        $.ajax({
            url: "${createLink(controller: 'json', action: 'createComment')}",
            type: 'POST',
            data: {
                'comment.article.id': $('#comment\\.article\\.id').val(),
                'comment.content':    $('#comment\\.content').val(),
                'comment.index':      commentsCount++
            },
            success: function(data) {
                $('.alert > .close').click();
                if (data.success) {
                    $('#comment\\.content').val(null);
                    $(data.data).appendTo('#comments').hide().fadeIn();
                }
                $(data.message).appendTo('#comments').hide().fadeIn();
            }
        });
    });
</script>