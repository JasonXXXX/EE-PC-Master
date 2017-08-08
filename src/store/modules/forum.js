import types from '@/store/types'
import atypes from '@/store/action-types'
import {loadFavorite, saveFavorite, deleteFavorite} from '@/common/util/cache'

const state = {
  forums: [],
  favoriteList: loadFavorite(),
  forumState: 1
}

const getters = {
  forums: state => state.forums,
  forumState: state => state.forumState,
  favoriteList: state => state.favoriteList,
}

const actions = {
  [atypes.SAVE_FAVORITE_LIST]({commit}, detail) {
    commit(types.SET_FAVORITE_LIST, saveFavorite(detail))
  },

  [atypes.DELETE_FAVORITE_LIST]({commit}, detail) {
    commit(types.SET_FAVORITE_LIST, deleteFavorite(detail))
  }
}

const mutations = {
  //给数组添加元素
  [types.ADD_FORUM_NEWS](state, forums) {
    forums.forEach(item => {
      state.forums.push(Object.freeze(item))
    })
  },
  [types.ADD_FORUM_NEWSDETAIL](state, {data}) {
    if(!state.newsDetail) {
      state.newsDetail = []
    }
    data.forEach(item => {
      state.newsDetail.push(Object.freeze(item))
    })
  },
  [types.SET_FAVORITE_LIST](state, list) {
    state.favoriteList = list
  },
  [types.UPDATE_FORUM_STATE] (state, forumState) {
    state.forumState = forumState
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}