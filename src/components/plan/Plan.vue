<template>
  <transition name="el-zoom-in-top">
    <div class="wrap">
      <header class="wrap-header">
        <i class="el-icon-check wrap-ctrl-icon" @click="handleSave"></i>
        <i class="el-icon-close wrap-ctrl-icon" @click="handleEmpty"></i>
      </header>
      <p class="wrap-time">{{time}}</p>
      <textarea class="wrap-content" v-model.trim="content" rows="6" :placeholder="$common.strings.plan_placeholder" @change="handleChange"></textarea>
      <p class="wrap-hint">{{content.length}}/{{$common.wordCountLimit.plan}}</p>
    </div>
  </transition>
</template>

<style lang="css" scoped>
  .wrap {
    display: flex;
    flex-direction: column;
    padding: 8px;
  }

  .wrap-header {
    display: flex;
    flex-direction: row-reverse;
    align-items: center;
    padding: 8px;
    border-bottom: .5px solid #BDBDBD;
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

  .wrap-time {
    padding: 8px;
    margin: 0;
    font-size: 13px;
    color: #999999;
    text-align: left;
  }

  .wrap-content {
    padding: 8px;
    font-size: 15px;
    color: #424242;
    outline: none;
    border: none;
  }

  .wrap-hint {
    margin: 0;
    padding: 0 8px;
    color: #B9B9B9;
    font-size: 12px;
    text-align: left;
  }
</style>

<script>
import types from '@/store/types'
import { mapGetters } from 'vuex'

export default {
  name: 'Plan',
  data () {
    return {
      time: '',
      content: '',
      mark: false,
      error: false
    }
  },
  created () {
    if (this.getPlanDraft.time) {
      this.time = this.getPlanDraft.time
      this.content = this.getPlanDraft.content
    } else if (!this.getPlan.time) {
      //如果在vuex中还没有计划内容，则进行初始化
      let params = new URLSearchParams()

      params.append('studentid', this.user.userid)
      
      this.$common.http.post(this.$common.api.PlanInfo, params)
        .then(response => {
          if (0 === this.$common.jsonUtil.jsonLength(response.data.length)) {
            this.time = this.$common.timeUtil.getDate()
            this.content = ''
          } else {
            this.time = response.data.set_time
            this.content = response.data.title
            let plan = {
              time: this.time,
              content: this.content
            }
            this.$store.commit(types.UPDATE_PLAN, plan)
          }
        })
        .catch(error => {
          this.error = true
          this.time = 'xxxx-xx-xx'
          this.content = '出错啦 :('
        })
    } else {
      this.time = this.getPlan.time
      this.content = this.getPlan.content
    }
  },
  beforeRouteLeave(to, from, next) {
    if (this.mark) {
      this.$confirm(this.$common.strings.plan_leaving_without_save, this.$common.strings.dialog_warning_type, {
        confirmButtonText: this.$common.strings.plan_save_draft_and_leave,
        cancelButtonText: this.$common.strings.dialog_button_no,
        type: 'warning'
      }).then(() => {
        this.$store.commit(types.UPDATE_PLAN_DRAFT, {
          time: this.$common.timeUtil.getDate(),
          content: this.content
        })

        this.$message({
          type: 'success',
          message: this.$common.strings.plan_after_save_draft
        })

        next()
      }).catch(() => {
        // next()
      })
    } else {
      next()
    }
  },
  methods: {
    handleChange () {
      this.mark = true
    },
    handleEmpty () {
      this.content = ''
      this.mark = true
    },
    handleSave () {
      let params = new URLSearchParams()

      params.append('plan_title', '')
      params.append('plan_content', this.content)
      params.append('plan_student_id', this.user.userid)
      params.append('plan_send_time', this.$common.timeUtil.getDate())

      this.$common.http.post(this.$common.api.StudyPlanUpdate, params).then(response => {
        if (1 === response.data.result) {
          this.$store.commit(types.UPDATE_PLAN, {
            time: this.$common.timeUtil.getDate(),
            content: this.content
          })
          this.$router.go(-1)
        } else {
          this.$confirm(this.$common.strings.plan_save_draft, this.$common.strings.dialog_warning_type, {
            confirmButtonText: this.$common.strings.dialog_button_yes,
            cancelButtonText: this.$common.strings.dialog_button_no,
            type: 'warning'
          }).then(() => {
            this.$store.commit(types.UPDATE_PLAN_DRAFT, {
              time: this.$common.timeUtil.getDate(),
              content: this.content
            })

            this.$message({
              type: 'success',
              message: this.$common.strings.plan_after_save_draft
            })

            this.mark = false
          }).catch(() => {
          })
        }
      }).catch(error => {
        this.error = true
        this.$confirm(this.$common.strings.plan_save_draft, this.$common.strings.dialog_warning_type, {
          confirmButtonText: this.$common.strings.dialog_button_yes,
          cancelButtonText: this.$common.strings.dialog_button_no,
          type: 'warning'
        }).then(() => {
          this.$store.commit(types.UPDATE_PLAN_DRAFT, {
            time: this.$common.timeUtil.getDate(),
            content: this.content
          })

          this.$message({
            type: 'success',
            message: this.$common.strings.plan_after_save_draft
          })

          this.mark = false
        }).catch(() => {
        })
      })
    },
    save() {
      let params = new URLSearchParams()

      params.append('plan_title', '')
      params.append('plan_content', this.content)
      params.append('plan_student_id', this.user.userid)
      params.append('plan_send_time', this.$common.timeUtil.getDate())

      this.$common.http.post(this.$common.api.StudyPlanUpdate, params).then(response => {
        if (1 === response.data.result) {
          this.$store.commit(types.UPDATE_PLAN, {
            time: this.$common.timeUtil.getDate(),
            content: this.content
          })
          this.$router.go(-1)
        } else {
          this.$confirm(this.$common.strings.plan_save_draft, this.$common.strings.dialog_warning_type, {
            confirmButtonText: this.$common.strings.dialog_button_yes,
            cancelButtonText: this.$common.strings.dialog_button_no,
            type: 'warning'
          }).then(() => {
            this.$store.commit(types.UPDATE_PLAN_DRAFT, {
              time: this.$common.timeUtil.getDate(),
              content: this.content
            })

            this.$message({
              type: 'success',
              message: this.$common.strings.plan_after_save_draft
            })
          }).catch(() => {
          })
        }
      }).catch(error => {
        this.error = true
        this.$confirm(this.$common.strings.plan_save_draft, this.$common.strings.dialog_warning_type, {
          confirmButtonText: this.$common.strings.dialog_button_yes,
          cancelButtonText: this.$common.strings.dialog_button_no,
          type: 'warning'
        }).then(() => {
          this.$store.commit(types.UPDATE_PLAN_DRAFT, {
            time: this.$common.timeUtil.getDate(),
            content: this.content
          })

          this.$message({
            type: 'success',
            message: this.$common.strings.plan_after_save_draft
          })
        }).catch(() => {
        })
      })
    },
    refresh() {
      let params = new URLSearchParams()
      params.append('studentid', this.user.userid)
      this.$common.http.post(this.$common.api.PlanInfo, params)
        .then(response => {
          if (0 === this.$common.jsonUtil.jsonLength(response.data.length)) {
            this.time = this.$common.timeUtil.getDate()
            this.content = ''

          } else {
            this.time = response.data.set_time
            this.content = response.data.title
            let plan = {
              time: this.time,
              content: this.content
            }
            this.$store.commit(types.UPDATE_PLAN, plan)
          }
        })
        .catch(error => {
          this.error = true
          this.time = 'xxxx-xx-xx'
          this.content = '出错啦 :('
        })
    }
  },
  watch: {
    content() {
      this.mark = !(this.content==='出错啦 :(')
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'getPlan',
      'getPlanDraft'
    ])
  }
}
</script>