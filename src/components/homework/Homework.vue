<template>
 <div style="width: 100%;">
    <div class="title">
      <router-link class="router-link" to="/home/forum" replace><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
      <span>作业</span>
    </div>
    <header class="header">
      <navbar v-model="homework">
        <tab-item id="undone">未完成</tab-item>
        <tab-item id="done">已完成</tab-item>
      </navbar>
    </header>
    <tab-container v-model="homework">
      <tab-container-item id="undone">
        <loadmore :top-method="loadTopUndone" :bottom-method="loadBottomUndone" :bottom-all-loaded="undoneAllLoaded" ref="loadMoreUndone" :auto-fill="autoFill">
          <div class="list-title-item" v-for="homework in homeworkUndone" :key="homework.id" @click="showDetail(homework)">
            <div class="list-title-item-left">{{ homework.title }}</div>
            <div class="list-title-item-right">{{ homework.uptime }}</div>
          </div>
        </loadmore>
      </tab-container-item>
      <tab-container-item id="done">
        <loadmore :top-method="loadTopDone" :bottom-method="loadBottomDone" :bottom-all-loaded="doneAllLoaded" ref="loadMoreDone" :auto-fill="autoFill">
          <div class="list-title-item" v-for="homework in homeworkDone" :key="homework.id" @click="showDetail(homework)">
            <div class="list-title-item-left">{{ homework.title }}</div>
            <div class="list-title-item-right">{{ homework.uptime }}</div>
          </div>
        </loadmore>
      </tab-container-item>
    </tab-container>
  </div>
</template>

<style lang="css" scoped>
.list-title-item {
  display: flex;
  align-items: center;
  padding: 1.2rem .8rem;
  width: 100%;
}

.list-title-item-left {
  flex: 1;
  padding-right: .8rem;
  overflow-x: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  font-size: 16px;
}

.list-title-item-right {
  white-space: nowrap;
  color: #999;
  font-size: 12px;
}
</style>

<script>
import types from '@/store/types'
import { mapGetters } from 'vuex'
import { Toast, Loadmore, Navbar, TabItem, TabContainer, TabContainerItem } from 'mint-ui'

	export default {
    name: 'Homework',
    data() {
      return {
        homework: 'undone',
        autoFill: false,
        undoneAllLoaded: false,
        doneAllLoaded: false
      }
    },
    components: {
      Navbar,
      TabItem,
      Loadmore,
      TabContainer,
      TabContainerItem
    },
    created() {
      this.homework = this.isHomeworkDone;
      //判断是否已经进行过数据加载
      if(this.isHomeworkDone==='undone'&&this.homeworkUndone.length<1 || this.isHomeworkDone==='done'&&this.homeworkDone.length<1) {
        this.fetchHomework()
      }
    },
    beforeRouteLeave (to, from, next) {
      if (to.path==='/home') {
        this.$store.commit(types.CLEAR_HOMEWORK_HOMEWORKS)
        this.$store.commit(types.UPDATE_HOMEWORK_ISDONE, 'undone')
      }
      next()
    },
    methods: {
      loadTopUndone() {
        this.fetchHomework()
      },
      loadBottomUndone() {
        this.fetchHomework()
      },
      loadTopDone() {
        this.fetchHomework()
      },
      loadBottomDone() {
        this.fetchHomework()
      },
      showDetail(homework) {
        this.$store.commit(types.UPDATE_HOMEWORK_HOMEWORK, homework)
        this.$router.push('/homeworkdetail')
      },
      fetchHomework() {
        let params = new URLSearchParams()
        if(this.isHomeworkDone==='undone') {
          params.append('isfinish', 2);
          params.append('index', this.homeworkUndone.length)
        } else {
          params.append('isfinish', 1)
          params.append('index', this.homeworkDone.length)
        }
        params.append('studentid', this.user.userid)
        this.$common.http.post(this.$common.api.HomeworkList, params)
          .then(response => {
            if(this.isHomeworkDone==='undone') {
              this.$store.commit(types.ADD_HOMEWORK_UNDONE, response.data)
              this.$refs.loadMoreDone.onTopLoaded();
              this.$refs.loadMoreDone.onBottomLoaded();
              this.undoneAllLoaded = this.$common.jsonUtil.jsonLength(response.data.length) < 10
            } else {
              this.$store.commit(types.ADD_HOMEWORK_DONE, response.data)
              this.$refs.loadMoreUndone.onTopLoaded()
              this.$refs.loadMoreUndone.onBottomLoaded()
              this.doneAllLoaded = this.$common.jsonUtil.jsonLength(response.data.length) < 10
            }
          })
          .catch(error => {
            //以下是测试数据
            let works = [{
              id: 1,
              title: '2用React Natve做一个app',
              content: '1利用vue.js做一个简单的页面跳转',
              uptime: '2014-12-03'
            }, {
              id: 2,
              title: '2用React Natve做一个app',
              content: '1利用vue.js做一个简单的页面跳转',
              uptime: '2014-12-03'
            }, {
              id: 3,
              title: '2用React Natve做一个app',
              content: '1利用vue.js做一个简单的页面跳转',
              uptime: '2014-12-03'
            }];
            if(this.isHomeworkDone==='done') {
              this.$store.commit(types.ADD_HOMEWORK_DONE, works)
              this.$refs.loadMoreDone.onTopLoaded()
              this.$refs.loadMoreDone.onBottomLoaded()
            } else {
              this.$store.commit(types.ADD_HOMEWORK_UNDONE, works)
              this.$refs.loadMoreUndone.onTopLoaded()
              this.$refs.loadMoreUndone.onBottomLoaded()
            }
          });
      }
    },
    watch: {
      homework(val, oldval) {
        this.$store.commit(types.UPDATE_HOMEWORK_ISDONE, val)
        if(this.isHomeworkDone==='undone'&&this.homeworkUndone.length<1 || this.isHomeworkDone==='done'&&this.homeworkDone.length<1) {
          this.fetchHomework()
        }
      }
    },
    computed: {
      ...mapGetters([
        'homeworkUndone',
        'homeworkDone',
        'isHomeworkDone',
        'user'
      ])
    }
  }
</script>