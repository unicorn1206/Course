<template>
    <div>
        <p>
            <button v-on:click="add()" class="btn btn-white btn-default btn-round">
                <i class="ace-icon fa fa-edit"></i>
                新增
            </button>
            &nbsp;
            <button v-on:click="list(1)" class="btn btn-white btn-default btn-round">
                <i class="ace-icon fa fa-refresh"></i>
                刷新
            </button>
        </p>

        <!--ref属性：组件别名,v-bind,绑定一个方法，左边list为子组件内部定义，暴露给外部的一个回调方法
        ，右边list是当前组件的list方法，作用：点击按钮的时候要执行什么方法-->
        <!--        <pagination ref="pagination" v-bind:list="list"></pagination>-->
        <pagination ref="pagination" v-bind:list="list" v-bind:itemCount="6"></pagination>

        <div id="form-modal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">表单</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">分类</label>
                                <div class="col-sm-10">
                                    <ul id="tree" class="ztree"></ul>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">封面</label>
                                <div class="col-sm-10">
                                    <big-file v-bind:text="'上传封面'"
                                          v-bind:input-id="'image-upload'"
                                          v-bind:suffixs="['jpg','jpeg','png']"
                                          v-bind:use="FILE_USE.COURSE.key"
                                          v-bind:after-upload="afterUpload"></big-file>
                                    <div v-show="course.image" class="row">
                                        <div class="col-md-6">
                                            <img v-bind:src="course.image" class="img-responsive"/><!--class设置图片为响应式-->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">名称</label>
                                <div class="col-sm-10">
                                    <input v-model="course.name" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">讲师</label>
                                <div class="col-sm-10">
                                    <select v-model="course.teacherId" class="form-control">
                                        <option v-for="o in teachers" v-bind:key="o.id" v-bind:value="o.id">
                                            {{o.name}}
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">概述</label>
                                <div class="col-sm-10">
                                    <input v-model="course.summary" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">时长</label>
                                <div class="col-sm-10">
                                    <input v-model="course.time" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">价格（元）</label>
                                <div class="col-sm-10">
                                    <input v-model="course.price" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">级别</label>
                                <div class="col-sm-10">
                                    <select v-model="course.level" class="form-control">
                                        <option v-for="o in COURSE_LEVEL" v-bind:key="o.key" v-bind:value="o.key">
                                            {{o.value}}
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">收费</label>
                                <div class="col-sm-10">
                                    <select v-model="course.charge" class="form-control">
                                        <option v-for="o in COURSE_CHARGE" v-bind:key="o.key" v-bind:value="o.key">
                                            {{o.value}}
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">状态</label>
                                <div class="col-sm-10">
                                    <select v-model="course.status" class="form-control">
                                        <option v-for="o in COURSE_STATUS" v-bind:key="o.key" v-bind:value="o.key">
                                            {{o.value}}
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">报名数</label>
                                <div class="col-sm-10">
                                    <input v-model="course.enroll" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">顺序</label>
                                <div class="col-sm-10">
                                    <input v-model="course.sort" class="form-control" disabled>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" v-on:click="save()">保存</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div id="course-sort-modal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">排序</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">当前排序</label>
                                <div class="col-sm-10">
                                    <input v-model="sort.oldSort" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">新排序</label>
                                <div class="col-sm-10">
                                    <input v-model="sort.newSort" class="form-control">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" v-on:click="updateSort()">更新排序</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div class="row">
            <div class="col-md-4" v-for="course in courses" v-bind:key="course.id">
                <div class="thumbnail search-thumbnail">
                    <img v-show="!course.image" class="media-object" src="/static/image/demo-course.jpg"/>
                    <img v-show="course.image" class="media-object" v-bind:src="course.image"/>
                    <div class="caption">
                        <div class="clearfix">
                            <span class="pull-right label label-primary info-label">
                                {{COURSE_LEVEL | optionKV(course.level)}}
                            </span>
                            <span class="pull-right label label-primary info-label">
                                {{COURSE_CHARGE | optionKV(course.charge)}}
                            </span>
                            <span class="pull-right label label-primary info-label">
                                {{COURSE_STATUS | optionKV(course.status)}}
                            </span>
                        </div>

                        <h3 class="search-title">
                            <a href="#" class="blue">{{course.name}}</a>
                        </h3>

                        <div class="profile-activity clearfix" v-for="teacher in teachers.filter(t=>{return t.id == course.teacherId})" v-bind:key="teacher.id">
                            <div>
                                <img v-show="!teacher.image" class="pull-left" src="/static/image/讲师头像/头像2.jpg"/>
                                <img v-show="teacher.image" class="pull-left" v-bind:src="teacher.image"/>
                                <a class="user" href="#"> {{teacher.name}} </a>
                                <br>
                                {{teacher.position}}
                            </div>
                        </div>

                        <p class="blue bolder bigger-150">{{course.price}}&nbsp;<i class="fa fa-rmb"></i></p>
                        <p>{{course.summary}}</p>
                        <p>
                            <span class="badge badge-info">{{course.id}}</span>
                            <span class="badge badge-info">排序：{{course.sort}}</span>
                            <span class="badge badge-info">时长：{{course.time | formatSecond}}</span>
                        </p>
                        <p>
                            <button v-on:click="toChapter(course)" class="btn btn-white btn-xs btn-info btn-round">
                                大章
                            </button>&nbsp;
                            <button v-on:click="toContent(course)" class="btn btn-white btn-xs btn-info btn-round">
                                内容
                            </button>&nbsp;
                            <button v-on:click="openSortModal(course)" class="btn btn-white btn-xs btn-info btn-round">
                                排序
                            </button>&nbsp;
                            <button v-on:click="edit(course)" class="btn btn-white btn-xs btn-info btn-round">
                                编辑
                            </button>&nbsp;
                            <button v-on:click="del(course.id)" class="btn btn-white btn-xs btn-waring btn-round">
                                删除
                            </button>
                        </p>
                    </div>
                </div>
            </div>
        </div>

    </div>
