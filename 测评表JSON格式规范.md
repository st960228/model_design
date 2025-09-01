# 测评表JSON格式规范

## 概述

本文档定义了用于描述各类测评表的标准化JSON格式。该格式支持多种类型的测评表，包括领导人员考核、民主评议、推荐票等。

## 整体结构

```json
{
  "formInfo": { ... },
  "header": { ... },
  "body": { ... },
  "footer": { ... },
  "validation": { ... }
}
```

## 1. formInfo - 表单基本信息

### 字段说明

| 字段名 | 类型 | 必填 | 说明 | 示例 |
|--------|------|------|------|------|
| title | string | 是 | 表单标题 | "领导人员任期综合考核测评表" |
| organization | string | 是 | 组织单位名称 | "国网浙江省电力有限公司舟山供电公司" |
| period | string | 是 | 考核/评议期间 | "2022-2024年" |
| formCode | string | 是 | 表单编码 | "A" |
| qrCode | boolean | 否 | 是否显示二维码 | true/false |
| selections | object | 否 | 选择项定义集合 | - |

### 1.1 selections - 选择项定义

用于定义表单中所有可能用到的选择项，避免在单元格中重复定义。

#### 选择项结构

```json
{
  "selectOne": {
    "options": [
      {"value": "A", "label": "[A]"},
      {"value": "B", "label": "[B]"},
      {"value": "C", "label": "[C]"},
      {"value": "D", "label": "[D]"}
    ],
    "multiple": "false"
  },
  "selectTwo": {
    "options": [
      {"value": "1", "label": "好"},
      {"value": "2", "label": "较好"},
      {"value": "3", "label": "一般"},
      {"value": "4", "label": "差"}
    ],
    "multiple": "false"
  }
}
```

#### 字段说明

| 字段名 | 类型 | 必填 | 说明 | 示例 |
|--------|------|------|------|------|
| options | array | 是 | 选项数组 | - |
| multiple | string | 是 | 是否多选 | "true"/"false" |

### 示例

```json
{
  "formInfo": {
    "title": "领导人员任期综合考核测评表",
    "organization": "国网浙江省电力有限公司舟山供电公司",
    "period": "2022-2024年",
    "formCode": "A",
    "qrCode": true,
    "selections": {
      "selectOne": {
        "options": [
          {"value": "A", "label": "[A]"},
          {"value": "B", "label": "[B]"},
          {"value": "C", "label": "[C]"},
          {"value": "D", "label": "[D]"}
        ],
        "multiple": "false"
      }
    }
  }
}
```

## 2. header - 表头定义

### 字段说明

| 字段名 | 类型 | 必填 | 说明 | 可选项 |
|--------|------|------|------|--------|
| type | string | 是 | 表头类型 | "simple", "hierarchical" |
| columns | array | 是 | 列定义数组 | - |

### 2.1 type 类型说明

#### simple - 简单表头
- 单行表头
- 适用于简单的表格结构

#### hierarchical - 层次表头
- 多行表头
- 支持跨行跨列的复杂表头结构
- 使用 `rowspan` 和 `colspan` 属性

### 2.2 columns 列定义

#### 通用字段

| 字段名 | 类型 | 必填 | 说明 | 可选项 |
|--------|------|------|------|--------|
| id | string | 是 | 列唯一标识符 | - |
| title | string | 是 | 列标题 | - |
| width | string | 否 | 列宽度 | 百分比或像素值 |
| align | string | 否 | 对齐方式 | "left", "center", "right" |

#### 特殊字段

| 字段名 | 类型 | 必填 | 说明 | 适用类型 |
|--------|------|------|------|----------|
| rowspan | number | 否 | 跨行数 | hierarchical |
| colspan | number | 否 | 跨列数 | hierarchical |
| parentId | string | 否 | 父列ID | hierarchical |

### 示例

#### 简单表头
```json
{
  "header": {
    "type": "simple",
    "columns": [
      {
        "id": "name",
        "title": "姓名",
        "width": "15%",
        "align": "center"
      },
      {
        "id": "position",
        "title": "职务",
        "width": "15%",
        "align": "center"
      }
    ]
  }
}
```

#### 层次表头
```json
{
  "header": {
    "type": "hierarchical",
    "columns": [
      {
        "id": "name",
        "title": "姓名",
        "width": "8%",
        "align": "center",
        "rowspan": 2
      },
      {
        "id": "comprehensive",
        "title": "综合评价",
        "width": "32%",
        "align": "center",
        "colspan": 4
      },
      {
        "id": "excellent",
        "title": "优秀",
        "width": "8%",
        "align": "center",
        "parentId": "comprehensive"
      }
    ]
  }
}
```

