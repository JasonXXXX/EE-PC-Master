<template>
  <div class="div">
    <div class="title">
      <router-link class="router-link" to="/userdetail" replace><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
      <span class="center">编辑头像</span>
      <span class="glyphicon glyphicon-ok" aria-hidden="true" @click.prevent="uploadImg"></span>
    </div>
    <div class="buttons header">
      <span class="button-cancle" @click.prevent="removeImg">取消</span>
      <label class="button-choose" for="input">{{getChooseButtonText}}</label>
      <input id="input" type="file" accept="image/png,image/jpg,image/jpeg" @change="handleFile()" ref="inputer" style="display: none;">
    </div>
    <div class="content">
      <!-- <canvas class="content-canvas" id="canvas"></canvas> -->
      <div class="content-img">
        <img class="content-canvas" :src="imgUrl">
      </div>
    </div>
  </div>
</template>

<style scoped>
  .div {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100vh;
    padding: 0;
    margin: 0;
    overflow-x: hidden;
  }

  .buttons {
    width: 100%;
    padding: 0;
    text-align: right;
  }

  .button-cancle,.button-choose {
    display: inline-block;
    padding: 8px 12px;
  }

  .button-cancle {
    color: #999999;
  }

  .button-cancle:click {
    background-color: #BBBBBB;
  }

  .button-choose {
    color: #0276FF;
  }

  .content {
    display: flex;
    flex: 1;
    flex-direction: column;
    margin: 0;
    padding: 0;
    width: 100%;
  }

  .content-img {
    flex: 1;
    display: flex;
    align-items: center;
  }

  .content-canvas {
    display: block;
    margin: 0;
    padding: 8px 4px;
    width: 100%;
    height: auto;
    /*max-height: 400px;*/
  }
</style>

<script>
import { mapGetters } from 'vuex'
import { Toast,MessageBox } from 'mint-ui'
import types from '@/store/types'
import Storage from '@/common/util/storage'
import ImageUtil from '@/common/util/image'

