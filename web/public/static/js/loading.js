 Loading = {
    show:function () {
        $.blockUI({
            message: '<img src="/static/image/loading.gif">',
            css: {
                zIndex: '10011',
                width: '80px',
                left: '50%',
                padding: '10px',
                marginLeft: '-40px'
            }
        });
    },
    hide:function () {
        $.unblockUI();
        // setTimeout(function () {
        //     $.unblockUI();
        // },500)
    }
};