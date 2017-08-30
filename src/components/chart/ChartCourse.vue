<template>
  <div class="wrap">
    <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
      <el-menu-item class="wrap-menu-item" index="1">最近三个月</el-menu-item>
      <el-menu-item class="wrap-menu-item" index="2">全部</el-menu-item>
    </el-menu>
    <canvas id="canvas-threemonth" v-show="activeIndex==='1'"></canvas>
    <canvas id="canvas-alltime" v-show="activeIndex==='2'"></canvas>
  </div>
</template>

<style lang="css" scoped>
  .wrap {
    flex: 1;
    margin: 0 4px;
    padding: 0 8px;
    /* box-shadow: 1px 1px 8px #BBBBBB; */
  }

  .wrap-menu-item {
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
          date: new Date('2015-08-18')
        },
        {
          date: new Date('2016-06-18')
        },
        {
          date: new Date('2016-07-18')
        },
        {
          date: new Date('2016-08-18')
        },
        {
          date: new Date('2016-08-18')
        },
        {
          date: new Date('2017-01-16')
        },
        {
          date: new Date('2017-03-16')
        },
        {
          date: new Date('2017-03-16')
        },
        {
          date: new Date('2017-04-16')
        },
        {
          date: new Date('2017-05-16')
        },
        {
          date: new Date('2017-05-16')
        },
        {
          date: new Date('2017-06-18')
        },
        {
          date: new Date('2017-06-16')
        },
        {
          date: new Date('2017-06-18')
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
      item: ''
    }
  },
  created () {

  },
  mounted () {
    this.ctx = document.getElementById('canvas-threemonth').getContext('2d')
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
      this.ctx = document.getElementById('canvas-threemonth').getContext('2d')

      const data = Handler.courseLastThreeMonths(this.courses)
      const now = new Date().getMonth()
      Draw.drawChart(this.ctx, [(now - 1) + '月', now + '月', (now + 1) + '月'], data)
    },
    allTime () {
      this.ctx = document.getElementById('canvas-alltime').getContext('2d')

      const m = Handler.metric(this.courses)
      const labels = Handler.renderLabels(this.courses)

      let data

      switch (m.type) {
        case 'month':
          // for (let i = 0; i <= m.end - m.start; i++) {
          //   labels[i] = (m.start + i) + '月'
          // }
          data = Handler.courseAllTime(this.courses, m.type, labels.length, m.start)
          break
        case 'day-ellipse':
          // const day = m.end
          // labels[0] = (day - 11) + '号及以前'
          // labels[1] = (day - 10) + '号'
          // labels[2] = (day - 9) + '号'
          // labels[3] = (day - 8) + '号'
          // labels[4] = (day - 7) + '号'
          // labels[5] = (day - 6) + '号'
          // labels[6] = (day - 5) + '号'
          // labels[7] = (day - 4) + '号'
          // labels[8] = (day - 3) + '号'
          // labels[9] = (day - 2) + '号'
          // labels[10] = (day - 1) + '号'
          // labels[11] = day + '号'
          // console.log('end=' + m.end)
          data = Handler.courseAllTime(this.courses, m.type, labels.length, m.end)
          break
        case 'day':
          // for (let i = 0; i <= m.end - m.start; i++) {
          //   labels[i] = (m.start + i) + '号'
          // }
          data = Handler.courseAllTime(this.courses, m.type, labels.length, m.end)
          break
        default:
          data = Handler.courseAllTime(this.courses, m.type, labels.length)
          break
      }
      const _courses = this.courses
      Draw.drawChartWithFunctions(this.ctx, labels, data, {
        clickYear (e, legendItem) {
          const label = legendItem[0]._model.label
        }
      })
    }
  },
  watch: {
    item (oldVal, newVal) {
      console.log(oldVal, newVal)
    }
  }
}
</script>
