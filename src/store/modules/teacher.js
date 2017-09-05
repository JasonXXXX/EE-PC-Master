import types from '@/store/types'

const state = {
  teachers: [],
  teachermark: 1,
  teacherid: 1,
}

const getters = {
  teachers: state => state.teachers,
  teachermark: state => state.teachermark,
  teacherid: state => state.teacherid,
}

const actions = {
}

const mutations = {
  //给数组添加元素
  [types.ADD_TEACHER_CHINA] (state, teachers) {
    teachers.forEach(item => {
      state.teachers.push(Object.freeze(item))

      state.teachers = Array.from(new Set(state.teachers))
    })
  },
  [types.UPDATE_TEACHER_TEACHERMARK](state, mark) {
    state.teachermark = mark
  },
  [types.UPDATE_TEACHER_TEACHERID](state, id) {
    state.teacherid = id
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
