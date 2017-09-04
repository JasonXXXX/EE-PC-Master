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
        <div class="item-div">
          <span class="item-div-span">修改密码</span>
          <el-button class="item-div-button" @click="updatePwd = true">编辑</el-button>
        </div>
        <el-form class="form" ref="form" :model="form" label-width="80px" v-if="updatePwd">
          <el-form-item class="form-item" label="您的邮箱">
            <el-input v-model.trim="form.email"></el-input>
          </el-form-item>
          <el-form-item class="form-item" label="旧密码">
            <el-input v-model.trim="form.oldpassword"></el-input>
          </el-form-item>
          <el-form-item class="form-item" label="新密码">
            <el-input v-model.trim="form.newpassword"></el-input>
          </el-form-item>
          <el-form-item class="form-item">
            <el-button type="primary" @click="modifyPassword">确定修改</el-button>
          </el-form-item>
        </el-form>
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

  .form {
    margin: 8px auto 0 auto;
    width: fit-content;
  }

  .form-item {
    margin: 4px auto;
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
      activeName: 'user',
      updatePwd: false,
      form: {
        email: '',
        oldpassword: '',
        newpassword: ''
      }
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
      if (this.form.email === this.user.email && this.form.oldpassword === this.user.password) {
        const params = new URLSearchParams()
        params.append('email', this.form.email)
        params.append('usermark', this.user.user)
        params.append('oldpassword', this.form.oldpassword)
        params.append('newpassword', this.form.newpassword)

        this.$common.http.post(this.$common.api.UpdatePassword, params).then(response => {
          if (response.data === 'true') {
            this.$message('密码已修改')
          }
        }).catch(error => {
          this.$message({
            type: 'error',
            message: '密码保存失败,请重新修改'
          })
        })
      } else {
        this.$message('请填写正确的邮箱和密码!')
      }
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
