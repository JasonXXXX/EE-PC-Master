import types from '@/store/types'

const state = {
  friends: []
}

const getters = {
  friends: state => state.friends,
}

const actions = {
}

const mutations = {
  //给数组添加元素
  [types.ADD_FRIEND_FRIENDS](state, { friends }) {
    friends.forEach(item => {
      state.friends.push(Object.freeze(item))
    })
  },
  //修改好友备注
  [types.UPDATE_FRIEND_FRIEND](state, { friend }) {
    for (let i = 0; i < state.friends.length; i++) {
      
    }
  },
  //清空数组
  [types.CLEAR_FRIEND_FRIENDS](state) {
    state.friends.splice(0, state.friends.length)
    console.log('好友已清除')
  },
  //添加好友
  [types.UPDATE_ADD_FRIEND](state, {friend}) {
    state.friends.unshift(friend)
  },
  //删除某一个好友
  [types.DELETE_FRIEND_FRIEND](state, friendid) {
    state.friends.every((item, index, arr) => {
      if (item.friend_id==friendid) {
        arr.splice(index, 1)
        return false
      }
      return true
    })
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}