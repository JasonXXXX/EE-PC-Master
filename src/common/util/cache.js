/**
 * 用来处理收藏列表相关函数
 */

import Storage from './storage'

const FAVORITE_KEY = '_favorite_'
const FAVORITE_MAX_LEN = 50   //最多收藏50条信息

export default {
  initStars() {
    const stars = localStorage.getItem(Storage.stars)
    return stars ? stars.split('-') : []
  },
  initLikes() {
    const likes = localStorage.getItem(Storage.likes)
    return likes ? likes.split('-') : []
  }
}