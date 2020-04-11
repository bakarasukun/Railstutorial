<template>
  <div>
    <ol class="microposts" id="vue-micropost">
      <div v-for="item in items" :key="item.id">
        <micropost :item="item" :current_user="current_user" @changeFeed="ChildChangeFeed"></micropost>
      </div>
    </ol>
    <div class="pagination">
      <el-pagination
        @current-change="ChildChangeFeed"
        :page-size="1"
        layout="prev, pager, next"
        :total="page_count"
      ></el-pagination>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import micropost from '../micropost/micropost.vue';
export default {
  name: 'feed',
  components: { micropost },
  props: {
    items: {
      type: Array,
      required: true,
    },
    current_user: {
      type: Object,
      required: true,
    },
    page_count: {
      type: Number,
      required: true,
    },
  },
  methods: {
    ChildChangeFeed(val) {
      this.$emit('changeFeed', val);
    },
  },
};
</script>