export default {
  name: 'ImagePickerVue',
  props: [],
  data() {
    return {
      imgUrl: null
    }
  },
  mounted () {
    document.getElementById('input').click()
  },
  methods: {
    handleFile() {
      this.imgUrl = null
      let imgFile = this.$refs.inputer.files[0]
      
      ImageUtil.convertImageToBase64(imgFile).then(resolve => {
        if (imgFile.size / 1024000 > 1){
          ImageUtil.scaleImage(resolve, 4).then(resolve => {
            this.imgUrl = resolve
          }).catch(error => {
            Toast({
              message: '保存失败',
              position: 'bottom',
              duration: 2000
            })
          })
        } else {
          this.imgUrl = resolve
        }
      }).catch(error => {
        Toast({
          message: '保存失败',
          position: 'bottom',
          duration: 2000
        })
      })
      // let reader = new FileReader()

      /*
      let _this = this,
        Orientation

      EXIF.getData(imgFile, () => {
        Orientation = EXIF.getTag(imgFile, 'Orientation')
      })
      */

        /*
      reader.readAsDataURL(imgFile)

      reader.onload = e => {
        var image = new Image()
        image.src = e.target.result

        image.onload = function () {
          var expectWidth = this.naturalWidth
          var expectHeight = this.naturalHeight
          if (this.naturalWidth > this.naturalHeight && this.naturalWidth > 800) {
            expectWidth = 800
            expectHeight = expectWidth * this.naturalHeight / this.naturalWidth
          } else if (this.naturalHeight > this.naturalWidth && this.naturalHeight > 1200) {
            expectHeight = 1200
            expectWidth = expectHeight * this.naturalWidth / this.naturalHeight
          }
          var canvas = document.createElement("canvas")
          var ctx = canvas.getContext("2d")
          canvas.width = expectWidth
          canvas.height = expectHeight
          ctx.drawImage(this, 0, 0, expectWidth, expectHeight)
          var base64 = null;
          //修复ios上传图片的时候 被旋转的问题
          if(Orientation != "" && Orientation != 1){
            switch(Orientation){
              case 6://需要顺时针（向左）90度旋转
                _this.rotateImg(this, 'left', canvas)
                break
              case 8://需要逆时针（向右）90度旋转
                _this.rotateImg(this, 'right', canvas)
                break
              case 3://需要180度旋转
                _this.rotateImg(this, 'right', canvas)//转两次
                _this.rotateImg(this, 'right', canvas)
                break
              default:
                break
            }
          }
          base64 = canvas.toDataURL("image/png", 0.8);
          if(imgFile.size / 1024000 > 1){
              _this.imgScale(base64, 4)
          }else{
              _this.imgUrl.src = base64
          }
          console.log(JSON.stringify(_this.imgUrl))
        }
      }

      reader.onloadend = e => {
        this.imgUrl = e.target.result
      }
      */
    },
    uploadImg() {
      if (this.imgUrl!==null){
        MessageBox.confirm('是否更换头像?').then(action => {
          let params = new URLSearchParams()
          params.append('userid', this.user.userid)
          params.append('headimg', this.imgUrl)
          this.$common.http.post(this.$common.api.UpdateHeadimg, params)
          .then(response => {
            if(response.data==1) {
              this.$store.commit(types.UPDATE_USER_HEADIMG, this.imgUrl)
              localStorage.setItem(Storage.headimg, this.imgUrl)
              this.$router.replace('/userdetail')
            } else {
              Toast({
                message: '保存失败，请重新保存',
                position: 'bottom',
                duration: 2000
              })
            }
          }).catch(error => {
            this.$store.commit(types.UPDATE_USER_HEADIMG, this.imgUrl)
            this.$router.replace('/userdetail')
          })
        }).catch(cancle => {

        })
      } else {
        Toast({
          message: '请先选择文件',
          position: 'bottom',
          duration: 2000
        })
      }
    },
    imgScale(imgUrl, quality) {
      let img = new Image()
      let canvas = document.createElement('canvas')
      let cxt = canvas.getContext('2d')
      img.src = imgUrl
      img.onload = () => {
        //缩放后图片的宽高
        let width = img.naturalWidth/quality
        let height = img.naturalHeight/quality
        canvas.width = width
        canvas.height = height
        cxt.drawImage(this, 0, 0, width, height)
        this.imgUrl.src = canvas.toDataURL('image/png')
      }
    },
    rotateImg(img, direction, canvas) {
      //图片旋转
      var min_step = 0
      var max_step = 3
      if (img == null) { 
        return
      }
      var height = img.height
      var width = img.width
      var step = 2
      if (step == null) {
        step = min_step
      }
      if (direction == 'right') {
        step++
        step > max_step && (step = min_step)
      } else {
        step--
        step < min_step && (step = max_step)
      }
      var degree = step * 90 * Math.PI / 180
      var ctx = canvas.getContext('2d')
      switch (step) {
        case 0:
          canvas.width = width
          canvas.height = height
          ctx.drawImage(img, 0, 0)
          break
        case 1:
          canvas.width = height
          canvas.height = width
          ctx.rotate(degree)
          ctx.drawImage(img, 0, -height)
          break
        case 2:
          canvas.width = width
          canvas.height = height
          ctx.rotate(degree)
          ctx.drawImage(img, -width, -height)
          break
        case 3:
          canvas.width = height
          canvas.height = width
          ctx.rotate(degree)
          ctx.drawImage(img, -width, 0)
          break
        default:
          break
      }
    },
    removeImg() {
      this.imgUrl = null
    }
  },
  computed: {
    ...mapGetters([
      'user'
    ]),
    getChooseButtonText() {
      return this.imgUrl===null? '选择照片': '重新选择'
    }
  }
}
</script>