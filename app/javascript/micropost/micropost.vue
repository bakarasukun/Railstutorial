<template>
  <div v-bind:id="`micropost_${item.id}`">
    <li>
      <a v-bind:href="`http://localhost:3000/users/${item.user_id}`">
        <img :src="`${item.avatar}`" class="gravatar" />
      </a>
      <span class="user">
        <a :href="`http://localhost:3000/users/${item.user_id}`">{{ item.name }}</a>
      </span>
      <span class="content">
        {{ item.content }}
        <img :src="`${item.pic}`" v-if="item.pic != null" />
      </span>
      <span class="timestamp">
        Posted {{ item.date }} ago.
        <a
          href="javascript:void(0)"
          v-on:click="del_confirm(item.id);"
          v-if="item.user_id == current_user.id"
        >delete</a>
      </span>
    </li>
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
  name: 'micropost',
  props: {
    item: {
      type: Object,
      required: true,
    },
    current_user: {
      type: Object,
      required: true,
    },
  },

  methods: {
    async del_confirm(id) {
      if (confirm('You sure?')) {
        try {
          const response = await axios.delete(`http://localhost:3000/microposts/${id}`);
          alert(response.data.msg);
        } catch (error) {
          alert('request送信失敗');
        }
        this.$emit('changeFeed', 1);
      }
    },
  },
};
</script>