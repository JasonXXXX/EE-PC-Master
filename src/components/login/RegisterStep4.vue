<template>
  <div>
    <p>为了更好的使用本软件，请完善信息:</p>
    <p class="small">你也可以选择跳过，随后再设置</p>
  	<select class="register-select" v-model="grade">
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
  	<select class="register-select" v-model="sub">
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
  	<input class="login-input" type="text" v-if="user.user==2" v-model.lazy.trim="parentname" placeholder="父母亲姓名">
  	<input class="login-input" type="text" v-if="user.user==2" v-model.lazy.trim="parenttel" placeholder="父母亲电话号码">
  	<div class="next-button" @click="register">确认注册</div>
  </div>
</template>

<style scoped>

</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import Convert from '@/common/util/convert'
import Storage from '@/common/util/storage'
import Rongyun from '@/common/util/rongyun'

export default {
	name: 'RegisterStep4',
	data() {
		return {
			grade: '初一',
			sub: '英语',
			parentname: '',
			parenttel: ''
		}
	},
	created() {
    this.grade = Convert.convertGradeNumber(this.user.grade||7)
    this.sub = Convert.convertSubNumber(this.user.sub||3)
    this.parentname = this.user.parentname || ''
    this.parenttel = this.user.parenttel || ''
	},
	methods: {
		register(){
			this.$store.commit(types.UPDATE_USER_LAST, {
				grade: Convert.convertMark(this.grade),
				sub: Convert.convertMark(this.sub),
				parentname: this.parentname,
				parenttel: this.parenttel
			})

      let params = new URLSearchParams()
      let keys = Object.getOwnPropertyNames(this.user)

			keys.forEach(item => {
        params.append(item, this.user[item])
      })

      this.$common.http.post(this.$common.api.Register, params)
        .then(response => {
          if ('[]' == response.data) {
            Toast({
              message: '很抱歉注册失败了!请重新注册',
              position: 'bottom',
              duration: 2000
            })
          } else {
            //注册成功，添加到localStorage
            Toast({
              message: '注册成功',
              position: 'bottom',
              duration: 2000
            })
            localStorage.setItem(Storage.user, this.user.user)
            localStorage.setItem(Storage.userid, response.data.id)
            localStorage.setItem(Storage.headimg, response.data.headimg)
            localStorage.setItem(Storage.name, response.data.name)
            localStorage.setItem(Storage.email, response.data.email)
            localStorage.setItem(Storage.password, response.data.password)
            localStorage.setItem(Storage.intro, response.data.intro)
            localStorage.setItem(Storage.token, response.data.token)
						Rongyun.setListenAndconnectRongyun()
            //跳转到主页面
            this.$router.replace('/home/forum/forum-news')
          }
        }).catch(error => {
        })
		}
	},
	computed: {
		...mapGetters([
			'user'
		])
	}
}
</script>