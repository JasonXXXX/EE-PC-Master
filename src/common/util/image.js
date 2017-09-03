/**
 * 图片操作方法
 * 1.将图片保存到本地
 * 2.发送照片到服务器端
 */

export default {
  exportCanvasAsPNG(id, fileName) {
    let canvasElement = document.getElementById(id)
    let MIME_TYPE = "image/png"
    let imgURL = canvasElement.toDataURL(MIME_TYPE)
    let dlLink = document.createElement('a')

    dlLink.download = fileName
    dlLink.href = imgURL
    dlLink.dataset.downloadurl = [MIME_TYPE, dlLink.download, dlLink.href].join(':')

    document.body.appendChild(dlLink)
    dlLink.click()
    document.body.removeChild(dlLink)
  },
  convertImageToBase64(file) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader()
      reader.readAsDataURL(file)

      reader.onloadend = e => {
        console.log('获取图片成功')
        resolve(e.target.result)
      }

      reader.onerror = e => {
        reject('获取图片失败')
      }

      reader.onabort = e => {
        reject('获取图片中断')
      }

      reader.onloadstart = e => {
        console.log('开始获取图片')
      }

    })
  },
  convertBase64ToImage(data) {

  },
  scaleImage(imageData, quality) {
    return new Promise((resolve, reject) => {
      let img = new Image()
      let canvas = document.createElement('canvas')
      let cxt = canvas.getContext('2d')
      img.src = imageData
      img.onload = e => {
        //缩放后图片的宽高
        let width = img.naturalWidth/quality
        let height = img.naturalHeight/quality
        canvas.width = width
        canvas.height = height
        cxt.drawImage(this, 0, 0, width, height)
        resolve(canvas.toDataURL('image/png'))
      }
    })
  }
}
