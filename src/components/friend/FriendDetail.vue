<template>
  <div>
	  <div class="title">
	  	<span class="glyphicon glyphicon-menu-left" aria-hidden="true" @click="goBack"></span >
	    <span class="center">详细资料</span>
	  </div>
	  <div class="headimg-div"><img class="headimg" :src="getFriend.friend_headimg"></div>
	  <div class="line-div">
	  	<span class="line-flex">{{getFriend.friend_name}}</span>
	  	<span class="line-flex">{{friend.gender | genderFilter}}</span>
	  	<span class="line-flex">{{friend.tel}}</span>
	  </div>
    <div class="line-div">
      <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
      <p class="line-flex">{{friend.grade | gradeFilter}}</p>
  	</div>
    <div class="line-div">
			<span class="glyphicon glyphicon-tags" aria-hidden="true"></span>
			<p class="line-flex">{{friend.sub | subFilter}}</p>
  	</div>
    <div class="line-div">
			<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
			<p class="line-flex">{{friend.intro}}</p>
  	</div>
    <span class="button" @click="chat">发 消 息</span>
    <span class="delete-button" @click="deleteFriend">删除该好友</span>
	</div>
</template>

<style scoped>
.headimg-div {
	margin: 0 0 44px 0;
	padding: 0;
	width: 100%;
	height: 150px;
	background-color: #02A8F3;
	box-shadow: 0px 2px 8px #BBBBBB;
}

.headimg {
	position: fixed;
	top: 100px;
	left: 50px;
	display: block;
	width: 100px;
	height: 100px;
	background-color: #FFFFFF;
	border-radius: 50%;
	box-shadow: 1px 2px 8px #AAA;
}

.line-div {
	display: flex;
	align-items: center;
	padding: 12px 8px 0px 8px;
	margin: 0;
	font-size: 15px;
	box-shadow: 0px 1px 4px #EEE;
}

.line-div .glyphicon {
	margin-right: 8px;
}

.line-flex {
	flex: 1;
	margin: 0;
	padding: 8px 4px;
	border: none;
	outline: none;
}

.button {
  display: block;
  margin: 12px 24px;
  padding: 12px;
  text-align: center;
  font-size: 15px;
  background-color: #02A8F3;
  color: #FFFFFF;
  border-radius: 4px;
  box-shadow: 0px 2px 4px #BBB;
}

.delete-button {
  display: block;
  margin: 12px 24px;
  padding: 12px;
  text-align: center;
  font-size: 15px;
  background-color: #FFFFFF;
  color: #CCC;
  border-radius: 4px;
  border: .5px solid #DDD;
}
</style>

<script>
import { mapGetters } from 'vuex'
import { MessageBox, Toast } from 'mint-ui'
import types from '@/store/types'
import Convert from '@/common/util/convert.js'

export default {
  name: 'FriendDetail',
  data() {
    return {
      friend: {
        sub: 3,
        grade: 10,
        gender: 1,
        intro: '',
        tel: ''
      }
    }
  },
  created() {
    this.fetchFriendInformation()
  },
  methods: {
    fetchFriendInformation() {
      this.$common.http.get(this.$common.api.UserInfo + '?studentid=' + this.getFriend.friend_id)
      .then(response => {
        this.friend.sub = response.data.sub
        this.friend.grade = response.data.grade
        this.friend.gender = response.data.gender
        this.friend.intro = response.data.intro
        this.friend.tel = response.data.tel
      }).catch(error => {
        this.friend.sub = 2
        this.friend.grade = 11
        this.friend.gender = 2
        this.friend.intro = '加油啊'
        this.friend.tel = 13089774321
      })
    },
    goBack() {
      this.$router.back()
    },
    chat() {
      this.$store.commit(types.UPDATE_CHAT_CHATFRIEND, this.getFriend)
      this.$router.push('/chat')
    },
    deleteFriend() {
      MessageBox.confirm('确认删除该好友？').then(action => {
        //提交到服务器
        
        //删除成功后
        this.$store.commit(types.DELETE_FRIEND_FRIEND, this.$route.params.friendid)
        Toast({
          message: '已删除',
          position: 'bottom',
          duration: 1000
        })
        this.$router.replace('/friend')
      }).catch(cancle => {

      })
    }
  },
  computed: {
    ...mapGetters([
      'friends'
    ]),
    getFriend() {
      return this.friends.find((item) => item.friend_id==this.$route.params.friendid)
    }
  },
  filters: {
    genderFilter(val) {
      return val===1? '男': '女'
    },
    subFilter(val) {
      return Convert.convertSubNumber(val)
    },
    gradeFilter(val) {
      return Convert.convertGradeNumber(val)
    }
  }
}
</script>