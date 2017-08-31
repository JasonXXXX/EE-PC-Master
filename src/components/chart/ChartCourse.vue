<template>
  <div class="wrap">
    <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
      <el-menu-item class="wrap-menu-item" index="1">最近三个月</el-menu-item>
      <el-menu-item class="wrap-menu-item" index="2">全部</el-menu-item>
    </el-menu>
    <el-select class="wrap-select" v-model="year" placeholder="xxxx年" v-if="activeIndex==='2' && years.length" @change="handleYearChange">
      <el-option v-for="item in years" :key="item" :label="item" :value="item">
      </el-option>
    </el-select>
    <el-select class="wrap-select" v-model="month" placeholder="xx月" v-if="activeIndex==='2' && months.length" @change="handleMonthChange">
      <el-option v-for="item in months" :key="item" :label="item" :value="item">
      </el-option>
    </el-select>
    <canvas id="canvas"></canvas>
  </div>
</template>

<style lang="css" scoped>
  .wrap {
    flex: 1;
    margin: 0 4px;
    padding: 0 8px;
  }

  .wrap-menu-item,
  .wrap-select {
    overflow: hidden;
  }
</style>

<script>
import Draw from '@/common/util/chart'
import Handler from '@/common/util/handle-chart-datas'

export default {
  name: 'ChartCourse',
  data () {
    return {
      activeIndex: '1',
      ctx: null,
      courses: [
        {
          date: new Date('2015-06-18')
        },
        {
          date: new Date('2015-07-18')
        },
        {
          date: new Date('2015-08-18')
        },
        {
          date: new Date('2015-08-19')
        },
        {
          date: new Date('2016-03-18')
        },
        {
          date: new Date('2016-05-03')
        },
        {
          date: new Date('2016-08-28')
        },
        {
          date: new Date('2016-08-18')
        },
        {
          date: new Date('2017-01-12')
        },
        {
          date: new Date('2017-03-06')
        },
        {
          date: new Date('2017-03-16')
        },
        {
          date: new Date('2017-04-26')
        },
        {
          date: new Date('2017-05-22')
        },
        {
          date: new Date('2017-05-27')
        },
        {
          date: new Date('2017-06-28')
        },
        {
          date: new Date('2017-06-29')
        },
        {
          date: new Date('2017-06-30')
        },
        {
          date: new Date('2017-07-13')
        },
        {
          date: new Date('2017-07-19')
        },
        {
          date: new Date('2017-07-18')
        },
        {
          date: new Date('2017-08-01')
        },
        {
          date: new Date('2017-08-02')
        },
        {
          date: new Date('2017-08-02')
        },
        {
          date: new Date('2017-08-03')
        },
        {
          date: new Date('2017-08-04')
        },
        {
          date: new Date('2017-08-05')
        },
        {
          date: new Date('2017-08-06')
        },
        {
          date: new Date('2017-08-18')
        },
        {
          date: new Date('2017-08-18')
        },
        {
          date: new Date('2017-08-19')
        },
        {
          date: new Date('2017-08-20')
        },
        {
          date: new Date('2017-08-21')
        },
        {
          date: new Date('2017-08-22')
        },
        {
          date: new Date('2017-08-22')
        },
        {
          date: new Date('2017-08-23')
        },
        {
          date: new Date('2017-08-24')
        },
        {
          date: new Date('2017-08-25')
        },
        {
          date: new Date('2017-08-26')
        },
      ],
      year: '',
      years: [],
      month: '',
      months: [],
    }
  },
  created () {

  },
  mounted () {
    this.ctx = document.getElementById('canvas').getContext('2d')
    this.threeMonth()
  },
  methods: {
    handleSelect (select) {
      this.activeIndex = select
      if (select === '1') {
        this.threeMonth()
      } else {
        this.allTime()
      }
    },
    threeMonth () {
      this.ctx.height = this.ctx.height

      const data = Handler.courseLastThreeMonths(this.courses)
      const now = new Date().getMonth()
      Draw.drawChart(this.ctx, [(now - 2) + '月', (now - 1) + '月', (now) + '月'], data)
    },
    allTime () {
      // this.ctx.height = this.ctx.height

      const dl = this.getDataAndLabels(this.courses)
      if (dl) {
        if (dl.labels[0].includes('年')) {
          this.years = dl.labels
        } else if (dl.labels[0].includes('月')) {
          this.year = '' + dl.data[0].date.getFullYear()
          this.months = dl.labels
        } else { }
      } else { }

      Draw.drawChart(this.ctx, dl.labels, dl.data)
    },
    getDataAndLabels (dataset) {
      const m = Handler.metric(dataset)
      if (m) {
        const labels = Handler.renderLabels(dataset)

        let data

        switch (m.type) {
          case 'month':
            data = Handler.courseAllTime(dataset, m.type, labels.length, m.start)
            break
          case 'day-ellipse':
            data = Handler.courseAllTime(dataset, m.type, labels.length, m.end)
            break
          case 'day':
            data = Handler.courseAllTime(dataset, m.type, labels.length, m.end)
            break
          default:
            data = Handler.courseAllTime(dataset, m.type, labels.length)
            break
        }

        return {
          data: data,
          labels: labels
        }
      } else {
        return m
      }
    },
    handleYearChange (val) {
      // this.ctx.height = this.ctx.height

      const y = parseInt(val.substr(0, val.indexOf('年')))
      const dataset = this.courses.filter(item => item.date.getFullYear() == y)

      console.log(dataset)

      if (dataset.length) {
        const dl = this.getDataAndLabels(dataset)

        this.months = dl.labels
        this.month = ''

        Draw.drawChart(this.ctx, dl.labels, dl.data)
      } else {
        this.$message(val + '没有学习课程的记录')
      }
    },
    handleMonthChange (val) {
      // this.ctx.height = this.ctx.height

      const y = parseInt(this.year.substr(0, this.year.indexOf('年')))
      const m = parseInt(val.substr(0, val.indexOf('月'))) - 1
      const dataset = this.courses.filter(item => (item.date.getFullYear() === y && item.date.getMonth() === m))

      console.log(dataset)

      if (dataset.length) {
        const dl = this.getDataAndLabels(dataset)

        Draw.drawChart(this.ctx, dl.labels, dl.data)
      } else {
        this.$message(val + '没有学习课程的记录')
      }
    }
  },
  computed: {
  }
}
</script>
