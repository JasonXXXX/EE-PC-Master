import types from '@/store/types'

const state = {
  microlecture: [],
  curriculum: [],
  //记录当前浏览的记录
  isdone1: 1
}

const getters = {
  microlecture: state => state.microlecture,
  curriculum: state => state.curriculum,
  isdone1: state => state.isdone1
}

const actions = {

}

const mutations = {
  //给数组添加元素
  [types.ADD_CBROOM_MICROLECTURE](state, { microlectures }) {
    for (let i = 0; i < microlectures.length; i++) {
      state.microlecture.push(Object.freeze(microlectures[i]))
    }
  },
  //给数组添加元素
  [types.ADD_CBROOM_CURRICULUM](state, { curriculums }) {
    for (let i = 0; i < curriculums.length; i++) {
      state.curriculum.push(Object.freeze(curriculums[i]))
    }
  },
  //更新课程类别
  [types.UPDATE_CBROOM_ISDONE](state, isdone1) {
    state.isdone1 = isdone1;
  },
  //清空数组
  [types.CLEAR_CBROOM_CBROOM](state) {
    state.microlecture.splice(0,state.microlecture.length)
    state.curriculum.splice(0, state.curriculum.length)
    state.isdone1 = 1
    console.log('课程已清除')
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}