import types from '@/store/types'
import Storage from '@/common/util/storage'

const state = {
  searchs: [{
    value: '请输入关键字'
  }]
}

const getters = {
  searchs: state => state.searchs
}

const actions = {
}

const mutations = {
  [types.ADD_SEARCH_RECORD](state, record) {
    state.searchs.push(Object.freeze(record))
    if (state.searchs.length > 8 || state.searchs[0].value === '请输入关键字') {
      state.searchs.splice(0, 1)
    }

    const records = JSON.stringify(state.searchs)
    console.log(records)
    localStorage.setItem(Storage.search_record, records)
  },
  [types.ADD_SEARCH_RECORDS](state, records) {
    records.forEach(item => {
      state.searchs.push(Object.freeze(item))
    })
    if (state.searchs.length > 8 || (state.searchs[0].value === '请输入关键字' && state.length > 1)) {
      state.searchs.splice(0, 1)
    }
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}