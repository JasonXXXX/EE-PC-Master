<template>
	<div>
		<forum-item v-for="item in news" :key="item.id" :item="item"></forum-item>
  </div>
</template>

<script>
import types from '@/store/types'
import atypes from '@/store/action-types'
import { mapGetters } from 'vuex'
import { Message } from 'element-ui'
import ForumItem from './ForumItem'

export default {
	name: 'ForumNews',
	data () {
	  return {
	  }
	},
  components: {
		ForumItem
  },
	created () {
	  if(this.news.length<1) {
	  	this.fetchNews()
	  }
	},
	methods: {
    getFavoriteIcon (detail) {
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
		loadTop() {
      this.fetchNews()
    },
    loadBottom() {
      this.fetchNews()
    },
    showDetail(id, title) {
      this.$router.push({
        path: '/newsdetail/' + id + '/title/' + title
      })
    },
	  fetchNews() {
	  	let params = new URLSearchParams()
      params.append('message_mark', 1)
      params.append('index', this.news.length)
    	this.$common.http.post(this.$common.api.MessageList, params)
    	  .then(response => {
          if (this.$common.jsonUtil.jsonLength(response.data) < 5) {

          	this.allLoaded = true
          }
          this.$store.commit(types.ADD_FORUM_NEWS, {news: response.data})
          this.$refs.loadMore.onTopLoaded()
          this.$refs.loadMore.onBottomLoaded()
        })
    	  .catch(error => {
    	    //测试数据
    	    let news = [{
    	      id: 2,
    	      mark: 1,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '尤雨溪',
    	      sender_mark: 2,
    	      title: '60分钟vue快速入门'
    	    },{
    	      id: 1,
    	      mark: 1,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '大神',
    	      sender_mark: 2,
    	      title: '你不知道的node.js'
    	    },{
    	      id: 3,
    	      mark: 1,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '大神',
    	      sender_mark: 2,
    	      title: '8天node.js快速入门'
    	     },{
    	      id: 4,
    	      mark: 1,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '大神',
    	      sender_mark: 2,
    	      title: '8天node.js快速入门'
    	     },{
    	      id: 5,
    	      mark: 1,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '阮一峰',
    	      sender_mark: 2,
    	      title: '7天es6快速入门'
    	    }]
    	    this.$store.commit(types.ADD_FORUM_NEWS, {news: news})
    	  });
	  }
	},
	computed: {
	  ...mapGetters([
	  	'news',
      'user',
      'favoriteList'
		])
	}
}
</script>

<style scoped>

</style>