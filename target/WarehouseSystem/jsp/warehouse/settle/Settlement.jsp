<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>仓储物流系统</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/jsp/include/header.jsp"/>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                <ul class="layui-tab-title">
                    <li class="layui-this">日结算收入报表（租金）</li>
                    <li>日结算收入报表（非租金）</li>
                    <li>支出报表</li>
                    <li>扣款报表</li>
                </ul>
                <div class="layui-tab-content" style="height: 500px;">
                    <div class="layui-tab-item layui-show">
                        <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                        <div id="main" style="width: 100%; height: 500px;"></div>
                    </div>
                    <div class="layui-tab-item">内容2</div>
                    <div class="layui-tab-item">内容3</div>
                    <div class="layui-tab-item">内容4</div>
                    <div class="layui-tab-item">内容5</div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/jsp/include/footer.jsp"/>

</div>
<!-- 引入jquery.js -->
<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<!-- 引入 echarts.js -->
<script  src="${ctx}/static/echarts/echarts.min.js"></script>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<%--<script type="text/javascript">--%>

<%--</script>--%>

<script>
    //JavaScript代码区域
    layui.use(['element','jquery'], function(){
        var element = layui.element;
        $ =layui.jquery;

        var myChart = echarts.init(document.getElementById('main'));
        // 显示标题，图例和空的坐标轴
        myChart.setOption({
            title: {
                text: "结算收入报表（租金）",
                x: "center",
                textStyle: {
                    fontSize: 29
                }
            },
            tooltip: {
                trigger: "axis",
                show: true
            },
            toolbox: {
                show: true,
                feature: {

                    saveAsImage: {
                        show: true
                    }
                },
                itemSize: 35,
                showTitle: true
            },
            calculable: true,
            xAxis: [
                {
                    type: "category",
                    data: ["某公司", "某公司", "某公司", "某公司", "某公司", "某公司", "某公司", "某公司", "某公司", "某公司", "某公司", "某公司"],
                    name: "某公司的合同",
                    axisTick: {
                        show: false
                    },
                    axisLabel: {
                        show: true,
                        textStyle: {
                            fontSize: 22
                        }
                    },
                    nameTextStyle: {
                        fontSize: 29
                    }
                }
            ],
            yAxis: [
                {
                    type: "value",
                    name: "租金",
                    splitLine: {
                        show: true
                    },
                    axisTick: {
                        show: true,
                        inside: true
                    },
                    nameTextStyle: {
                        fontSize: 25
                    },
                    scale: true,
                    axisLabel: {
                        textStyle: {
                            fontSize: 25
                        }
                    }
                }
            ],
            series: [
                {
                    type: "bar",
                    name: "租金",
                    data: [2.6, 5.9, 9, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6, 2.3],
                    itemStyle: {
                        normal: {
                            label: {
                                show: true,
                                position: "top",
                                textStyle: {
                                    fontSize: 19
                                }
                            }
                        }
                    }
                }
            ]
        });
    });
</script>
</body>
</html>

