<template>
  <div class="config-wrap">
    <div class="wrap-img">
      <img class="headimg" :src="detail.headimg">
      <span class="name">{{detail.name}}</span>
    </div>
    <el-collapse class="wrap-collapse" v-model.trim="activeName" accordion>
      <el-collapse-item class="wrap-collapse-item" title="教师信息" name="info">
        <table class="wrap-table" cellpadding="8px" border="1">
          <tr>
            <td>姓名</td>
            <td>{{detail.name}}</td>
          </tr>
          <tr>
            <td>性别</td>
            <td>{{detail.gender}}</td>
          </tr>
          <tr>
            <td>科目</td>
            <td>{{detail.sub}}</td>
          </tr>
          <tr>
            <td>联系电话</td>
            <td>{{detail.phone}}</td>
          </tr>
          <tr>
            <td>地址</td>
            <td>{{detail.address}}</td>
          </tr>
          <tr>
            <td>个人简介</td>
            <td>{{detail.introduce}}</td>
          </tr>
        </table>
      </el-collapse-item>
      <el-collapse-item class="wrap-collapse-item" title="获得证书" name="certification">
        <table border="1" cellpadding="8px">
          <tr>
            <td>序号</td>
            <td>内容</td>
          </tr>
          <tr v-for="(item, index) in detail.certifications" :key="item.id">
            <td>{{index + 1}}</td>
            <td>{{item.title}}</td>
          </tr>
        </table>
      </el-collapse-item>
      <el-collapse-item class="wrap-collapse-item" title="获得评价" name="evaluation">
        <table border="1" cellpadding="8px">
          <tr>
            <td>序号</td>
            <td>内容</td>
            <td>评分</td>
          </tr>
          <tr v-for="(item, index) in detail.evaluations" :key="item.id">
            <td>{{index + 1}}</td>
            <td>{{item.content}}</td>
            <td>{{item.evaluation}}</td>
          </tr>
        </table>
      </el-collapse-item>
      <el-collapse-item class="wrap-collapse-item" title="教学经历" name="careers">
        <table border="1" cellpadding="8px">
          <tr>
            <td>序号</td>
            <td>内容</td>
            <td>开始时间</td>
            <td>结束时间</td>
          </tr>
          <tr v-for="(item, index) in detail.careers" :key="item.id">
            <td>{{index + 1}}</td>
            <td>{{item.content}}</td>
            <td>{{item.start}}</td>
            <td>{{item.end}}</td>
          </tr>
        </table>
      </el-collapse-item>
    </el-collapse>
  </div>
</template>

<style scoped>
  .wrap-image {
    text-align: center;
  }

  .headimg {
    display: block;
    margin: 12px;
    width: 160px;
    height: 160px;
    box-shadow: 1px 1px 32px #BBBBBB;
  }

  .name {
    display: inline-block;
    margin-top: 8px;
  }

  .wrap-collapse-item {
    padding: 8px;
  }
</style>

<script>
import types from '@/store/types'
import { mapGetters } from 'vuex'
import Convert from '@/common/util/convert.js'
import Server from '@/common/data/server.js'
import Logo from '@/assets/logo.png'

export default {
  data () {
    return {
      detail: {
        address: '',
        careers: [],
        certifications: [],
        evaluations: [],
        introduce: '',
        phone: '',
        teacherid: 0,
        submark: 0,
        teachername: '',
        submarkname: '',
        gender: '',
        headimg: Logo
      },
      activeName: 'info'
    }
  },
  created () {
    this.fetchteacherDetail()
  },
  mounted () {
    // 单独获取头像
    this.detail.headimg = 'http://' + Server.ip + ':' + Server.port + '/' + Server.server + '/image/userheadimg/teacher' + this.teacherid + '.png'
  },
  methods: {
    fetchteacherDetail () {
      this.$common.http.get(this.$common.api.TeacherInfo + '?teacherid=' + this.teacherid)
        .then(response => {
          this.detail.address = response.data.address
          this.detail.careers = response.data.careers
          this.detail.certifications = response.data.certifications
          this.detail.evaluations = response.data.evaluations
          this.detail.phone = response.data.phone
          this.detail.submark = response.data.submark
          this.detail.introduce = response.data.introduce
          this.detail.submark_name = Convert.convertSubNumber(response.data.submark)
          this.detail.gender = Convert.convertGenderNumber(response.data.gender)
        })
        .catch(error => {
          //测试数据
          // let teacherDetail = {
          //   address: '广州市天河区中山大道17号',
          //   careers: [{
          //     content: '教高一语文两个学期',
          //     end: '2016-07-21',
          //     id: 1,
          //     start: '2015-09-07'
          //   },{
          //     content: '教高一语文三个学期',
          //     end: '2016-07-20',
          //     id: 2,
          //     start: '2015-02-03'
          //   }],
          //   certifications: [{
          //     id: 1,
          //     title: '中级教师资格证',
          //   }, {
          //     id: 2,
          //     title: '高级教师资格证'
          //   }],
          //   evaluations: [{
          //     content: '课程讲解详细，通俗易懂',
          //     evaluation: 3.5
          //   }],
          //   headimg: Logo,
          //   introduce: '讲课简单易懂，平易近人',
          //   phone: '13456859523',
          //   submark: 1,
          //   gender: '女'
          //
          // }
          // this.detail.address = teacherDetail.address
          // this.detail.careers = teacherDetail.careers
          // this.detail.certifications = teacherDetail.certifications
          // this.detail.evaluations = teacherDetail.evaluations
          // this.detail.headimg = teacherDetail.headimg
          // this.detail.phone = teacherDetail.phone
          // this.detail.submark = teacherDetail.submark
          // this.detail.introduce = teacherDetail.introduce
          // this.detail.submarkname = Convert.convertSubNumber(teacherDetail.submark)
          // this.detail.gender = teacherDetail.gender
        })
    },
  },
  computed: {
    ...mapGetters([
      'teacherid',
    ])
  }
}
</script>
