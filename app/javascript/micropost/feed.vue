<template>
<div>
  <ol class='microposts' id='vue-micropost'>
    <div v-for='item in microposts' :key='item.id'>
      <micropost :item='item'
        :current_user='current_user'
      >
      </micropost>
    </div>
  </ol>
  <div class='pagination'>
    <el-pagination
      :page-size='1'
      layout="prev, pager, next"
      :total='page_count'>
    </el-pagination>
  </div>
</div>
</template>
<script>
import micropost from '../micropost/micropost.vue';
export default {
  name: 'feed',
  components: {micropost},
  props: {
    microposts: {
      type: Array,
      required: true
    },
    current_user: {
      type: Object,
      required: true
    },
    page_count: {
      type: Number,
      required: true
    }
  }
}
</script>