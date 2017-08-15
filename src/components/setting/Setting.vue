<template>
  <div class="config-wrap">
    <el-collapse class="wrap-collapse" v-model="activeName" accordion>
      <el-collapse-item class="wrap-collapse-item" :title="$common.strings.setting_title_user" name="user">
        <div class="item-div">
          <span class="item-div-span">{{$common.strings.setting_logout_hint}}</span>
          <el-button class="item-div-button" @click="logout">{{$common.strings.setting_logout_button}}</el-button>
        </div>
      </el-collapse-item>
  
      <el-collapse-item class="wrap-collapse-item" :title="$common.strings.setting_title_data" name="data">
        <div class="item-div">
          <span class="item-div-span">{{$common.strings.setting_clearchat_hint}}</span>
          <el-button class="item-div-button" @click="clearChatRecord">{{$common.strings.setting_clearchat_button}}</el-button>
        </div>
      </el-collapse-item>
  
      <el-collapse-item class="wrap-collapse-item" :title="$common.strings.setting_title_security" name="security">
      </el-collapse-item>
    </el-collapse>
  </div>
</template>

<style scoped>
  .wrap-collapse {
    width: 100%;
    text-align: left;
  }
  
  .item-div {
    display: flex;
    align-items: center;
  }
  
  .item-div-span {
    flex: 1;
    display: block;
    text-align: left;
    color: #999999;
    font-size: 14px;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types.js'
import atypes from '@/store/action-types.js'
import Database from '@/common/util/database.js'

export default {
  name: 'Setting',
  data () {
    return {
      activeName: 'user'
    }
  },
  created () {

  },
  methods: {
    clearChatRecord () {
      let self = this
      this.$confirm('确认清空本地聊天记录吗？', this.$common.strings.dialog_warning_type, {
        confirmButtonText: this.$common.strings.dialog_button_yes,
        cancelButtonText: this.$common.strings.dialog_button_no,
        type: 'warning'
      }).then(() => {
        Database.init(true).then(() => {
          Database.clear().then(() => {
            self.$store.commit(types.CLEAR_CHAT_CHATS)
            Database.close()
            this.$message({
              type: 'success',
              message: '聊天记录已删除!'
            })
          }).catch(() => {
            this.$message({
              type: 'warning',
              message: '未能成功删除,请重新删除!'
            })
          })
        }).catch(error => {
          this.$message({
            type: 'warning',
            message: '访问本地数据失败,请重新删除!'
          })
        })
      }).catch(cancle => {

      })
    },
    modifyPassword () {

    },
    logout () {
      if (this.user.userid === 0) {
        this.$message('您还未登录,请先登录!')
      } else {
        this.$confirm('是否进行注销？', this.$common.strings.dialog_warning_type, {
          confirmButtonText: this.$common.strings.dialog_button_yes,
          cancelButtonText: this.$common.strings.dialog_button_no,
          type: 'warning'
        }).then(() => {
          this.$store.dispatch(atypes.LOGOUT).then(resolve => {
            this.$message('已注销!')
          }).catch(reject => {

          })
        }).catch(cancle => {

        })
      }
    }
  },
  computed: {
    ...mapGetters([
      'chats',
      'user'
    ])
  }
}
</script>