</template>

<script>
    import Pagination from '../../components/pagination'//引入子组件2-1
    import BigFile from '../../components/big-file'
    export default {
        components: {Pagination,BigFile},//引入子组件2-2
        name: "business-course",
        data: function () {
            return {
                course: {},//新增时，弹出框的值
                // courseId:"",
                // name:'',
                courses: [],//列表展示
                COURSE_LEVEL: COURSE_LEVEL,
                COURSE_CHARGE: COURSE_CHARGE,
                COURSE_STATUS: COURSE_STATUS,
                FILE_USE: FILE_USE,
                categorys: [],
                tree: {},
                sort: {
                    id: "",
                    oldSort: 0,
                    newSort: 0
                },
                teachers:[],
                files:[]
            }
        },
        mounted: function () {
            //this.$parent.activeSideBar("business-course-sidebar");
            let _this = this;
            _this.$refs.pagination.size = 5;
            _this.list(1);
            _this.allCategory();
            _this.allTeachers();
        },
        methods: {
            /**
             * 列表查询
             */
            allCategory() {
                let _this = this;
                Loading.show();
                _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/category/all').then((response) => {
                    Loading.hide();
                    let resp = response.data;
                    _this.categorys = resp.content;
                    _this.initTree();
                })
            },
            allTeachers() {
                let _this = this;
                Loading.show();
                _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/teacher/all').then((response) => {
                    Loading.hide();
                    let resp = response.data;
                    _this.teachers = resp.content;
                })
            },
            initTree() {
                let _this = this;
                var setting = {
                    check: {
                        enable: true
                    },
                    data: {
                        simpleData: {
                            idKey: "id",
                            pIdKey: "parent",
                            rootPId: "00000000",
                            enable: true
                        }
                    }
                };

                var zNodes = _this.categorys;
                _this.tree = $.fn.zTree.init($("#tree"), setting, zNodes);
            },
            /**
             * 点击【新增】
             */
            add() {
                let _this = this;
                _this.course = {
                    sort: _this.$refs.pagination.total + 1
                };
                _this.tree.checkAllNodes(false);
                $('#form-modal').modal('show');
            },
            /**
             * 点击【编辑】
             */
            edit(course) {
                let _this = this;
                //数据双向绑定
                // _this.course = course;
                //取消数据双向绑定，在编辑框输入值，不影响列表内的值
                _this.course = $.extend({}, course);//将course对象复制到一个空对象{}
                _this.listCategory(course.id);
                $('#form-modal').modal('show');
            },

            /**
             * 列表查询
             */
            list(page) {
                let _this = this;
                Loading.show();
                _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/course/list', {
                    page: page,
                    size: _this.$refs.pagination.size//获取组件内部的size变量
                }).then((response) => {
                    Loading.hide();
                    let resp = response.data;
                    _this.courses = resp.content.list;
                    _this.$refs.pagination.render(page, resp.content.total);//重新渲染当前组件，所选页数的底色
                })
            },

            /**
             * 点击【保存】
             */
            save() {
                let _this = this;
                // let course ={
                //     couseId:this.courseId,
                //     name:this.name
                // }
                // 保存校验
                if (1 != 1
                    || !Validator.require(_this.course.name, "名称")
                    || !Validator.length(_this.course.name, "名称", 1, 50)
                    || !Validator.length(_this.course.summary, "概述", 1, 2000)
                    || !Validator.length(_this.course.image, "封面", 1, 100)
                ) {
                    return;
                }
                let categorys = _this.tree.getCheckedNodes();
                if (Tool.isEmpty(categorys)) {
                    Toast.warning("请选择分类！");
                    return;
                }
                console.log(categorys);
                _this.course.categorys = categorys;
                Loading.show();
                _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/course/save', _this.course
                ).then((response) => {
                    Loading.hide();
                    let resp = response.data;
                    if (resp.success) {
                        $('#form-modal').modal('hide');
                        _this.list(1);
                        Toast.success('保存成功');
                    } else {
                        Toast.warning(resp.message);
                    }

                })
            },
            /**
             * 点击【删除】
             */
            del(id) {
                let _this = this;
                Confirm.show("删除课程后不可恢复，确认删除？", function () {
                    Loading.show();
                    _this.$ajax.delete(process.env.VUE_APP_SERVER + '/business/admin/course/delete/' + id
                    ).then((response) => {
                        Loading.hide();
                        let resp = response.data;
                        if (resp.success) {
                            _this.list(1);
                            Toast.success('删除成功');
                        }
                    })
                });
            },
            /**
             * 点击【跳转大章】
             */
            toChapter(course) {
                let _this = this;
                SessionStorage.set(SESSION_KEY_COURSE, course);
                _this.$router.push("/business/chapter");
            },
            /**
             * 点击【跳转内容编辑】
             */
            toContent(course) {
                let _this = this;
                SessionStorage.set(SESSION_KEY_COURSE, course);
                _this.$router.push("/business/content");
            },

            listCategory(courseId) {
                let _this = this;
                Loading.show();
                _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/course/list-category/' + courseId
                ).then((response) => {
                    Loading.hide();
                    let resp = response.data;
                    let categorys = resp.content;
                    _this.tree.checkAllNodes(false);
                    for (let i = 0; i < categorys.length; i++) {
                        let node = _this.tree.getNodeByParam("id", categorys[i].categoryId);
                        _this.tree.checkNode(node, true);
                    }
                })
            },
            /**
             *编辑排序
             */
            openSortModal(course) {
                let _this = this;
                console.log("course", course.id);
                console.log("sort", course.sort);
                _this.sort = {
                    id: course.id,
                    oldSort: course.sort,
                    newSort: course.sort
                };
                // _this.sort.id = course.id;
                // _this.sort.oldSort = course.sort;
                // _this.sort.newSort = course.sort;
                $('#course-sort-modal').modal("show");
            },

            /**
             *更新排序
             */
            updateSort() {
                let _this = this;
                if (_this.sort.newSort == _this.sort.oldSort) {
                    Toast.warning("排序没有变化！");
                    return;
                }
                Loading.show();
                _this.$ajax.post(process.env.VUE_APP_SERVER + '/business/admin/course/sort', _this.sort
                ).then((response) => {
                    Loading.hide();
                    let resp = response.data;
                    if (resp.success) {
                        $('#course-sort-modal').modal('hide');
                        _this.list(1);
                        Toast.success('更新排序成功');
                    } else {
                        Toast.warning(resp.message);
                    }

                })
            },
            afterUpload(resp){
                let _this = this;
                let image = resp.content.path;
                _this.course.image = image;///Users/stephanie/IdeaProjects/course
            }

        }
    }
</script>

<style scoped>
    /*scoped:样式只作用于当前组件，防止互相渲染*/
    .caption h3 {
        font-size: 20px;
    }

    @media (max-width: 1199px) {
        .caption h3 {
            font-size: 16px;
        }
    }
</style>