## 3. body - 表格主体

### 字段说明

| 字段名 | 类型 | 必填 | 说明 | 可选项 |
|--------|------|------|------|--------|
| type | string | 是 | 主体类型 | "fixed" |
| rows | array | 是 | 行数据数组 | - |

### 3.1 type 类型说明

#### fixed - 固定行数
- 预定义的行数和结构
- 适用于标准化的测评表

### 3.2 rows 行定义

#### 行字段

| 字段名 | 类型 | 必填 | 说明 | 可选项 |
|--------|------|------|------|--------|
| id | string | 是 | 行唯一标识符 | - |
| type | string | 是 | 行类型 | "data", "empty" |
| cells | array | 是 | 单元格数组 | - |
| className | string | 否 | CSS类名 | - |
| validation | object | 否 | 行级验证规则 | - |

#### cells 单元格定义

| 字段名 | 类型 | 必填 | 说明 | 可选项 |
|--------|------|------|------|--------|
| columnId | string | 是 | 对应列ID | - |
| value | string | 是 | 单元格值 | - |
| type | string | 是 | 单元格类型 | "text", "input", "select" |
| readonly | boolean | 否 | 是否只读 | true/false |
| rowspan | number | 否 | 跨行数 | - |
| className | string | 否 | CSS类名 | - |
| selectRef | string | 否 | 选择项引用 | formInfo.selections中的键名 |

#### 单元格类型详解

##### text
- 纯文本显示
- 通常用于标题、说明文字等

##### input
- 文本输入框
- 用于填写姓名、职务等

##### select
- 选择器（统一radio和checkbox）
- 通过 `selectRef` 引用 `formInfo.selections` 中定义的选择项
- 单选/多选由引用的选择项定义决定

#### select类型配置

```json
{
  "columnId": "evaluation",
  "value": "",
  "type": "select",
  "selectRef": "selectOne"  // 引用formInfo.selections.selectOne
}
```

#### select类型渲染说明

根据 `selectRef` 的引用方式，单元格会有不同的渲染内容：

1. **单个选项渲染** - 当 `selectRef` 包含索引时
   - 格式：`"selectRef": "selectOne[1]"`
   - 含义：引用 `formInfo.selections.selectOne.options[1]`
   - 渲染内容：只显示单个选项，如 `[B]`
   - 适用于：需要显示特定选项的场景

2. **多个选项渲染** - 当 `selectRef` 不包含索引时
   - 格式：`"selectRef": "selectOne"`
   - 含义：引用整个 `formInfo.selections.selectOne`
   - 渲染内容：显示所有选项，如 `[A][B][C][D]`
   - 适用于：需要显示完整选项组的场景

#### 行类型详解

##### data - 数据行
- 包含实际数据的行
- 需要提供完整的cells数组

##### empty - 空行
- 用于填充空白行
- 通常用于预留填写空间

### 示例

```json
{
  "body": {
    "type": "fixed",
    "rows": [
      {
        "id": "row1",
        "type": "data",
        "cells": [
          {
            "columnId": "name",
            "value": "汪宇怀",
            "type": "text",
            "readonly": true
          },
          {
            "columnId": "excellent",
            "value": "",
            "type": "select",
            "selectRef": "selectOne"  // 渲染所有选项 [A][B][C][D]
          }
        ]
      }
    ]
  }
}
```

## 4. footer - 页脚说明

### 字段说明

| 字段名 | 类型 | 必填 | 说明 | 可选项 |
|--------|------|------|------|--------|
| notes | array | 否 | 说明文字数组 | - |

### 示例

```json
{
  "footer": {
    "notes": [
      "1. 副职中，评价为"优秀"的最多可选2人，多选将视为无效票。",
      "2. 政治、本领、担当、作风、廉洁过硬评价中，A为表现好10分；B为表现较好8分；C为表现一般6分；D为表现较差4分。",
      "3. 每一栏目各选项中只能选一项，请在相应选项括号内划圈(如[〇])。"
    ]
  }
}
```

## 5. validation - 验证规则

### 字段说明

| 字段名 | 类型 | 必填 | 说明 | 可选项 |
|--------|------|------|------|--------|
| rules | array | 否 | 验证规则数组 | - |

### 5.1 rules 规则定义

#### 规则字段

| 字段名 | 类型 | 必填 | 说明 | 可选项 |
|--------|------|------|------|--------|
| type | string | 是 | 规则类型 | "custom" |
| field | string | 是 | 验证字段 | - |
| message | string | 是 | 错误提示信息 | - |
| condition | string | 是 | 验证条件 | "unique", "exclusive_selection", "max_count:2" |

