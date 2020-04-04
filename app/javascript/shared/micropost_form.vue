<template>
<div id='micropost_form'>
  <div class='field'>
    <textarea v-model="textarea" 
      placeholder="Please input">
    </textarea>
  </div>
  <el-button type="primary" v-on:click='upload()'>Post</el-button>
  <span class='picture'>
    <input v-on:change='selectfile()' type='file'>
  </span>
</div>
</template>

<script>
import axios from 'axios';
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  name: 'micropost_form',
  data() {
    return {
      textarea: '',
      file: null
    }
  },
  methods: {
    async upload(){
      try{
        console.log(this.textarea);
        console.log(this.file);
        const url = 'http://localhost:3000/microposts';
        const headers = { 'content-type': 'multipart/form-data' };
        const data = new FormData();
        data.append('micropost[content]', this.textarea);
        data.append('micropost[picture]', this.file);
        const res = await axios.post(url, data, { headers });
      } catch(err){console.log(err)};
    },    
    selectfile(){
      this.file = event.target.files[0];
      if (this.file){
        var size_in_megabytes = this.file.size/1024/1024;
        if (size_in_megabytes > 5) {
          alert('Maximum file size is 5MB. Please choose a smaller file.');
        }
      }
    }
  }
}
</script>