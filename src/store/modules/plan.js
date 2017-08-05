import types from '@/store/types'

const state = {
  plan: {},
  draft: {}
}

const getters = {
  getPlan: state => state.plan,
  getPlanDraft: state => state.draft
}

const actions = {
}

const mutations = {
  //修改计划
  [types.UPDATE_PLAN](state, { plan }) {
    state.plan = plan
  },
  //保存计划的草稿
  [types.UPDATE_PLAN_DRAFT](state, { draft }) {
    state.draft = draft
  },
  [types.CLEAR_PLAN_PLAN](state) {
    state.plan = null
    state.draft = null
    console.log('计划已清除')
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}