import types from '@/store/types'

const state = {
  homeworkUndone: [],
  homeworkDone: [],
  isdone: false,
  undonecalled: false,
  donecalled: false,
  homeworkSelected: []
}

const getters = {
  isdone: state => state.isdone,
  homeworkDone: state => state.homeworkDone,
  homeworkUndone: state => state.homeworkUndone,
  undonecalled: state => state.undonecalled,
  donecalled: state => state.donecalled,
  homeworkSelected: state => state.homeworkSelected
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
  //更新作业加载情况
  [types.UPDATE_HOMEWORK_UNDONECALLED](state, undonecalled) {
    state.undonecalled = undonecalled
  },
  //更新作业加载情况
  [types.UPDATE_HOMEWORK_DONECALLED](state, donecalled) {
    state.donecalled = donecalled
  },
  //清空数组
  [types.CLEAR_HOMEWORK_HOMEWORKS](state) {
    state.homeworkDone.splice(0,state.homeworkDone.length)
    state.homeworkUndone.splice(0, state.homeworkUndone.length)
    state.isdone = false
    state.homework = null
    console.log('作业已清除')
  },
  //修改显示的作业
  [types.UPDATE_HOMEWORK_HOMEWORK](state, homework) {
    state.homework = homework
  },
  //更新作业列表
  [types.UPDATE_HOMEWORK_HOMEWORKS](state, homework) {
    if(!state.isdone) {
      for(let i=0; i<state.homeworkUndone.length; i++) {
        if(state.homeworkUndone[i].id===homework.id) {
          state.homeworkUndone[i].work_anser = homework.content
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
  },
  [types.DELETE_HOMEWORK_SELECTED] (state, id) {
    state.homeworkSelected.every((item, index, arr) => {
      if (item===id) {
        arr.splice(index, 1)
        return false
      }
      return true
    })
  },
  [types.DELETE_HOMEWORK_HOMEWORK] (state, payload) {
    if (payload.mark) {
      //mark为true时,说明是已完成的作业,清空答案后加入未完成的作业
      state.homeworkDone.every((item, index, arr) => {
      if (item.id===payload.id) {
        let data = {
          id: item.id,
          title: item.title,
          uptime: item.uptime,
          content: ''
        }
        state.homeworkUndone.unshift(data)
        arr.splice(index, 1)
        return false
      }
      return true
    })
    }
  },
  [types.ADD_HOMEWORK_SELECTED] (state, id) {
    state.homeworkSelected.push(id)
  },
  [types.HOMEWORK_SELECT_NONE] (state) {
    state.homeworkSelected.splice(0, state.homeworkSelected.length)
  },
  [types.HOMEWORK_SELECT_ALL] (state, mark) {
    state.homeworkSelected.splice(0, state.homeworkSelected.length)

    if (mark) {
      //为真表示当前是未完成作业
      state.homeworkUndone.forEach(item => {
        state.homeworkSelected.push(item.id)
      })
    } else {
      state.homeworkDone.forEach(item => {
        state.homeworkSelected.push(item.id)
      })
    }
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}