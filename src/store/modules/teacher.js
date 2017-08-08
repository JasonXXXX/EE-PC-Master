import types from '@/store/types'

const state = {
  teachers: [],
  teachermark: 1
}

const getters = {
  teachers: state => state.teachers,
  teachermark: state => state.teachermark
}

const actions = {
}

const mutations = {
  //给数组添加元素
  [types.ADD_TEACHER_CHINA] (state, teachers) {
    teachers.forEach(item => {
      state.teachers.push(Object.freeze(item))
    })
  },
  [types.UPDATE_TEACHER_TEACHERMARK](state, mark) {
    state.teachermark = mark
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}