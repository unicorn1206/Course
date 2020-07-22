Confirm = {
    show:function (message,callback) {
        Swal.fire({
            title: '确认删除?',
            text: message,
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '确认!'
        }).then((result) => {
            if (result.value) {
                if(callback){
                    callback();
                }
            }
        })

    }
}