<template>
	<div>
	  <div class="title">
	  	<span class="glyphicon glyphicon-menu-left" aria-hidden="true" @click="backward"></span >
	    <span class="center">关于我</span>
	    <span class="glyphicon glyphicon-saved" aria-hidden="true" v-if="ifModified" @click="modify"></span>
	    <span class="glyphicon glyphicon-option-vertical" aria-hidden="true" v-if="!ifModified" @click="showMenu"></span>
	  </div>
	  <div class="headimg-div"><img class="headimg" :src="headimg" @click.stop="showSheet"></div>
	  <div class="line-div">
	  	<span class="line-flex" @click="modifyName">{{name}}</span>
	  	<span class="line-flex">{{gender | genderFilter}}</span>
	  	<span class="line-flex" @click="modifyTel">{{tel}}</span>
	  </div>
    <div class="line-div">
      <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
      <input class="line-flex" v-model.lazy.trim="address" @change="markEdit">
  	</div>
    <div class="line-div" v-if="user.user===2">
      <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
      <select class="line-flex" v-model="grade" @change="markEdit">
			  <option>小学一年级</option>
			  <option>小学二年级</option>
			  <option>小学三年级</option>
			  <option>小学四年级</option>
			  <option>小学五年级</option>
			  <option>小学六年级</option>
			  <option>初一</option>
			  <option>初二</option>
			  <option>初三</option>
			  <option>高一</option>
			  <option>高二</option>
			  <option>高三</option>
			</select>
  	</div>
    <div class="line-div">
			<span class="glyphicon glyphicon-tags" aria-hidden="true"></span>
			<select class="line-flex" v-model="sub" @change="markEdit">
	      <option>语文</option>
	      <option>数学</option>
	      <option>英语</option>
	      <option>物理</option>
	      <option>化学</option>
	      <option>生物</option>
	      <option>政治</option>
	      <option>历史</option>
	      <option>地理</option>
	    </select>
  	</div>
		<div class="line-div">
      <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
      <p class="line-flex" v-html="ID"></p>
  	</div>
		<div class="line-div" v-show="user.user===2">
      <span class="glyphicon glyphicon-user" aria-hidden="true"></span><span>家长姓名:</span>
      <input class="line-flex" v-model.lazy.trim="parentname" @change="markEdit">
  	</div>
		<div class="line-div" v-show="user.user===2">
      <span class="glyphicon glyphicon-phone" aria-hidden="true"></span><span>家长电话:</span>
      <input class="line-flex" v-model.lazy.trim="parenttel" @change="markEdit">
  	</div>
		<textarea class="textarea" v-model.lazy.trim="intro" rows="2" @change="markEdit"></textarea>
		<actionsheet :actions="actions" v-model="sheetVisible"></actionsheet>
	</div>
</template>

<style scoped>
.headimg-div {
	margin: 0 0 44px 0;
	padding: 0;
	width: 100%;
	height: 150px;
	background-color: #02A8F3;
	box-shadow: 0px 2px 8px #BBBBBB;
}

.headimg {
	position: fixed;
	top: 100px;
	left: 50px;
	display: block;
	width: 100px;
	height: 100px;
	background-color: #FFFFFF;
	border-radius: 50%;
	box-shadow: 1px 2px 8px #AAA;
}

.line-div {
	display: flex;
	align-items: center;
	padding: 12px 8px 0px 8px;
	margin: 0;
	font-size: 15px;
	box-shadow: 0px 1px 4px #EEE;
}

.line-div .glyphicon {
	margin-right: 8px;
}

.line-flex {
	flex: 1;
	margin: 0;
	padding: 8px 4px;
	border: none;
	outline: none;
}

.textarea {
	padding: 8px;
	width: 100%;
	overflow-x: hidden;
	outline: none;
	border: none;
	box-shadow: 0px 2px 8px #BBB;
	font-size: 15px;
}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import Convert from '@/common/util/convert.js'
import { Toast,MessageBox,Actionsheet } from 'mint-ui'
import Storage from '@/common/util/storage'

