<template>
  <div class="config-wrap">
    <div class="wrap-img">
      <img class="headimg" :src="headimg">
      <span class="name">{{name}}</span>
    </div>
    <el-collapse class="wrap-collapse" v-model.trim="activeName" accordion>
      <el-collapse-item class="wrap-collapse-item" title="教师信息" name="info">
        <table class="wrap-table" cellpadding="8px" border="1">
          <tr>
            <td>姓名</td>
            <td>{{name || ''}}</td>
          </tr>
          <tr>
            <td>性别</td>
            <td>{{gender}}</td>
          </tr>
          <tr>
            <td>科目</td>
            <td>{{submark}}</td>
          </tr>
          <tr>
            <td>联系电话</td>
            <td>{{phone || ''}}</td>
          </tr>
          <tr>
            <td>地址</td>
            <td>{{address || ''}}</td>
          </tr>
          <tr>
            <td>个人简介</td>
            <td>{{introduce || ''}}</td>
          </tr>
        </table>
      </el-collapse-item>
      <el-collapse-item class="wrap-collapse-item" title="获得证书" name="certification">
        <table class="wrap-table" border="1" cellpadding="8px">
          <tr>
            <td>序号</td>
            <td>内容</td>
          </tr>
          <tr v-for="(item, index) in certifications" :key="item.id">
            <td>{{index + 1}}</td>
            <td>{{item.title}}</td>
          </tr>
        </table>
      </el-collapse-item>
      <el-collapse-item class="wrap-collapse-item" title="获得评价" name="evaluation">
        <table class="wrap-table" border="1" cellpadding="8px">
          <tr>
            <td>序号</td>
            <td>内容</td>
            <td>评分</td>
          </tr>
          <tr v-for="(item, index) in evaluations" :key="item.id">
            <td>{{index + 1}}</td>
            <td>{{item.content}}</td>
            <td>{{item.evaluation}}</td>
          </tr>
        </table>
      </el-collapse-item>
      <el-collapse-item class="wrap-collapse-item" title="教学经历" name="careers">
        <table class="wrap-table" border="1" cellpadding="8px">
          <tr>
            <td>序号</td>
            <td>内容</td>
            <td>开始时间</td>
            <td>结束时间</td>
          </tr>
          <tr v-for="(item, index) in careers" :key="item.id">
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

  .wrap-collapse {
    flex: 1;
  }

  .wrap-collapse-item {
    padding: 8px;
    text-align: left;
  }

  .wrap-table {
    border-collapse: collapse;
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
      detail: {},
      name: '',
      address: '',
      careers: [],
      certifications: [],
      evaluations: [],
      phone: '',
      introduce: '',
      submark: '',
      gender: '',
      headimg: Logo,
      activeName: 'info'
    }
  },
  created () {
    this.fetchteacherDetail()
  },
  mounted () {
    // 单独获取头像
    this.headimg = 'http://' + Server.ip + ':' + Server.port + '/' + Server.server + '/image/userheadimg/teacher' + this.teacherid + '.png'
  },
  methods: {
    fetchteacherDetail () {
      this.$common.http.get(this.$common.api.TeacherInfo + '?teacherid=' + this.teacherid)
        .then(response => {
          this.name = response.data.teachername
          this.address = response.data.address
          this.careers = response.data.careers
          this.certifications = response.data.certifications
          this.evaluations = response.data.evaluations
          this.phone = response.data.phone
          this.introduce = response.data.introduce
          this.submark = Convert.convertSubNumber(response.data.submark)
          this.gender = response.data.gender === 1? '男': '女'
        })
        .catch(error => {
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
