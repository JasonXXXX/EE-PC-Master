<template>
  <div class="wrap">
    <img class="wrap-img" :src="bg">
    <div class="wrap-login">
      <el-form class="wrap-form" label-position="top" label-width="80px">
        <el-form-item label="邮箱">
          <el-tooltip :content="emailValid" :manual="true" :value="tipVisible">
            <el-input v-model="email" type="email" placeholder="邮箱"></el-input>
          </el-tooltip>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="password" type="password" placeholder="******" :minlength="minlength" :maxlength="maxlength"></el-input>
        </el-form-item>
        <el-button type="primary" @click="login">登录 / 注册</el-button>
      </el-form>
    </div>
  </div>
</template>

<style scoped>
  .wrap {
    display: flex;
    align-items: center;
    height: 100vh;
    width: 100%;
  }
  
  .wrap-img {
    width: 100%;
    height: 100%;
  }
  
  .wrap-login {
    position: absolute;
    top: 200px;
    width: 100%;
    text-align: right;
    padding-right: 48px;
  }
  
  .wrap-form {
    margin: 8px 48px 8px auto;
    padding: 12px 48px;
    width: fit-content;
    background-color: #FFFFFF;
    opacity: .6;
    border-radius: 8px;
    box-shadow: 2px 2px 12px #999999;
    transition: all .8s ease;
  }
  
  .wrap-form:hover {
    opacity: .9;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import Bg from '@/assets/bg.jpg'

export default {
  name: 'Login',
  data () {
    return {
      minlength: 6,
      maxlength: 16,
      useriden: '学生',
      email: '',
      password: '',
      bg: Bg,
      emailValid: '格式不对',
      tipVisible: false
    }
  },
  components: {
  },
  created () {

  },
  methods: {
    login () {
      if (this.test(this.email, new RegExp('[0-9a-zA-Z]+@[0-9a-zA-Z]+\.[a-zA-Z]+'))) {
        let params = new URLSearchParams()

        params.append('user', this.user.user)
        params.append('email', this.email)
        params.append('password', this.password)

        this.$common.http.post(this.$common.api.Login, params)
          .then(response => {
            if ('[]' != response.data) {
              localStorage.setItem('user', this.user)
              localStorage.setItem('userid', response.data.id)
              localStorage.setItem('name', response.data.name)
              localStorage.setItem('headimg', response.data.headimg)
              localStorage.setItem('email', response.data.email)
              localStorage.setItem('password', response.data.password)
              localStorage.setItem('intro', response.data.intro)
              localStorage.setItem('token', response.data.token)

              this.$store.commit(types.UPDATE_USER_USER, {
                user: this.user,
                userid: response.data.id,
                name: response.data.name,
                headimg: response.data.headimg,
                email: response.data.email,
                intro: response.data.intro,
                token: response.data.token,
              })

              this.$message('登录成功')

              Rongyun.setListenAndconnectRongyun()

              //跳转到主页面
              this.$router.replace('/')
            } else {
              //联网成功但登录失败
              this.$message({
                type: 'warning',
                message: '登录失败,请重新登录'
              })
            }
          }).catch(error => {
          })

      } else {
        this.$message('请填写正确的邮箱')
        this.register()
      }

    },
    test (value, regex) {
      return regex.test(value)
    },
    register () {
      this.$router.push('/register')
    }
  },
  computed: {
    ...mapGetters([
      'user'
    ])
  }
}
</script>
