<template>
  <div class="wrap">
    <header class="wrap-header">
      <i class="el-icon-d-arrow-left" @click="back"></i>
    </header>
    <article class="wrap-article">
      <li class="article-title-indicator"><h1 class="article-title">{{detail.title}}</h1></li>
      <div class="article-info">
        <li class="article-title-indicator">
          <span class="article-info-detail">{{detail.sender_name}}</span>
          <span class="article-info-detail">{{detail.send_time}}</span>
        </li>
      </div>
      <p class="article-content" v-text="detail.content"></p>
    </article>
    <div class="wrap-comment">
      <comment-item v-for="comment in detail.comment_views" :comment="comment" :key="comment.id"></comment-item>
    </div>
  </div>
</template>

<style scoped>
  .wrap {
    text-align: left;
  }

  .el-icon-d-arrow-left {
    padding: 12px 18px;
    transform: all .8s ease;
  }

  .el-icon-d-arrow-left:hover {
    color: #0873F9;
    box-shadow: 0px .5px 2px #BDBDBD;
  }

  .wrap-header {
    margin: 0;
    padding: 8px;
    border-bottom: .5px solid #CDCDCD;
  }

  .wrap-article {
    margin: 0;
    padding: 8px;
    border-bottom: .5px solid #CDCDCD;
  }

  .article-header-indicator {
    list-style-type: circle;
  }

  .article-title {
    display: inline-block;
    margin: 16px 0 4px 0;
  }

  .article-info {
    padding: 0;
    margin: 0 0 8px 0;
  }

  .article-info-detail {
    display: inline-block;
    margin: 4px 8px 4px 0;
    color: #959595;
    font-size: 14px;
  }

  .article-content {
    text-indent: 32px;
    line-height: 28px;
    color: #424242;
  }
</style>

<script>
import router from '@/router/index'
import types from '@/store/types'
import atypes from '@/store/action-types'
import { mapGetters } from 'vuex'
import CommentItem from './ForumCommentItem'
import Convert from '@/common/util/convert.js'

export default {
  data() {
    return {
      detail: {
        comment_views: [],
        // comment_name: '',
        content: '',
        id: 0,
        mark: 1,
        message_mark: 0,
        send_time: '',
        sender_name: '',
        title: ''
      },
      commentText: ''
    }
  },
  components: {
    CommentItem
  },
  created() {
    this.fetchNewsDetail()
  },
  methods: {
    back () {
      this.$router.back()
    },
    getMyTime() {
      let now = new Date()
      let year = now.getFullYear()
      let month = now.getMonth() + 1
      let day = now.getDate()
      let today = year + "-" + month + "-" + day
      return today
    },
    addComment(){
      if (this.commentText!==''){
        this.detail.comment_views.push({
          comment_tocomment_id: 1,
          content: this.commentText,
          id: 1,
          send_time: this.getMyTime(),
          sender_id: this.user.userid,
          sender_mark: 2
        })
        this.commentText = ''
      }
    },
    canelComment(){
      this.commentText = ''
    },
    toggleFavorite(detail) {
      if (this.isFavorite(detail)) {
        // this.$context.commit(atypes.DELETE_FAVORITE_LIST, detail)
        this.$store.dispatch(atypes.DELETE_FAVORITE_LIST, detail)
        // this.deleteFavoriteList(detail)
        console.log(this.favoriteList)
      } else {
        // this.$context.commit(atypes.SAVE_FAVORITE_LIST, detail)
        // this.saveFavoriteList(detail)
        this.$store.dispatch(atypes.SAVE_FAVORITE_LIST, detail)
        console.log(this.favoriteList)
      }
    },
    getFavoriteIcon(detail) {
      if (this.isFavorite(detail)) {
        return 'glyphicon-heart'
      }
      return 'glyphicon-heart-empty'
    },
    isFavorite(detail) {
      const index = this.favoriteList.findIndex((item) => {
        return item.id == detail.id && item.mark == detail.mark
      })
      return index > -1
    },
    fetchNewsDetail() {
      this.$common.http.get(this.$common.api.MessageInfo+'?message_id='+this.$route.params.newsid)
        .then(response => {
          this.detail.comment_views = response.data.comment_views
          this.detail.content = response.data.content
          this.detail.id = response.data.id
          this.detail.mark = response.data.mark
          this.detail.message_mark = response.data.message_mark
          this.detail.send_time = response.data.send_time
          this.detail.sender_name = Convert.convertName(response.data.sender_mark , response.data.sender_id)
          this.detail.title = response.data.title
          // this.detail.comment_name = Convert.convertName(response.data.comment_views.sender_mark , response.data.comment_views.sender_id)
        })
        .catch(error => {
          //测试数据
          let newsDetail = {
            comment_views: [{
              comment_tocomment_id: 1,
              content: "好厉害！瞬间就明白了都，希望作者多多出这样的良心文章!!!坐等更新~",
              id: 1,
              send_time: "2017-04-18",
              name: 'Jason',
              sender_id: 1,
              sender_mark: 2
            },{
              comment_tocomment_id: 2,
              content: "新技能get！",
              id: 2,
              send_time: "2017-04-20",
              name: 'Jason',
              sender_id: 2,
              sender_mark: 2
            },{
              comment_tocomment_id: 1,
              content: "好厉害！瞬间就明白了都，希望作者多多出这样的良心文章",
              id: 1,
              send_time: "2017-04-18",
              name: 'Jason',
              sender_id: 1,
              sender_mark: 2
            },{
              comment_tocomment_id: 2,
              content: "新技能get！",
              id: 2,
              send_time: "2017-04-20",
              name: 'Jason',
              sender_id: 2,
              sender_mark: 2
            },{
              comment_tocomment_id: 3,
              content: "见解独到，佩服佩服",
              id: 3,
              send_time: "2017-04-25",
              name: 'Jason',
              sender_id: 3,
              sender_mark: 2
            }
            ],
          content: "我们经常需要把某种模式匹配到的所有路由，全都映射到同个组件。例如，我们有一个 User 组件，对于所有 ID 各不相同的用户，都要使用这个组件来渲染。那么，我们可以在 vue-router 的路由路径中使用『动态路径参数』（dynamic segment）来达到这个效果.一个『路径参数』使用冒号 : 标记。当匹配到一个路由时，参数值会被设置到 this.$route.params，可以在每个组件内使用。于是，我们可以更新 User 的模板，输出当前用户的 ID .提醒一下，当使用路由参数时，例如从 /user/foo 导航到 user/bar，原来的组件实例会被复用。因为两个路由都渲染同个组件，比起销毁再创建，复用则显得更加高效。不过，这也意味着组件的生命周期钩子不会再被调用。",
          id: 2,
          mark: 1,
          message_mark: 2,
          send_time: "2017-1-2",
          sender_id: 1,
          sender_mark: 1,
          title: "6660分钟vue快速入门"
        }
          this.detail.comment_views = newsDetail.comment_views
          this.detail.content = newsDetail.content
          this.detail.id = newsDetail.id
          this.detail.mark = newsDetail.mark
          this.detail.message_mark = newsDetail.message_mark
          this.detail.send_time = newsDetail.send_time
          this.detail.sender_name = Convert.convertName(newsDetail.sender_mark , newsDetail.sender_id)
          this.detail.title = newsDetail.title
          // this.detail.comment_name = Convert.convertName(newsDetail.comment_views.sender_mark , newsDetail.comment_views.sender_id)

        });
    },

  },
  computed: {
    ...mapGetters([
      'favoriteList',
      'user'
    ])
  }
}
</script>