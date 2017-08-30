<template>
	<div class="config-wrap" id="parent">
		<transition name="el-zoom-in-top">
			<div class="config-wrap-tab">
				<el-autocomplete class="wrap-input" :placeholder="friendHint" :fetch-suggestions="queryFriendSuggestions" icon="search" @select="handleFriendSelect" v-model="name">
				</el-autocomplete>
				<friend-item v-for="item in friends" :key="item.friend_id" :item="item"></friend-item>
			</div>
		</transition>
		<!-- <router-view class="config-wrap-view wrap-chat-window"></router-view> -->
		<div class="config-wrap-view chat-div" id="child">
			<p class="message-name">{{chatfriend.friend_name}}</p>
			<div class="message-content">
				<chat-item v-for="chatmsg in getMessages" :chatmsg="chatmsg" :key="chatmsg.id"></chat-item>
			</div>
			<div class="text-div">
				<el-input class="text" id="input" type="textarea" :rows="input_rows" v-model.trim="text">
				</el-input>
				<el-button class="button" @click="sendMessage">发送</el-button>
			</div>
		</div>
	</div>
</template>

<style lang="css" scoped>
	#parent {
		padding: 0;
	}

	.wrap-input {
		margin: 0 0 4px 0;
		opacity: .6;
		border: none;
		border-radius: 0;
		font-size: 12px;
	}

	.chat-div {
		display: flex;
		flex-direction: column;
		width: 100%;
		height: 100%;
	}

	.message-name {
		margin: 0;
		padding: 8px 12px;
		text-align: left;
		color: #424242;
		/* border-bottom: .5px solid #BDBDBD; */
		box-shadow: 1px 1px 8px #BBBBBB;
	}

	.message-content {
		flex: 1;
	}

	.text-div {
		position: relative;
	}

	.text {
		width: 100%;
		font-size: 15px;
		color: #424242;
	}

	.button {
		position: absolute;
		padding: 4px 12px;
		bottom: 4px;
		right: 8px;
		color: #999999;
	}
</style>

<script>
import { mapGetters } from 'vuex'
import types from '@/store/types'
import atypes from '@/store/action-types'
import Logo from '@/assets/logo.png'
import FriendItem from './FriendItem'
import ChatItem from './ChatItem'
import Rongyun from '@/common/util/rongyun'
import Database from '@/common/util/database'

export default {
	name: 'Friend',
	data () {
		return {
			friendHint: '搜索',
			name: '',
			text: '',
			input_rows: 3
		}
	},
	components: {
		FriendItem,
		ChatItem
	},
	created () {
		if (this.friends.length < 1) {
			this.fetchFriends()
		}
		this.friendHint = '搜索共' + this.friends.length + '位好友'
	},
	mounted () {
		document.getElementById('child').style.height = document.getElementById('parent').clientHeight - 16 + 'px'
	},
	beforeDestroy () {
		if (this.newchats.length) {
			//组件销毁前，保存到本地数据库
			this.$store.dispatch(atypes.SAVE_TO_INDEXEDDB, {
				userid: this.user.userid,
				friendid: this.chatfriend.friend_id
			}).then(() => {

			}).catch(error => {
				this.$message({
					type: 'warning',
					message: error
				})
			})
		}
	},
	methods: {
		queryFriendSuggestions (queryString, cb) {
			const names = []
			this.friends.every(item => {
				names.push({
					value: item.friend_name,
					id: item.friend_id
				})
				return true
			})
			const suggestions = names
			const results = queryString ? suggestions.filter(this.createFilter(queryString)) : suggestions
			// 调用 callback 返回建议列表的数据
			cb(results)
		},
		createFilter (queryString) {
			return suggestions => (suggestions.value.indexOf(queryString.toLowerCase()) !== -1)
		},
		handleFriendSelect (select) {
			this.$store.commit(types.UPDATE_CHAT_CHATFRIEND, this.friends.find(item => item.friend_id === select.id))
		},
		fetchFriends () {
			this.$common.http.get(this.$common.api.StudentFriendList + '?studentid=' + this.user.userid)
				.then(response => {
					this.$store.commit(types.ADD_FRIEND_FRIENDS, response.data)
				})
				.catch(error => {
				});
		},
		friendDetail (friendid) {
			this.$router.push('/frienddetail/' + friendid)
		},
		getMessageCount (id) {
			return this.unopen.filter(item => item.from == id).length
		},
		openChatView (friend) {
			this.$store.commit(types.UPDATE_CHAT_CHATFRIEND, friend)
			this.$router.push('/chat')
		},
		sendMessage () {
			if (this.text.length > 0) {
				//发送信息
				let chat = {
					from: this.user.userid,
					to: this.chatfriend.friend_id,
					content: this.text,
					failed: true,
					unopen: false
				}
				this.text = ''
				this.$store.commit(types.ADD_CHAT_CHAT, chat)
				Rongyun.sendMessage(chat.to, chat.content, this.newchats[this.newchats.length - 1].id)
					.then(() => {
					}).catch(info => {
						console.log(info)
						this.$message({
							type: 'warning',
							message: '网络发生错误'
						})
					})
			} else {
				this.$message('不能发送空消息')
			}
		}
	},
	computed: {
		...mapGetters([
			'friends',
			'user',
			'unopen',
			'chats',
			'newchats',
			'chatfriend'
		]),
		getMessages () {
			return this.chats.filter(item => (item.from == this.chatfriend.friend_id) || (item.to == this.chatfriend.friend_id && item.from == this.user.userid))
		}
	}
}
</script>