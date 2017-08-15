/**
 * 数据库操作
 * 1.保存到数据库
 * 2.从数据库读取本地聊天记录
 */
import Storage from './storage'

let db = {
  name: 'ChatDB',
  version: parseInt(localStorage.getItem(Storage.dbversion)) || 1,
  store_chat_record: 'ChatDBStore'
}

export default {
  DataBase: null,
  init(edit) {
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
        if (!(this.DataBase.objectStoreNames.contains(db.store_chat_record))) {
          this.DataBase.createObjectStore(db.store_chat_record, { keyPath: 'id', autoIncrement: true })
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
  put(data) {
    //这个方法若key值存在，会进行修改
    //打开事务
    let transaction = this.DataBase.transaction(db.store_chat_record, 'readwrite')
    //打开仓库
    let store = transaction.objectStore(db.store_chat_record)
    //写入数据
    let request = store.put(data)
    request.onsuccess = (event) => {
      console.log('插入/修改数据到数据库成功,keyPath=', event.target.result)
    }
    request.onerror = (event) => {
      console.log('插入/修改数据到数据库失败')
    }
  },
  add(data) {
    //这个方法若key值存在，不会进行修改
    let transaction = this.DataBase.transaction(db.store_chat_record, 'readwrite')
    let store = transaction.objectStore(db.store_chat_record)
    let request = store.add(data)
    request.onsuccess = (event) => {
      console.log('插入数据到数据库成功,keyPath=', event.target.result)
    }
    request.onerror = (event) => {
      console.log('插入数据到数据库失败')
    }
  },
  delete(key) {
    let request = this.DataBase.transaction(db.store_chat_record, 'readwrite')
      .objectStore(db.store_chat_record)
      .delete(key)
    request.onsuccess = () => {
      console.log('删除数据成功')
    }
    request.onerror = () => {
      console.log('删除数据失败')
    }
  },
  select(key) {
    return new Promise((resolve, reject) => {
      let request,
        store = this.DataBase.transaction(db.store_chat_record, 'readwrite').objectStore(db.store_chat_record)
      if (key) {
        request = store.get(key)
      } else {
        request = store.getAll()
      }
      request.onsuccess = () => {
        console.log('数据查询成功')
        resolve(request.result)
      }
      request.onerror = () => {
        console.log('数据查询失败')
        reject('获取聊天记录失败')
      }
    })
  },
  clear() {
    return new Promise((resolve, reject) => {
      let request = this.DataBase.transaction(db.store_chat_record, 'readwrite').objectStore(db.store_chat_record)
        .clear()
      request.onsuccess = () => {
        console.log('清空数据库数据成功')
        resolve()
      }
      request.onerror = () => {
        console.log('清空数据库数据失败')
        reject()
      }
    })
  },
  deleteDatabase() {
    return new Promise((resolve, reject) => {
      let request = indexedDB.deleteDatabase(db.name)
      request.onerror = (event) => {
        console.log('删除数据库失败')
        reject('删除数据库失败')
      }
      request.onsuccess = (event) => {
        console.log('数据库已删除')
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