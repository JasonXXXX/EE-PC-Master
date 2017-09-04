<template>
  <div class="wrap" id="wrap">
    <el-steps class="wrap-header" :space="200" :active="step">
      <el-step title="步骤 1" description="请先选择您的身份"></el-step>
      <el-step title="步骤 2" description="这是最基本的用户信息,请耐心填写(注意,注册后不可更改)"></el-step>
      <el-step title="步骤 3" description="这部分的信息你可以先跳过,以后再填写"></el-step>
      <el-step title="步骤 4" description="这部分的信息也可以跳过,但是我们建议你现在就完成"></el-step>
    </el-steps>
    <el-carousel class="wrap-content" ref="carousel" :arrow="indicator" :autoplay="false" @change="handleChange">
      <el-carousel-item>
        <h3>您的身份</h3>
        <el-radio-group class="wrap-user" v-model="user">
          <el-radio-button label="教师"></el-radio-button>
          <el-radio-button label="学生"></el-radio-button>
        </el-radio-group>
      </el-carousel-item>

      <el-carousel-item>
        <h3>请认真完成以下信息</h3>
        <el-form class="wrap-form" label-position="top" label-width="80px">
          <el-form-item class="wrap-form-item" label="用户名">
            <el-input v-model.trim="name" placeholder="用户名"></el-input>
          </el-form-item>
          <el-form-item class="wrap-form-item" label="邮箱">
            <el-input v-model.trim="email" type="email" placeholder="邮箱"></el-input>
          </el-form-item>
          <el-form-item class="wrap-form-item" label="密码">
            <el-input v-model.trim="password" type="password" placeholder="******" :minlength="minlength" :maxlength="maxlength"></el-input>
          </el-form-item>
          <el-form-item class="wrap-form-item" label="确认密码">
            <el-input v-model.trim="confirmpassword" type="password" placeholder="******" :minlength="minlength" :maxlength="maxlength"></el-input>
          </el-form-item>
        </el-form>
      </el-carousel-item>

      <el-carousel-item>
        <h3>这部分信息也可以以后再填</h3>
        <el-form class="wrap-form" label-position="top" label-width="80px">
          <el-form-item class="wrap-form-item" label="手机号">
            <el-input v-model.trim="tel" placeholder="手机号"></el-input>
          </el-form-item>
          <el-form-item class="wrap-form-item" label="地址">
            <el-input v-model.trim="address" type="email" placeholder="地址"></el-input>
          </el-form-item>
          <el-form-item class="wrap-form-item" label="自我简介">
            <el-input v-model.trim="intro" type="textarea" :autosize="{minRows: 2,maxRows: 4}" placeholder="你的自我介绍"></el-input>
          </el-form-item>
          <el-form-item class="wrap-form-item" label="身份证">
            <el-input v-model.trim="ID" placeholder="******" :minlength="IDminlength" :maxlength="IDmaxlength"></el-input>
          </el-form-item>
        </el-form>
      </el-carousel-item>

      <el-carousel-item>
        <h3>请继续完善信息,或直接注册</h3>
        <el-form class="wrap-form" label-position="top" label-width="80px">
          <el-autocomplete class="wrap-form-item" :placeholder="$common.strings.detail_placeholder_gender" :fetch-suggestions="queryGenderSuggestions" v-model="gender">
          </el-autocomplete>
          <el-autocomplete class="wrap-form-item" :placeholder="$common.strings.detail_placeholder_sub" :fetch-suggestions="querySubSuggestions" v-model="sub">
          </el-autocomplete>
          <el-autocomplete class="wrap-form-item" :placeholder="$common.strings.detail_placeholder_grade" :fetch-suggestions="queryGradeSuggestions" v-model="grade">
          </el-autocomplete>
          <el-form-item class="wrap-form-item" label="父/母姓名" v-if="user.user===2">
            <el-input v-model.trim="parentname" placeholder="父/母姓名"></el-input>
          </el-form-item>
          <el-form-item class="wrap-form-item" label="父/母手机号" v-if="user.user===2">
            <el-input v-model.trim="parenttel" placeholder="父/母手机号"></el-input>
          </el-form-item>
        </el-form>
        <el-button type="primary" @click="register">注册</el-button>
      </el-carousel-item>

    </el-carousel>
  </div>
</template>

<style scoped>
  .wrap {
    display: flex;
    flex-direction: column;
    height: 100vh;
    text-align: center;
  }

  .wrap-header {
    margin-top: 12px;
  }

  .wrap-content {
    flex: 1;
  }

  .wrap-user {
    margin-top: 48px;
  }

  .wrap-form {
    margin: 0 auto;
    width: 40%;
  }

  .wrap-form-item {
    margin: 4px 0;
    width: 100%;
    text-align: left;
  }
