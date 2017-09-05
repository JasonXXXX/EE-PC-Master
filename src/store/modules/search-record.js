import types from '@/store/types'
import Storage from '@/common/util/storage'

const state = {
  searchs: [],
  records: [{
    value: '请输入关键字'
  }]
}

const getters = {
  searchs: state => state.searchs,
  records: state => state.records
}

const actions = {
}

const mutations = {
  [types.ADD_SEARCH_RECORD](state, record) {
    state.records.push(Object.freeze(record))

    state.records = Array.from(new Set(state.records))

    if (state.records.length > 8 || state.records[0].value === '请输入关键字') {
      state.records.splice(0, 1)
    }

    const recordsstr = JSON.stringify(state.records)
    console.log(recordsstr)
    localStorage.setItem(Storage.search_record, recordsstr)
  },
  [types.ADD_SEARCH_RECORDS](state, records) {
    records.forEach(item => {
      state.searchs.push(Object.freeze(item))
    })

    if (state.searchs.length > 8 || (state.searchs[0].value === '请输入关键字' && state.length > 1)) {
      state.searchs.splice(0, 1)
    }
  },
  [types.ADD_SEARCH_SEARCH](state, search) {
    state.searchs.push(Object.freeze(search))
  },
  [types.CLEAR_SEARCH_ALL](state, search) {
    state.searchs.splice(0, state.searchs.length)
    state.records.splice(0, state.records.length)
    console.log('搜索记录已清空')
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
