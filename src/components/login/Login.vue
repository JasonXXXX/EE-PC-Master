<template>
  <div>
    <div class="title">
      <span class="glyphicon glyphicon-menu-left" aria-hidden="true" @click="goBack"></span >
      <span>欢迎</span>
    </div>
    <header class="header"></header>
    <router-view class="login-div"></router-view>
  </div>
</template>

<style>
.login-div {
  padding: 0 12px;
}

.login-input,.register-select {
  padding: 8px 8px 2px 8px;
  margin: 8px 8px 4px 9%;
  width: 82%;
  outline: none;
  border: none;
  border-bottom: 1px solid #26A2FF;
  font-size: 15px;
}

.next-button {
  position: fixed;
  bottom: 8px;
  right: 8px;
  padding: 12px 24px;
  background-color: #26A2FF;
  color: #FFFFFF;
  font-size: 16px;
}

.skip-button {
  position: fixed;
  bottom: 8px;
  left: 8px;
  padding: 12px 24px;
  background-color: #FEFEFE;
  color: #BBBBBB;
  font-size: 16px;
}
</style>

<script>
import { Radio } from 'mint-ui'

export default {
  name: 'Login',
  data() {
    return {
      useriden: '学生'
    }
  },
  components: {
    'mtRadio':Radio
  },
  created() {

  },
  methods: {
    goBack() {
      this.$router.back()
    }
  }
}
</script>
