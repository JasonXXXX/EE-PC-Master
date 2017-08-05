<template>
  <div class="plan-div">
  <div class="title" >
    <router-link class="router-link" to="/home/forum" replace><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
    <span class="center">学习计划</span>
    <transition-group name="fade">
      <span key="save" class="glyphicon glyphicon-saved" aria-hidden="true" @click="save" v-if="mark"></span >
      <span key="refresh" class="glyphicon glyphicon-refresh" aria-hidden="true" @click="refresh" v-if="error&&(!mark)" ></span >
    </transition-group>
  </div>
  <div class="plan-content">
    <p class="plan-content-time">{{ time }}</p>
    <textarea class="plan-content-content" placeholder="背单词..." v-model.lazy.trim="content"></textarea>
  </div>
</div>
</template>

<style lang="css" scoped>
.plan-div {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100vh;
}

.plan-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 0;
  margin: 0;
  width: 100%;
}

.plan-content-time {
  width: 100%;
  padding: .4rem .8rem;
  margin: 5rem 0 0 0;
  color: #33B0AB;
  font-size: 12px;
}

.plan-content-content {
  flex: 1;
  padding: .8rem;
  margin: 0;
  font-size: 14px;
  border: none;
  outline: none;
}
</style>

<script>
import types from '@/store/types'
import { mapGetters } from 'vuex'
import { Toast, MessageBox } from 'mint-ui'

export default {
  name: 'Plan',
  data() {
    return {
      time: '',
      content: '',
      mark: false,
      error: false
    }
  },
  mounted() {
    this.init();
  },
  beforeRouteLeave(to, from, next) {
  if (this.mark && !this.error) {
      MessageBox.confirm('返回将丢失修改的内容。是否返回？').then(action => {
        next()
      })
    } else {
      next()
    }
  },
  methods: {
    init() {
      if(this.getPlanDraft.time) {
        this.time = this.getPlanDraft.time;
        this.content = this.getPlanDraft.content;
      } else if(!this.getPlan.time) {
        //如果在vuex中还没有计划内容，则进行初始化
        let params = new URLSearchParams();
      params.append('studentid', this.user.userid);
      this.$common.http.post(this.$common.api.PlanInfo, params)
        .then(response => {
          if (0 === this.$common.jsonUtil.jsonLength(response.data.length)) {
            this.time = this.$common.timeUtil.getDate();
            this.content = '';
          } else {
            this.time = response.data.set_time;
            this.content = response.data.title;
            let plan = {
              time: this.time,
              content: this.content
            };
            this.$store.commit(types.UPDATE_PLAN, {plan: plan});
          }
        })
        .catch(error => {
          Toast({
            message: '访问出错，请刷新',
            position: 'bottom',
            duration: 2000
          });
          this.error = true;
          this.time = 'xxxx-xx-xx';
          this.content = '出错啦 :(';
        });
      } else {
        this.time = this.getPlan.time;
        this.content = this.getPlan.content;
      }
    },
    save() {
      let params = new URLSearchParams()
      params.append('plan_title', '')
      params.append('plan_content', this.content)
      params.append('plan_student_id', this.user.userid)
      params.append('plan_send_time', this.$common.timeUtil.getDate())
      this.$common.http.post(this.$common.api.StudyPlanUpdate, params).then(response => {
        if (1 === response.data.result) {
          Toast({
            message: '计划已保存',
            position: 'bottom',
            duration: 2000
          });
          this.$store.commit(types.UPDATE_PLAN, {plan: {time: this.$common.timeUtil.getDate(),content: this.content}});
          this.$router.go(-1);
        } else {
          MessageBox.confirm('保存失败，是否存入草稿？').then(action => {
            this.$store.commit(types.UPDATE_PLAN_DRAFT, {draft: {time: this.$common.timeUtil.getDate(),content: this.content}});
            Toast({
              message: '草稿已保存',
              position: 'bottom',
              duration: 2000
            })
            this.$router.go(-1)
          })
        }
      }).catch(error => {
        this.error = true
        MessageBox.confirm('网络发生错误，是否存入草稿？').then(action => {
          this.$store.commit(types.UPDATE_PLAN_DRAFT, {draft: {time: this.$common.timeUtil.getDate(),content: this.content}})
          Toast({
            message: '草稿已保存',
            position: 'bottom',
            duration: 2000
          })
          this.$router.go(-1)
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
            Toast({
              message: '更新失败',
              position: 'bottom',
              duration: 2000
            })
          } else {
            this.time = response.data.set_time
            this.content = response.data.title
            let plan = {
              time: this.time,
              content: this.content
            }
            this.$store.commit(types.UPDATE_PLAN, {plan: plan})
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