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
      <span class='timestampe'>
        Posted {{item.date}} ago.
      </span>
      <a href="" v-on:click="del_confirm(item.id)" v-if='item.user_id == current_user_id'>Delete</a>
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
  data() {
    return {
      item: {id: 1, user_id: 1},
      current_user_id: null
    };
  },
  methods: {
    del_confirm(id){
      if (confirm("You sure?")){

        axios
          .delete("http://localhost:3000/microposts/"+id)
          .then()
      }
    }
  },
  //props: ['item']
  beforeCreate(){
    axios
      .get('http://localhost:3000/api')
      .then(response => (this.item = response.data.items[0], this.current_user_id = response.data.current_user_id))
  }
}
</script>