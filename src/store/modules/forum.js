import types from '@/store/types'
import atypes from '@/store/action-types'
import Cache from '@/common/util/cache'
import Storage from '@/common/util/storage'

const state = {
  forums: [],
  stars: Cache.initStars(),
  likes: Cache.initLikes(),
  forumState: 1,
  messageid: 0
}

const getters = {
  forums: state => state.forums,
  forumState: state => state.forumState,
  stars: state => state.stars,
  likes: state => state.likes,
  messageid: state => state.messageid,
}

const actions = {
  [atypes.SAVE_FAVORITE_LIST]({ commit }, detail) {
    commit(types.SET_FAVORITE_LIST, saveFavorite(detail))
  },

  [atypes.DELETE_FAVORITE_LIST]({ commit }, detail) {
    commit(types.SET_FAVORITE_LIST, deleteFavorite(detail))
  }
}

const mutations = {
  //清空
  [types.CLEAR_FORUM_ALL](state) {
    state.forums.splice(0, state.forums.length)
    state.stars.splice(0, state.stars.length)
    state.likes.splice(0, state.likes.length)
    state.forumState = 1
    state.messageid = 0
    console.log('论坛资讯已清空')
  },
  //给数组添加元素
  [types.ADD_FORUM_NEWS](state, forums) {
    forums.forEach(item => {
      state.forums.push(Object.freeze(item))
    })
  },
  [types.ADD_FORUM_NEWSDETAIL](state, { data }) {
    if (!state.newsDetail) {
      state.newsDetail = []
    }
    data.forEach(item => {
      state.newsDetail.push(Object.freeze(item))
    })
  },
  [types.SET_FAVORITE_LIST](state, list) {
    state.favoriteList = list
  },
  [types.UPDATE_FORUM_STATE](state, forumState) {
    state.forumState = forumState
  },
  [types.UPDATE_FORUM_MESSAGEID](state, messageid) {
    state.messageid = messageid
  },
  [types.ADD_STAR](state, id) {
    state.stars.push(id)
    state.stars = Array.from(new Set(state.stars))

    localStorage.setItem(Storage.stars, state.stars.join('-'))
  },
  [types.ADD_LIKE](state, id) {
    state.likes.push(id)
    state.likes = Array.from(new Set(state.likes))

    localStorage.setItem(Storage.likes, state.likes.join('-'))
  },
  [types.DELETE_STAR](state, id) {
    state.stars.every((item, index, arr) => {
      if (item == id) {
        arr.splice(index, 1)
        return false
      } else {
        return true
      }
    })

    localStorage.setItem(Storage.stars, state.stars.join('-'))
  },
  [types.DELETE_LIKE](state, id) {
    state.likes.every((item, index, arr) => {
      if (item == id) {
        arr.splice(index, 1)
        return false
      } else {
        return true
      }
    })

    localStorage.setItem(Storage.likes, state.likes.join('-'))
  },
}

export default {
  state,
  getters,
  mutations,
  actions
}