export default {
	data() {
	  return {
	    headimg: '',
	    name: '',
	    tel: '189****2356',
	    address: 'xx省xx区xx市',
	    ID: '44xxxxxxxxxxxxxxx8',
	    parentname: 'xxx',
	    parenttel: '135****8954',
	    intro: '',
	    ifModified: false,
	    grade: '高二',
	    sub: '英语',
			gender: 1,
			sheetVisible: false,
			actions: [
				{
					name: '拍照',
					method: () => {
						this.plusReady(() => {
							let camera = this.$camera.getCamera()
							let res = camera.supportedImageResolutions[0]
							let fmt = camera.supprotedImageFormat[0]
							console.log('Resolution:' + res + ',Format:' + fmt)

							camera.captureImage(path => {
								console.log('拍照成功,path=' + path)
							},
							error => {
								console.log('拍照失败,error:'+error)
							},
							{
								resolution: res,
								format: fmt
							})
						})
					}
				},
				{
					name: '本地相册',
					method: () => {
						this.$router.replace('/imagepicker')
					}
				}
			]
	  }
	},
	components: {
		Actionsheet
	},
	created() {
		this.headimg = this.user.headimg
		this.intro = this.user.intro
		this.name = this.user.name

    let params = new URLSearchParams()
    params.append('studentid', this.user.userid)
    this.$common.http.post(this.$common.api.UserInfo, params)
      .then(response => {
      	this.tel = response.data.tel
      	this.address = response.data.address
      	this.ID = response.data.ID
      	this.parentname = response.data.parentname
      	this.parenttel = response.data.parenttel
      	this.grade = Convert.convertGradeNumber(response.data.grade)
      	this.sub = Convert.convertSubNumber(response.data.sub)
      	this.gender = response.data.gender
      }).catch(error => {

      })
	},
	methods: {
		backward() {
		  if (this.ifModified) {
		    MessageBox.confirm('返回将丢失修改的内容。是否返回？').then(action => {
		      this.$router.back()
		    })
		  } else {
		    this.$router.back()
		  }
		},
		modifyName() {
			MessageBox.prompt('请输入姓名:').then(({value, action}) => {
				this.name = value
				this.ifModified = true
			})
		},
		modifyTel() {
			MessageBox.prompt('请输入手机号:').then(({value, action}) => {
				if (/1[0-9]{10}/.test(value)) {
					this.tel = value
					this.ifModified = true
				} else {
					Toast({
					  message: '请输入正确的手机号',
					  position: 'bottom',
					  duration: 2000
					})
				}
			})
		},
	  modify() {
	    let params = new URLSearchParams()
	    params.append('user', this.user.user)
	    params.append('userid', this.user.userid)
	    params.append('name', this.name)
	    params.append('tel', this.tel)
	    params.append('gender', this.gender)
	    params.append('address', this.address)
	    params.append('intro', this.intro)
	    params.append('grademark', Convert.convertMark(this.grademark))
	    params.append('submark', Convert.convertMark(this.submark))
	    params.append('parenttel', this.parenttel)
	    params.append('parentname', this.parentname)
	    params.append('ID', this.ID)
	    params.append('token', this.user.token)
	    this.$common.http.post(this.$common.api.InfoUpdate, params)
	      .then(response => {
	      	Toast({
	      	  message: '保存成功',
	      	  position: 'bottom',
	      	  duration: 2000
	      	})
	      	localStorage.setItem(Storage.name, this.name)
	      	localStorage.setItem(Storage.intro, this.intro)
	        this.$store.commit(types.UPDATE_USER_NAME_AND_INTRO, {
	        	name: this.name,
	        	intro: this.intro
	        })
	        this.$router.back()
	      }).catch(error => {

	      })
	  },
	  markEdit() {
	  	this.ifModified = true
		},
		showMenu() {

		},
		showSheet() {
			this.sheetVisible = true
		}
	},
	filters: {
	  genderFilter(value) {
	    return 1 === value ? '男' : '女'
	  }
	},
	computed: {
		...mapGetters([
			'user'
		])
	}
}
</script>