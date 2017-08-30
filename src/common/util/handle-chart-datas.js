export default {
  metric(arr) {
    //根据数组数据进行划分,分别有按 年份/月份/天
    const first = arr[0].date
    const last = arr[arr.length - 1].date

    if (last.getFullYear() - first.getFullYear() > 0) {
      if (last.getFullYear() - first.getFullYear() > 11) {
        const len = last.getFullYear() - first.getFullYear()
        return {
          type: 'year-ellipse',
          metric: len
        }
      } else {
        return {
          type: 'year',
          start: first.getFullYear(),
          end: last.getFullYear()
        }
      }
    } else if (last.getMonth() - first.getMonth() > 0) {
      let start = 11, end = 0
      arr.forEach(item => {
        const nowmonth = item.date.getMonth()
        if (nowmonth < start) {
          start = nowmonth
        }
        if (nowmonth > end) {
          end = nowmonth
        }
      })
      return {
        type: 'month',
        start: start + 1,
        end: end + 1
      }
    } else {
      if (last.getDate() - first.getDate() > 11) {
        return {
          type: 'day-ellipse',
          start: first.getDate(),
          end: last.getDate()
        }
      } else {
        return {
          type: 'day',
          start: first.getDate(),
          end: last.getDate()
        }
      }
    }
  },
  renderLabels(arr) {
    //根据数组数据,生成labels
    const m = this.metric(arr)
    const labels = []
    switch (m.type) {
      case 'year-ellipse':
        const year = new Date().getFullYear()
        labels[0] = (year - 7) + '及以前'
        labels[1] = year - 6
        labels[2] = year - 5
        labels[3] = year - 4
        labels[4] = year - 3
        labels[5] = year - 2
        labels[6] = year - 1
        labels[7] = year
        break
      case 'year':
        for (let i = 0; i <= m.end - m.start; i++) {
          labels[i] = (m.start + i)
        }
        break
      case 'month':
        for (let i = 0; i <= m.end - m.start; i++) {
          labels[i] = (m.start + i) + '月'
        }
        break
      case 'day-ellipse':
        const day = m.end
        labels[0] = (day - 11) + '号及以前'
        labels[1] = (day - 10) + '号'
        labels[2] = (day - 9) + '号'
        labels[3] = (day - 8) + '号'
        labels[4] = (day - 7) + '号'
        labels[5] = (day - 6) + '号'
        labels[6] = (day - 5) + '号'
        labels[7] = (day - 4) + '号'
        labels[8] = (day - 3) + '号'
        labels[9] = (day - 2) + '号'
        labels[10] = (day - 1) + '号'
        labels[11] = day + '号'
        break
      case 'day':
        for (let i = 0; i <= m.end - m.start; i++) {
          labels[i] = (m.start + i) + '号'
        }
        break
      default:
        break
    }

    return labels
  },
  courseLastThreeMonths(courses) {
    //返回近三个月的学习情况
    const nowYear = new Date().getFullYear()
    const nowMonth = new Date().getMonth()

    const result = new Array(3)
    result.fill(0)

    courses.forEach(item => {
      if (nowYear === item.date.getFullYear() && nowMonth - item.date.getMonth() < 3) {
        result[(item.date.getMonth() + 1) % 3]++
      }
    })

    return result
  },
  courseAllTime(courses, type, len, start) {
    //返回全部的学习情况
    const nowYear = new Date().getFullYear()

    const result = new Array(len)
    result.fill(0)

    switch (type) {
      case 'year-ellipse':
        courses.forEach(item => {
          const year = item.date.getFullYear()
          if (year <= (nowYear - len + 1)) {
            result[0]++
          } else {
            result[(nowYear - year) % len]++
          }
        })
        break;
      case 'year':
        const firstyear = courses[0].date.getFullYear()
        courses.forEach(item => {
          result[(item.date.getFullYear() - firstyear) % len]++
        })
        break;
      case 'month':
        courses.forEach(item => {
          result[(item.date.getMonth() - start + 1) % len]++
        })
        break;
      case 'day-ellipse':
        courses.forEach(item => {
          const day = item.date.getDate()
          if (day <= (start - len)) {
            result[0]++
          } else {
            result[len - (start - day) - 1]++
          }
        })
        break;
      case 'day':
        courses.forEach(item => {
          result[len - (start - item.date.getDate()) - 1]++
        })
        break;
    }

    return result
  }
}