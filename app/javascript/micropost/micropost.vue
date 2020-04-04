<template>
  <div :id='`micropost_${item.id}`'>
    <li>
      <img :src='`${item.avatar}`'>
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
    del_confirm(id){
      if (confirm("You sure?")){

        axios
          .delete("http://localhost:3000/microposts/"+id)
          .then()
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