class calender {
    // 构造集成
    constructor(opts) {
        let opt = {
            'parent' : "",
            'width'  : 545
        }
        // 获取时间
        this.date   = new Date()
        // 获取当前月份
        this.Month  = this.date.getMonth()
        // 获取当前年份
        this.Year   = this.date.getFullYear()
        // 当前日期 
        this.day    = ""
        // 模板初始
        this.template = `<table class='hxcrltable' cellpadding='0' cellspacing='0'></table>`
        // 合并数据
        this.settings = $.extend(opt, opts, {})
        // 渲染日历
        this.render(this.Month, this.Year)
        // 操作上下月日历
        this.bindEvent()
        
    }

    render(Month, Year){
        let  day  = this.date.getDate()
        this.day = this.day || day
        console.log(this.settings.data)
        
        let firstDay = new Date(Year, Month, 1)
        let firstDayWeek  = firstDay.getDay()
        let isleapyear = this.isLeapYear(Year)
        let monthDay = [31, 28 + isleapyear, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        let trSize   = Math.ceil((monthDay[Month] + firstDayWeek) / 7) //获取当月所需行数
        let i        = 0
        let param    = $(`<div style="width:${this.settings.width}px"></div>`)
        let $table    = $(this.template)
        let currentYear = this.date.getFullYear()
        let currentMonth = this.date.getMonth()

        $(this.weekCont()).appendTo($table)
        for(; i< trSize; i++) {
            var $trCont = $("<tr class='hxcrltr" + i + "'></tr>")

            for(let k=0; k < 7; k++) {
                let tdNum = i * 7 + k
                let tdDay =  tdNum - firstDayWeek + 1
                let tdCont = ""
                tdDay  = (tdDay <= 0 || tdDay > monthDay[Month]) ? "&nbsp;": tdNum - firstDayWeek + 1

                //判断是否为当天，并高亮显示，如修改可直接修改td内联样式即可
                if(currentYear === this.Year && currentMonth === this.Month && tdDay == day) {
                    tdCont =  this.curDataRander(tdDay)
                } else {
                    tdCont = this.renderDay(tdDay)
                }

                $(tdCont).appendTo($trCont)

                $(this.settings.parent).find('tr:not(:lt(2)) td').each(()=> {
                    if (tdDay < day) {
                        $(this).css("color", "#ccc")
                    }
                })
            }
            $($trCont).appendTo($table) 
        }

        
        $(this.headerCont(Month, Year, this.day, firstDayWeek)).appendTo(param)
        $table.appendTo(param)

        this.settings.parent.html(param)

        // 触发当前点击日期
        this.curDay()
    }

    renderDay(tdDay) {
        var randerData = this.uploadData(this.settings.data)

        for(let key in randerData) {
            if(Number(tdDay) == key) {
                let  randerValue = randerData[key]
                return tdDay == this.day && !!this.settings.curDate ? "<td class='cur' data-eventNo='"+ randerValue['eventNo']+"' data-eventTitle = '"+randerValue['eventTitle']+"' ><span class='b-b-s'>" + tdDay + "</span></td>" : "<td><span class='b-b-s' data-eventNo='"+ randerValue['eventNo']+"' data-eventTitle = '"+randerValue['eventTitle']+"' >" + tdDay + "</span></td>"
            }
        }
        return tdDay == this.day&& !!this.settings.curDate ? "<td class='cur'><span>" + tdDay + "</span></td>" : "<td><span>" + tdDay + "</span></td>"
    }

    curDataRander(tdDay){
        var randerData = this.uploadData(this.settings.data)
        for(let key in randerData) {
            if(Number(tdDay) == key) {
                let  randerValue = randerData[key]
                return "<td  class='active' data-eventNo='"+ randerValue['eventNo']+"' data-eventTitle = '"+randerValue['eventTitle']+"' ><span class='b-b-s'>" + tdDay + "</span></td>" 
            }
        }
        return "<td  class='active'><span>" + tdDay + "</span></td>"
    }

    headerCont(Month, Year, day){
        let firstDayWeek = new Date(Year, Month, day).getDay()
        // 设置日历头
        let  arrWeek = ['星期日','星期一','星期二','星期三','星期四','星期五','星期六']
        return `<div class="dateHeader clearfix">
                    <div class="weekDay">
                        <span class="day">${day}</span>
                        <span class="week">${arrWeek[firstDayWeek]}</span>
                    </div>
                    <div class="yearDate">
                        <span class="btnLeft cPointer"><i class="icon iconfont icon-shangxiazuoyou-3"></i></span>
                        <span class="yearDateCont">${Year}年${Month+1}月</span>
                        <span class="btnRight cPointer"><i class="icon iconfont icon-shangxiazuoyou-"></i></span>
                    </div>
                </div>`
    }
    
    //渲染星期内容
    weekCont(){
        //星期内容
        return `<thead>
                    <tr>
                        <th>日</th>
                        <th>一</th>
                        <th>二</th>
                        <th>三</th>
                        <th>四</th>
                        <th>五</th>
                        <th>六</th>
                    </tr>
                </thead>
                `
    }
    //判断是否为闰年
    isLeapYear(year) {
        return (year % 100 == 0 ? (year % 400 == 0 ? 1 : 0) : (year % 4 == 0 ? 1 : 0))
    }

     // 触发当前点击日期
     curDay() {
        $('td', this.settings.parent).hover(
            (event)=> {
                if(event.target.tagName.toLowerCase() === 'td') {
                    var curstart = ( $(event.target).attr('class') && $(event.target).attr('class').indexOf('active')) > -1 ? true : ""
                    this.settings.callback && this.settings.callback(event, curstart)
                    this.settings.callback && this.position(event)
                }
            },
            (event) => {
                $('.dataFixed', '.hxcrltable').remove()
            }
        )
    }

    // 往期日期
    prevDate(){
        if(this.Month > 0) {
            this.Month -= 1
        } else {
            this.Month = 11
            this.Year -= 1
        }

        this.settings.parent.trigger("prevDate")   
    }

    // 以后的日期
    nextDate() {
        if(this.Month < 11) {
            this.Month += 1
        } else {
            this.Month = 0
            this.Year += 1
        }
        this.settings.parent.trigger("nextDate")
        
    }
   // 更新切换日期的数据
    bindRander(opts){
        // 如果opts为空或者opts未穿 要做处理
        !!opts && (this.settings = $.extend(this.settings, opts, {}))
        this.render(this.Month, this.Year)
    }

    // 绑定上下月日期更新
    bindEvent() {
        this.settings.parent.on("click", "span.btnLeft", this.prevDate.bind(this, this.Year, this.Month));
        this.settings.parent.on("click", "span.btnRight", this.nextDate.bind(this, this.Year, this.Month));
    }

    // 绑定触发事件
    on(envetName, callback) {
        this.settings.parent.on(envetName, function() {
            callback(this)
        }.bind(this));
    }

    //更新数据
    uploadData(data){
        var obj = {}
        for(let value of data) {
            if(obj[value.day]) {
                obj[value.day].eventNo.push(value.eventNo)
                obj[value.day].eventTitle.push(value.eventTitle)
            } else {
                obj[value.day] = {}
                obj[value.day].eventNo = [].concat(value.eventNo)
                obj[value.day].eventTitle = [].concat(value.eventTitle)
            }
        }
        return obj
    }

    //浮层定位
    position(event){
        console.log(event)
    }
}
