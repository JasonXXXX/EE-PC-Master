<template>
  <div class="div">
    请选择您的身份：<br>
    <div class="iden">
      <div class="iden-div">
        <div :class="[teacher? 'selected': 'unselected', 'iden-item']" @click="select"><p class="p">教 师</p></div>
      </div>
      <div class="iden-div">
        <div :class="[teacher? 'unselected': 'selected', 'iden-item']" @click="select"><p class="p">学 生</p></div>
      </div>
    </div>
    <div class="next-button" @click="next">下一步</div>
  </div>
</template>

<style lang="css" scoped>
.div {
  margin: 0;
  padding: 12px;
  width: 100%;
  font-size: 16px;
  color: #525252;
  overflow-y: hidden;
}

.iden {
  display: flex;
  padding: 48px 0;
}

.iden-div {
  flex: 1;
}

.iden-item {
  margin: 0 auto;
  padding: 0;
  width: 100px;
  height: 100px;
  border-radius: 50%;
  line-height: 100px;
}

.p {
  margin: 0;
  padding: 0;
  width: 100%;
  font-size: 18px;
  text-align: center;
}

.selected {
  background-color: #26A2FF;
  color: #FFFFFF;
}

.unselected {
  background-color: #DDDDDD;
  color: #FFFFFF;
}
</style>

<script>
import {mapGetters} from 'vuex'
import types from '@/store/types'

export default {
  name: 'RegisterStep1',
  data() {
    return {
      teacher: false
    }
  },
  created() {
    this.teacher = this.user.user===1? true: false
  },
  beforeRouterLeave (to, from, next) {

  },
  methods: {
    select() {
      this.teacher = !this.teacher
    },
    next() {
      this.$store.commit(types.UPDATE_USER_USER, this.teacher? 1: 2)
      this.$router.push('/login/registerstep2')
    }
  },
  computed: {
    ...mapGetters([
      'user'
    ])
  }
}
</script>