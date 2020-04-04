<template>
  <div :id='`micropost_${item.id}`'>
    <li>
      <a :href='`http://localhost:3000/users/${item.user_id}`'>
        <img :src='`${item.avatar}`' class='gravatar'>
      </a>
      <span class='user'>
        <a :href='`http://localhost:3000/users/${item.user_id}`'>
          {{item.name}}
        </a>
      </span>
      <span class='content'>
        {{item.content}}
        <img :src='`${item.pic}`' v-if='item.pic !=null'>
      </span>
      <span class='timestamp'>
        Posted {{item.date}} ago.
        <a href="" v-on:click="del_confirm(item.id)" v-if='item.user_id == current_user.id'>delete</a>
      </span>
    </li>
  </div>
</template>

<script>
import axios from 'axios';
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};
export default {
  name: 'micropost',
  methods: {
    async del_confirm(id){
      var response = null;
      if (confirm("You sure?")){
        try {
          response = await axios
            .delete("http://localhost:3000/microposts/"+id)
        } catch(err){};
        this.$emit('chagneFeed');
      }
    }
  },
  props: {
    item: {
      type: Object,
      required: true
    },
    current_user: {
      type: Object,
      required: true
    }
  }
}
</script>