<template>
  <div id="micropost_form">
    <div class="field">
      <textarea v-model="textarea" placeholder="Please input"></textarea>
    </div>
    <el-button type="primary" v-on:click="upload()">Post</el-button>
    <span class="picture">
      <input
        v-on:change="selectfile()"
        accept="image/jpg, image/gif, image/jpeg/, image/png"
        type="file"
        ref="fileinput"
        name="micropost[picture]"
        id="micropost_picture"
      />
    </span>
  </div>
</template>

<script>
import axios from 'axios';
axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content'),
};

export default {
  name: 'micropost_form',
  data() {
    return {
      textarea: '',
      file: null,
    };
  },
  methods: {
    async upload() {
      const url = 'http://localhost:3000/microposts';
      const headers = { 'content-type': 'multipart/form-data' };
      const data = new FormData();
      data.append('micropost[content]', this.textarea);
      data.append('micropost[picture]', this.file);
      try {
        const response = await axios.post(url, data, { headers });
        alert(response.data);
      } catch (error) {
        alert('request送信失敗');
      }
      this.$emit('changeFeed', 1);
      this.textarea = '';
      this.file = null;
      this.$refs.fileinput.value = '';
    },
    selectfile() {
      this.file = event.target.files[0];
      const BYTES_PER_MEGABYTE = 1024 * 1024;
      const MAX_FILE_SIZE = 5;
      if (this.file) {
        const size_in_megabytes = this.file.size / BYTES_PER_MEGABYTE;
        if (size_in_megabytes > MAX_FILE_SIZE) {
          alert('Maximum file size is 5MB. Please choose a smaller file.');
          this.file = null;
          this.$refs.fileinput.value = '';
        }
      }
    },
  },
};
</script>