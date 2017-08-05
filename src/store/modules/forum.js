import types from '@/store/types'
import atypes from '@/store/action-types'
import {loadFavorite, saveFavorite, deleteFavorite} from '@/common/util/cache'

const state = {
  says: [],
  news: [],
  favoriteList: loadFavorite(),
  forumState: '1'

}

const getters = {
  says: state => state.says,
  news: state => state.news,
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
  [types.ADD_FORUM_SAY](state, { says }) {
    says.forEach(item => {
      state.says.push(Object.freeze(item))
    })
  },
  [types.ADD_FORUM_NEWS](state, { news }) {
    news.forEach(item => {
      state.news.push(Object.freeze(item))
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