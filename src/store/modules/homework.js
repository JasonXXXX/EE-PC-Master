import types from '@/store/types'

const state = {
  homeworkUndone: [],
  homeworkDone: [],
  //记录当前浏览状态
  isdone: 'undone',
  homework: {}
}

const getters = {
  homeworkDone: state => state.homeworkDone,
  homeworkUndone: state => state.homeworkUndone,
  isHomeworkDone: state => state.isdone,
  getHomework: state => state.homework
}

const actions = {

}

const mutations = {
  //给数组添加元素
  [types.ADD_HOMEWORK_UNDONE](state, homeworks) {
    homeworks.forEach(item => {
      state.homeworkUndone.push(item)
    })
  },
  //给数组添加元素
  [types.ADD_HOMEWORK_DONE](state, homeworks) {
    homeworks.forEach(item => {
      state.homeworkDone.push(item)
    })
  },
  //更新作业类别
  [types.UPDATE_HOMEWORK_ISDONE](state, isdone) {
    state.isdone = isdone
  },
  //清空数组
  [types.CLEAR_HOMEWORK_HOMEWORKS](state) {
    state.homeworkDone.splice(0,state.homeworkDone.length)
    state.homeworkUndone.splice(0, state.homeworkUndone.length)
    state.isdone = 'undone'
    state.homework = null
    console.log('作业已清除')
  },
  //修改显示的作业
  [types.UPDATE_HOMEWORK_HOMEWORK](state, homework) {
    state.homework = homework
  },
  //更新作业列表
  [types.UPDATE_HOMEWORK_HOMEWORKS](state, homework) {
    if(state.isdone==='undone') {
      for(let i=0; i<state.homeworkUndone.length; i++) {
        if(state.homeworkUndone[i].id===homework.id) {
          state.homeworkUndone[i].content = homework.content
          state.homeworkUndone[i].uptime = homework.uptime
          console.log('原完成作业数:'+state.homeworkDone.length)
          state.homeworkDone.unshift(state.homeworkUndone[i])
          state.homeworkUndone.splice(i,1)
          return ;
        }
      }
    } else {
      for(let i=0; i<state.homeworkDone.length; i++) {
        if(state.homeworkDone[i].id===homework.id) {
          state.homeworkDone[i].content = homework.content
          state.homeworkDone[i].uptime = homework.uptime
          return ;
        }
      }
    }
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}