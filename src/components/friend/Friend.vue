<template>
	<div style="width: 100%;">
    <div class="title">
      <router-link class="router-link" to="/home/forum" replace>
      	<span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span >
      </router-link>
    	<span>好友列表</span>
    </div>
    <div style="height: 5rem;"></div>
    <div class="friend-item" v-for="friend in friends" :key="friend.id" @click="friendDetail(friend.friend_id)">
      <img class="friend-headimg" :src="friend.friend_headimg">
      <p class="friend-username">{{friend.friend_name}}</p>
			<div @click.stop="openChatView(friend)">
				<badge size="small" v-if="getMessageCount(friend.friend_id)">
					<slot slot="name">{{getMessageCount(friend.friend_id)}}</slot>
				</badge>
			</div>
    </div>
    <p class="friend-hint-text" v-show="friends.length">共 {{this.friends.length}} 位好友</p>
    <p class="friend-hint-text" v-show="!friends.length">您目前没有好友 :)</p>
  </div>
</template>

<style lang="css" scoped>
.friend-item {
	display: flex;
	align-items: center;
	padding: 8px;
	margin: 0;
	width: 100%;
	border-bottom: .5px solid #BBB;
	overflow-x: hidden;
}

.friend-headimg {
	padding: 0;
	margin: 0;
	width: 32px;
	height: 32px;
	border-radius: 50%;
}

.friend-username {
	flex: 1;
	margin: 0 0 0 4px;
	padding: 0 0 0 4px;
	color: #424242;
	font-size: 14px;
}

.friend-hint-text {
	margin: 0;
	padding: 12px 0;
	width: 100%;
	text-align: center;
	color: #A0A0A0;
}
</style>

<script>
import types from '@/store/types'
import { mapGetters } from 'vuex'
import Logo from '@/assets/logo.png'
import { Toast,Badge } from 'mint-ui'

export default {
	name: 'Friend',
	data() {
	  return {

	  }
	},
	components: {
		Badge
	},
	mounted() {
	  if(this.friends.length<1) {
	  	this.fetchFriends()
	  }
	},
	methods: {
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