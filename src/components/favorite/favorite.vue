<template>
	<div style="width: 100%;">
    <div class="title">
      <router-link class="router-link" to="/home/forum" replace>
        <span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span >
      </router-link>
      <span>我的收藏</span>
    </div>
    <header class="header"></header>
    <div v-if="this.favoriteList.length==0" class="favorempty">暂无数据</div>
		<div v-else v-for="list in favoriteList" @click="showDetail(list.id, list.title, list.mark)">
			<p class="news-title">{{list.title}}</p>
			<ul>
			  <li>作者：{{list.sender_name}}</li>
			  <li class="glyphicon glyphicon-heart" >收藏</li>
        <li>{{list.send_time}}</li>
			</ul>
		</div>
  </div>
</template>

<script>
import types from '@/store/types'
import atypes from '@/store/action-types'
import { mapGetters } from 'vuex'

export default {
	data() {
	  return {

	  }
	},
  components: {
  },
	mounted() {
	  if(this.favoriteList.length<1) {
	  	this.fetchFavorite()
	  }
	},
	methods: {
    showDetail(id, title ,mark) {
      if(mark==1){
        this.$router.push({
          path: '/newsdetail/' + id + '/title/' + title
        })
      }else{
        this.$router.push({
          path: '/saysdetail/' + id + '/title/' + title
        })
      }
    },
	  fetchFavorite() {
    	this.$common.http.post(this.$common.api.Messagemark)
    	  .then(response => {
          this.$store.commit(types.SET_FAVORITE_LIST, {favoriteList: response.data})

        })
    	  .catch(error => {
    	    //测试数据
          return this.favoriteList
    	  });
	  }
	},
	computed: {
	  ...mapGetters([
      'user',
      'favoriteList'
		])
	}
}
</script>

<style lang="css" >
  .favorempty{
    margin: 20px auto;
    text-align: center; 
  }
  .news-title {
    margin-top: 5%;
    margin-left: 10%;
    font-size: 18px;
  }

  ul {
    border-bottom: 1px solid black ;
    overflow: hidden;  
    width: 80%;  
    margin: 0 auto;  
    text-align: center;  
  }

  li {
    list-style-type: none;
    display: inline;
    width:33.33%; 
    float: left;
    font-size: 14px;
  }
</style>