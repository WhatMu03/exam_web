/*锁定列位置控制*/
function fixedRow(){ 
  var h1 = $(".datagrid-view0").width();
  var h2 = $(".datagrid-view2").width();
  var h3 = $(".datagrid-view1").width();
  $(".datagrid-view1").css({'float':'left'});
  $(".datagrid-view2").css("right", h3 + 1 + 'px');
} 
/*datagrid表格中有固定列时中间部分有竖向滚动条时最后一列不对齐*/
function register(){
    $(".datagrid-header").find("table").css("width","100%");
    var d = $(".datagrid-view2");
    for(var i=0;i<d.length;i++){
        var flag=$(d[i]).find(".datagrid-header").find("td").siblings("div");
        if(flag.length>0){
            $(d[i]).find(".datagrid-header").find("td").siblings("div").remove();
        }
        var h1=$(d[i]).find(".datagrid-body").height();
        var h2=$(d[i]).find(".datagrid-body").find("table").height();
        if (h1 < h2 ) {
           $(".datagrid-view2 .datagrid-header-inner .datagrid-htable").attr("style","padding-right:7px;width:100%;")
        }
    }

    /*给表格表头添加title提示*/
    var div = $(".datagrid-header").find(".datagrid-cell");
    $.each(div,function(i,ele){
        var span=$(ele).find("span");
        $($(span)[0]).prop("title",$($(span)[0]).html());
    })
}

//文字过长省略号显示
function title(){
    var node=$(".formatTitleTxt");
    for(var i=0;i<node.length;i++){
        $(node[i]).prop("title",$(node[i]).text());
    }
}
//过长文字省略号显示，鼠标移上去title显示完整文字
var formatTitleTxt = function(value){
    if(value){
        return '<span class=\'formatTitleTxt\' title='+value+'>'+value+'</span>';
    }
    return '<span class=\'formatTitleTxt\' title='+value+'>'+'</span>';
}   
