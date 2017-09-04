<template>
  <div class="config-wrap wrap">
    <header class="wrap-header">
      <i class="el-icon-d-arrow-left" @click="back"></i>
    </header>
    <article class="wrap-article">
      <li class="article-title-indicator">
        <h1 class="article-title">{{detail.title}}</h1>
      </li>
      <div class="article-info">
        <li class="article-title-indicator">
          <span class="article-info-detail">{{detail.sender_name}}</span>
          <span class="article-info-detail">{{detail.send_time}}</span>
        </li>
      </div>
      <p class="article-content" v-text="detail.content"></p>
      <div class="article-control">
        <span class="article-icon-wrap" @click.stop="toggleLike">
          <icon :name="like" class="article-icon"></icon>
          <span>点赞</span>
        </span>
        <span class="article-icon-wrap" @click.stop="toggleStar" style="flex: 1;">
          <icon :name="star" class="article-icon"></icon>
          <span>收藏</span>
        </span>
        <span class="article-icon-wrap" @click.stop="toggleComment" v-if="!writeComment">
          <icon name="commenting-o" class="article-icon"></icon>
          <span>评论</span>
        </span>
        <el-button class="article-comment-button" type="primary" v-if="writeComment">发表评论</el-button>
      </div>
      <textarea class="article-comment-ta" v-model.trim="comment" v-if="writeComment" placeholder="随便说点什么吧~" maxlength="100"></textarea>
      <span class="article-comment-hint" v-if="writeComment">{{comment.length}}/{{$common.wordCountLimit.comment}}</span>
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
    font-size: 17px;
    color: #424242;
  }

  .article-control {
    display: flex;
    align-items: center;
  }

  .article-icon-wrap {
    display: flex;
    align-items: center;
    margin: 8px 8px 0 0;
    font-size: 13px;
    color: #919191;
    transition: color .8s ease;
  }

  .article-icon-wrap:hover {
    color: #2070FF;
  }

  .article-icon {
    margin: 0 4px;
  }

  .article-comment-button {
    font-size: 13px;
    padding: 6px 12px;
  }

  .article-comment-ta {
    margin: 12px -12px 0 -12px;
    padding: 12px;
    width: 100%;
    line-height: 24px;
    font-size: 15px;
    color: #424242;
    outline: none;
    border: none;
    border-top: .5px solid #CDCDCD;
  }

  .article-comment-hint {
    color: #959595;
    font-size: 13px;
  }
</style>

<script>
import router from '@/router/index'
import types from '@/store/types'
import atypes from '@/store/action-types'
import { mapGetters } from 'vuex'
import 'vue-awesome/icons/heart-o'
import 'vue-awesome/icons/heart'
import 'vue-awesome/icons/star-o'
import 'vue-awesome/icons/star'
import 'vue-awesome/icons/commenting-o'
import CommentItem from './ForumCommentItem'
import Convert from '@/common/util/convert'
import Cache from '@/common/util/cache'

