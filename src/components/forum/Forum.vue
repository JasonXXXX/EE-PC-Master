<template>
  <div class="config-wrap">
    <el-menu :default-active="forumState" class="el-menu-vertical-demo config-wrap-tab" @select="handleSelect">
      <el-menu-item index="1"><i class="el-icon-menu"></i>资讯</el-menu-item>
      <el-menu-item index="2"><i class="el-icon-setting"></i>讨论</el-menu-item>
    </el-menu>
    <router-view class="config-wrap-view"></router-view>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import types from '@/store/types'

  export default {
    name: 'Forum',
    created() {
    },
    methods: {
      handleSelect(index) {
        this.$store.commit(types.UPDATE_FORUM_STATE, index)
        this.$router.push('/home/forum/' + (index==='1'? 'forumnews': 'forumdiscover'))
      }
    },
    computed: {
      ...mapGetters([
        'forumState'
      ])
    }
  }
</script>

<style scoped>

</style>