</style>

<script>
import types from '@/store/types'
import Convert from '@/common/util/convert'

export default {
  name: 'Register',
  data () {
    return {
      indicator: 'always',
      step: 1,
      minlength: 6,
      maxlength: 16,
      IDminlength: 5,
      IDmaxlength: 18,
      user: '学生',
      name: '',
      email: sessionStorage.getItem('register-email') || '',
      password: sessionStorage.getItem('register-password') || '',
      confirmpassword: sessionStorage.getItem('register-password') || '',
      tel: '',
      address: '',
      intro: '',
      ID: '',
      sub: '',
      grade: '',
      gender: '',
      parentname: '',
      parenttel: '',
      genderSuggestions: [
        { value: this.$common.strings.common_male },
        { value: this.$common.strings.common_female }
      ],
      gradeSuggestions: [
        { "value": this.$common.strings.common_grade_1 },
        { "value": this.$common.strings.common_grade_2 },
        { "value": this.$common.strings.common_grade_3 },
        { "value": this.$common.strings.common_grade_4 },
        { "value": this.$common.strings.common_grade_5 },
        { "value": this.$common.strings.common_grade_6 },
        { "value": this.$common.strings.common_grade_7 },
        { "value": this.$common.strings.common_grade_8 },
        { "value": this.$common.strings.common_grade_9 },
        { "value": this.$common.strings.common_grade_10 },
        { "value": this.$common.strings.common_grade_11 },
        { "value": this.$common.strings.common_grade_12 },
      ],
      subSuggestions: [
        { "value": this.$common.strings.common_sub_chinese },
        { "value": this.$common.strings.common_sub_math },
        { "value": this.$common.strings.common_sub_english },
        { "value": this.$common.strings.common_sub_physical },
        { "value": this.$common.strings.common_sub_chemistry },
        { "value": this.$common.strings.common_sub_biology },
        { "value": this.$common.strings.common_sub_political },
        { "value": this.$common.strings.common_sub_history },
        { "value": this.$common.strings.common_sub_geology },
      ]
    }
  },
  mounted () {
    sessionStorage.removeItem('register-email')
    sessionStorage.removeItem('register-password')
  },
  methods: {
    handleChange (newIndex, oldIndex) {
      switch ((oldIndex + 1)) {
        case 1:
          if (newIndex === 3) {
            this.step = 1
            this.$refs.carousel.setActiveItem(oldIndex)
          } else {
            this.$store.commit(types.UPDATE_USER_USER, this.user === '教师' ? 1 : 2)
            this.step = newIndex + 1
          }
          break
        case 2:
          if (newIndex === 2) {
            if (this.test(this.email, new RegExp('[0-9a-zA-Z]+@[0-9a-zA-Z]+\.[a-zA-Z]+')) && this.name != '' && this.password != '' && this.password === this.confirmpassword) {

              this.$store.commit(types.UPDATE_USER_BASE, {
                name: this.name,
                email: this.email,
                password: this.password
              })
              this.step = newIndex + 1
            } else {
              this.$message({
                type: 'warning',
                message: '请检查你的邮箱格式或者密码是否一致'
              })
              this.$refs.carousel.setActiveItem(1)
            }
          } else {
            this.step = newIndex + 1
          }
          break
        case 3:
          this.step = newIndex + 1
          if (newIndex === 3) {
            this.indicator = 'never'
          }
          break
        default:
          break
      }
    },
    register () {
      this.$store.commit(types.UPDATE_USER_LAST, {
        gender: Convert.convertGender(this.gender),
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
          if ('false' == response.data) {
            this.$message({
              type: 'warning',
              message: '注册失败,请重新注册'
            })
            this.indicator = 'always'
          } else {
            //注册成功，添加到localStorage
            this.$message('注册成功')
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
            this.$router.replace('/')
          }
        }).catch(error => {
        })
    },
    test (value, regex) {
      return regex.test(value)
    },
    queryGenderSuggestions (queryString, cb) {
      const suggestions = this.genderSuggestions
      const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
      // 调用 callback 返回建议列表的数据
      cb(results)
    },
    querySubSuggestions (queryString, cb) {
      const suggestions = this.subSuggestions
      const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
      // 调用 callback 返回建议列表的数据
      cb(results)
    },
    queryGradeSuggestions (queryString, cb) {
      const suggestions = this.gradeSuggestions
      const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
      // 调用 callback 返回建议列表的数据
      cb(results)
    },
    createFilter (queryString) {
      return suggestions => (suggestions.value.indexOf(queryString.toLowerCase()) === 0)
    },
  }
}
</script>
