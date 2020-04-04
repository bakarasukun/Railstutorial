<template>
<div id='home'>
  <logged_in_home v-if="current_user" 
    :current_user='current_user'
    :microposts='microposts'
    :page_count='page_count'>
  </logged_in_home>
  <not_logged_in_home v-else></not_logged_in_home>
</div>
</template>

<script>
import axios from 'axios';
import logged_in_home from '../home/logged_in_home.vue';
import not_logged_in_home from '../home/not_logged_in_home.vue';
export default {
  name: 'home',
  components: {
    logged_in_home,
    not_logged_in_home
  },
  data() {
    return {
      current_user: null,
      microposts: null,
      page: 1,
      page_count: 1
    }
  },
  async beforeCreate(){
    var query = location.search;
    var page = query.replace("?page=", "");
    var response =null;
    console.log(query);
    console.log(page);
    if (page=='')page=1;
    console.log(page);
    try {
      response = await axios
        .get('http://localhost:3000/api', {
          params: {
            page: page
          }
        })
    } catch(err) {}
    this.current_user = response.data.current_user;
    this.microposts = response.data.items;
    this.page_count = response.data.page_count;
  }
}
</script>