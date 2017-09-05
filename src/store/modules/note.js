import types from '@/store/types'

const state = {
  notes: [],
  draft: {},
  noteSelected: []
}

const getters = {
  notes: state => state.notes,
  noteSelected: state => state.noteSelected,
  //草稿
  draft: state => state.draft
}

const actions = {
}

const mutations = {
  //给数组添加元素
  [types.ADD_NOTE_NOTES](state, notes) {
    notes.forEach(item => {
      state.notes.push(item)
    })
  },
  //修改全局保存的note对象，即显示详情的那一个
  [types.UPDATE_NOTE_NOTE](state, note) {
    state.note = note
  },
  //修改全局保存的draft对象，即草稿
  [types.UPDATE_NOTE_DRAFT](state, draft) {
    console.log('保存草稿')
    state.draft = draft
  },
  //修改全局保存的notes数组，更新修改的那个笔记
  [types.UPDATE_NOTE_NOTES](state, note) {
    for (let i = 0; i < state.notes.length; i++) {
      if (note.note_id === state.notes[i].id) {
        state.notes[i].note_title = note.title
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
  [types.UPDATE_ADD_NOTE](state, note) {
    state.notes.push(note)
  },

  [types.DELETE_NOTE_SELECTED] (state, id) {
    state.noteSelected.every((item, index, arr) => {
      if (item===id) {
        arr.splice(index, 1)
        return false
      }
      return true
    })
  },
  [types.ADD_NOTE_SELECTED] (state, id) {
    state.noteSelected.push(id)
  },
  [types.DELETE_NOTE_NOTE] (state, id) {
    state.notes.every((item, index, arr) => {
      if (item.note_id === id) {
        arr.splice(index, 1)
        return false
      }
      return true
    })
  },
  [types.NOTE_SELECT_NONE] (state) {
    state.noteSelected.splice(0, state.noteSelected.length)
  },
  [types.NOTE_SELECT_ALL] (state) {
    state.noteSelected.splice(0, state.noteSelected.length)
    state.notes.forEach(item => {
      state.noteSelected.push(item.id)
    })
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}