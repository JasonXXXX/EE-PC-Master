<template>
  <div>
    <div id="wrap-upload" class="wrap-upload">
      <i class="el-icon-upload wrap-upload-icon"></i>
      <p class="wrap-hint">{{$common.strings.detail_upload_drag_hint}}
        <em class="wrap-em" @click="handleChooseVideo">{{$common.strings.detail_upload_click_text}}</em>
      </p>
      <p class="wrap-p">{{$common.strings.video_upload_limit}}</p>
      <button id="pickvideos" hidden></button>
    </div>
    <el-button class="upload-button" type="primary-plain" v-if="uploading" @click="abort">{{$common.strings.video_abort_button}}</el-button>
    <el-button class="upload-button" type="primary" @click="upload">{{$common.strings.video_upload_button}}</el-button>
  </div>
</template>

<style scoped>
  .wrap-upload {
    padding: 32px 48px;
    margin: 24px auto;
    border: 2px dashed #BDBDBD;
    width: fit-content;
    border-radius: 8px;
    overflow: hidden;
  }
  
  .wrap-hint,
  .wrap-p {
    margin: 4px auto;
    color: #959595;
  }
  
  .wrap-em {
    color: #0366ED;
  }
  
  .wrap-p {
    font-size: 13px;
  }
  
  .wrap-upload-icon {
    display: block;
    margin: 0 auto 12px auto;
    font-size: 32px;
    color: #888888;
    overflow: hidden;
  }
  
  .upload-button {
    margin: 8px 0 0 0;
  }
</style>

<script>
import { mapGetters } from 'vuex'
// import 'static/moxie.js'
// import 'static/plupload.dev.js'
// import 'static/plupload.full.min.js'
import 'static/qiniu.min.js'
import Keys from '@/common/data/keys'

export default {
  name: 'VideoUpload',
  data () {
    return {
      accept: 'video/mp4',
      videos: [],
      payload: {},
      Uploader: null,
      uploading: false
    }
  },
  created () {
    this.payload = {
      'user': this.user.user,
      'userid': this.user.userid
    }
  },
  mounted () {
    this.InitUpload()
  },
  methods: {
    InitUpload () {
      this.Uploader = Qiniu.uploader({
        runtimes: 'html5,flash,html4',      // 上传模式，依次退化
        browse_button: 'pickvideos',         // 上传选择的点选按钮，必需
        // 在初始化时，uptoken，uptoken_url，uptoken_func三个参数中必须有一个被设置
        // 且如果提供了多个，其优先级为uptoken > uptoken_url > uptoken_func
        // 其中uptoken是直接提供上传凭证，uptoken_url是提供了获取上传凭证的地址，如果需要定制获取uptoken的过程则可以设置uptoken_func
        uptoken: Keys.Qiniu.uptoken, // uptoken是上传凭证，由其他程序生成
        // uptoken_url: '/uptoken',         // Ajax请求uptoken的Url，强烈建议设置（服务端提供）
        // uptoken_func: function(){    // 在需要获取uptoken时，该方法会被调用
        //    // do something
        //    return uptoken;
        // },
        get_new_uptoken: false,             // 设置上传文件的时候是否每次都重新获取新的uptoken
        // downtoken_url: '/downtoken',
        // Ajax请求downToken的Url，私有空间时使用，JS-SDK将向该地址POST文件的key和domain，服务端返回的JSON必须包含url字段，url值为该文件的下载地址
        // unique_names: true,              // 默认false，key为文件名。若开启该选项，JS-SDK会为每个文件自动生成key（文件名）
        // save_key: true,                  // 默认false。若在服务端生成uptoken的上传策略中指定了sava_key，则开启，SDK在前端将不对key进行任何处理
        domain: Keys.Qiniu.bucket_domain,     // bucket域名，下载资源时用到，必需
        container: 'wrap-upload',             // 上传区域DOM ID，默认是browser_button的父元素
        max_file_size: '500mb',             // 最大文件体积限制
        flash_swf_url: '../../../../static/Moxie.swf',  //引入flash，相对路径
        max_retries: 3,                     // 上传失败最大重试次数
        dragdrop: true,                     // 开启可拖曳上传
        drop_element: 'wrap-upload',          // 拖曳上传区域元素的ID，拖曳文件或文件夹后可触发上传
        chunk_size: '4mb',                  // 分块上传时，每块的体积
        auto_start: false,                   // 选择文件后自动上传，若关闭需要自己绑定事件触发上传
        //x_vars : {
        //    查看自定义变量
        //    'time' : function(up,file) {
        //        var time = (new Date()).getTime();
        // do something with 'time'
        //        return time;
        //    },
        //    'size' : function(up,file) {
        //        var size = file.size;
        // do something with 'size'
        //        return size;
        //    }
        //},
        init: {
          FilesAdded (up, files) {
            console.log('添加了一个文件')
            plupload.each(files, file => {
              // 文件添加进队列后，处理相关的事情
              consolo.log(file)
            })
          },
          BeforeUpload (up, file) {
            // 每个文件上传前，处理相关的事情
          },
          UploadProgress (up, file) {
            // 每个文件上传时，处理相关的事情
          },
          FileUploaded (up, file, info) {
            // 每个文件上传成功后，处理相关的事情
            // 其中info是文件上传成功后，服务端返回的json，形式如：
            // {
            //    "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
            //    "key": "gogopher.jpg"
            //  }
            // 查看简单反馈
            // var domain = up.getOption('domain');
            // var res = parseJSON(info);
            // var sourceLink = domain +"/"+ res.key; 获取上传成功后的文件的Url
          },
          Error (up, err, errTip) {
            //上传出错时，处理相关的事情
          },
          UploadComplete () {
            //队列文件处理完毕后，处理相关的事情
          },
          Key (up, file) {
            // 若想在前端对每个文件的key进行个性化处理，可以配置该函数
            // 该配置必须要在unique_names: false，save_key: false时才生效
            var key = "";
            // do something with key here
            return key
          }
        },
        filters: {
          prevent_duplicates: true,
          mime_types: [
            {
              title: 'Video files',
              extensions: 'flv,mpg,mpeg,avi,wmv,mov,asf,rm,rmvb,mkv,m4v,mp4'
            }
          ]
        }
      })
    },
    upload () {
      this.uploading = true
      this.Uploader.start()
    },
    abort () {
      this.uploading = false
      this.Uploader.stop()
    },
    handleChooseVideo () {
      document.getElementById('pickvideos').click()
    }
  },
  computed: {
    ...mapGetters([
      'user'
    ])
  }
}
</script>
