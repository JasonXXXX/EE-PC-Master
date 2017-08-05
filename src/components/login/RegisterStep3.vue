<template>
  <div>
    <p>为了更好的使用本软件，请完善信息:</p>
    <p class="small">(你也可以选择跳过，随后再设置)</p>
  	<input class="login-input" type="tel" v-model.lazy.trim="tel" placeholder="189****2356">
  	<input class="login-input" v-model.lazy.trim="address" placeholder="xx省xx区xx市">
  	<input class="login-input" v-model.lazy.trim="intro" placeholder="自我简介">
  	<input class="login-input" v-model.lazy.trim="ID" placeholder="身份证号码">
		<router-link class="skip-button" to="/login/registerstep4">跳过</router-link>
	  <div class="next-button" @click="next">下一步</div>
  </div>
</template>

<style lang="css" scoped>
.small {
  font-size: 13px;
  color: #999999;
}
</style>

<script>
import { mapGetters } from 'vuex'
import { Toast } from 'mint-ui'
import types from '@/store/types'

export default {
	name: 'RegisterStep3',
	data() {
		return {
			tel: '',
			address: '',
			intro: '',
			ID: '',
			mark: true
		}
	},
	created() {
		this.tel = this.user.tel || ''
		this.address = this.user.address || ''
		this.intro = this.user.intro || ''
		this.ID = this.user.ID || ''
	},
	methods: {
		next() {
			if(this.mark) {
				this.$store.commit(types.UPDATE_USER_EXTRA, {
					tel: this.tel,
					address: this.address,
					intro: this.intro,
					ID: this.ID
				})
				this.$router.push('/login/registersetp4')
			} else {
				Toast({
				  message: '请填写正确的手机号',
				  position: 'bottom',
				  duration: 2000
				})
			}
		}
	},
	watch: {
		tel(val) {
			const regex = new RegExp('1[0-9]{10}')
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