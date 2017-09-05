import Vue from 'vue'
import Vuex from 'vuex'

import getters from './getters'
import mutations from './mutations'
import actions from './actions'
import modules from './modules'

import Storage from '@/common/util/storage'
import Server from '@/common/data/server'
import imgUrl from '@/assets/logo.png'

Vue.use(Vuex)

const state = {
  headerSelected: 'forum',
  meState: '/me/courseing',
  loading: true,
  user: {
    user: localStorage.getItem(Storage.user) || 2,
    userid: localStorage.getItem(Storage.userid) || 2,
    token: localStorage.getItem(Storage.token) || '0',
    email: localStorage.getItem(Storage.email) || '',
    password: localStorage.getItem(Storage.password) || '',
    name: localStorage.getItem(Storage.name) || '默认名',
    intro: localStorage.getItem(Storage.intro) || '优质学习，在线互动',
    headimg: localStorage.getItem(Storage.headimg) || 'http://' + Server.ip + ':' + Server.port + '/' + Server.server + '/image/userheadimg/' + ((localStorage.getItem(Storage.user) || 2)===2? 'student': 'teacher') + (localStorage.getItem(Storage.userid) || 2) + '.png'
  },
  configNet: true
}

export default new Vuex.Store({
  state,
  getters,
  mutations,
  actions,
  modules
})