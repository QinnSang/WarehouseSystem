
<script>
    // 自定义模块
    layui.config({
        base: '${ctx}/static/layuiExtend/'   // 模块根目录
    }).extend({                         // 模块别名
        soulTable: 'soulTable/soulTable', //js在根目录下的位置
        tableFilter:'soulTable/tableFilter',
        excel:'soulTable/excel',
        tableChild:'soulTable/tableChild',
        tableMerge:'soulTable/tableMerge',
        dropdown:'dropdown/dropdown'
    });
</script>
