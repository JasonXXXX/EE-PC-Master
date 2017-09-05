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
        <span class="article-icon-wrap" @click.stop="toggleComment">
          <icon name="commenting-o" class="article-icon"></icon>
          <span>评论</span>
        </span>
        <el-button class="article-comment-button" type="primary" v-if="writeComment" @click="handlePublishComment">发表评论</el-button>
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
    flex-direction: column;
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
import Convert from '@/common/util/convert.js'

export default {
  data () {
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
    isFavorite (detail) {
      const index = this.favoriteList.findIndex((item) => {
        return item.id == detail.id && item.mark == detail.mark
      })
      return index > -1
    },
    fetchNewsDetail () {
      this.$common.http.get(this.$common.api.MessageInfo + '?message_id=' + this.messageid)
        .then(response => {
          this.detail.comment_views = response.data.comment_views
          this.detail.content = response.data.content
          this.detail.id = response.data.id
          this.detail.mark = response.data.mark
          this.detail.message_mark = response.data.message_mark
          this.detail.send_time = response.data.send_time
          this.detail.sender_name = Convert.convertName(response.data.sender_mark, response.data.sender_id)
          this.detail.title = response.data.title
        })
        .catch(error => {
        })
    },
    handlePublishComment () {
      const time = this.$common.timeUtil.getDate()
      const params = new URLSearchParams()
      params.append('operate', 1)
      params.append('comment_content', this.comment)
      params.append('comment_sender_mark', this.user.user)
      params.append('comment_sender_id', this.user.userid)
      params.append('comment_root_id', this.messageid)
      params.append('comment_tocomment_id', 0)
      params.append('comment_send_time', time)

      this.$common.http.post(this.$common.api.PublishMessageComment, params).then(response => {
        if (response.data) {
          this.writeComment = false

          this.detail.comment_views.unshift({
            name: this.user.name,
            content: this.comment,
            send_time: time,
            sender_id: this.user.userid,
            sender_mark: this.user.user,
          })
        } else {

        }
      })
    }
  },
  computed: {
    ...mapGetters([
      'favoriteList',
      'messageid',
      'user'
    ])
  },
  watch: {
    'like': (newVal, oldVal) => {
      if ('heart' == newVal) {
        const params = new URLSearchParams()

        params.append('operate', 1)
        params.append('user_mark', this.user.user)
        params.append('like_message_id', this.messageid)
        params.append('like_user_id', this.user.userid)

        this.$common.http.post(this.$common.api.AddMessageLike, params).then(response => {

        }).catch(error => { })
      }
    },
    'star': (newVal, oldVal) => {
      if ('star' === newVal) {
        const params = new URLSearchParams()

        params.append('operate', 1)
        params.append('user_mark', this.user.user)
        params.append('mark_message_id', this.messageid)
        params.append('mark_user_id', this.user.userid)

        this.$common.http.post(this.$common.api.AddMessageStar, params).then(response => {

        }).catch(error => { })
      }
    }
  }
}
</script>
