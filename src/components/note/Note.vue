<template>
  <div style="margin-top: 5rem;width: 100%;">
    <div class="title">
      <router-link class="router-link" to="/home/forum" replace><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></router-link>
      <span>笔记</span>
    </div>
    <div v-infinite-scroll="loadMore" infinite-scroll-disabled="loading" infinite-scroll-distance="8">
      <div class="list-title-item" v-for="note in getNotes" :key="note.id" @click="showDetail(note)">
        <div class="list-title-item-left">{{ note.title }}</div>
        <div class="list-title-item-right">{{ note.set_time }}</div>
      </div>
    </div>
    <div class="snote-a" @click="add">+</div>
  </div>
</template>

<style scoped>
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

.snote-a {
  position: fixed;
  right: 24px;
  bottom: 36px;
  border-radius: 50%;
  background-color: #FFFFFF;
  box-shadow: 2px 2px 16px #AAA;
  width: 48px;
  height: 48px;
  text-align: center;
  line-height: 48px;
  font-size: 3rem;
  z-index: 5;
}

.snote-a>span {
  padding: 0;
  margin: 0;
  line-height: 48px;
  font-size: 32px;
}
</style>

<script>
import types from '@/store/types'
import Vue from 'vue'
import { mapGetters } from 'vuex'
import { InfiniteScroll, Toast } from 'mint-ui'

Vue.use(InfiniteScroll)

export default {
  name: 'Note',
  data() {
    return {
      ifNoMore: false,
      loading: false
    }
  },
  mounted() {
  },
  beforeRouteLeave(to, from, next) {
    if (to.path==='/home') {
      this.$store.commit(types.CLEAR_NOTE_NOTES)
    }
    next()
  },
  methods: {
    del() {

    },
    loadMore() {
      if(this.getNotes.length<1) {
        this.fetchData();
      }
    },
    showDetail(note) {
      this.$store.commit(types.UPDATE_NOTE_NOTE, {note: note})
      this.$router.push('/notedetail')
    },
    add() {
      this.$router.push('/addnote')
    },
    fetchData() {
      this.loading = true;
      this.$common.http.get(this.$common.api.StudentNoteList+'?studentid='+this.getUser.userid+'$index='+this.getUser.index)
        .then(response => {
          this.loading = false;
          if(this.$common.jsonUtil.jsonLength(response.data)>0) {
            this.$store.commit(types.ADD_NOTE_NOTES, { notes: response.data })
          }
          if(this.$common.jsonUtil.jsonLength(response.data) < 10) {
          }
        })
        .catch(error => {
          this.loading = false;
          //测试数据
          let notes = [{
            title: '掌握vue的数组渲染、模板语法、数据绑定、路由管理等基础知识，并尝试实践应用',
            set_time: '2017-04-21',
            id: 3
          }, {
            title: '学习vue跟angularjs的不同',
            set_time: '2017-04-21',
            id: 2
          }, {
            title: '学会用react-native做hybrid开发',
            set_time: '2017-04-21',
            id: 1
          }, {
            title: '掌握vue的数组渲染、模板语法、数据绑定、路由管理等基础知识，并尝试实践应用',
            set_time: '2017-04-21',
            id: 3
          }, {
            title: '学习vue跟angularjs的不同',
            set_time: '2017-04-21',
            id: 2
          }, {
            title: '学会用react-native做hybrid开发',
            set_time: '2017-04-21',
            id: 1
          }, {
            title: '掌握vue的数组渲染、模板语法、数据绑定、路由管理等基础知识，并尝试实践应用',
            set_time: '2017-04-21',
            id: 3
          }, {
            title: '学习vue跟angularjs的不同',
            set_time: '2017-04-21',
            id: 2
          }, {
            title: '学会用react-native做hybrid开发',
            set_time: '2017-04-21',
            id: 1
          }, {
            title: '掌握vue的数组渲染、模板语法、数据绑定、路由管理等基础知识，并尝试实践应用',
            set_time: '2017-04-21',
            id: 3
          }, {
            title: '学习vue跟angularjs的不同',
            set_time: '2017-04-21',
            id: 2
          }, {
            title: '学会用react-native做hybrid开发',
            set_time: '2017-04-21',
            id: 1
          }, {
            title: '学习vue跟angularjs的不同',
            set_time: '2017-04-21',
            id: 2
          }, {
            title: '学会用react-native做hybrid开发',
            set_time: '2017-04-21',
            id: 1
          }, {
            title: '掌握vue的数组渲染、模板语法、数据绑定、路由管理等基础知识，并尝试实践应用',
            set_time: '2017-04-21',
            id: 3
          }, {
            title: '学习vue跟angularjs的不同',
            set_time: '2017-04-21',
            id: 2
          }, {
            title: '学会用react-native做hybrid开发',
            set_time: '2017-04-21',
            id: 1
          }]
          this.$store.commit(types.ADD_NOTE_NOTES, { notes: notes })
        })
    }
  },
  computed: {
    ...mapGetters({
      getNotes: 'notes',
      getUser: 'user'
    })
  }
}
</script>