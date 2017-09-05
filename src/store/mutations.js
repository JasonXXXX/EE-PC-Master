import types from './types'
import imgUrl from '@/assets/logo.png'

export default {
  //修改菜单栏状态
  [types.UPDATE_HEADER_SELECTED](state, headerSelected) {
    state.headerSelected = headerSelected
  },
  //修改loading
  [types.UPDATE_LOADING](state, loading) {
    state.loading = loading
  },
  //清除数据
  [types.CLEAR](state) {
    state.user = null
    state.user = {
      userid: 0,
      token: '0',
      name: '默认名',
      intro: '优质学习，在线互动',
      headimg: imgUrl
    }
  },
  [types.UPDATE_ME_MESTATE](state, meState) {
    state.meState = meState
  },
  [types.UPDATE_USER_USER](state, user) {
    state.user.user = user
  },
  [types.UPDATE_USER_ALL](state, user) {
    state.user = user
  },
  [types.UPDATE_CONFIGNET](state, net) {
    state.configNet = net
  },
  [types.UPDATE_USER_BASE](state, base) {
    state.user.name = base.name
    state.user.email = base.email
    state.user.password = base.password
  },
  [types.UPDATE_USER_EXTRA](state, extra) {
    state.user.tel = extra.tel
    state.user.address = extra.address
    state.user.intro = extra.intro
    state.user.ID = extra.ID
  },
  [types.UPDATE_USER_LAST](state, last) {
    state.user.gender = last.gender
    state.user.grade = last.grade
    state.user.sub = last.sub
    state.user.parentname = last.parentname
    state.user.parenttel = last.parenttel
  },
  [types.UPDATE_USER_NAME_AND_INTRO](state, data) {
    state.user.name = data.name
    state.user.intro = data.intro
  },
  [types.UPDATE_USER_HEADIMG](state, imgUrl) {
    state.user.headimg = imgUrl
  },
  [types.RELEASE_LOGIN](state) {
    state.user = null
    state.user = {
      userid: 0,
      token: '0',
      name: '默认名',
      intro: '优质学习，在线互动',
      headimg: imgUrl
    }
  }
}