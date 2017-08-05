import types from '@/store/types'

const state = {
  notes: [],
  note: {},
  draft: {}
}

const getters = {
  notes: state => state.notes,
  note: state => state.note,
  //草稿
  draft: state => state.draft
}

const actions = {
}

const mutations = {
  //给数组添加元素
  [types.ADD_NOTE_NOTES](state, { notes }) {
    notes.forEach(item => {
      state.notes.push(item)
    })
  },
  //修改全局保存的note对象，即显示详情的那一个
  [types.UPDATE_NOTE_NOTE](state, { note }) {
    state.note = note
  },
  //修改全局保存的draft对象，即草稿
  [types.UPDATE_NOTE_DRAFT](state, { draft }) {
    console.log('保存草稿')
    state.draft = draft
  },
  //修改全局保存的notes数组，更新修改的那个笔记
  [types.UPDATE_NOTE_NOTES](state, { note }) {
    for (let i = 0; i < state.notes.length; i++) {
      if (note.id === state.notes[i].id) {
        state.notes[i].title = note.title
        state.notes[i].set_time = note.set_time
        state.notes[i].content = note.content
        return;
      }
    }
  },
  //清空数组
  [types.CLEAR_NOTE_NOTES](state) {
    state.notes.splice(0, state.notes.length)
    state.note = null
    state.draft = null
    console.log('笔记已清除')
  },
  //添加笔记
  [types.UPDATE_ADD_NOTE](state, {note}) {
    state.notes.unshift(note)
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}