<template>
  <transition name="el-zoom-in-top">
    <div :class="['div', {highlight:edit}]">
      <div class="wrap">
        <div class="wrap-content">
          <el-tooltip :disabled="edit" :content="'我的答案: '+item.work_content" placement="bottom" effect="light">
            <span class="content-problem">{{item.work_title}}</span>
          </el-tooltip>
          <span class="content-time">{{item.uptime}}</span>
        </div>
        <div class="wrap-ctrl">
          <i class="el-icon-edit wrap-ctrl-icon" v-if="!edit" @click="handleEdit"></i>
          <i class="el-icon-close wrap-ctrl-icon" v-if="edit" @click="handleClose"></i>
          <i class="el-icon-check wrap-ctrl-icon" v-if="edit" @click="handleSave"></i>
          <i class="el-icon-delete wrap-ctrl-icon" @click="hadnleDelete"></i>
          <el-checkbox class="ctrl-check" v-model="checked" @change="handleChange"></el-checkbox>
        </div>
      </div>
      <transition name="el-zoom-in-top">
        <div class="answer" v-if="edit">
          <textarea class="answer-ta" v-model.trim="answer" maxlength="200" :placeholder="$common.strings.homework_answer_placeholder"></textarea>
          <span class="answer-hint">{{answer.length}}/{{$common.wordCountLimit.homework}}</span>
        </div>
      </transition>
    </div>
  </transition>
</template>

<style scoped>
  .div {
    border-bottom: .5px solid #BDBDBD;
    padding: 12px 8px 12px 12px;
    transition: height .3s ease;
  }

  .wrap {
    display: flex;
    align-items: center;
  }

  .wrap-content {
    flex-grow: 1;
    text-align: left;
  }

  .content-problem {
    display: block;
    margin: 4px 0;
    padding: 0;
    color: #424242;
    font-size: 17px;
    text-overflow: ellipsis;
  }

  .content-time {
    color: #A9A9A9;
    font-size: 13px;
  }

  .wrap-ctrl {
    display: flex;
    align-items: center;
  }

  .wrap-ctrl-icon {
    margin: 0 8px;
    padding: 2px;
    color: #989898;
    transition: all .6s ease;
  }

  .wrap-ctrl-icon:hover,
  .wrap-ctrl-icon:active {
    color: #2155dC;
    border-bottom: .5px solid #999999;
  }

  .ctrl-check {
    margin: 0 0 0 8px;
  }

  .answer {
    text-align: left;
  }

  .highlight {
    margin: 4px 2px;
    /* border: .5px solid #2155dC; */
    box-shadow: 2px 2px 16px #999999;
  }

  .answer-ta {
    margin: 12px -12px 0 -12px;
    padding: 12px;
    width: 100%;
    line-height: 24px;
    font-size: 15px;
    color: #747474;
    outline: none;
    border: none;
    border-top: .5px solid #BDBDBD;
  }

  .answer-hint {
    font-size: 12px;
    color: #898989;
  }
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'

export default {
  name: 'HomeworkItem',
  props: ['item'],
  data () {
    return {
      checked: false,
      edit: false,
      answer: this.item.work_content
    }
  },
  methods: {
    handleChange (event) {
      if (event.target.checked) {
        this.$store.commit(types.ADD_HOMEWORK_SELECTED, this.item.id)
      } else {
        this.$store.commit(types.DELETE_HOMEWORK_SELECTED, this.item.id)
      }
    },
    handleEdit () {
      this.edit = true
    },
    handleClose () {
      this.edit = false
    },
    handleSave () {
      this.$confirm('确定更新答案?', '确认', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'confirm'
      }).then(() => {
        let params = new URLSearchParams()

        params.append('work_id', this.item.id)
        params.append('work_content', this.answer)

        this.$common.http.post(this.$common.api.HomeworkUpdate, params).then(response => {
          if ('true' == response.data.result) {
            let data = {
              id: this.item.id,
              content: this.answer,
              uptime: this.$common.timeUtil.getDate()
            }
            this.$store.commit(types.UPDATE_HOMEWORK_HOMEWORKS, data)
            this.$message({
              type: 'success',
              message: this.$common.strings.homework_after_save_message
            })
            this.edit = false
          } else {
            this.$message({
              type: 'error',
              message: this.$common.strings.homework_after_save_failed_message
            })
          }
        }).catch(error => {
          //测试结果
          let data = {
            id: this.item.id,
            content: this.answer,
            uptime: this.$common.timeUtil.getDate()
          }
          this.$store.commit(types.UPDATE_HOMEWORK_HOMEWORKS, data)
          this.$message({
            type: 'success',
            message: this.$common.strings.homework_after_save_message
          })
          this.edit = false
        })
      }).catch(() => {
      })
    },
    hadnleDelete () {
      this.$confirm(this.$common.strings.homework_warning_message, this.$common.strings.dialog_warning_type, {
        confirmButtonText: this.$common.strings.dialog_button_yes,
        cancelButtonText: this.$common.strings.dialog_button_no,
        type: 'warning'
      }).then(() => {
        this.$store.commit(types.DELETE_HOMEWORK_HOMEWORK, {
          mark: this.item.content.length != 0,
          id: this.item.id
        })
        this.answer = ''

        this.$message({
          type: 'success',
          message: '该答案已删除!'
        })
      }).catch(() => {
      })
    }
  },
  computed: {
    ...mapGetters([
      'homeworkSelected'
    ])
  },
  watch: {
    homeworkSelected () {
      if (this.homeworkSelected.length > 0) {
        this.homeworkSelected.every(item => {
          this.checked = item === this.item.id
          return !this.checked
        })
      } else {
        this.checked = false
      }
    },
    'item.content': {
      handler (newVal, oldVal) {
        this.answer = newVal
        if (newVal == '') {
          this.checked = false
        }
      },
      deep: true
    }
  }
}
</script>
