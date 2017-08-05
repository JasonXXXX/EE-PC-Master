<template>
  <div>
    <p>请完成以下基础信息:</p>
    <input class="login-input" type="text" v-model.lazy.trim="name" placeholder="王小明(注册后不可更改)">
    <input class="login-input" type="email" v-model.lazy.trim="email" placeholder="example@example.com">
    <input class="login-input" type="password" v-model.lazy.trim="password" placeholder="******">
    <input class="login-input" type="password" v-model.lazy.trim="confirmpassword" placeholder="确认密码">
    <div class="next-button" @click="next">下一步</div>
  </div>
</template>

<style lang="css" scoped>
  
</style>

<script>
import {mapGetters} from 'vuex'
import types from '@/store/types'
import { Toast } from 'mint-ui'

export default {
	name: 'RegisterStep2',
	data() {
		return {
			name: '',
			email: '',
			password: '',
			confirmpassword: '',
      mark: false
		}
	},
  created() {
    this.name = this.user.name || ''
    this.email = this.user.email || ''
    this.password = this.user.password || ''
    this.confirmpassword = this.password
  },
  methods: {
    next() {
      if(this.password.length >= 6 && this.password === this.confirmpassword && this.mark) {
        this.$store.commit(types.UPDATE_USER_BASE, {
          name: this.name,
          email: this.email,
          password: this.password
        })
        this.$router.push('/login/registerstep3')
      } else if (!this.mark) {
        Toast({
          message: '请填写正确的邮箱',
          position: 'bottom',
          duration: 2000
        })
      } else if (this.password.length < 6) {
        Toast({
          message: '密码长度不能小于6',
          position: 'bottom',
          duration: 2000
        })
      } else {
        Toast({
          message: '两次密码不一致',
          position: 'bottom',
          duration: 2000
        })
      }
    }
  },
  watch: {
    email(val) {
      const regex = new RegExp('[0-9a-zA-Z]+@[0-9a-zA-Z]+\.[a-zA-Z]+')
      this.mark = regex.test(val)
    }
  },
  computed: {
    ...mapGetters([
      'user'
    ])
  }
}
</script>