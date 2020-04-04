<template>
  <div id='logged_in_home'>
    <div class='row'>
      <aside class='col-md-4'>
        <section class='user-info'>
          <user_info
            :current_user='current_user'>
          </user_info>
        </section>
        <section class='stats'>
          <stats :current_user='current_user'></stats>
        </section>
        <section class='micropost_form'>
          <micropost_form @changeFeed='changeFeed'></micropost_form>
        </section>
      </aside>
      <div class='col-md-8' id='feed'>
        <h3>Micropost feed</h3>
        <feed
          :items='items'
          :current_user='current_user'
          :page_count='page_count'
          @changeFeed='changeFeed'>
        </feed>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import user_info from '../shared/user_info.vue';
import stats from '../shared/stats.vue';
import micropost_form from '../shared/micropost_form.vue';
import feed from '../micropost/feed.vue';
export default {
  name: 'logged_in_home',
  components: {user_info, stats, micropost_form, feed},
  props: {
    current_user: {
      type: Object,
      required: true
    },
    microposts: {
      type: Array,
      required: true
    },
    page_count: {
      type: Number,
      required: true
    }
  },
  data(){
    return {
      items: this.microposts
    }
  },
  methods: {
    async changeFeed(val) {
      var response = null;
      try {
      response = await axios
        .get('http://localhost:3000/api', {
          params: {
            page: val
          }
        })
      } catch(err) {};
      console.log(val);
      this.items = response.data.items;
    }
  }
}
</script>