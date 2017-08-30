/**
 * 封装对chart.js的使用
 */

import 'chart.js'

const defaultChartType = 'bar'

const labels = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']

const defaultDataLabel = 'HIDE'

const defaultBackgroundColor = [
  'rgba(255, 99, 132, 0.2)',
  'rgba(54, 162, 235, 0.2)',
  'rgba(255, 206, 86, 0.2)',
  'rgba(75, 252, 102, 0.2)',
  'rgba(153, 102, 255, 0.2)',
  'rgba(255, 01, 01, 0.2)',
  'rgba(0, 0, 255, 0.2)',
  'rgba(0, 255, 0, 0.2)',
  'rgba(255, 206, 86, 0.2)',
  'rgba(75, 192, 192, 0.2)',
  'rgba(153, 102, 255, 0.2)',
  'rgba(255, 159, 64, 0.2)',
]

const defaultBorderColor = [
  'rgba(255, 99, 132, 1)',
  'rgba(54, 162, 235, 1)',
  'rgba(255, 206, 86, 1)',
  'rgba(75, 252, 102, 1)',
  'rgba(153, 102, 255, 1)',
  'rgba(255, 01, 01, 1)',
  'rgba(0, 0, 255, 1)',
  'rgba(0, 255, 0, 1)',
  'rgba(255, 206, 86, 1)',
  'rgba(75, 192, 192, 1)',
  'rgba(153, 102, 255, 1)',
  'rgba(255, 159, 64, 1)',
]

const defaultOptions = {
  scales: {
    yAxes: [
      {
        ticks: {
          beginAtZero: true
        }
      }
    ]
  }
}

export default {
  draw(element, type, data, options) {
    return new Chart(element, {
      type: type,
      data: data,
      options: options
    })
  },
  drawChart(ele, labels, data, options, bdwidth, type, datalabel) {
    return this.draw(ele, type || defaultChartType, {
      labels: labels,
      datasets: [
        {
          label: datalabel || defaultDataLabel,
          data: data,
          backgroundColor: defaultBackgroundColor.slice(0, labels.length),
          borderColor: defaultBorderColor.slice(0, labels.length),
          borderWidth: bdwidth || 1
        }
      ]
    }, options || defaultOptions)
  },
  drawChartWithFunctions(ele, labels, data, functions, type) {
    return this.draw(ele, type || defaultChartType, {
      labels: labels,
      datasets: [
        {
          label: defaultDataLabel,
          data: data,
          backgroundColor: defaultBackgroundColor.slice(0, labels.length),
          borderColor: defaultBorderColor.slice(0, labels.length),
          borderWidth: 1
        }
      ]
    }, {
        yAxes: [
          {
            ticks: {
              beginAtZero: true
            }
          }
        ],
        onClick: functions.clickYear
      })
  }
}