export default {
  data () {
    return {
      detail: {
        comment_views: [],
        // comment_name: '',
        content: '',
        mark: 1,
        message_mark: 0,
        send_time: '',
        sender_name: '',
        title: ''
      },
      commentText: '',
      like: 'heart-o',
      star: 'star-o',
      writeComment: false,
      comment: ''
    }
  },
  components: {
    CommentItem
  },
  created () {
    this.fetchNewsDetail()
  },
  methods: {
    back () {
      this.$router.back()
    },
    toggleLike () {
      this.like = this.like === 'heart-o' ? 'heart' : 'heart-o'
    },
    toggleStar () {
      this.star = this.star === 'star-o' ? 'star' : 'star-o'
    },
    toggleComment () {
      this.writeComment = !this.writeComment
    },
    getMyTime () {
      let now = new Date()
      let year = now.getFullYear()
      let month = now.getMonth() + 1
      let day = now.getDate()
      let today = year + "-" + month + "-" + day
      return today
    },
    addComment () {
      if (this.commentText !== '') {
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
    canelComment () {
      this.commentText = ''
    },
    toggleFavorite (detail) {
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
    getFavoriteIcon (detail) {
      if (this.isFavorite(detail)) {
        return 'glyphicon-heart'
      }
      return 'glyphicon-heart-empty'
    },
    isFavorite () {
      const index = this.likes.findIndex((item) => {
        return item == this.messageid
      })
      return index > -1
    },
    isStarred () {
      const index = this.stars.findIndex((item) => {
        return item == this.messageid
      })
      return index > -1
    },
    fetchNewsDetail () {
      this.$common.http.get(this.$common.api.MessageInfo + '?message_id=' + this.messageid)
        .then(response => {
          this.detail.comment_views = response.data.comment_views
          this.detail.content = response.data.content
          this.detail.mark = response.data.mark
          this.detail.message_mark = response.data.message_mark
          this.detail.send_time = response.data.send_time
          this.detail.sender_name = Convert.convertName(response.data.sender_mark, response.data.sender_id)
          this.detail.title = response.data.title
        })
        .catch(error => {
          //测试数据
          // let newsDetail = {
          //   comment_views: [{
          //     comment_tocomment_id: 1,
          //     content: "好厉害！瞬间就明白了都，希望作者多多出这样的良心文章!!!坐等更新~",
          //     id: 1,
          //     send_time: "2017-04-18",
          //     name: 'Jason',
          //     sender_id: 1,
          //     sender_mark: 2
          //   }, {
          //     comment_tocomment_id: 2,
          //     content: "新技能get！",
          //     id: 2,
          //     send_time: "2017-04-20",
          //     name: 'Jason',
          //     sender_id: 2,
          //     sender_mark: 2
          //   }, {
          //     comment_tocomment_id: 1,
          //     content: "好厉害！瞬间就明白了都，希望作者多多出这样的良心文章",
          //     id: 1,
          //     send_time: "2017-04-18",
          //     name: 'Jason',
          //     sender_id: 1,
          //     sender_mark: 2
          //   }, {
          //     comment_tocomment_id: 2,
          //     content: "新技能get！",
          //     id: 2,
          //     send_time: "2017-04-20",
          //     name: 'Jason',
          //     sender_id: 2,
          //     sender_mark: 2
          //   }, {
          //     comment_tocomment_id: 3,
          //     content: "见解独到，佩服佩服",
          //     id: 3,
          //     send_time: "2017-04-25",
          //     name: 'Jason',
          //     sender_id: 3,
          //     sender_mark: 2
          //   }
          //   ],
          //   content: "我们经常需要把某种模式匹配到的所有路由，全都映射到同个组件。例如，我们有一个 User 组件，对于所有 ID 各不相同的用户，都要使用这个组件来渲染。那么，我们可以在 vue-router 的路由路径中使用『动态路径参数』（dynamic segment）来达到这个效果.一个『路径参数』使用冒号 : 标记。当匹配到一个路由时，参数值会被设置到 this.$route.params，可以在每个组件内使用。于是，我们可以更新 User 的模板，输出当前用户的 ID .提醒一下，当使用路由参数时，例如从 /user/foo 导航到 user/bar，原来的组件实例会被复用。因为两个路由都渲染同个组件，比起销毁再创建，复用则显得更加高效。不过，这也意味着组件的生命周期钩子不会再被调用。",
          //   id: 2,
          //   mark: 1,
          //   message_mark: 2,
          //   send_time: "2017-1-2",
          //   sender_id: 1,
          //   sender_mark: 1,
          //   title: "6660分钟vue快速入门"
          // }
          // this.detail.comment_views = newsDetail.comment_views
          // this.detail.content = newsDetail.content
          // this.detail.id = newsDetail.id
          // this.detail.mark = newsDetail.mark
          // this.detail.message_mark = newsDetail.message_mark
          // this.detail.send_time = newsDetail.send_time
          // this.detail.sender_name = Convert.convertName(newsDetail.sender_mark, newsDetail.sender_id)
          // this.detail.title = newsDetail.title
          // this.detail.comment_name = Convert.convertName(newsDetail.comment_views.sender_mark , newsDetail.comment_views.sender_id)

        })
    },

  },
  computed: {
    ...mapGetters([
      'messageid',
      'user',
      'stars',
      'likes'
    ])
  },
  watch: {
    'like': (newVal, oldVal) => {
      if ('heart' == newVal) {
        this.$store.commit(types.ADD_LIKE, this.messageid)

        const params = new URLSearchParams()
        params.append('operate', 1)
        // params.append('user_mark', this.user.user)
        params.append('like_message_id', this.messageid)
        // params.append('like_user_id', this.user.userid)

        this.$common.http.post(this.$common.api.AddMessageLike, params).then(response => {
        }).catch(error => {
          this.$store.commit(types.DELETE_LIKE, this.messageid)
        })
      } else {
        this.$store.commit(types.DELETE_LIKE, this.messageid)
        const params = new URLSearchParams()

        params.append('operate', 2)
        params.append('like_message_id', this.messageid)

        this.$common.http.post(this.$common.api.AddMessageLike, params).then(response => {
        }).catch(error => {
          this.$store.commit(types.ADD_LIKE, this.messageid)

        })
      }
    },
    'star': (newVal, oldVal) => {
      if ('star' === newVal) {
        this.$store.commit(types.ADD_STAR, this.messageid)
        const params = new URLSearchParams()

        params.append('operate', 1)
        params.append('user_mark', this.user.user)
        params.append('mark_message_id', this.messageid)
        params.append('mark_user_id', this.user.userid)

        this.$common.http.post(this.$common.api.AddMessageStar, params).then(response => {
        }).catch(error => {
          this.$store.commit(types.DELETE_STAR, this.messageid)
        })
      } else {
        this.$store.commit(types.DELETE_STAR, this.messageid)
        const params = new URLSearchParams()

        params.append('operate', 2)
        params.append('user_mark', this.user.user)
        params.append('mark_message_id', this.messageid)
        params.append('mark_user_id', this.user.userid)

        this.$common.http.post(this.$common.api.AddMessageStar, params).then(response => {
        }).catch(error => {
          this.$store.commit(types.ADD_STAR, this.messageid)
        })
      }
    }
  }
}
</script>
