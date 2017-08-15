<template>
  <div class="config-wrap">
		<transition name="el-zoom-in-top">
			<div class="config-wrap-tab">
				<el-input
				  class="wrap-input"
		      :placeholder="friendHint"
		      :fetch-suggestions="queryFriendSuggestions"
		      icon="search"
		      @select="handleFriendSelect"
		      v-model="name">
		    </el-input>
				<friend-item v-for="item in friends" :key="item.friend_id" :item="item"></friend-item>
			</div>
		</transition>
	</div>
</template>

<style lang="css" scoped>
  .wrap-input {
		margin: 0 0 4px 0;
		opacity: .6;
		border: none;
		border-radius: 0;
		font-size: 12px;
	}
</style>

<script>
import types from '@/store/types'
import { mapGetters } from 'vuex'
import Logo from '@/assets/logo.png'
import FriendItem from './FriendItem'

export default {
	name: 'Friend',
	data () {
	  return {
			friendHint: '搜索',
			name: ''
	  }
	},
	components: {
		FriendItem
	},
	created () {
		if(this.friends.length<1) {
	  	this.fetchFriends()
	  }
	},
	mounted () {
	  this.friendHint = '搜索共' + this.friends.length + '位好友'
	},
	methods: {
		queryFriendSuggestions (queryString, callback) {

		},
		handleFriendSelect () {

		},
	  fetchFriends() {
    	this.$common.http.get(this.$common.api.StudentFriendList+'?studentid='+this.user.userid)
    	  .then(response => {
    	    this.$store.commit(types.ADD_FRIEND_FRIENDS, {friends: response.data})
    	  })
    	  .catch(error => {
    	    //测试数据
    	    let friends = [{
    	      friend_id: 1,
    	      friend_headimg: Logo,
    	      friend_name: '张建新'
    	    }, {
    	      friend_id: 2,
    	      friend_headimg: Logo,
    	      friend_name: '胡荣玲'
    	    }, {
    	      friend_id: 3,
    	      friend_headimg: Logo,
    	      friend_name: '郭颖'
    	    }]
    	    this.$store.commit(types.ADD_FRIEND_FRIENDS, {friends: friends})
    	  });
	  },
		friendDetail(friendid) {
			this.$router.push('/frienddetail/'+friendid)
		},
		getMessageCount(id) {
			return this.unopen.filter(item => item.from==id).length
		},
		openChatView(friend) {
      this.$store.commit(types.UPDATE_CHAT_CHATFRIEND, friend)
      this.$router.push('/chat')
    }
	},
	computed: {
	  ...mapGetters([
	  	'friends',
			'user',
			'unopen'
		])
	}
}
</script>