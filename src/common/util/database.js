/**
 * 数据库操作
 * 1.保存到数据库
 * 2.从数据库读取本地聊天记录
 */
import Storage from './storage'

let db = {
  name: 'ChatDB',
  version: parseInt(localStorage.getItem(Storage.dbversion)) || 1,
  store_chat_record: 'ChatDBStore',
  /**
   * 记录course浏览记录,
   * 格式
   * {
   *   id: ,
   *   text: ,
   *   date:
   * }
   */
  store_course: 'CourseStore',
  /**
   * 记录note书写记录,
   * 格式
   * {
   *   id: ,
   *   text: ,
   *   date:
   * }
   */
  store_note: 'NoteStore',
  /**
   * 记录plan书写记录,
   * 格式
   * {
   *   id: ,
   *   text: ,
   *   date:
   * }
   */
  store_plan: 'PlanStore',
  /**
   * 记录homework做作业记录,
   * 格式
   * {
   *   id: ,
   *   text: ,
   *   date:
   * }
   */
  store_homework: 'HomeworkStore',
  /**
   * 记录course浏览记录,
   * 格式
   * {
   *   id: ,
   *   text: ,
   *   date:
   * }
   */
  store_friend: 'FriendStore',
}

export default {
  DataBase: null,

  db: db,

  init(edit, store) {
    return new Promise((resolve, reject) => {
      if (edit || !(localStorage.getItem(Storage.dbversion))) {
        //先对数据库版本号进行更新
        db.version += 1
        localStorage.setItem(Storage.dbversion, db.version)
      }
      //打开数据库
      let request = indexedDB.open(db.name, db.version ? db.version : 1)
      request.onerror = (event) => {
        console.log('您的设备不支持数据操作。将无法本地保存聊天记录')
        reject('您的设备不支持数据操作。将无法本地保存聊天记录')
      }
      request.onupgradeneeded = (event) => {
        console.log('数据库更新执行')
        this.DataBase = event.target.result
        if (!(this.DataBase.objectStoreNames.contains(store || db.store_chat_record))) {
          this.DataBase.createObjectStore(store || db.store_chat_record, { keyPath: 'id', autoIncrement: true })
          console.log('objectStore已创建')
        }
      }
      request.onsuccess = (event) => {
        console.log('数据库打开成功')
        //保存IDBDatabase实例
        this.DataBase = event.target.result
        resolve()
      }
    })
  },

  put(data, store) {
    //这个方法若key值存在，会进行修改
    //打开事务
    let transaction = this.DataBase.transaction(store || db.store_chat_record, 'readwrite')
    //打开仓库
    let Store = transaction.objectStore(store || db.store_chat_record)
    //写入数据
    let request = Store.put(data)
    request.onsuccess = (event) => {
      console.log('插入/修改数据到数据库成功,keyPath=', event.target.result)
    }
    request.onerror = (event) => {
      console.log('插入/修改数据到数据库失败')
    }
  },

  add(data, store) {
    //这个方法若key值存在，不会进行修改
    let transaction = this.DataBase.transaction(store || db.store_chat_record, 'readwrite')
    let Store = transaction.objectStore(store || db.store_chat_record)
    let request = Store.add(data)
    request.onsuccess = (event) => {
      console.log('插入数据到数据库成功,keyPath=', event.target.result)
    }
    request.onerror = (event) => {
      console.log('插入数据到数据库失败')
    }
  },

  delete(key, store) {
    let request = this.DataBase.transaction(store || db.store_chat_record, 'readwrite')
      .objectStore(store || db.store_chat_record)
      .delete(key)
    request.onsuccess = () => {
      console.log('删除数据成功')
    }
    request.onerror = () => {
      console.log('删除数据失败')
    }
  },

  select(key, store) {
    return new Promise((resolve, reject) => {
      let request,
        Store = this.DataBase.transaction(store || db.store_chat_record, 'readwrite').objectStore(store || db.store_chat_record)
      if (key) {
        request = Store.get(key)
      } else {
        request = Store.getAll()
      }
      request.onsuccess = () => {
        console.log('数据查询成功')
        resolve(request.result)
      }
      request.onerror = () => {
        console.log('获取聊天记录失败')
        reject('获取聊天记录失败')
      }
    })
  },

  clear(store) {
    return new Promise((resolve, reject) => {
      let request = this.DataBase.transaction(store || db.store_chat_record, 'readwrite').objectStore(store || db.store_chat_record)
        .clear()
      request.onsuccess = () => {
        console.log('清空仓库数据成功')
        resolve()
      }
      request.onerror = () => {
        console.log('清空仓库数据失败')
        reject()
      }
    })
  },

  deleteDatabase(name) {
    return new Promise((resolve, reject) => {
      let request = indexedDB.deleteDatabase(name || db.name)
      request.onerror = (event) => {
        console.log('删除数据库' + (name || '') + '失败')
        reject('删除数据库失败')
      }
      request.onsuccess = (event) => {
        console.log((name + '') + '数据库已删除')
        resolve()
      }
    })
  },

  close() {
    this.DataBase.close()
    this.DataBase = null
    console.log('数据库已关闭')
  }
}