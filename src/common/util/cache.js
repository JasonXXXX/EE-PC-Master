/**
 * 用来处理收藏列表相关函数
 */
import storage from 'good-storage'

const FAVORITE_KEY = '_favorite_'
const FAVORITE_MAX_LEN = 50   //最多收藏50条信息

function insertArray(arr, val, compare, maxLen) {
  const index = arr.findIndex(compare)
  if (index === 0) {
    return
  }
  if (index > 0) {
    arr.splice(index, 1)
  }
  arr.unshift(val)
  if (maxLen && arr.length > maxLen) {
    arr.pop()
  }
}

function deleteFromArray(arr, compare) {
  const index = arr.findIndex(compare)
  if (index > -1) {
    arr.splice(index, 1)
  }
}

export function saveFavorite(anew) {
  let favornews = storage.get(FAVORITE_KEY, [])
  insertArray(favornews, anew, (item) => {
    return anew.id === item.id
  }, FAVORITE_MAX_LEN)
  storage.set(FAVORITE_KEY, favornews)
  return favornews
}

export function deleteFavorite(anew) {
  let favornews = storage.get(FAVORITE_KEY, [])
  deleteFromArray(favornews, (item) => {
    return item.id === anew.id
  })
  storage.set(FAVORITE_KEY, favornews)
  return favornews
}

export function loadFavorite() {
  return storage.get(FAVORITE_KEY, [])
}