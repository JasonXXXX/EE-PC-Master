<template>
	<div>
		<forum-item v-for="item in says" :key="item.id" :item="item"></forum-item>
  </div>
</template>

<script>
import types from '@/store/types'
import atypes from '@/store/action-types'
import { mapGetters } from 'vuex'
import { Message } from 'element-ui'
import ForumItem from './ForumItem'

export default {
	name: 'ForumDiscover',
	data() {
	  return {
	  	allLoaded: false,
			autoFill: false
	  }
	},
  components: {
    ForumItem
  },
	created() {
	  if(this.says.length<1) {
	  	this.fetchSay()
	  }
	},
	methods: {
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
		loadTop() {
      this.fetchSay()
    },
    loadBottom() {
      this.fetchSay()
    },
	  fetchSay() {
	  	let params = new URLSearchParams()
      params.append('message_mark', 2)
      params.append('index', this.says.length)
    	this.$common.http.post(this.$common.api.MessageList, params)
    	  .then(response => {
          if (this.$common.jsonUtil.jsonLength(response.data) < 5) {

          	this.allLoaded = true
          }
          this.$store.commit(types.ADD_FORUM_SAY, {says: response.data})
        })
    	  .catch(error => {
    	    //测试数据
    	    let says = [{
    	      id: 1,
    	      mark: 2,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '一飞冲天',
    	      sender_mark: 2,
    	      title: '父母给的压力太大，我该怎么办？'
    	    },{
    	      id: 2,
    	      mark: 2,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '威力无边',
    	      sender_mark: 2,
    	      title: '分享vue学习笔记'
    	    },{
    	      id: 3,
    	      mark: 2,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '是你就是你',
    	      sender_mark: 2,
    	      title: '分享js学习笔记'
    	     },{
    	      id: 4,
    	      mark: 2,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '小哪吒！',
    	      sender_mark: 2,
    	      title: '分享html5学习笔记'
    	     },{
    	      id: 5,
    	      mark: 2,
    	      message_like: 2,
    	      send_time: '2017-7-26',
    	      sender_name: '黑猫警长',
    	      sender_mark: 2,
    	      title: '分享css3学习笔记'
    	    }]
    	    this.$store.commit(types.ADD_FORUM_SAY, {says: says})
    	  });
	  }
	},
	computed: {
	  ...mapGetters([
	  	'says',
      'user',
      'favoriteList'
		])
	}
}
</script>

<style scoped>

</style>