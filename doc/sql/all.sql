drop table if exists course;
create table course(
                        id char(8) not null default '' comment 'ID',
                        name varchar(50) not null comment '名称',
                        summary varchar(2000) comment '概述',
                        time int default 0 comment '时长|单位秒',
                        price decimal(8,2)  default 0.00 comment '价格（元）',
                        image varchar(100) comment '封面',
                        level char(1) comment '级别|ONE("1", "初级"),TWO("2", "中级"),THREE("3", "高级")',
                        charge char(1) comment '收费|CHARGE("C", "收费"),FREE("F", "免费")',
                        status char(1) comment '状态|PUBLISH("P", "发布"),DRAFT("D", "草稿")',
                        enroll integer default 0 comment '报名数',
                        sort int comment '顺序',
                        create_at datetime(3) comment '创建时间',
                        update_at datetime(3) comment '更新时间',
                        primary key (id)
)engine=innodb default charset=utf8mb4 comment ='课程';
insert into course values('00000001','测试课程01','这是一门测试课程',7200,19.9,'',0,'C','D',100,0,now(),now());

drop table if exists section;
create table section(
                        id char(8) not null default '' comment 'ID',
                        title varchar(50) not null comment '标题',
                        course_id char(8) comment '课程|course.id',
                        chapter_id char(8) comment '大章|chapter.id',
                        video varchar(200) comment '视频',
                        time int comment '时长|单位秒',
                        charge char(1) comment '收费|C 收费;F 免费',
                        sort int comment '顺序',
                        create_at datetime(3) comment '创建时间',
                        update_at datetime(3) comment '更新时间',
                        primary key (id)
)engine=innodb default charset=utf8mb4 comment ='小节';

insert into section values ('00000001','测试小节01','00000001','00000000','',500,'F',1,now(),now());

drop table if exists chapter;
create table chapter(
                        id char(8) not null comment 'ID',
                        course_id char(8) comment '课程ID',
                        name varchar(50) comment '名称',
                        primary key (id)
)engine=innodb default charset=utf8mb4 comment ='大章';

insert into chapter values ('00000001','00000000','测试大章1');
insert into chapter values ('00000002','00000001','测试大章2');
insert into chapter values ('00000003','00000000','测试大章3');
insert into chapter values ('00000004','00000000','测试大章4');
insert into chapter values ('00000005','00000000','测试大章5');
insert into chapter values ('00000006','00000000','测试大章6');
insert into chapter values ('00000007','00000000','测试大章7');
insert into chapter values ('00000008','00000000','测试大章8');
insert into chapter values ('00000009','00000000','测试大章9');
insert into chapter values ('00000010','00000000','测试大章10');
insert into chapter values ('00000011','00000000','测试大章11');
insert into chapter values ('00000012','00000001','测试大章12');
insert into chapter values ('00000013','00000001','测试大章13');
insert into chapter values ('00000014','00000001','测试大章14');
insert into chapter values ('00000015','00000001','测试大章15');
insert into chapter values ('00000016','00000001','测试大章16');
insert into chapter values ('00000017','00000001','测试大章17');
insert into chapter values ('00000018','00000001','测试大章18');
insert into chapter values ('00000019','00000001','测试大章19');