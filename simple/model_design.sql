/*
    暂时没定义业务相关字段，只定义了测评模版配置及统计相关字段
*/

CREATE TABLE `evaluation_template`
(
    `id`                bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `type`              varchar(64)    NOT NULL DEFAULT '' COMMENT '测评模版类型',
    `template_json`     varchar(2048)  NOT NULL DEFAULT '' COMMENT '测评模版json',
    `version`           int            NOT NULL DEFAULT '0' COMMENT '测评模版版本',
    `first_remark`      varchar(64)    NOT NULL DEFAULT '' COMMENT '备用字段1',
    `second_remark`     varchar(64)    NOT NULL DEFAULT '' COMMENT '备用字段2',
    `is_delete`         tinyint        NOT NULL default '0' COMMENT '是否删除, 1 是 0 否',
    `create_time`       datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`       datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    KEY `type` (`type`)
) ENGINE = InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci
COMMENT ='测评模版表';

CREATE TABLE `evaluation_template_selection`
(
    `id`                bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `template_id`       bigint(20)     NOT NULL DEFAULT '0' COMMENT '测评模版id',
    `bind_props`        varchar(64)    NOT NULL DEFAULT '' COMMENT '选项绑定的 props 属性',
    `selection_label`   varchar(128)    NOT NULL DEFAULT '' COMMENT '选项标签',
    `selection_value`   varchar(64)    NOT NULL DEFAULT '' COMMENT '选项值',
    `selection_score`   varchar(64)    NOT NULL DEFAULT '' COMMENT '选项分数',
    `first_remark`      varchar(64)    NOT NULL DEFAULT '' COMMENT '备用字段1',
    `second_remark`     varchar(64)    NOT NULL DEFAULT '' COMMENT '备用字段2',
    `is_delete`         tinyint        NOT NULL default '0' COMMENT '是否删除, 1 是 0 否',
    `create_time`       datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`       datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    KEY `template_id` (`template_id`),
    KEY `selection_value` (`selection_value`)
) ENGINE = InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci
COMMENT ='测评模版选项配置表';

CREATE TABLE `evaluation_template_data`
(
    `id`                bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `template_id`       bigint(20)     NOT NULL DEFAULT '0' COMMENT '测评模版id',
    `user_id`           varchar(64)    NOT NULL DEFAULT '' COMMENT '测评填写用户id',
    `data_json`         varchar(4096)  NOT NULL DEFAULT '' COMMENT '测评填写数据json',
    `first_remark`      varchar(64)    NOT NULL DEFAULT '' COMMENT '备用字段1',
    `second_remark`     varchar(64)    NOT NULL DEFAULT '' COMMENT '备用字段2',
    `is_delete`         tinyint        NOT NULL default '0' COMMENT '是否删除, 1 是 0 否',
    `create_time`       datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`       datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    KEY `template_id` (`template_id`),
    KEY `user_id` (`user_id`),
    KEY `unique_id` (`unique_id`),
    KEY `bind_props` (`bind_props`)
) ENGINE = InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci
COMMENT ='测评数据表';

CREATE TABLE `evaluation_template_data_statistics`
(
    `id`                bigint(20)     NOT NULL AUTO_INCREMENT COMMENT '主键',
    `template_id`       bigint(20)     NOT NULL DEFAULT '0' COMMENT '测评模版id',
    `user_id`           varchar(64)    NOT NULL DEFAULT '' COMMENT '测评填写用户id',
    `unique_id`         varchar(64)    NOT NULL DEFAULT '' COMMENT '测评数据唯一标识',
    `bind_props`        varchar(64)    NOT NULL DEFAULT '' COMMENT '测评数据绑定 props 属性',
    `data_content`    varchar(2048)    NOT NULL DEFAULT '' COMMENT '测评数据内容',
    `first_remark`      varchar(64)    NOT NULL DEFAULT '' COMMENT '备用字段1',
    `second_remark`     varchar(64)    NOT NULL DEFAULT '' COMMENT '备用字段2',
    `is_delete`         tinyint        NOT NULL default '0' COMMENT '是否删除, 1 是 0 否',
    `create_time`       datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`       datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`),
    KEY `template_id` (`template_id`),
    KEY `unique_id` (`unique_id`),
    KEY `bind_props` (`bind_props`),
    KEY `user_id` (`user_id`)
) ENGINE = InnoDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci
COMMENT ='测评数据统计表';


// 设计一个视图，用于查询测评数据统计表
CREATE VIEW `evaluation_template_data_statistics_view` AS
SELECT * FROM `evaluation_template_data_statistics`
WHERE `is_delete` = 0;