#### 验证条件详解

##### unique - 唯一性验证
- 确保某个字段的值在表格中唯一
- 适用于编码、姓名等字段

##### exclusive_selection - 互斥选择
- 确保同一行中只能选择一个选项
- 适用于单选按钮组

##### max_count:N - 最大数量限制
- 限制某个选项的最大选择数量
- N为具体数量

### 示例

```json
{
  "validation": {
    "rules": [
      {
        "type": "custom",
        "field": "code",
        "message": "人选不得重复",
        "condition": "unique"
      },
      {
        "type": "custom",
        "field": "excellent",
        "message": "副职中，评价为”优秀“的最多可选2人",
        "condition": "max_count:2"
      }
    ]
  }
}
```

## 6. 完整示例

### 领导班子任期综合考核测评表

```json
{
  "formInfo": {
    "title": "领导班子任期综合考核测评表",
    "organization": "国网浙江省电力有限公司舟山供电公司",
    "period": "2022-2024年",
    "formCode": "A",
    "qrCode": true,
    "selections": {
      "selectOne": {
        "options": [
          {"value": "A", "label": "[A]"},
          {"value": "B", "label": "[B]"},
          {"value": "C", "label": "[C]"},
          {"value": "D", "label": "[D]"}
        ],
        "multiple": "false"
      }
    }
  },
  "header": {
    "type": "hierarchical",
    "columns": [
      {
        "id": "name",
        "title": "姓名",
        "width": "8%",
        "align": "center",
        "rowspan": 2
      },
      {
        "id": "comprehensive",
        "title": "综合评价",
        "width": "32%",
        "align": "center",
        "colspan": 4
      },
      {
        "id": "excellent",
        "title": "优秀",
        "width": "8%",
        "align": "center",
        "parentId": "comprehensive"
      }
    ]
  },
  "body": {
    "type": "fixed",
    "rows": [
      {
        "id": "row1",
        "type": "data",
        "cells": [
          {
            "columnId": "name",
            "value": "汪宇怀",
            "type": "text",
            "readonly": true
          },
          {
            "columnId": "excellent",
            "value": "",
            "type": "select",
            "selectRef": "selectOne"  // 渲染所有选项 [A][B][C][D]
          },
          {
            "columnId": "excellent1",
            "value": "",
            "type": "select",
            "selectRef": "selectOne[1]"  // 只渲染[B]
          }
        ]
      }
    ]
  },
  "footer": {
    "notes": [
      "1. 每一栏目各选项中只能选一项，请在相应选项括号内划圈(如[〇])。"
    ]
  }
}
```

### 领导人员选拔任用工作民主评议表

```json
{
  "formInfo": {
    "title": "领导人员选拔任用工作民主评议表",
    "organization": "国网浙江省电力有限公司舟山供电公司",
    "period": "2024年",
    "formCode": "B",
    "qrCode": true,
    "selections": {
      "selectOne": {
        "options": [
          {"value": "1", "label": "好"},
          {"value": "2", "label": "较好"},
          {"value": "3", "label": "一般"},
          {"value": "4", "label": "差"}
        ],
        "multiple": "false"
      },
      "selectTwo": {
        "options": [
          {"value": "1", "label": "（1）政治素质过硬"},
          {"value": "2", "label": "（2）业务能力突出"},
          {"value": "3", "label": "（3）工作作风扎实"}
        ],
        "multiple": "true"
      }
    }
  },
  "header": {
    "type": "simple",
    "columns": [
      {
        "id": "item",
        "title": "评议内容",
        "width": "60%",
        "align": "left"
      },
      {
        "id": "result",
        "title": "评议结果",
        "width": "40%",
        "align": "center"
      }
    ]
  },
  "body": {
    "type": "fixed",
    "rows": [
      {
        "id": "row1",
        "type": "data",
        "cells": [
          {
            "columnId": "item",
            "value": "1. 政治素质",
            "type": "text",
            "readonly": true
          },
          {
            "columnId": "result",
            "value": "",
            "type": "select",
            "selectRef": "selectOne"
          }
        ]
      },
      {
        "id": "row8",
        "type": "data",
        "cells": [
          {
            "columnId": "item",
            "value": "8. 其他需要说明的情况",
            "type": "text",
            "readonly": true
          },
          {
            "columnId": "result",
            "value": "",
            "type": "select",
            "selectRef": "selectTwo"
          }
        ]
      }
    ]
  }
}
```
